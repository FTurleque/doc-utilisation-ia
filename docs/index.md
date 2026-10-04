# Claude Code — Configuration et utilisation

<div class="hero-banner" markdown>

## Un parcours guidé pour développer avec Claude Code

Installation, contexte, automatisation, MCP, sécurité et pratiques d'équipe.

[:material-robot: Commencer avec Claude Code](chapitre-3b-claude-code-migration-copilot/installation.md){ .md-button .md-button--primary }
[:material-folder-cog: Configurer le projet](chapitre-3b-claude-code-migration-copilot/architecture-claude.md){ .md-button }

</div>

## Qu'est-ce que Claude Code ?

Claude Code est l'outil de développement agentique d'Anthropic. Il peut lire un dépôt, modifier plusieurs fichiers, exécuter des commandes, travailler avec Git et se connecter à des outils externes via MCP. Il est disponible en terminal ainsi que dans les environnements de développement pris en charge.

**Dans ce dépôt, Claude Code devient le parcours principal pour :**

- **Explorer et modifier un codebase** sur plusieurs fichiers ;
- **Planifier puis exécuter** des tâches de refactoring, correction, tests ou documentation ;
- **Versionner les instructions du projet** avec `CLAUDE.md` et les mécanismes de configuration Claude ;
- **Connecter des outils et sources externes** avec le Model Context Protocol (MCP) ;
- **Automatiser des workflows** en CLI, CI/CD, hooks et agents spécialisés ;
- **Travailler depuis VS Code, JetBrains ou le terminal** selon le besoin.

!!! info "Sources Claude vérifiées"
    Les pages Claude sont maintenues à partir de la documentation officielle Claude Code et Anthropic. Les informations sensibles à l'évolution — installation, modèles, quotas, prix, intégrations — doivent être revalidées lors de leur mise à jour.

---

## Parcours recommandés

<div class="grid cards" markdown>

- :material-download: **[Installer Claude Code](chapitre-3b-claude-code-migration-copilot/installation.md)**

    CLI, VS Code, JetBrains, authentification et premiers tests.

- :material-folder-cog: **[Structurer un dépôt pour Claude](chapitre-3b-claude-code-migration-copilot/architecture-claude.md)**

    `CLAUDE.md`, configuration `.claude/`, règles, hooks, skills et agents.

- :material-connection: **[Connecter Claude avec MCP](chapitre-3b-claude-code-migration-copilot/mcp-sources-externes.md)**

    Relier GitHub, outils internes, bases de données et services externes.

- :material-shield-lock: **[Sécurité & gouvernance](chapitre-3b-claude-code-migration-copilot/securite-gouvernance.md)**

    Permissions, secrets, garde-fous et pratiques d'équipe.

</div>

---

## À qui s'adresse cette documentation ?

| Niveau | Profil | Ce que vous trouverez ici |
|--------|--------|---------------------------|
| 🟢 **Débutant** | Vous découvrez les assistants de développement IA | Installation, premiers usages, vocabulaire et parcours guidés |
| 🟡 **Intermédiaire** | Vous utilisez déjà un agent de développement | Configuration du contexte, règles, skills et workflows reproductibles |
| 🔴 **Expert** | Vous industrialisez l'usage de l'IA | MCP, hooks, agents, CI/CD, gouvernance, sécurité et architectures avancées |

---

## Comment utiliser cette documentation

- **Vous démarrez avec Claude ?** → [Installation Claude Code](chapitre-3b-claude-code-migration-copilot/installation.md)
- **Vous cherchez à mieux gérer le contexte ?** → [Contexte & Personnalisation](chapitre-4-contexte/index.md)
- **Vous avez un problème ?** → [Troubleshooting](chapitre-11-troubleshooting/index.md)
- **Vous surveillez les coûts ?** → [Coûts & Gouvernance](chapitre-12-couts-gouvernance/index.md)

---

## Principe de maintenance

Les pages principales suivent le parcours Claude Code. Les références historiques sont regroupées en annexe, à la fin du menu.

---

## Référence en annexe

[Copilot — archive de ce chapitre](appendices/copilot/accueil.md#page-index).

## Prochaine étape

Poursuivez avec **[Claude Code — Introduction](chapitre-3b-claude-code-migration-copilot/index.md)**, la page suivante dans le menu.
