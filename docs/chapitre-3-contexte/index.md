# Contexte & Personnalisation

GitHub Copilot n'est pas un simple outil d'autocomplétion — c'est un système dont la qualité des suggestions dépend directement de la **qualité du contexte** que vous lui fournissez. Ce chapitre couvre tous les mécanismes disponibles pour enrichir ce contexte et personnaliser le comportement de Copilot.

---

## Qu'est-ce que le "contexte" pour Copilot ?

Quand vous tapez du code, Copilot ne lit pas seulement la ligne courante — il analyse l'ensemble du contexte disponible pour générer des suggestions pertinentes :

```
┌─────────────────────────────────────────────────┐
│              CONTEXTE DE COPILOT                │
├─────────────────────────────────────────────────┤
│  1. Fichier actuel (position du curseur)        │  ← Priorité max
│  2. Fichiers ouverts dans les onglets           │  ← Haute priorité
│  3. Fichiers récemment édités                   │  ← Priorité moyenne
│  4. Instructions (.instructions.md)             │  ← Globales/ciblées
│  5. Structure du workspace/projet               │  ← Contexte projet
└─────────────────────────────────────────────────┘
```

---

## Les mécanismes de personnalisation

Ce chapitre documente tous les mécanismes disponibles pour personnaliser Copilot :

<div class="grid cards" markdown>

- :material-file-cog: **[Concepts fondamentaux](concepts.md)**

    Fenêtre de contexte, tokens, priorités, strategies pour améliorer les suggestions

- :material-file-code: **[Instructions (.instructions.md)](instructions.md)**

    Règles persistantes pour guider Copilot sur les conventions du projet

- :material-tune-variant: **[applyTo avancé](applyto-avance.md)**

    Écrire des patterns glob robustes pour cibler précisément les fichiers

- :material-file-document: **[Prompt Files (.prompt.md)](prompt-files.md)**

    Prompts réutilisables pour des tâches récurrentes

- :material-robot: **[Agents (.agent.md)](agents.md)**

    Agents IA custom avec comportements et outils spécialisés

- :material-lightbulb: **[Skills (SKILL.md)](skills.md)**

    Packages de connaissance domaine pour des expertise métier

- :material-folder-cog: **[Paramètres du dépôt](parametres-depot.md)**

    Structurer `.github/`, `AGENT.md`, et la gouvernance de personnalisation

- :material-console: **[Références fichiers & CLI](../chapitre-8-cli-modes/page-principale.md)**

    Utiliser `#fichier` et `@fichier`, plus les points d'attention CLI

- :material-hook: **[Hooks](hooks.md)**

    Automatisations déclenchées par les actions Copilot

- :material-microsoft-visual-studio-code: **[VS Code — Contexte projet](vscode-contexte.md)**

    `.code-workspace`, `.copilotignore`, structuration pour VS Code

- :simple-intellijidea: **[IntelliJ — Contexte projet](intellij-contexte.md)**

    Modules, indexation, bonnes pratiques pour IntelliJ

- :material-compare: **[Comparaison](comparaison-contexte.md)**

    Ce qui est natif VS Code vs ce qui s'applique aussi à IntelliJ

</div>

---

## En un coup d'œil

| Mécanisme | Emplacement | Qui l'utilise | VS Code | IntelliJ |
|-----------|-------------|--------------|:-------:|:--------:|
| `copilot-instructions.md` | `.github/` | Tous | ✅ | ✅ |
| `.instructions.md` | `.github/instructions/` | Développeurs, équipes | ✅ | ✅ |
| `AGENT.md` | Racine du repo | Équipes avancées | ✅ | ✅ |
| `.prompt.md` | `.github/prompts/` | Développeurs | ✅ | ✅ |
| `.agent.md` | `.github/agents/` | Équipes avancées | ✅ | ✅ |
| `SKILL.md` | Workspace | Experts | ✅ | ⚠️ lecture seule |
| Hooks | `.github/` | Équipes DevOps | ✅ | ❌ |
| `.copilotignore` | Racine du projet | Tous | ✅ | ⚠️ via `.gitignore` |
| Structure projet | Partout | Tous | ✅ | ✅ |

!!! info "Support IntelliJ"
    `copilot-instructions.md`, `.instructions.md`, `.prompt.md`, `.agent.md` et `SKILL.md` sont supportés dans IntelliJ IDEA via le plugin GitHub Copilot. La création de `SKILL.md` via l'interface reste réservée à VS Code, mais les fichiers créés manuellement ou via VS Code sont bien pris en compte par IntelliJ. Seuls les hooks restent spécifiques à VS Code.

