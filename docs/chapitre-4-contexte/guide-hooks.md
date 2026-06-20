# Hooks Copilot

<span class="badge-vscode">VS Code</span> <span class="badge-expert">Expert</span>

## Présentation
Les hooks Copilot sont des **déclencheurs automatiques** qui exécutent des actions en réponse à des événements dans votre workflow de développement. Ils permettent d'intégrer Copilot dans des pipelines automatisés : validation de code, génération automatique de documentation, contrôles qualité, etc.

!!! info "Fonctionnalité en évolution"
    Les hooks Copilot sont une fonctionnalité relativement récente et en cours d'évolution active. Les capacités et APIs décrites ici correspondent à l'état de la fonctionnalité en 2025-2026. Consultez la [documentation GitHub Copilot](https://docs.github.com/copilot) pour les dernières mises à jour.

---

## Concept : Qu'est-ce qu'un hook ?

Un hook est un mécanisme qui **écoute un événement de session d'agent** et déclenche automatiquement une **commande shell**. Dans le contexte de l'agent Copilot VS Code :

```
Événement d'agent   →   Hook déclenché    →   Commande shell exécutée
──────────────────────────────────────────────────────────────────────
Avant un outil      →   PreToolUse        →   Validation / blocage
Après un outil      →   PostToolUse       →   Lint / format automatique
Début de session    →   SessionStart      →   Injection de contexte
Fin de session      →   Stop              →   Rapport / nettoyage
```

!!! warning "Les hooks `onSave`, `onOpen`, `pre-commit` ne sont PAS des hooks Copilot"
    Ces événements n'existent pas dans l'API de hooks Copilot VS Code. Les hooks Copilot écoutent les **événements de session d'agent** (PreToolUse, PostToolUse, etc.), pas les événements d'éditeur. Pour les hooks Git (`pre-commit`, `post-merge`), voir la section [Git Hooks](#hook-pre-commit-avec-git-hooks) plus bas.

---

## Types de hooks disponibles (réels)

Les hooks Copilot VS Code (Preview) supportent 8 événements de cycle de vie d'agent :

| Événement | Déclencheur | Cas d'usage |
|-----------|-------------|-------------|
| `SessionStart` | Première soumission d'un prompt | Injecter du contexte projet, logger le démarrage |
| `UserPromptSubmit` | Chaque soumission de prompt utilisateur | Auditer les requêtes, injecter du contexte système |
| `PreToolUse` | Avant qu'un outil soit invoqué | Bloquer des opérations dangereuses, demander confirmation |
| `PostToolUse` | Après qu'un outil se termine | Lancer un linter/formatter, logger les résultats |
| `PreCompact` | Avant la compaction du contexte | Exporter l'état important avant troncature |
| `SubagentStart` | Lancement d'un sous-agent | Tracker l'usage de sous-agents |
| `SubagentStop` | Fin d'un sous-agent | Agréger les résultats |
| `Stop` | Fin de la session d'agent | Générer des rapports, nettoyer les ressources |

---

## Configuration des hooks Copilot

### Format de fichier

Les hooks se configurent dans des **fichiers JSON** placés dans `.github/hooks/` :

```
mon-projet/
└── .github/
    └── hooks/
        ├── format.json      ← Hook de formatage post-édition
        └── security.json    ← Hook de validation pré-outil
```

Structure du fichier JSON :

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "type": "command",
        "command": "npx prettier --write \"$TOOL_INPUT_FILE_PATH\""
      }
    ],
    "PreToolUse": [
      {
        "type": "command",
        "command": "./scripts/validate-tool.sh",
        "timeout": 15
      }
    ]
  }
}
```

### Propriétés d'une commande hook

| Propriété | Type | Description |
|-----------|------|-------------|
| `type` | string | Obligatoire — toujours `"command"` |
| `command` | string | Commande à exécuter (cross-platform) |
| `windows` | string | Commande spécifique Windows (override) |
| `linux` | string | Commande spécifique Linux (override) |
| `osx` | string | Commande spécifique macOS (override) |
| `cwd` | string | Répertoire de travail (relatif à la racine du repo) |
| `timeout` | number | Timeout en secondes (défaut : 30) |

### Variables d'environnement disponibles

Les hooks reçoivent des informations via des variables d'environnement et via `stdin` (JSON) :

| Variable | Description |
|----------|-------------|
| `$TOOL_INPUT_FILE_PATH` | Chemin du fichier modifié (PostToolUse) |
| `$TOOL_NAME` | Nom de l'outil invoqué |

!!! tip "Via stdin"
    Chaque hook reçoit aussi un objet JSON complet via `stdin` avec `tool_name`, `tool_input`, `sessionId`, etc. Utilisez-le dans vos scripts shell pour une logique avancée.

### Exemple minimal : formater après chaque édition

Créez `.github/hooks/format.json` :

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "type": "command",
        "command": "npx prettier --write \"$TOOL_INPUT_FILE_PATH\""
      }
    ]
  }
}
```

