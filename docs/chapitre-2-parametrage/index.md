# GitHub Copilot — Paramétrage (référence)

Ce chapitre conserve les réglages et personnalisations **GitHub Copilot** pour IntelliJ IDEA et Visual Studio Code.

!!! info "Parcours principal Claude Code"
    Pour le paramétrage recommandé dans ce dépôt, utilisez désormais [Architecture et paramétrage Claude Code](../chapitre-3b-claude-code-migration-copilot/architecture-claude.md). Les pages Copilot restent disponibles pour les environnements qui l'utilisent encore et pour faciliter les comparaisons ou un retour futur.

---

## Pages Copilot conservées

<div class="grid cards" markdown>

- :simple-intellijidea: **[IntelliJ — Paramétrage Copilot](intellij-parametrage.md)**

    Réglages du plugin et personnalisations disponibles dans l'écosystème JetBrains.

- :material-microsoft-visual-studio-code: **[VS Code — Paramétrage Copilot](vscode-parametrage.md)**

    Réglages de l'extension et personnalisations spécifiques à VS Code.

- :material-compare: **[Comparaison des paramètres](comparaison-parametres.md)**

    Différences de surface entre VS Code et JetBrains.

</div>

---

## Attention aux différences entre IDE

Les personnalisations Copilot ne sont pas disponibles au même niveau partout. D'après la matrice GitHub actuelle :

- VS Code dispose du support le plus complet pour les instructions, prompt files, agents, subagents, skills et MCP ;
- plusieurs fonctionnalités de personnalisation restent en **preview** dans JetBrains ;
- les hooks ne sont pas actuellement une fonctionnalité JetBrains équivalente à celle de Copilot CLI / cloud agent et des surfaces qui les prennent en charge.

Avant de recopier un réglage d'un IDE à l'autre, vérifiez la [Copilot customization cheat sheet](https://docs.github.com/en/copilot/reference/customization-cheat-sheet).

---

## Équivalences utiles avec Claude Code

| Besoin | Claude Code | Copilot conservé dans ce dépôt |
|---|---|---|
| Instructions projet | `CLAUDE.md`, `AGENTS.md`, `.claude/rules/` | `.github/copilot-instructions.md`, instructions ciblées |
| Réglages partagés | `.claude/settings.json` | réglages IDE / politiques Copilot |
| Capacité réutilisable | `.claude/skills/<nom>/SKILL.md` | `.github/skills/`, `.claude/skills/` ou `.agents/skills/` selon surface |
| Agent spécialisé | `.claude/agents/*.md` | `.github/agents/*.agent.md` ou profils compatibles |
| Automatisation lifecycle | hooks Claude dans settings | hooks Copilot sur surfaces prises en charge |
| Outils externes | MCP / `.mcp.json` | MCP selon IDE / agent / configuration GitHub |

!!! tip "Ne dupliquez pas inutilement les skills"
    Certaines surfaces Copilot savent lire `.claude/skills`. Lorsqu'un skill peut réellement rester générique, préférez une seule source compatible plutôt qu'une copie Claude et une copie Copilot qui divergent.

---

## Prochaine étape

Poursuivez avec **[IntelliJ IDEA](intellij-parametrage.md)**, la page suivante dans le menu.

## Sources

Sources officielles consultées le **28 septembre 2026** :

- [GitHub Docs — Copilot customization cheat sheet](https://docs.github.com/en/copilot/reference/customization-cheat-sheet)
- [GitHub Docs — Agent skills](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/customize-cloud-agent/add-skills)
- [GitHub Docs — Hooks](https://docs.github.com/en/copilot/concepts/agents/hooks)
- [Claude Code — Settings](https://code.claude.com/docs/en/settings)
- [Claude Code — `.claude` directory](https://code.claude.com/docs/en/claude-directory)
