# Copilot — archives : Claude Code

Extraits déplacés du parcours principal le **3 octobre 2026**. Les affirmations, exemples et dates de vérification sont ceux des pages d’origine ; ils ne constituent pas une nouvelle validation des fonctionnalités Copilot. Les passages comparatifs peuvent aussi citer Claude afin de conserver leur sens.


## Introduction { #page-chapitre-3b-claude-code-migration-copilot-index }

Origine : [chapitre-3b-claude-code-migration-copilot/index.md](../../chapitre-3b-claude-code-migration-copilot/index.md).

<!-- Extrait original : chapitre-3b-claude-code-migration-copilot/index.md:5 ; paragraphe -->

Ce chapitre vous accompagne pour découvrir **Claude Code**, l'agent de codage d'Anthropic, et structurer vos usages dans le dépôt. Les guides de comparaison et de migration depuis GitHub Copilot sont regroupés en **Annexe**, à la fin du menu de gauche. De l'installation aux workflows avancés, en passant par Claude Desktop et une comparaison honnête des deux écosystèmes, vous y trouverez tout pour décider et agir.

<!-- Extrait original : chapitre-3b-claude-code-migration-copilot/index.md:7 ; encadré -->

!!! info "Claude Code, c'est quoi ?"
    Là où Copilot est né dans l'IDE (complétion fluide, intégration GitHub), Claude Code est né dans le **terminal** : un agent autonome piloté par une configuration **versionnée** (`.claude/`, `CLAUDE.md`). Il est désormais également accessible via **Claude Desktop**, en plus de la CLI et des intégrations IDE. Copilot peut continuer à cohabiter dans le même environnement pour les usages que vous souhaitez conserver.

<!-- Extrait original : chapitre-3b-claude-code-migration-copilot/index.md:116 ; tableau comparatif -->

