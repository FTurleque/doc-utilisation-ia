# Skills Copilot (SKILL.md)

<span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span> <span class="badge-expert">Expert</span>

!!! info "Support IntelliJ"
    Les fichiers `SKILL.md` créés manuellement ou via VS Code sont pris en compte par IntelliJ en lecture. La création via l'interface (commande `copilot-skill://`) reste réservée à VS Code.

## Présentation
Les **Skills** sont des packages de connaissance domaine que les agents Copilot peuvent référencer via l'URI `copilot-skill://`. Ils permettent de packager de l'expertise métier ou technique complexe et de la rendre disponible à la demande, séparément des instructions toujours actives.

---

## Qu'est-ce qu'un SKILL.md ?

Un `SKILL.md` est un fichier de documentation structurée qui:

- **Encode une expertise spécifique** dans un domaine précis.
- **Est référençable** par les agents via une URI dédiée.
- **Fournit du contexte profond** sur un domaine sans alourdir le contexte global.

Contrairement aux `.instructions.md` (toujours actives), les skills sont **chargés à la demande** — uniquement quand un agent ou un prompt en a besoin.

---

## Emplacement et URI

Les fichiers `SKILL.md` sont placés dans des dossiers dédiés et référencés via l'URI `copilot-skill://` :

```
mon-projet/
└── .github/
    └── skills/
        ├── agent-customization/
        │   └── SKILL.md    → copilot-skill://agent-customization/SKILL.md
        ├── api-standards/
        │   └── SKILL.md    → copilot-skill://api-standards/SKILL.md
        ├── security/
        │   └── SKILL.md    → copilot-skill://security/SKILL.md
        └── domain-model/
            └── SKILL.md    → copilot-skill://domain-model/SKILL.md
```

---

## Structure d'un SKILL.md

```markdown
# Nom du Skill

## Description
Courte description du domaine de connaissance couvert par ce skill.

## Prérequis
Ce que l'utilisateur doit savoir avant d'utiliser ce skill.

## Connaissance principale

### Section 1
Contenu de connaissance détaillé...

### Section 2
...

## Exemples
Exemples concrets d'application de cette connaissance.

## Références
- Lien vers documentation officielle
- Ressources complémentaires
```

---

## Exemple : Skill Agent Customization

Ce skill existe dans le workspace actuel (`documentation-ia`) :

```markdown
# Agent Customization Skill

## Description
**WORKFLOW SKILL** — Créer, mettre à jour, réviser, corriger ou déboguer des fichiers de 
personnalisation VS Code (`.instructions.md`, `.prompt.md`, `.agent.md`, `SKILL.md`, 
`copilot-instructions.md`, `AGENTS.md`).

## Cas d'usage
À utiliser pour :
- Sauvegarder des préférences de code
- Diagnostiquer pourquoi des instructions/skills/agents sont ignorés
- Configurer des patterns `applyTo`
- Définir des restrictions d'outils
- Créer des modes d'agent custom ou des workflows spécialisés
- Packager de la connaissance domaine
- Corriger la syntaxe YAML du frontmatter

Ne PAS utiliser pour :
- Questions générales de code (utiliser l'agent par défaut)
- Débogage runtime ou diagnostic d'erreurs
- Configuration de serveur MCP (utiliser les docs MCP directement)
- Développement d'extension VS Code

## Workflow recommandé
1. Lire les fichiers existants dans `.github/`
2. Identifier les gaps ou problèmes
3. Intervenir avec les outils appropriés (lire/écrire des fichiers de customisation)
4. Valider via les questions posées à l'utilisateur si besoin
```

---

## Référencer un skill depuis un agent

Dans un fichier `.agent.md`, vous pouvez indiquer quel skill utiliser :

```markdown
---
name: Agent Customization Expert
description: Expert en personnalisation VS Code et agents Copilot
tools:
  - codebase
  - editFiles
---

# Agent Customization Expert

Pour réaliser cette tâche, applique les connaissances du skill :
`copilot-skill://agent-customization/SKILL.md`

