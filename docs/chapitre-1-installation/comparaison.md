# GitHub Copilot — Installation IntelliJ vs VS Code (référence)

Cette page compare les deux expériences d'installation **GitHub Copilot** conservées dans la documentation.

!!! info "Claude-first"
    Pour une nouvelle configuration de ce dépôt, consultez d'abord [Installer Claude Code](../chapitre-3b-claude-code-migration-copilot/installation.md). Cette comparaison reste utile si vous conservez ou réactivez Copilot.

---

## Installation

| Critère | JetBrains | Visual Studio Code |
|---|---|---|
| Source | JetBrains Marketplace | VS Code Marketplace |
| Extension/plugin | Plugin officiel GitHub Copilot | Extension officielle GitHub Copilot |
| Authentification | Compte GitHub autorisé à utiliser Copilot | Compte GitHub autorisé à utiliser Copilot |
| Redémarrage | Peut être demandé par l'IDE/plugin | Un reload de fenêtre peut suffire selon la mise à jour |
| Mise à jour | Via le système de plugins JetBrains | Via le système d'extensions VS Code |

!!! note "Ne figez pas une version minimale d'IDE sans source"
    GitHub recommande d'utiliser une version stable récente de l'IDE et la dernière version disponible du plugin/extension. Les compatibilités changent : vérifiez la documentation officielle au moment d'installer.

---

## Personnalisations : différences importantes

La différence majeure en 2026 n'est plus simplement « Chat inclus ou séparé », mais la **maturité des fonctions agentiques et de personnalisation** selon la surface.

| Fonction Copilot | VS Code | JetBrains |
|---|:---:|:---:|
| Custom instructions | ✓ | Preview |
| Prompt files | ✓ | Preview |
| Custom agents | ✓ | Preview |
| Subagents | ✓ | Preview |
| Agent skills | ✓ | Preview |
| Hooks | Preview | ✗ |
| MCP | ✓ | ✓ |

La matrice officielle est susceptible d'évoluer. Consultez la [Copilot customization cheat sheet](https://docs.github.com/en/copilot/reference/customization-cheat-sheet) avant de concevoir un workflow qui doit fonctionner dans plusieurs IDE.

---

## Compatibilité JetBrains

GitHub documente actuellement Copilot pour de nombreux IDE JetBrains, notamment :

- IntelliJ IDEA ;
- Android Studio ;
- CLion ;
- DataGrip et DataSpell ;
- GoLand ;
- PhpStorm ;
- PyCharm ;
- Rider ;
- RubyMine ;
- RustRover ;
- WebStorm ;
- JetBrains Client et plusieurs autres outils de la plateforme.

Utilisez le Marketplace JetBrains pour vérifier la compatibilité exacte avec votre version installée.

---

## Cohabitation avec Claude Code

Les deux outils peuvent rester installés. Dans le cadre de ce dépôt :

- **Claude Code** est le parcours documenté en priorité ;
- **Copilot** reste une référence et peut continuer à fournir ses fonctions IDE ;
- les skills peuvent parfois être partagés : GitHub Copilot accepte notamment des skills sous `.claude/skills` sur certaines surfaces ;
- les fichiers spécifiquement Copilot sous `.github/` sont conservés.

---

## Sources

Sources officielles consultées le **28 septembre 2026** :

- [GitHub Docs — Installing the GitHub Copilot extension](https://docs.github.com/en/copilot/how-tos/set-up/install-copilot-extension)
- [GitHub Docs — Copilot customization cheat sheet](https://docs.github.com/en/copilot/reference/customization-cheat-sheet)
- [GitHub Docs — Agent skills](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/customize-cloud-agent/add-skills)
