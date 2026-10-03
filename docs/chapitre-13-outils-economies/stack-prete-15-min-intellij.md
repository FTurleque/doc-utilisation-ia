# Stack locale rapide — IntelliJ + Claude Code

<span class="badge-beginner">Débutant</span> <span class="badge-intellij">IntelliJ</span>

Cette page adapte le parcours local-first à IntelliJ IDEA. Le socle n'est plus Continue : **Claude Code reste l'agent principal**, éventuellement connecté à Ollama ou LM Studio comme backend compatible Anthropic.

IntelliJ apporte en plus ses inspections, refactorings, navigation structurelle et intégration SonarQube.

---

## Stack cible

```text
IntelliJ IDEA
├── refactorings / inspections / tests natifs
├── Claude Code
│   ├── backend Claude habituel
│   ├── OU Ollama
│   └── OU LM Studio
├── SonarQube for IDE (optionnel)
└── RTK pour les sorties terminal volumineuses (optionnel)
```

---

## 1. Utiliser d'abord l'IDE

Avant tout appel agentique, exploitez :

- Inspect Code ;
- Find Usages ;
- Rename / Extract / Change Signature ;
- navigation symboles/classes ;
- debugger ;
- tests ciblés ;
- analyse Sonar lorsque disponible.

Pour une transformation déterministe, l'IDE reste généralement plus sûr qu'une génération probabiliste.

---

## 2. Installer/configurer Claude Code

Suivez le guide JetBrains Claude Code du chapitre installation. Le plugin JetBrains s'appuie sur la CLI Claude Code : vérifiez donc l'installation avec :

```bash
claude --version
claude doctor
```

Puis testez la connexion IDE depuis un petit projet avant de l'utiliser sur un dépôt critique.

---

## 3. Backend local avec Ollama

Ollama peut configurer Claude Code directement :

```bash
ollama launch claude
```

Ou utilisez :

```bash
export ANTHROPIC_AUTH_TOKEN=ollama
export ANTHROPIC_BASE_URL=http://localhost:11434
claude --model <modele-local>
```

---

## 4. Backend local avec LM Studio

```bash
lms server start --port 1234
export ANTHROPIC_BASE_URL=http://localhost:1234
export ANTHROPIC_AUTH_TOKEN=lmstudio
export CLAUDE_CODE_ATTRIBUTION_HEADER=0
claude --model <modele-local>
```

Si LM Studio est exposé au réseau, activez l'authentification et limitez le bind réseau.

---

## 5. Ajouter SonarQube for IDE

SonarQube est particulièrement pertinent avec IntelliJ :

```text
issue Sonar
→ Quick Fix / intention IntelliJ si possible
→ Claude si analyse complexe
→ compilation + tests
→ réanalyse Sonar
```

Connected Mode et MCP Sonar sont optionnels et dépendent de l'infrastructure d'équipe.

---

## 6. Ajouter RTK seulement si utile

Pour des builds Gradle/Maven ou suites de tests verbeuses :

```bash
rtk init --global --dry-run
rtk init --global
rtk gain
```

Si un diagnostic devient incomplet, relancez la commande sans filtrage.

---

## Critères de validation

La stack est prête lorsque :

- l'IDE compile et teste sans dépendre de l'IA ;
- Claude Code voit le bon dépôt et les bonnes instructions ;
- le modèle choisi réussit les tool calls nécessaires ;
- les secrets restent hors Git ;
- un changement agentique peut être relu via diff ;
- Sonar et les tests, s'ils existent, servent de validation objective.

---

## Continue — référence legacy

L'ancien montage IntelliJ + Continue + Ollama est conservé uniquement pour les installations existantes. Le dépôt Continue n'étant plus activement maintenu, ne construisez pas un nouveau standard d'équipe autour de son plugin JetBrains.

---

### Configuration locale et retour au fournisseur habituel

Les blocs `export` ciblent Bash (Linux, macOS ou WSL). Dans PowerShell, utilisez par exemple `$env:ANTHROPIC_BASE_URL = "http://localhost:11434"` pour Ollama, ou le port `1234` pour LM Studio, puis définissez `$env:ANTHROPIC_AUTH_TOKEN`. Pour LM Studio, ajoutez `$env:CLAUDE_CODE_ATTRIBUTION_HEADER = "0"`, comme dans son guide actuel. Ces variables routent la session vers un autre backend : retirez-les avant de revenir à votre connexion Claude habituelle et vérifiez `/status`.

Exigez un modèle prenant en charge les appels d’outils et testez un petit changement avec validation. Un modèle servi localement ne rend pas automatiquement locaux les MCP, recherches Web ou autres outils de la session.

Guides revérifiés le **3 octobre 2026** : [Ollama — compatibilité Anthropic](https://docs.ollama.com/api/anthropic-compatibility) et [LM Studio — Claude Code](https://lmstudio.ai/docs/integrations/claude-code).

## Sources

- [Claude Code — JetBrains](https://code.claude.com/docs/en/jetbrains) — consulté le 2026-09-28
- [Ollama — Claude Code](https://docs.ollama.com/api/anthropic-compatibility) — consulté le 2026-09-28
- [LM Studio — Claude Code](https://lmstudio.ai/docs/integrations/claude-code) — consulté le 2026-09-28
- [SonarQube MCP Server](https://github.com/SonarSource/sonarqube-mcp-server) — consulté le 2026-09-28

## Prochaine étape

Poursuivez avec **[Vue d'ensemble](agents-code/index.md)**, la page suivante dans le menu.