---

## Personnalisation des messages de commit

!!! info "Ce n'est pas un hook au sens strict"
    La génération de message de commit est une fonctionnalité distincte des hooks d'agent. Elle se configure dans `settings.json` et s'active manuellement via l'icône ✨ dans la vue Source Control.

### Configuration via settings VS Code

```json
{
    "github.copilot.chat.commitMessageGeneration.instructions": [
        {
            "text": "Génère les messages de commit en français, format Conventional Commits (feat/fix/docs/chore). Maximum 72 caractères pour le sujet."
        }
    ]
}
```

**Activation :**

1. Dans la vue Source Control de VS Code
2. Cliquez sur l'icône étoile ✨ dans le champ de message de commit
3. Copilot analyse vos changements et génère un message

---

## Hook pre-commit avec Git Hooks

Pour intégrer Copilot dans un hook Git pre-commit, vous pouvez combiner les hooks Git natifs avec des prompts Copilot :

### Exemple : Validation pre-commit automatique

Créez `.git/hooks/pre-commit` :

```bash
#!/bin/sh
# Hook pre-commit : vérifications minimales avant commit

# Vérifier si des fichiers .env sont staged
if git diff --cached --name-only | grep -E '\.env$|\.env\.' > /dev/null 2>&1; then
    echo "❌ ERREUR: Des fichiers .env sont dans le staging area !"
    echo "   Retirez-les avec: git reset HEAD <fichier.env>"
    exit 1
fi

# Vérifier les TODO/FIXME critiques dans le code staged
if git diff --cached | grep -E '^\+.*(FIXME|HACK|XXX)' > /dev/null 2>&1; then
    echo "⚠️  ATTENTION: Des marqueurs FIXME/HACK/XXX ont été ajoutés."
    echo "   Vérifiez s'ils doivent être résolus avant le commit."
    # exit 1  # Décommenter pour bloquer le commit
fi

echo "✅ Pre-commit checks passed"
exit 0
```

!!! tip "Commenter avec Copilot"
    Après avoir écrit votre hook, demandez à Copilot Chat : "*Améliore ce hook pre-commit pour ajouter des vérifications de sécurité supplémentaires*".

---

## Hooks via GitHub Actions + Copilot

Pour des environnements d'équipe, les hooks Copilot s'intègrent dans GitHub Actions :

### Workflow de revue automatique

```yaml
# .github/workflows/copilot-review.yml
name: Copilot PR Review

on:
  pull_request:
    types: [opened, synchronize]

jobs:
  copilot-review:
    runs-on: ubuntu-latest
    permissions:
      pull-requests: write
    steps:
      - uses: actions/checkout@v4
      
      - name: Request Copilot Review
        # GitHub Copilot peut être configuré pour reviewer automatiquement les PRs
        # via les paramètres du repository dans GitHub.com
        run: echo "Copilot review requested via GitHub settings"
```

!!! info "Revue automatique de PR par Copilot"
    GitHub Copilot peut être configuré pour commenter automatiquement sur les Pull Requests. Activez-le depuis les paramètres de votre repository → Code and automation → GitHub Copilot.

