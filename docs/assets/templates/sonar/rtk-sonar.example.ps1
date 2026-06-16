#!/usr/bin/env pwsh
# Requires: PowerShell 7+
# rtk-sonar CLI
# Commands:
#   collect   - collect Sonar issues from API
#   summarize - filter/dedupe/prioritize and write sonar-packet.{json,md}
#   prompt    - generate compact Copilot prompt from sonar-packet.json

[CmdletBinding()]
param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$CliArgs
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Write-Info([string]$Message) { Write-Host "[INFO] $Message" -ForegroundColor Cyan }
function Write-Warn([string]$Message) { Write-Warning $Message }
function Write-Fail([string]$Message) { Write-Error $Message }

function Normalize-OptName([string]$Name) {
    if ([string]::IsNullOrWhiteSpace($Name)) { return "" }
    return ($Name.TrimStart('-').ToLowerInvariant() -replace '[-_]', '')
}

function Parse-Options([string[]]$ArgsList) {
    $opts = @{}
    if (-not $ArgsList) { return $opts }

    for ($i = 0; $i -lt $ArgsList.Count; $i++) {
        $arg = $ArgsList[$i]
        if ($arg -notmatch '^-{1,2}') { continue }

        $rawName = $arg
        $value = $true

        if ($arg -match '^(--?[^=]+)=(.*)$') {
            $rawName = $Matches[1]
            $value = $Matches[2]
        }
        elseif ($i + 1 -lt $ArgsList.Count -and $ArgsList[$i + 1] -notmatch '^-{1,2}') {
            $value = $ArgsList[$i + 1]
            $i++
        }

        $key = Normalize-OptName $rawName
        if ($opts.ContainsKey($key)) {
            if ($opts[$key] -is [System.Collections.IList]) {
                [void]$opts[$key].Add($value)
            }
            else {
                $opts[$key] = [System.Collections.ArrayList]@($opts[$key], $value)
            }
        }
        else {
            $opts[$key] = $value
        }
    }
    return $opts
}

function Get-Opt([hashtable]$Opts, [string[]]$Aliases, $Default = $null) {
    foreach ($alias in $Aliases) {
        $k = Normalize-OptName $alias
        if ($Opts.ContainsKey($k)) { return $Opts[$k] }
    }
    return $Default
}

function To-Bool($Value, [bool]$Default = $false) {
    if ($null -eq $Value) { return $Default }
    if ($Value -is [bool]) { return $Value }
    $s = "$Value".Trim().ToLowerInvariant()
    if ($s -in @("1", "true", "yes", "y", "on")) { return $true }
    if ($s -in @("0", "false", "no", "n", "off")) { return $false }
    return $Default
}

function To-Int($Value, [int]$Default, [int]$Min = 0) {
    if ($null -eq $Value) { return $Default }
    $n = 0
    if (-not [int]::TryParse("$Value", [ref]$n)) { return $Default }
    if ($n -lt $Min) { return $Min }
    return $n
}

function To-StringList($Value) {
    if ($null -eq $Value) { return @() }
    if ($Value -is [System.Collections.IList]) {
        $all = @()
        foreach ($v in $Value) { $all += (To-StringList $v) }
        return $all
    }

    $text = "$Value".Trim()
    if ([string]::IsNullOrWhiteSpace($text)) { return @() }

    return @($text.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ })
}

function Ensure-OutDir([string]$OutDir) {
    $resolved = if ([string]::IsNullOrWhiteSpace($OutDir)) { "." } else { $OutDir }
    if (-not (Test-Path -LiteralPath $resolved)) {
        New-Item -ItemType Directory -Path $resolved -Force | Out-Null
    }
    return (Resolve-Path -LiteralPath $resolved).Path
}

function Save-Json([object]$Data, [string]$Path) {
    $json = $Data | ConvertTo-Json -Depth 32
    Set-Content -LiteralPath $Path -Value $json -Encoding utf8
}

function Read-Json([string]$Path) {
    if (-not (Test-Path -LiteralPath $Path)) {
        throw "Input file not found: $Path"
    }
    $raw = Get-Content -LiteralPath $Path -Raw -Encoding utf8
    return ($raw | ConvertFrom-Json)
}

