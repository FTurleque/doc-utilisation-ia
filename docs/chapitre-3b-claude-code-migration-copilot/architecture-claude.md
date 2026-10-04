# Architecture et paramétrage Claude Code

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span> <span class="badge-cli">CLI</span>

Claude Code utilise plusieurs couches de configuration : instructions persistantes, settings JSON, règles, skills, subagents, hooks et MCP. L'objectif n'est pas de tout mettre dans `.claude/`, mais de placer chaque élément au bon niveau et au bon scope.

!!! info "Vérifié le 28 septembre 2026"
    Cette page suit la structure actuelle documentée par Claude Code. Elle remplace plusieurs conventions plus anciennes, notamment l'idée que tout serait centralisé exclusivement dans `.claude/`.

---

## Vue d'ensemble actuelle

```text
mon-projet/
├─ CLAUDE.md                       # instructions projet principales
├─ AGENTS.md                       # instructions multi-agents éventuelles
├─ .mcp.json                       # serveurs MCP partagés au niveau projet
└─ .claude/
   ├─ settings.json                # réglages partagés et versionnés
   ├─ settings.local.json          # réglages personnels du projet
   ├─ rules/                       # instructions thématiques / ciblées par chemins
   ├─ skills/
   │  └─ ma-competence/
   │     └─ SKILL.md
   ├─ commands/                    # prompts mono-fichier, compatibilité / raccourcis
   ├─ agents/                      # définitions de subagents
   ├─ workflows/                   # workflows dynamiques
   ├─ output-styles/               # styles de réponse personnalisés
   └─ hooks/                       # scripts appelés par les hooks configurés
```

Au niveau utilisateur, Claude Code lit aussi `~/.claude/` — `%USERPROFILE%\.claude` sous Windows — pour les préférences et extensions personnelles.

### Quel fichier pour quel besoin ?

| Besoin | Emplacement recommandé |
|---|---|
| Contexte et conventions du projet | `CLAUDE.md` |
| Règles ciblées sur une partie du code | `.claude/rules/*.md` |
| Permissions, hooks, variables d'environnement, plugins | `.claude/settings.json` |
| Surcharges personnelles d'un projet | `.claude/settings.local.json` |
| Prompt ou capacité réutilisable | `.claude/skills/<nom>/SKILL.md` |
| Prompt mono-fichier existant | `.claude/commands/*.md` |
| Agent spécialisé avec son propre contexte | `.claude/agents/*.md` |
| Orchestration dynamique | `.claude/workflows/*.js` |
| Serveurs MCP partagés au projet | `.mcp.json` |

---

## `CLAUDE.md` — instructions persistantes

`CLAUDE.md` fournit les instructions stables que Claude doit connaître lorsqu'il travaille sur le projet :

- architecture et conventions ;
- commandes build/test/lint ;
- contraintes métier ;
- règles de contribution ;
- pièges connus et décisions techniques importantes.

Un fichier projet peut se trouver à la racine (`./CLAUDE.md`) ou dans `./.claude/CLAUDE.md`.

```markdown
# API de réservation

## Stack
- Java 21, Spring Boot, PostgreSQL
- Tests : JUnit, Testcontainers

## Commandes
- Build : `./mvnw clean verify`
- Tests : `./mvnw test`

## Conventions
- Injection par constructeur
- DTOs aux frontières HTTP
- Aucun secret dans le dépôt
```

### Imports

Un `CLAUDE.md` peut importer un autre fichier :

```markdown
@AGENTS.md

Voir aussi @docs/architecture.md
```

Ce dépôt utilise précisément `@AGENTS.md` dans son `CLAUDE.md` afin de partager une partie des instructions entre plusieurs agents.

### `AGENTS.md`

Les versions récentes de Claude Code savent également lire `AGENTS.md`. Par défaut, si un `CLAUDE.md` existe dans le chemin de travail, celui-ci reste prioritaire ; l'import explicite `@AGENTS.md` demeure donc une stratégie simple et compatible pour charger les deux.

