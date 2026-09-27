# Claude Code — Configuration, utilisation & migration depuis Copilot

<div class="hero-banner" markdown>

## Un parcours Claude-first, sans supprimer la documentation Copilot

Cette documentation est désormais organisée autour de **Claude Code** pour les workflows de développement assistés par IA : installation, contexte, automatisation, MCP, sécurité, coûts et usages avancés.

Les contenus **GitHub Copilot restent disponibles** comme référence, pour les équipes qui l'utilisent encore, pour comparer les approches, ou pour revenir vers Copilot si son offre évolue.

[:material-robot: Commencer avec Claude Code](chapitre-3b-claude-code-migration-copilot/installation.md){ .md-button .md-button--primary }
[:material-swap-horizontal: Migrer depuis Copilot](chapitre-3b-claude-code-migration-copilot/migration-pas-a-pas.md){ .md-button }
[:simple-github: Documentation GitHub Copilot](chapitre-1-installation/index.md){ .md-button }

</div>

---

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

## Et GitHub Copilot ?

GitHub Copilot n'est **pas supprimé** de cette documentation. Les pages existantes restent utiles pour :

- conserver un mode d'emploi complet de Copilot ;
- comparer Copilot et Claude Code sans perdre le contexte historique ;
- documenter les environnements où les deux outils cohabitent ;
- faciliter une migration progressive plutôt qu'une bascule brutale ;
- permettre un retour vers Copilot si son positionnement ou sa tarification évolue.

Les pages spécifiquement Copilot restent identifiées comme telles. Les pages génériques seront progressivement réécrites avec **Claude comme chemin par défaut**, puis une section Copilot lorsque cela apporte une information distincte.

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

- :material-swap-horizontal: **[Migrer depuis Copilot](chapitre-3b-claude-code-migration-copilot/migration-pas-a-pas.md)**

    Transformer progressivement les instructions, prompts, agents et workflows existants.

- :material-compare: **[Comparer Claude Code et Copilot](chapitre-3b-claude-code-migration-copilot/comparaison-copilot-claude.md)**

    Comprendre les différences de philosophie, d'intégration et d'usage sans perdre la documentation Copilot.

</div>

---

## À qui s'adresse cette documentation ?

| Niveau | Profil | Ce que vous trouverez ici |
|--------|--------|---------------------------|
| 🟢 **Débutant** | Vous découvrez les assistants de développement IA | Installation, premiers usages, vocabulaire et parcours guidés |
| 🟡 **Intermédiaire** | Vous utilisez déjà Claude, Copilot ou un autre agent | Contexte, prompting, outils, coûts, qualité et workflows reproductibles |
| 🔴 **Expert** | Vous industrialisez l'usage de l'IA | MCP, hooks, agents, CI/CD, gouvernance, sécurité et architectures avancées |

---

## Structure de la documentation

```text
🤖 Claude Code & Migration
   └── Installation, architecture, modèles, prompting, MCP, hooks, sécurité, coûts

🐙 GitHub Copilot — référence conservée
   └── Installation, paramétrage, modes et configuration historique

🧠 Contexte & Personnalisation
   └── Gestion du contexte, instructions, agents, skills et hooks

✍️ Prompt Engineering
   └── Fondamentaux, techniques avancées et adaptations par outil

✅ Bonnes Pratiques
   └── Productivité, sécurité, qualité, performance et workflows

🔧 Troubleshooting
   └── Diagnostic et résolution des problèmes Claude/Copilot/outils

💰 Coûts & Gouvernance
   └── Quotas, abonnements, économies et choix de mode

🧰 Outils & MCP
   └── RTK, SonarQube, outils locaux, MCP et alternatives

📚 IA appliquée
   └── RAG, Machine Learning, Deep Learning, cas d'usage et veille
```

---

## Comment utiliser cette documentation

- **Vous démarrez avec Claude ?** → [Installation Claude Code](chapitre-3b-claude-code-migration-copilot/installation.md)
- **Vous venez de Copilot ?** → [Migration pas à pas](chapitre-3b-claude-code-migration-copilot/migration-pas-a-pas.md)
- **Vous souhaitez garder Copilot ?** → [Installation & configuration Copilot](chapitre-1-installation/index.md)
- **Vous cherchez à mieux gérer le contexte ?** → [Contexte & Personnalisation](chapitre-4-contexte/index.md)
- **Vous avez un problème ?** → [Troubleshooting](chapitre-11-troubleshooting/index.md)
- **Vous surveillez les coûts ?** → [Coûts & Gouvernance](chapitre-12-couts-gouvernance/index.md)

---

## Principe de maintenance

La migration de cette documentation est volontairement réalisée **par lots**. Chaque lot doit réorienter les pages génériques vers Claude Code, préserver les informations Copilot utiles, vérifier les faits évolutifs dans les sources officielles et maintenir les liens/navigation du site.