function Build-QueryString([hashtable]$Params) {
    $parts = New-Object System.Collections.Generic.List[string]
    foreach ($k in $Params.Keys) {
        $v = $Params[$k]
        if ($null -eq $v -or "$v" -eq "") { continue }

        if ($v -is [System.Collections.IList] -and -not ($v -is [string])) {
            if ($v.Count -eq 0) { continue }
            $v = ($v -join ",")
        }

        $ek = [uri]::EscapeDataString("$k")
        $ev = [uri]::EscapeDataString("$v")
        $parts.Add("$ek=$ev")
    }
    return ($parts -join "&")
}

function Get-ObjProp([object]$Obj, [string]$Name, $Default = $null) {
    if ($null -eq $Obj) { return $Default }
    if ($Obj.PSObject.Properties.Name -contains $Name) {
        $value = $Obj.$Name
        if ($null -eq $value) { return $Default }
        return $value
    }
    return $Default
}

function Invoke-WithRetry([scriptblock]$Action, [int]$MaxAttempts = 3) {
    $attempt = 1
    while ($true) {
        try {
            return & $Action
        }
        catch {
            if ($attempt -ge $MaxAttempts) { throw }
            $delay = [math]::Pow(2, $attempt - 1)
            Write-Warn "Transient failure on attempt $attempt/$MaxAttempts. Retrying in $delay sec."
            Start-Sleep -Seconds $delay
            $attempt++
        }
    }
}

function Get-IssuesFromAnyJson([object]$Data) {
    $issues = @()

    if ($null -eq $Data) { return $issues }

    if ($Data.PSObject.Properties.Name -contains "issues") {
        return @($Data.issues)
    }

    if ($Data -is [System.Collections.IList]) {
        foreach ($entry in $Data) {
            if ($entry.PSObject.Properties.Name -contains "issues") {
                $issues += @($entry.issues)
            }
            elseif ($entry.PSObject.Properties.Name -contains "severity") {
                $issues += @($entry)
            }
        }
        return $issues
    }

    if ($Data.PSObject.Properties.Name -contains "items") {
        return @($Data.items)
    }

    return $issues
}

function Get-ComponentPath([string]$Component, [string]$ProjectKey = "") {
    if ([string]::IsNullOrWhiteSpace($Component)) { return "" }
    if ($Component -match '^[^:]+:(.+)$') {
        return ($Matches[1] -replace '\\', '/')
    }
    if ($ProjectKey -and $Component.StartsWith("${ProjectKey}:")) {
        return ($Component.Substring($ProjectKey.Length + 1) -replace '\\', '/')
    }
    return ($Component -replace '\\', '/')
}

function Get-SeverityWeight([string]$Severity) {
    $severityText = if ($null -eq $Severity) { "" } else { $Severity }
    switch ($severityText.ToUpperInvariant()) {
        "BLOCKER" { return 100 }
        "CRITICAL" { return 80 }
        "MAJOR" { return 50 }
        "MINOR" { return 20 }
        "INFO" { return 5 }
        default { return 10 }
    }
}

function Get-TypeWeight([string]$Type) {
    $typeText = if ($null -eq $Type) { "" } else { $Type }
    switch ($typeText.ToUpperInvariant()) {
        "VULNERABILITY" { return 30 }
        "BUG" { return 20 }
        "CODE_SMELL" { return 10 }
        default { return 0 }
    }
}

function Get-IssueScore([object]$Issue, [bool]$IsNewCodeOnly = $false) {
    $score = 0
    $score += Get-SeverityWeight (Get-ObjProp $Issue "severity" "")
    $score += Get-TypeWeight (Get-ObjProp $Issue "type" "")

    $status = (Get-ObjProp $Issue "status" "").ToString().ToUpperInvariant()
    if ($status -in @("CLOSED", "RESOLVED")) { $score -= 120 }

    if (Get-ObjProp $Issue "line" $null) { $score += 3 }

    $isNew = $false
    if ($Issue.PSObject.Properties.Name -contains "isNew") { $isNew = To-Bool (Get-ObjProp $Issue "isNew" $false) }
    if ($isNew) { $score += 15 }

    if ($IsNewCodeOnly -and -not $isNew) { $score -= 25 }

    return $score
}