| Votre besoin | Commencez par |
|--------------|---------------|
| Installer et tester Claude vite | [Installation](../../chapitre-3b-claude-code-migration-copilot/installation.md) |
| Utiliser Claude Code dans l'application de bureau | [Claude Desktop](../../chapitre-3b-claude-code-migration-copilot/claude-desktop.md) |
| Structurer un dépôt pour Claude | [Architecture `.claude/`](../../chapitre-3b-claude-code-migration-copilot/architecture-claude.md) |
| Choisir Haiku / Sonnet / Opus / Fable | [Modèles Claude](../../chapitre-3b-claude-code-migration-copilot/modeles-claude.md) |
| Comprendre l'impact du modèle sur budget et limites | [Coûts & quotas](../../chapitre-3b-claude-code-migration-copilot/couts-quotas.md) |
| Écrire de meilleurs prompts | [Prompt Engineering avec Claude](../../chapitre-3b-claude-code-migration-copilot/prompt-engineering-claude.md) |
| Copier des recettes prêtes | [Cookbook](../../chapitre-3b-claude-code-migration-copilot/cookbook.md) |
| Automatiser avec des hooks | [Hooks avancés](../../chapitre-3b-claude-code-migration-copilot/hooks-avances.md) |
| Brancher Claude dans la CI | [Workflows CI](../../chapitre-3b-claude-code-migration-copilot/workflows-ci.md) |
| Orchestrer plusieurs agents | [Orchestration multi-agents](../../chapitre-3b-claude-code-migration-copilot/subagents-orchestration.md) |
| Brancher GitHub / Jira / BDD | [MCP — sources externes](../../chapitre-3b-claude-code-migration-copilot/mcp-sources-externes.md) |
| Sécuriser et gouverner l'agent | [Sécurité & gouvernance](../../chapitre-3b-claude-code-migration-copilot/securite-gouvernance.md) |
| Partager la config entre dépôts | [Plugins d'équipe](../../chapitre-3b-claude-code-migration-copilot/plugins-equipe.md) |
| Décider Copilot vs Claude | [Comparaison](../../chapitre-3b-claude-code-migration-copilot/comparaison-copilot-claude.md) |
| Migrer une équipe existante | [Migration pas à pas](../../chapitre-3b-claude-code-migration-copilot/migration-pas-a-pas.md) → [Checklist 30/60/90](../../chapitre-3b-claude-code-migration-copilot/migration-30-60-90.md) |

<!-- Extrait original : chapitre-3b-claude-code-migration-copilot/index.md:136 ; section dédiée -->

#### Références Copilot en annexe

Ces pages se trouvent dans **Annexe**, à la fin du menu de gauche.

<div class="grid cards" markdown>

- :material-compare: **[Comparaison Copilot vs Claude](../../chapitre-3b-claude-code-migration-copilot/comparaison-copilot-claude.md)**

    <span class="badge-beginner">Débutant</span> <span class="badge-intermediate">Intermédiaire</span>

    Tableau détaillé, avantages/inconvénients, coûts, et grille de décision (rester / passer / hybride).

- :material-swap-horizontal: **[Migration pas à pas](../../chapitre-3b-claude-code-migration-copilot/migration-pas-a-pas.md)**

    <span class="badge-expert">Expert</span>

    Convertir vos fichiers Copilot (`instructions`, `prompts`, `agents`, hooks) en configuration Claude.

- :material-calendar-check: **[Checklist 30/60/90 jours](../../chapitre-3b-claude-code-migration-copilot/migration-30-60-90.md)**

    <span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span>

    Un plan calendaire pour piloter la bascule en équipe avec des points de décision mesurables.


---


## Installation (CLI, VS Code, JetBrains) { #page-chapitre-3b-claude-code-migration-copilot-installation }

Origine : [chapitre-3b-claude-code-migration-copilot/installation.md](../../chapitre-3b-claude-code-migration-copilot/installation.md).

<!-- Extrait original : chapitre-3b-claude-code-migration-copilot/installation.md:259 ; encadré -->

!!! tip "Copilot reste compatible avec ce dépôt"
    La documentation GitHub Copilot est conservée. Vous pouvez garder Copilot installé en parallèle, par exemple pour comparer les workflows ou conserver une complétion inline spécifique. Ce dépôt recommande toutefois Claude Code comme parcours principal.


## Architecture et paramétrage Claude Code { #page-chapitre-3b-claude-code-migration-copilot-architecture-claude }

Origine : [chapitre-3b-claude-code-migration-copilot/architecture-claude.md](../../chapitre-3b-claude-code-migration-copilot/architecture-claude.md).

<!-- Extrait original : chapitre-3b-claude-code-migration-copilot/architecture-claude.md:232 ; encadré -->

!!! info "Migration depuis Copilot"
    Les anciens `.github/prompts/*.prompt.md` restent conservés dans ce dépôt. Lorsqu'un workflow devient Claude-first, sa nouvelle version peut être déplacée vers un skill ou une command Claude sans supprimer l'original Copilot.


## Coûts & quotas { #page-chapitre-3b-claude-code-migration-copilot-couts-quotas }

Origine : [chapitre-3b-claude-code-migration-copilot/couts-quotas.md](../../chapitre-3b-claude-code-migration-copilot/couts-quotas.md).

<!-- Extrait original : chapitre-3b-claude-code-migration-copilot/couts-quotas.md:208 ; section dédiée -->

#### Claude vs Copilot : ne pas comparer des unités différentes

GitHub Copilot utilise actuellement son propre système de plans et d'**AI Credits**. Claude combine selon le plan allocations incluses, usage credits, API ou consommation entreprise.

Une comparaison budgétaire sérieuse doit donc utiliser un même corpus de tâches et mesurer :

- coût de licence/siège ;
- consommation variable ;
- temps développeur ;
- taux de réussite des validations ;
- rework ;
- contraintes de gouvernance.

Le chapitre **[Coûts & Gouvernance](../../chapitre-12-couts-gouvernance/index.md)** détaille cette approche et conserve les AI Credits Copilot comme référence.

---


## Prompt Engineering avec Claude { #page-chapitre-3b-claude-code-migration-copilot-prompt-engineering-claude }

Origine : [chapitre-3b-claude-code-migration-copilot/prompt-engineering-claude.md](../../chapitre-3b-claude-code-migration-copilot/prompt-engineering-claude.md).

<!-- Extrait original : chapitre-3b-claude-code-migration-copilot/prompt-engineering-claude.md:250 ; section dédiée -->

#### 11. Copilot reste une référence distincte

Les techniques générales — objectif clair, contexte précis, exemples, vérification — restent utiles avec GitHub Copilot. Les mécanismes de stockage diffèrent toutefois.

Pour les détails Copilot, voir **[Prompting avec GitHub Copilot](../../chapitre-5-prompt-engineering/avec-copilot.md)** plutôt que de mélanger `.github/` et `.claude/` dans une même recette.

---


## Orchestration multi-agents { #page-chapitre-3b-claude-code-migration-copilot-subagents-orchestration }

Origine : [chapitre-3b-claude-code-migration-copilot/subagents-orchestration.md](../../chapitre-3b-claude-code-migration-copilot/subagents-orchestration.md).

<!-- Extrait original : chapitre-3b-claude-code-migration-copilot/subagents-orchestration.md:7 ; encadré -->

!!! info "Pré-requis"
    Cette page approfondit les [subagents introduits dans l'architecture `.claude/`](../../chapitre-3b-claude-code-migration-copilot/architecture-claude.md#agents-subagents-isoles). Pour l'usage côté Copilot et la vue comparative, voir [Orchestration multi-agents (Copilot & Claude)](../../chapitre-4-contexte/orchestration-multi-agents.md).


## MCP — sources externes { #page-chapitre-3b-claude-code-migration-copilot-mcp-sources-externes }

Origine : [chapitre-3b-claude-code-migration-copilot/mcp-sources-externes.md](../../chapitre-3b-claude-code-migration-copilot/mcp-sources-externes.md).

<!-- Extrait original : chapitre-3b-claude-code-migration-copilot/mcp-sources-externes.md:7 ; encadré -->

!!! info "MCP n'est pas propre à Claude"
    MCP est un protocole ouvert (initié par Anthropic) que d'autres outils adoptent, dont GitHub Copilot. Migrer un serveur MCP d'un écosystème à l'autre est donc souvent direct.

<!-- Extrait original : chapitre-3b-claude-code-migration-copilot/mcp-sources-externes.md:30 ; encadré -->

!!! tip "Équivalent Copilot"
    MCP est l'équivalent fonctionnel du « contexte externe » de Copilot, mais formalisé et portable : un même serveur MCP fonctionne avec Claude Code et d'autres clients compatibles.

---

## Prochaine étape

Poursuivez avec **[Contexte & Personnalisation](chapitre-4-contexte.md)**, la page suivante dans le menu.