!!! tip "Contrôler ce qui est chargé"
    Utilisez `/context` pour inspecter les fichiers de mémoire/instructions pris en compte dans la session, et `/status` pour inspecter les sources de settings.

---

## `.claude/rules/` — instructions ciblées

Pour éviter un `CLAUDE.md` trop volumineux, placez les règles thématiques dans `.claude/rules/`.

Exemple :

```markdown
---
paths:
  - "src/api/**/*.ts"
---

# API HTTP

- Valider toutes les entrées externes.
- Ne jamais exposer directement une entité de persistence.
- Ajouter un test d'erreur pour chaque validation métier.
```

Les règles peuvent être chargées selon les chemins concernés, ce qui permet de réduire le bruit dans les gros dépôts.

---

## Les quatre scopes de settings

Claude Code distingue plusieurs scopes :

| Scope | Fichier / source | Usage |
|---|---|---|
| Utilisateur | `~/.claude/settings.json` | préférences personnelles pour tous les projets |
| Projet partagé | `.claude/settings.json` | permissions, hooks, plugins et variables communes à l'équipe |
| Projet local | `.claude/settings.local.json` | surcharges personnelles pour un seul projet |
| Géré | `managed-settings.json`, MDM ou settings serveur | politiques d'organisation non surchargeables sauf exceptions documentées |

!!! warning "`settings.local.json` ne doit pas être versionné"
    Claude Code peut l'exclure automatiquement lorsqu'il le crée. Si vous le créez manuellement, ajoutez-le explicitement à vos exclusions Git.

### Exemple de settings partagé

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "permissions": {
    "allow": [
      "Bash(py -m mkdocs build)",
      "Bash(git status)"
    ],
    "deny": [
      "Read(./.env)",
      "Read(./.env.*)"
    ]
  }
}
```

La clé `$schema` apporte autocomplétion et validation dans les éditeurs compatibles.

### Vérifier la configuration

Après modification :

```text
/status
```

La ligne **Setting sources** indique les scopes réellement chargés. Pour les settings invalides ou ignorés :

```bash
claude doctor
```

### Modifier les settings

Trois approches principales :

1. `/config` pour les préférences exposées dans l'interface terminal ;
2. édition directe d'un fichier JSON ;
3. arguments CLI ou variables d'environnement pour une session ponctuelle.

!!! note "JSON strict"
    Les fichiers settings sont du JSON strict : pas de commentaire `//` ni de virgule finale.

---

## Permissions : préférer les règles aux instructions textuelles

Une instruction dans `CLAUDE.md` influence le comportement du modèle, mais ce n'est **pas une barrière de sécurité**. Pour bloquer une lecture ou une commande, utilisez les permissions ou une politique gérée.

```json
{
  "permissions": {
    "deny": [
      "Read(./.env)",
      "Read(./secrets/**)"
    ]
  }
}
```

Cette règle agit également sur certains chemins référencés via `@...`, là où un hook `PreToolUse` sur `Read` ne voit pas forcément l'ajout direct de contexte.

---

### Skills

Un skill vit dans `.claude/skills/<nom>/SKILL.md` :

```markdown
---
name: documentation-mkdocs
description: Maintenir une documentation MkDocs Material en français.
allowed-tools:
  - Read
  - Grep
---

# Documentation MkDocs

- Préserver la navigation dans `mkdocs.yml`.
- Vérifier les liens relatifs.
- Exécuter le build avant de terminer lorsque l'environnement le permet.
```

Les skills peuvent être invoqués via `/nom` et, selon leur configuration, Claude peut aussi les sélectionner automatiquement.

### Commands

`.claude/commands/*.md` reste pris en charge. Les commands utilisent désormais le **même mécanisme que les skills** pour les prompts mono-fichier. Pour une nouvelle capacité structurée ou accompagnée de références, préférez généralement un skill.

---

## Agents — subagents isolés

Les subagents sont définis dans `.claude/agents/*.md` et possèdent leur propre contexte, prompt et sélection d'outils.

