# push-and-deploy.ps1
# Nom historique conservé pour compatibilité.
# Le script NE déploie PAS et NE pousse JAMAIS directement sur main.
# Il valide la documentation, commit optionnellement les changements, puis pousse
# la branche de travail courante. Le déploiement est déclenché après merge manuel
# de la PR par .github/workflows/deploy.yml.
#
# Usage :
#   .\scripts\push-and-deploy.ps1
#   .\scripts\push-and-deploy.ps1 -CommitMessage "docs: actualiser une page"

param(
    [string]$CommitMessage = ""
)

$ErrorActionPreference = "Stop"

$branch = (git branch --show-current).Trim()
if (-not $branch) {
    throw "Impossible de déterminer la branche courante (HEAD détaché ?)."
}

if ($branch -in @("main", "master")) {
    throw "Refus : ce script ne pousse jamais directement sur '$branch'. Crée une branche puis ouvre une Pull Request."
}

Write-Host "1/4 - Build MkDocs strict..."
python -m mkdocs build --strict
if ($LASTEXITCODE -ne 0) { throw "Le build MkDocs a échoué." }

Write-Host "2/4 - Validation des liens et ancres internes..."
python scripts/validate-links.py
if ($LASTEXITCODE -ne 0) { throw "La validation des liens a échoué." }

$hasChanges = -not [string]::IsNullOrWhiteSpace((git status --porcelain))
if ($hasChanges) {
    if ([string]::IsNullOrWhiteSpace($CommitMessage)) {
        throw "Des changements non commités existent. Relance avec -CommitMessage 'type: description' ou committe-les manuellement."
    }

    Write-Host "3/4 - Commit des changements sur '$branch'..."
    git add -A
    git commit -m $CommitMessage
    if ($LASTEXITCODE -ne 0) { throw "Le commit a échoué." }
} else {
    Write-Host "3/4 - Aucun changement local à committer."
}

Write-Host "4/4 - Push de la branche '$branch'..."
git push -u origin $branch
if ($LASTEXITCODE -ne 0) { throw "Le push de la branche a échoué." }

Write-Host "Terminé. Ouvre ou mets à jour une Pull Request vers main. Le déploiement aura lieu seulement après son merge manuel."
