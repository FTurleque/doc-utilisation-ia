# rtk-sonar (PowerShell 7+)

Outil CLI local pour reduire le bruit Sonar avant envoi a Copilot.

## Preconditions

- PowerShell 7+
- Acces Sonar API (token utilisateur)
- Optionnel: git disponible pour `--git-modified-only`

## Commandes

Le script d'exemple est: `docs/assets/templates/sonar/rtk-sonar.example.ps1`

```powershell
pwsh .\docs\assets\templates\sonar\rtk-sonar.example.ps1 help
```

### 1) collect

Recupere les issues Sonar via `/api/issues/search` avec pagination bornee.

```powershell
$env:SONAR_TOKEN = "xxxx"   # ne pas commiter ce token
pwsh .\docs\assets\templates\sonar\rtk-sonar.example.ps1 collect `
  --base-url "https://sonar.myorg.local" `
  --projectKey "doc-utilisation-ia" `
  --branch "main" `
  --severities "BLOCKER,CRITICAL,MAJOR" `
  --newCodeOnly true `
  --maxItems 400 `
  --outDir ".\tmp"
```

Fichier genere par defaut:
- `tmp/sonar-issues.raw.json`

Options utiles:
- `--pullRequest 123`
- `--pageSize 200`
- `--outFile sonar-pr-123.raw.json`

### 2) summarize

Lit un JSON Sonar, applique filtres, dedup, priorisation, et genere:
- `sonar-packet.json`
- `sonar-packet.md`

```powershell
pwsh .\docs\assets\templates\sonar\rtk-sonar.example.ps1 summarize `
  --input ".\tmp\sonar-issues.raw.json" `
  --severities "BLOCKER,CRITICAL,MAJOR" `
  --git-modified-only `
  --top 25 `
  --outDir ".\tmp"
```

Comportement safe:
- si git absent ou hors repo: warning + filtre git ignore (pas d echec).

### 3) prompt

Genere un prompt compact pret a coller dans Copilot a partir de `sonar-packet.json`.

```powershell
pwsh .\docs\assets\templates\sonar\rtk-sonar.example.ps1 prompt `
  --input ".\tmp\sonar-packet.json" `
  --top 20 `
  --outDir ".\tmp"
```

Fichier genere par defaut:
- `tmp/sonar-prompt.txt`

## Flux recommande equipe

```powershell
pwsh .\docs\assets\templates\sonar\rtk-sonar.example.ps1 collect --base-url "https://sonar.myorg.local" --projectKey "doc-utilisation-ia" --branch "main" --maxItems 500 --outDir ".\tmp"
pwsh .\docs\assets\templates\sonar\rtk-sonar.example.ps1 summarize --input ".\tmp\sonar-issues.raw.json" --git-modified-only --top 30 --outDir ".\tmp"
pwsh .\docs\assets\templates\sonar\rtk-sonar.example.ps1 prompt --input ".\tmp\sonar-packet.json" --top 20 --outDir ".\tmp"
```

## Notes securite

- Le token n est jamais affiche par le script.
- Preferer variable d environnement `SONAR_TOKEN`.
- Ne pas commiter les JSON bruts si sensibles.