## Rôle
Tu es expert en configuration d'agents VS Code Copilot...
```

---

## Différence Skills vs Instructions vs Agents

| Aspect | SKILL.md | .instructions.md | .agent.md |
|--------|:--------:|:----------------:|:---------:|
| **Activé automatiquement** | Non | Oui (si applyTo matche) | Non (manuel) |
| **Invocation** | Via URI depuis un agent | Automatique | Via @ ou sélecteur |
| **Contenu** | Expertise domaine | Règles de code | Comportement + outils |
| **Persistance** | Passif (disponible) | Actif (toujours injecté) | Actif pendant session |
| **Taille typique** | Longue (connaissance riche) | Courte (règles précises) | Moyenne (instructions comportement) |

---

## Exemples de skills utiles pour une équipe de développement

### Skill API Standards

```markdown
# API Standards Skill

## REST API Design Guidelines

### Nommage des endpoints
- Utiliser des noms de ressources au pluriel : `/users`, `/products`
- Snake_case pour les paramètres de query string : `?sort_by=created_at`
- Versionnement URL : `/api/v1/`

### Codes HTTP attendus
| Opération | Success | Error |
|-----------|---------|-------|
| GET | 200 | 404, 400 |
| POST | 201 | 400, 409 |
| PUT/PATCH | 200 | 400, 404 |
| DELETE | 204 | 404 |

### Format de réponse standard
```json
{
  "data": {},
  "meta": { "pagination": {} },
  "errors": []
}
```

### Gestion des erreurs
- Toujours retourner un corps JSON en cas d'erreur
- Inclure un `error_code` machine-readable
- Inclure un `message` lisible par l'humain
```

### Skill Modèle de Domaine

```markdown
# Domain Model Skill — MonApp E-commerce

## Entités principales

### User
- `id` : UUID v4
- `email` : unique, lowercase
- `role` : enum(ADMIN, SELLER, BUYER)
- `status` : enum(ACTIVE, SUSPENDED, DELETED)

### Product
- `id` : UUID v4
- `sellerId` : FK → User.id (role=SELLER)
- `status` : enum(DRAFT, PUBLISHED, ARCHIVED)
- `price` : en centimes (integer, jamais float pour les montants monétaires)

## Règles métier importantes
1. Un produit ARCHIVED ne peut pas être commandé
2. Un User SUSPENDED ne peut pas créer de commandes
3. Le prix est toujours en centimes — diviser par 100 pour l'affichage
4. Les IDs sont toujours des UUID — jamais d'auto-increment SQL

## Invariants
- `Order.total` doit toujours égaler `sum(OrderItem.quantity * OrderItem.unitPrice)`
- Un `User.email` ne peut jamais être modifié une fois confirmé
```

---

## Bonnes pratiques

### Organisation des skills

```
.github/skills/
├── technical/
│   ├── api-standards/SKILL.md       ← Standards techniques
│   ├── security/SKILL.md             ← Sécurité
│   └── testing/SKILL.md              ← Tests
├── domain/
│   ├── domain-model/SKILL.md         ← Modèle métier
│   └── business-rules/SKILL.md       ← Règles métier
└── tooling/
    ├── ci-cd/SKILL.md                ← CI/CD
    └── agent-customization/SKILL.md  ← Customisation agents
```

### Quand utiliser un skill vs une instruction

| Critère | Utiliser SKILL.md | Utiliser .instructions.md |
|---------|:-----------------:|:-------------------------:|
| Connaissance très détaillée | ✅ | ❌ (trop lourd pour instructions) |
| Applicable à tous les fichiers | ❌ | ✅ |
| Applicable uniquement à certains agents | ✅ | ❌ |
| Règle de code simple | ❌ | ✅ |
| Documentation de domaine métier | ✅ | ❌ |

### Skill vs prompt jetable

Si un workflow revient régulièrement (ex: audit sécurité, génération de tests, migration), privilégiez un `SKILL.md` plutôt qu'un prompt ad-hoc recopié à la main.

- Prompt jetable: rapide, mais peu maintenable
- Skill: versionnable, partageable, améliorable dans le temps

---

## Prochaines étapes

- [Hooks](hooks.md) — Automatisations déclenchées par les actions Copilot
- [Paramètres du Dépôt](parametres-depot.md) — Centraliser la configuration Copilot dans le dépôt
- [VS Code — Contexte projet](vscode-contexte.md) — Intégrer ces mécanismes dans la structure de projet