function Get-GitModifiedPaths {
    $git = Get-Command git -ErrorAction SilentlyContinue
    if (-not $git) {
        Write-Warn "git command not available. Skipping git filter."
        return $null
    }

    try {
        $inside = (git rev-parse --is-inside-work-tree 2>$null | Out-String).Trim().ToLowerInvariant()
        if ($inside -ne "true") {
            Write-Warn "Current folder is not inside a git repository. Skipping git filter."
            return $null
        }

        $lines = @(git status --porcelain 2>$null)
        $set = New-Object "System.Collections.Generic.HashSet[string]" ([System.StringComparer]::OrdinalIgnoreCase)

        foreach ($line in $lines) {
            if ([string]::IsNullOrWhiteSpace($line) -or $line.Length -lt 4) { continue }
            $path = $line.Substring(3).Trim()
            if ($path -match ' -> ') {
                $parts = $path.Split(' -> ')
                $path = $parts[-1].Trim()
            }
            $norm = ($path -replace '\\', '/').ToLowerInvariant()
            [void]$set.Add($norm)
        }

        Write-Info "Detected $($set.Count) git modified path(s)."
        return $set
    }
    catch {
        Write-Warn "Unable to read git status. Skipping git filter. $($_.Exception.Message)"
        return $null
    }
}

function Test-PathMatchesGitSet([string]$IssuePath, $GitSet) {
    if ($null -eq $GitSet) { return $true }
    if ([string]::IsNullOrWhiteSpace($IssuePath)) { return $false }

    $p = ($IssuePath -replace '\\', '/').ToLowerInvariant()
    if ($GitSet.Contains($p)) { return $true }

    foreach ($g in $GitSet) {
        if ($p.EndsWith("/$g") -or $g.EndsWith("/$p")) { return $true }
    }
    return $false
}

function Show-Help {
@"
rtk-sonar.ps1 - Sonar noise reduction helper

Usage:
  pwsh ./docs/assets/templates/sonar/rtk-sonar.example.ps1 collect   [options]
  pwsh ./docs/assets/templates/sonar/rtk-sonar.example.ps1 summarize [options]
  pwsh ./docs/assets/templates/sonar/rtk-sonar.example.ps1 prompt    [options]

collect options:
  --base-url <url>             Required. Sonar base URL, ex: https://sonar.myorg.local
  --token <token>              Optional. Uses SONAR_TOKEN env var if omitted.
  --projectKey <key>           Required. Sonar project key.
  --branch <name>              Optional. Branch filter.
  --pullRequest <id>           Optional. Pull request filter.
  --severities <csv>           Optional. Ex: BLOCKER,CRITICAL,MAJOR
  --newCodeOnly [true|false]   Optional. Default false. Maps to inNewCodePeriod=true.
  --maxItems <n>               Optional. Default 500.
  --pageSize <n>               Optional. Default 100. Max 500.
  --outDir <path>              Optional. Default current dir.
  --outFile <name>             Optional. Default sonar-issues.raw.json

summarize options:
  --input <file>               Required. Input issues json.
  --outDir <path>              Optional. Default current dir.
  --severities <csv>           Optional. Keep only selected severities.
  --newCodeOnly [true|false]   Optional. Default false.
  --git-modified-only          Optional. Restrict to git modified files.
  --top <n>                    Optional. Default 30.
  --projectKey <key>           Optional. Helps component path normalization.

prompt options:
  --input <file>               Optional. Default <outDir>/sonar-packet.json
  --outDir <path>              Optional. Default current dir.
  --top <n>                    Optional. Default 20.
  --outFile <name>             Optional. Default sonar-prompt.txt
"@ | Write-Host
}

