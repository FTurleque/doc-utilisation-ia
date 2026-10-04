# rtk-sonar — exemple PowerShell 7+

Outil CLI local pour réduire le bruit Sonar avant de transmettre un lot borné à **Claude Code** ou, en référence, à GitHub Copilot.

## Rôle des fichiers de ce dossier

- `rtk-sonar.example.ps1` — collecte, filtre et prépare un paquet Sonar ;
- `sonar-*.prompt.md` — **templates GitHub Copilot** au format prompt file ;
- `sonar-remediation.agent.md` — **template GitHub Copilot** de custom agent ;
- `sonar.instructions.md` — règles génériques réutilisables ;
- `mcp-config.example.json` / `sonar-mcp.env.example` — exemples pédagogiques MCP/environnement ;
- `sonar-issues.sample.json` — données d'exemple.

L'équivalent Claude Code du rôle de remédiation est versionné dans `.claude/agents/sonar-remediation.md`.

## Prérequis

- PowerShell 7+ ;
- accès à l'API Sonar avec un token adapté ;
- Git optionnel pour le filtre `--git-modified-only`.

Ne committez jamais un token réel. Utilisez une variable d'environnement ou le mécanisme de secret approprié à votre environnement.

## Commandes

```powershell
pwsh .\docs\assets\templates\sonar\rtk-sonar.example.ps1 help
```

### Collecter

```powershell
$env:SONAR_TOKEN = "<token-local>"
pwsh .\docs\assets\templates\sonar\rtk-sonar.example.ps1 collect `
  --base-url "https://sonar.example.internal" `
  --projectKey "mon-projet" `
  --branch "ma-branche" `
  --severities "BLOCKER,CRITICAL,MAJOR" `
  --newCodeOnly true `
  --maxItems 400 `
  --outDir ".\tmp"
```

Le script écrit par défaut `sonar-issues.raw.json` dans le dossier de sortie choisi.

### Résumer

```powershell
pwsh .\docs\assets\templates\sonar\rtk-sonar.example.ps1 summarize `
  --input ".\tmp\sonar-issues.raw.json" `
  --severities "BLOCKER,CRITICAL,MAJOR" `
  --git-modified-only `
  --top 25 `
  --outDir ".\tmp"
```

Cette étape filtre, déduplique et priorise les issues dans `sonar-packet.json` / `sonar-packet.md`.

### Générer un prompt compact

```powershell
pwsh .\docs\assets\templates\sonar\rtk-sonar.example.ps1 prompt `
  --input ".\tmp\sonar-packet.json" `
  --top 20 `
  --outDir ".\tmp"
```

Le fichier `sonar-prompt.txt` est du **texte de prompt générique** : il peut être fourni à Claude Code ou à un autre assistant après revue humaine.

## Garde-fous

- une issue ou une règle à la fois pour les corrections ;
- ne jamais utiliser `NOSONAR` ou désactiver une règle comme substitut automatique à une correction ;
- compiler/tester après modification ;
- ne pas committer les JSON bruts lorsqu'ils contiennent du code, des chemins ou métadonnées sensibles ;
- ne pas pousser/merger automatiquement dans `main`.

Les exemples d'URL, project keys, branches et tokens de ce dossier sont des placeholders : adaptez-les à votre environnement sans versionner de secret.