```markdown
---
name: doc-reviewer
description: Vérifie la cohérence, les liens et les sources d'une page de documentation.
tools:
  - Read
  - Grep
model: inherit
---

Audite la page demandée sans modifier les fichiers tant que les écarts ne sont pas établis.
```

Les champs disponibles évoluent : modèle, outils, permissions, skills, MCP, hooks, mémoire, isolation, effort, etc. Évitez de figer des identifiants de modèle dans les exemples génériques lorsque `inherit` suffit.

---

## Hooks — automatisation avant/après action

Les hooks exécutent automatiquement une action à des événements de Claude Code. Ils peuvent être des commandes shell, appels HTTP, outils MCP, prompts ou subagents.

Exemple de structure actuelle dans `settings.json` :

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash|PowerShell",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/check-command.py"
          }
        ]
      }
    ]
  }
}
```

Le hook reçoit les informations d'événement en JSON. Un `PreToolUse` peut notamment autoriser, refuser ou demander confirmation avant l'exécution d'un outil.

!!! danger "Les hooks sont du code"
    Un hook de type commande s'exécute avec les droits de l'utilisateur. Relisez et versionnez les scripts comme du code de production.

Pour les cas avancés, consultez la page dédiée [Hooks avancés](hooks-avances.md) plutôt que de recopier une liste d'événements susceptible d'évoluer.

---

## MCP : `.mcp.json` est à la racine

La configuration MCP partagée au projet est distincte de `.claude/settings.json` :

```text
mon-projet/
├─ .mcp.json
├─ CLAUDE.md
└─ .claude/
   └─ settings.json
```

Les détails de configuration, scopes et sécurité MCP sont traités dans [MCP — sources externes](mcp-sources-externes.md).

---

## Données locales et confidentialité

`~/.claude/` ne contient pas seulement des préférences. Claude Code y stocke aussi, selon les fonctionnalités utilisées :

- historiques et transcriptions de sessions ;
- snapshots de fichiers pour le checkpointing ;
- données d'usage ;
- logs et caches ;
- credentials gérés par Claude Code.

Les transcriptions et historiques locaux ne sont pas chiffrés par Claude Code lui-même : la protection au repos dépend des permissions et mécanismes du système d'exploitation. Évitez donc de faire lire ou imprimer inutilement des secrets par les outils.

---

## Configuration minimale recommandée pour ce dépôt

Pour `doc-utilisation-ia`, la base Claude-first peut rester simple :

```text
CLAUDE.md
AGENTS.md
.claude/
└─ settings.json       # à ajouter seulement quand des règles partagées sont nécessaires
```

Puis ajouter progressivement :

1. `rules/` pour les conventions documentaires ciblées ;
2. `skills/` pour les workflows de rédaction/audit ;
3. `agents/` pour les audits spécialisés ;
4. hooks uniquement lorsqu'une automatisation apporte une garantie mesurable ;
5. `.mcp.json` seulement pour les serveurs MCP réellement partagés par l'équipe.

---

## Templates à adapter au projet

Les [templates de configuration Claude](../chapitre-4-contexte/templates-configuration.md) sont regroupés dans Contexte & Personnalisation, avec des modèles pour chaque mécanisme.

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-3b-claude-code-migration-copilot.md#page-chapitre-3b-claude-code-migration-copilot-architecture-claude).

## Prochaine étape

Poursuivez avec **[Choisir le bon modèle](modeles-claude.md)**, la page suivante dans le menu.

## Sources

Sources officielles consultées le **28 septembre 2026** :

- [Claude Code — Explore the `.claude` directory](https://code.claude.com/docs/en/claude-directory)
- [Claude Code — Memory / `CLAUDE.md` / `AGENTS.md`](https://code.claude.com/docs/en/memory)
- [Claude Code — Settings and precedence](https://code.claude.com/docs/en/settings)
- [Claude Code — Skills](https://code.claude.com/docs/en/skills)
- [Claude Code — Subagents](https://code.claude.com/docs/en/sub-agents)
- [Claude Code — Hooks reference](https://code.claude.com/docs/en/hooks)