function Run-Collect([hashtable]$Opts) {
    $baseUrl = Get-Opt $Opts @("base-url", "baseurl")
    $token = Get-Opt $Opts @("token")
    $projectKey = Get-Opt $Opts @("projectKey", "project-key", "project")
    $branch = Get-Opt $Opts @("branch")
    $pullRequest = Get-Opt $Opts @("pullRequest", "pull-request", "pr")
    $severities = To-StringList (Get-Opt $Opts @("severities", "severity"))
    $newCodeOnly = To-Bool (Get-Opt $Opts @("newCodeOnly", "new-code-only")) $false
    $maxItems = To-Int (Get-Opt $Opts @("maxItems", "max-items")) 500 1
    $pageSize = To-Int (Get-Opt $Opts @("pageSize", "page-size")) 100 1
    $outDir = Ensure-OutDir (Get-Opt $Opts @("outDir", "out-dir") ".")
    $outFile = Get-Opt $Opts @("outFile", "out-file") "sonar-issues.raw.json"

    if (-not $baseUrl) { throw "Missing required option: --base-url" }
    if (-not $projectKey) { throw "Missing required option: --projectKey" }
    if (-not $token) { $token = $env:SONAR_TOKEN }
    if (-not $token) { throw "Missing token. Pass --token or set SONAR_TOKEN." }

    if ($pageSize -gt 500) { $pageSize = 500 }

    $endpoint = "$($baseUrl.TrimEnd('/'))/api/issues/search"

    $encoded = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("${token}:"))
    $headers = @{ Authorization = "Basic $encoded" }

    Write-Info "Collecting issues from Sonar API..."
    Write-Info "Project: $projectKey | Branch: $branch | PullRequest: $pullRequest | MaxItems: $maxItems"

    $allIssues = New-Object System.Collections.Generic.List[object]
    $page = 1
    $serverTotal = $null

    while ($allIssues.Count -lt $maxItems) {
        $q = @{
            componentKeys = $projectKey
            p = $page
            ps = $pageSize
        }
        if ($branch) { $q.branch = $branch }
        if ($pullRequest) { $q.pullRequest = $pullRequest }
        if ($severities.Count -gt 0) { $q.severities = ($severities -join ",") }
        if ($newCodeOnly) { $q.inNewCodePeriod = "true" }

        $url = "$endpoint?$(Build-QueryString $q)"

        $resp = Invoke-WithRetry -Action {
            Invoke-RestMethod -Method Get -Uri $url -Headers $headers -ContentType "application/json"
        } -MaxAttempts 3

        if ($null -eq $serverTotal) {
            if ($resp.PSObject.Properties.Name -contains "total") { $serverTotal = [int]$resp.total }
            elseif ($resp.PSObject.Properties.Name -contains "paging") { $serverTotal = [int]$resp.paging.total }
            else { $serverTotal = 0 }
            Write-Info "Sonar total available: $serverTotal"
        }

        $issues = @($resp.issues)
        if ($issues.Count -eq 0) { break }

        foreach ($i in $issues) {
            if ($allIssues.Count -ge $maxItems) { break }
            $allIssues.Add($i)
        }

        Write-Info "Fetched page $page, total collected: $($allIssues.Count)"

        if ($issues.Count -lt $pageSize) { break }
        if ($serverTotal -gt 0 -and $allIssues.Count -ge $serverTotal) { break }

        $page++
    }

    $output = [ordered]@{
        tool = "rtk-sonar"
        mode = "collect"
        collectedAtUtc = (Get-Date).ToUniversalTime().ToString("o")
        source = [ordered]@{
            baseUrl = $baseUrl
            endpoint = "/api/issues/search"
            projectKey = $projectKey
            branch = $branch
            pullRequest = $pullRequest
            severities = $severities
            newCodeOnly = $newCodeOnly
        }
        paging = [ordered]@{
            pageSize = $pageSize
            pagesFetched = $page
            maxItems = $maxItems
            serverTotal = $serverTotal
            collected = $allIssues.Count
        }
        issues = @($allIssues)
    }

    $outPath = Join-Path $outDir $outFile
    Save-Json -Data $output -Path $outPath
    Write-Info "Raw Sonar JSON written: $outPath"
}