---

## Hook de génération de documentation automatique

Configurez VS Code pour suggérer une mise à jour de documentation quand vous modifiez une fonction :

```json
{
    "github.copilot.chat.codeGeneration.instructions": [
        {
            "text": "Quand tu génères du code, ajoute toujours la documentation JSDoc/TSDoc correspondante."
        }
    ]
}
```

### Instructions via `.github/copilot-instructions.md`

Vous pouvez aussi configurer un comportement "hook-like" via les instructions globales :

```markdown
# Instructions GitHub Copilot

## Comportement automatique attendu

### Lors de la génération de code
- Toujours ajouter JSDoc/TSDoc pour les fonctions/classes publiques
- Toujours inclure des tests unitaires de base dans un bloc de commentaires
- Signaler si une fonction dépasse 30 lignes (suggérer un refactoring)

### Lors de la modification de code existant
- Si tu modifies une fonction documentée, mets à jour la documentation
- Si tu ajoutes un paramètre, documente-le dans le JSDoc existant
```

---

## Cas d'usage pratiques

### 1. Validation de qualité post-édition

Configurez un snippet VS Code qui se déclenche après l'acceptation d'une suggestion :

```json
// .vscode/tasks.json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Validate with ESLint",
            "type": "shell",
            "command": "npx eslint ${file} --fix",
            "runOptions": { "runOn": "folderOpen" },
            "group": "test"
        }
    ]
}
```

Combinez avec une keybinding pour déclencher la validation après une session Copilot :

```json
// keybindings.json
{
    "key": "ctrl+alt+v",
    "command": "workbench.action.tasks.runTask",
    "args": "Validate with ESLint"
}
```

### 2. Hook de message de commit personnalisé

```json
{
    "github.copilot.chat.commitMessageGeneration.instructions": [
        {
            "file": ".github/commit-instructions.md"
        }
    ]
}
```

```markdown
<!-- .github/commit-instructions.md -->
# Instructions pour les messages de commit

## Format obligatoire
type(scope): description courte en français (max 72 chars)

## Types acceptés
- feat: nouvelle fonctionnalité
- fix: correction de bug
- docs: documentation uniquement
- refactor: refactoring sans changement de comportement
- test: ajout/modification de tests
- chore: tâches de maintenance

## Exemple
feat(auth): ajouter la vérification 2FA par SMS
```

---

## Limites actuelles

!!! warning "Ce que les hooks ne peuvent pas faire (encore)"

    - **Déclencher des actions arbitraires** à partir de n'importe quel événement VS Code
    - **Modifier le comportement de complétion inline** en temps réel
    - **Intercepter** les suggestions avant leur affichage pour les filtrer
    - **S'intégrer nativement** avec des outils externes (Jira, Slack) sans extension tierce

    Ces capacités évoluent rapidement. Consultez les [release notes VS Code](https://code.visualstudio.com/updates) pour les nouvelles fonctionnalités Copilot.

---

## Sources

- [Customizing GitHub Copilot in your organization](https://docs.github.com/en/copilot/customizing-copilot/creating-a-custom-model-for-github-copilot) - consulté le 2026-06-20
- [About customizing GitHub Copilot Chat responses](https://docs.github.com/en/copilot/customizing-copilot/customizing-the-behavior-of-github-copilot-chat/about-customizing-github-copilot-chat-responses) - consulté le 2026-06-20

## Prochaine étape

**[Paramètres du Dépôt](parametres-depot.md)** : centraliser et versionner la configuration Copilot dans `.github/` pour la partager avec toute l'équipe.

Concepts clés couverts :

- **Couches de personnalisation** — Instructions, Skills, Agents combinés
- **Arborescence recommandée** — `.github/copilot-instructions.md`, `instructions/`, `prompts/`, `agents/`, `skills/`
- **Fichier AGENT.md à la racine** — Catalogue et orchestration des agents
- **Priorité des fichiers** — Ordre d'application et résolution de conflits
