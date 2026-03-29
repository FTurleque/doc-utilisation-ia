# Hooks Copilot

<span class="badge-vscode">VS Code</span> <span class="badge-expert">Expert</span>

## Présentation
Les hooks Copilot sont des **déclencheurs automatiques** qui exécutent des actions en réponse à des événements dans votre workflow de développement. Ils permettent d'intégrer Copilot dans des pipelines automatisés : validation de code, génération automatique de documentation, contrôles qualité, etc.

!!! info "Fonctionnalité en évolution"
    Les hooks Copilot sont une fonctionnalité relativement récente et en cours d'évolution active. Les capacités et APIs décrites ici correspondent à l'état de la fonctionnalité en 2025-2026. Consultez la [documentation GitHub Copilot](https://docs.github.com/copilot) pour les dernières mises à jour.

---

## Concept : Qu'est-ce qu'un hook ?

Un hook est un mécanisme qui **écoute un événement** et déclenche une action automatiquement. Dans le contexte de Copilot :

```
Événement        →     Hook déclenché     →     Action Copilot
─────────────────────────────────────────────────────────────
Sauvegarde      →    pre-save hook       →    Vérification qualité
Commit Git      →    pre-commit hook     →    Revue Copilot automatique
Suggestion     →    post-accept hook    →    Application de conventions
Build fail     →    on-error hook       →    Suggestion de correction
```

---

## Types de hooks disponibles

### Hooks d'éditeur (VS Code)

| Hook | Événement déclencheur | Cas d'usage |
|------|----------------------|-------------|
| `onSave` | Sauvegarde d'un fichier | Validation format, lint automatique |
| `onOpen` | Ouverture d'un fichier | Chargement du contexte spécifique |
| `onCodeAction` | Action de code (ampoule) | Actions contextuelles personnalisées |

### Hooks de workflow

| Hook | Événement | Cas d'usage |
|------|-----------|-------------|
| `pre-commit` | Avant un commit Git | Revue de code automatique |
| `post-merge` | Après un merge | Mise à jour documentation |
| `on-build-error` | Erreur de build | Suggestion de correction Copilot |

---

## Configuration des hooks dans VS Code

### Via les settings VS Code

Les hooks Copilot se configurent dans `settings.json` ou dans un fichier de configuration dédié :

```json
{
    "github.copilot.chat.commitMessageGeneration.instructions": [
        {
            "text": "Génère les messages de commit en français, format Conventional Commits (feat/fix/docs/chore). Maximum 72 caractères pour le sujet."
        }
    ]
}
```

### Hook de génération de message de commit

L'un des hooks les plus utiles : Copilot peut générer automatiquement des messages de commit basés sur vos changements.

**Activation :**

1. Dans la vue Source Control de VS Code
2. Cliquez sur l'icône étoile ✨ dans le champ de message de commit
3. Copilot analyse vos changements et génère un message

**Personnalisation via settings :**

```json
{
    "github.copilot.chat.commitMessageGeneration.instructions": [
        {
            "text": "Format: Conventional Commits. Langue: français. Structure: type(scope): description courte\n\nCorps optionnel avec détails."
        }
    ]
}
```

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

## Prochaines étapes

- [Paramètres du Dépôt](parametres-depot.md) — Centraliser la configuration Copilot dans le dépôt
- [VS Code — Contexte projet](vscode-contexte.md) — Intégrer tous ces mécanismes dans la structure de votre projet
- [IntelliJ — Contexte projet](intellij-contexte.md) — Équivalents pour IntelliJ