function Run-Summarize([hashtable]$Opts) {
    $input = Get-Opt $Opts @("input", "in", "file")
    $outDir = Ensure-OutDir (Get-Opt $Opts @("outDir", "out-dir") ".")
    $sevFilter = @(To-StringList (Get-Opt $Opts @("severities", "severity")) | ForEach-Object { $_.ToUpperInvariant() })
    $newCodeOnly = To-Bool (Get-Opt $Opts @("newCodeOnly", "new-code-only")) $false
    $gitModifiedOnly = To-Bool (Get-Opt $Opts @("git-modified-only", "gitmodifiedonly", "gitmodified")) $false
    $top = To-Int (Get-Opt $Opts @("top")) 30 1
    $projectKey = Get-Opt $Opts @("projectKey", "project-key", "project")

    if (-not $input) { throw "Missing required option: --input" }

    $data = Read-Json $input

    if (-not $projectKey -and $data.PSObject.Properties.Name -contains "source") {
        $pk = $data.source.projectKey
        if ($pk) { $projectKey = "$pk" }
    }

    $issues = @(Get-IssuesFromAnyJson $data)
    $inputCount = $issues.Count
    Write-Info "Input issues: $inputCount"

    $gitSet = $null
    if ($gitModifiedOnly) {
        $gitSet = Get-GitModifiedPaths
    }

    $filtered = New-Object System.Collections.Generic.List[object]
    foreach ($issue in $issues) {
        if ($null -eq $issue) { continue }

        $severity = (Get-ObjProp $issue "severity" "").ToString().ToUpperInvariant()
        if ($sevFilter.Count -gt 0 -and $severity -notin $sevFilter) { continue }

        if ($newCodeOnly) {
            $isNew = $false
            if ($issue.PSObject.Properties.Name -contains "isNew") { $isNew = To-Bool (Get-ObjProp $issue "isNew" $false) }
            if (-not $isNew) { continue }
        }

        $path = Get-ComponentPath -Component (Get-ObjProp $issue "component" "") -ProjectKey $projectKey
        if ($gitModifiedOnly -and -not (Test-PathMatchesGitSet -IssuePath $path -GitSet $gitSet)) { continue }

        $filtered.Add($issue)
    }

    $afterFilter = $filtered.Count
    Write-Info "After filter: $afterFilter"

    $seen = @{}
    $ranked = New-Object System.Collections.Generic.List[object]

    foreach ($issue in $filtered) {
        $path = Get-ComponentPath -Component (Get-ObjProp $issue "component" "") -ProjectKey $projectKey
        $lineValue = Get-ObjProp $issue "line" 0
        $line = if ($lineValue) { [int]$lineValue } else { 0 }
        $rule = (Get-ObjProp $issue "rule" "").ToString()
        $msg = (Get-ObjProp $issue "message" "").ToString().Trim()

        $dedupeKey = "$rule|$path|$line|$msg"
        if ($seen.ContainsKey($dedupeKey)) { continue }
        $seen[$dedupeKey] = $true

        $score = Get-IssueScore -Issue $issue -IsNewCodeOnly:$newCodeOnly

        $item = [ordered]@{
            score = $score
            key = (Get-ObjProp $issue "key" "").ToString()
            severity = (Get-ObjProp $issue "severity" "").ToString()
            type = (Get-ObjProp $issue "type" "").ToString()
            status = (Get-ObjProp $issue "status" "").ToString()
            rule = $rule
            message = $msg
            component = (Get-ObjProp $issue "component" "").ToString()
            file = $path
            line = $line
            effort = (Get-ObjProp $issue "effort" "").ToString()
            tags = @((Get-ObjProp $issue "tags" @()))
            isNew = if ($issue.PSObject.Properties.Name -contains "isNew") { To-Bool (Get-ObjProp $issue "isNew" $false) } else { $false }
            creationDate = (Get-ObjProp $issue "creationDate" "").ToString()
            updateDate = (Get-ObjProp $issue "updateDate" "").ToString()
            assignee = (Get-ObjProp $issue "assignee" "").ToString()
            author = (Get-ObjProp $issue "author" "").ToString()
        }

        $ranked.Add([pscustomobject]$item)
    }

    $afterDedup = $ranked.Count
    Write-Info "After dedupe: $afterDedup"

    $selected = @(
        $ranked |
            Sort-Object -Property @{ Expression = "score"; Descending = $true }, @{ Expression = "severity"; Descending = $true } |
            Select-Object -First $top
    )

    $packet = [ordered]@{
        tool = "rtk-sonar"
        mode = "summarize"
        generatedAtUtc = (Get-Date).ToUniversalTime().ToString("o")
        inputFile = (Resolve-Path -LiteralPath $input).Path
        filters = [ordered]@{
            severities = $sevFilter
            newCodeOnly = $newCodeOnly
            gitModifiedOnly = $gitModifiedOnly
            top = $top
            projectKey = $projectKey
        }
        counts = [ordered]@{
            input = $inputCount
            afterFilter = $afterFilter
            afterDedup = $afterDedup
            selected = $selected.Count
        }
        items = $selected
    }

    $packetJsonPath = Join-Path $outDir "sonar-packet.json"
    Save-Json -Data $packet -Path $packetJsonPath
    Write-Info "Written: $packetJsonPath"

    $mdPath = Join-Path $outDir "sonar-packet.md"
    $md = New-Object System.Collections.Generic.List[string]
    $md.Add("# Sonar packet")
    $md.Add("")
    $md.Add("- generatedAtUtc: $($packet.generatedAtUtc)")
    $md.Add("- input: $($packet.inputFile)")
    $md.Add("- selected: $($packet.counts.selected) / $($packet.counts.afterDedup)")
    $md.Add("")
    $md.Add("| Rank | Score | Severity | Type | File | Line | Rule | Message |")
    $md.Add("|---:|---:|---|---|---|---:|---|---|")

    $rank = 1
    foreach ($it in $selected) {
        $msg = "$($it.message)" -replace '\|', '/' -replace '\r?\n', ' '
        if ($msg.Length -gt 120) { $msg = $msg.Substring(0, 117) + "..." }

        $file = if ($it.file) { $it.file } else { $it.component }
        $md.Add("| $rank | $($it.score) | $($it.severity) | $($it.type) | $file | $($it.line) | $($it.rule) | $msg |")
        $rank++
    }

    Set-Content -LiteralPath $mdPath -Value ($md -join [Environment]::NewLine) -Encoding utf8
    Write-Info "Written: $mdPath"
}

