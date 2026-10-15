# Organisation du code pour Claude Code

<span class="badge-intermediate">Intermédiaire</span>

Un dépôt lisible aide les développeurs **et** les agents. Claude Code s'appuie sur la structure des fichiers, les noms, les tests, les commandes et les conventions versionnées pour retrouver le bon contexte au moment utile.

---

## Principe : rendre l'intention observable

Un agent travaille mieux lorsqu'il peut répondre rapidement à ces questions :

- où vit la logique métier ?
- où sont les tests associés ?
- quelles commandes valident ce module ?
- quelles APIs sont publiques ?
- quelles règles s'appliquent à ce dossier ?

L'organisation doit réduire l'ambiguïté, pas optimiser un score supposé de « précision IA ».

---

## 1. Nommage descriptif

```typescript
// À éviter
const d = new Date();
const r = await repository.find(id);

// Plus explicite
const orderCreatedAt = new Date();
const customerOrder = await orderRepository.findById(orderId);
```

Les noms métier servent de signal lors des recherches `grep`, de l'exploration et du raisonnement sur le code.

---

## 2. Types et contrats explicites

```typescript
interface CreateOrderRequest {
  customerId: string;
  items: Array<{ productId: string; quantity: number }>;
  shippingAddress: Address;
}

async function createOrder(request: CreateOrderRequest): Promise<Order> {
  // ...
}
```

Les types améliorent le code lui-même : validation statique, documentation et refactoring. Leur intérêt pour Claude est secondaire mais réel : ils rendent les contrats plus faciles à découvrir.

---

## 3. Séparer les responsabilités

```text
src/
├── orders/
│   ├── api/
│   ├── domain/
│   ├── persistence/
│   └── tests/
├── payments/
└── shared/
```

Préférez des frontières qui reflètent le domaine ou les responsabilités réelles du système. Évitez les dossiers fourre-tout `misc/`, `helpers/` ou `stuff/` quand ils masquent plusieurs concepts indépendants.

---

## 4. Garder les tests proches du comportement

Claude doit pouvoir trouver rapidement le test qui prouve une modification.

Deux organisations valides :

```text
src/orders/OrderService.ts
src/orders/OrderService.test.ts
```

ou :

```text
src/orders/OrderService.ts
tests/orders/OrderService.test.ts
```

L'important est la cohérence et une convention documentée.

---

## 5. `CLAUDE.md` comme carte, pas comme manuel complet

À la racine :

```markdown
# Project map

- `src/orders/`: order lifecycle
- `src/payments/`: payment integration
- `tests/`: integration tests

## Commands
- Unit tests: `npm test`
- Type check: `npm run typecheck`
- Lint: `npm run lint`
```

Ne dupliquez pas tout le README ou l'architecture détaillée. Pointez vers les documents utiles et laissez Claude charger le détail à la demande.

Cette stratégie correspond au **just-in-time context** décrit par Anthropic : des références légères permettent à l'agent de retrouver les données pertinentes sans saturer son contexte.

---

## 6. Règles ciblées par dossier

`.claude/rules/backend.md` :

```markdown
---
paths:
  - "src/backend/**/*.ts"
---

- Validate external input at the HTTP boundary.
- Domain services must not import Express types.
- Database access goes through repositories.
```

Les règles ciblées évitent de charger des conventions frontend lorsqu'on travaille sur le backend.

Cette sélection exige le frontmatter `paths` : sans lui, une règle est chargée dès le lancement. Une règle ciblée est activée lorsque Read, Write ou Edit accède à un fichier correspondant au motif. Vérifiez ce qui a réellement été chargé avec `/context` ; un simple nom de dossier dans le titre de la règle ne suffit pas.

---

## 7. Les commentaires expliquent le « pourquoi »

```typescript
// Montants stockés en centimes pour éviter les erreurs d'arrondi binaire.
const totalInCents = order.total;
```

Évitez :

```typescript
// Incrémente i
 i++;
```

Un bon commentaire encode une contrainte, un compromis ou une raison non évidente.

---

## 8. Commandes reproductibles

Un agent ne devrait pas deviner comment valider un module.

Bon dépôt :

```json
{
  "scripts": {
    "test": "vitest run",
    "typecheck": "tsc --noEmit",
    "lint": "eslint .",
    "build": "vite build"
  }
}
```

Puis dans `CLAUDE.md`, documentez uniquement les commandes réellement attendues.

---

## 9. Réduire le bruit

Ne faites pas indexer ou relire inutilement :

- builds ;
- dépendances vendored ;
- dumps ;
- logs ;
- snapshots massifs ;
- données générées.

Utilisez `.gitignore`, l'organisation du workspace et les permissions Claude lorsque des chemins ne doivent pas être lus.

`.gitignore` est un filtre de découverte, pas une interdiction de lecture. Pour protéger un chemin sensible, utilisez les restrictions d'accès appropriées et vérifiez aussi les commandes shell et les outils externes susceptibles de le lire.

---

## 10. Monorepos

Dans un monorepo, placez des instructions locales proches des sous-projets si les commandes diffèrent.

```text
repo/
├── CLAUDE.md
├── services/
│   ├── billing/
│   │   └── CLAUDE.md
│   └── catalog/
│       └── CLAUDE.md
└── frontend/
    └── CLAUDE.md
```

Gardez la racine pour les règles transverses ; les détails locaux restent avec leur composant.

---

## 11. Architecture et ADR

Pour les décisions non évidentes, un ADR court est plus robuste qu'une règle cachée dans un prompt :

```text
docs/adr/
├── 0001-use-postgresql.md
└── 0002-events-for-order-transitions.md
```

Claude peut les découvrir et les citer lors d'un changement d'architecture.

Pour auditer les décisions existantes, limiter les nouveaux ADR aux arbitrages pertinents et contrôler leur respect, suivre **[Gérer les ADR avec Claude Code et OpenSpec](adr-claude.md)**. Ce parcours conserve OpenSpec lorsqu'il est déjà installé et ajoute Archgate CLI au workflow.

---

## Checklist

- [ ] responsabilités de dossiers explicites ;
- [ ] contrats et types découvrables ;
- [ ] commandes de validation documentées ;
- [ ] tests faciles à relier au code ;
- [ ] `CLAUDE.md` court et maintenu ;
- [ ] rules ciblées pour les conventions locales ;
- [ ] fichiers générés/bruit exclus ;
- [ ] décisions d'architecture importantes documentées.

---

## Sources

- [Claude Code — règles ciblées et chargement des instructions](https://code.claude.com/docs/en/memory) — vérifié le 2026-10-03

- [Anthropic — Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) — consulté le 2026-09-28
- [Claude Code — répertoire `.claude/`](https://code.claude.com/docs/en/claude-directory) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-9-bonnes-pratiques.md#page-chapitre-9-bonnes-pratiques-organisation-code).

## Prochaine étape

Poursuivez avec **[ADR avec Claude Code, OpenSpec et arc42](adr-claude.md)**, la page suivante dans le menu.