function Run-Prompt([hashtable]$Opts) {
    $outDir = Ensure-OutDir (Get-Opt $Opts @("outDir", "out-dir") ".")
    $input = Get-Opt $Opts @("input", "in", "file")
    if (-not $input) { $input = Join-Path $outDir "sonar-packet.json" }
    $top = To-Int (Get-Opt $Opts @("top")) 20 1
    $outFile = Get-Opt $Opts @("outFile", "out-file") "sonar-prompt.txt"

    $packet = Read-Json $input
    $items = @($packet.items | Select-Object -First $top)

    $lines = New-Object System.Collections.Generic.List[string]
    $lines.Add("You are helping reduce Sonar issues before final patch submission.")
    $lines.Add("Apply minimal and safe edits. Keep behavior unchanged unless issue fix requires it.")
    $lines.Add("For each issue, propose exact file edits and rationale.")
    $lines.Add("")
    $lines.Add("Prioritized Sonar issues:")
    $i = 1
    foreach ($it in $items) {
        $msg = "$($it.message)" -replace '\r?\n', ' '
        if ($msg.Length -gt 160) { $msg = $msg.Substring(0, 157) + "..." }

        $file = if ($it.file) { $it.file } else { $it.component }
        $line = if ($it.line) { $it.line } else { 0 }
        $lines.Add("$i. [$($it.score)] [$($it.severity)] [$($it.type)] ${file}:$line | rule=$($it.rule) | $msg")
        $i++
    }

    $lines.Add("")
    $lines.Add("Return:")
    $lines.Add("1) grouped fix plan")
    $lines.Add("2) patch-ready code snippets")
    $lines.Add("3) quick validation checklist")

    $prompt = ($lines -join [Environment]::NewLine)
    $outPath = Join-Path $outDir $outFile
    Set-Content -LiteralPath $outPath -Value $prompt -Encoding utf8

    Write-Info "Prompt written: $outPath"
    Write-Host ""
    Write-Host $prompt
}

try {
    if (-not $CliArgs -or $CliArgs.Count -eq 0) {
        Show-Help
        exit 1
    }

    $command = $CliArgs[0].ToLowerInvariant()
    $rest = if ($CliArgs.Count -gt 1) { $CliArgs[1..($CliArgs.Count - 1)] } else { @() }
    $opts = Parse-Options $rest

    switch ($command) {
        "collect"   { Run-Collect $opts; break }
        "summarize" { Run-Summarize $opts; break }
        "prompt"    { Run-Prompt $opts; break }
        "help"      { Show-Help; break }
        "--help"    { Show-Help; break }
        "-h"        { Show-Help; break }
        default {
            throw "Unknown command: $command. Use: collect | summarize | prompt | help"
        }
    }
}
catch {
    $msg = $_.Exception.Message
    Write-Fail "rtk-sonar failed: $msg"
    exit 2
}








