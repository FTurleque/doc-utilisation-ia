# Instructions Copilot (.instructions.md)

<span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span> <span class="badge-expert">Expert</span>

## Présentation
Les fichiers `.instructions.md` sont des fichiers Markdown spéciaux que VS Code injecte automatiquement dans le contexte de Copilot. Ils permettent de définir des **règles persistantes** qui s'appliquent à toutes vos interactions avec Copilot, sans avoir à les répéter à chaque prompt.

---

## Deux types d'instructions

### 1. Instructions globales — `copilot-instructions.md`

Le fichier `.github/copilot-instructions.md` s'applique à **toutes** les interactions Copilot dans le workspace.

```
mon-projet/
└── .github/
    └── copilot-instructions.md   ← S'applique partout
```

### 2. Instructions ciblées — `*.instructions.md`

Les fichiers dans `.github/instructions/` peuvent cibler des fichiers spécifiques via le champ `applyTo` du frontmatter.

```
mon-projet/
└── .github/
    └── instructions/
        ├── typescript.instructions.md    ← Uniquement les fichiers .ts
        ├── react.instructions.md         ← Uniquement les composants React
        ├── tests.instructions.md         ← Uniquement les fichiers de test
        └── api.instructions.md           ← Uniquement src/api/**
```

---

## Structure d'un fichier .instructions.md

```markdown
---
description: Conventions TypeScript pour ce projet
applyTo: "**/*.ts,**/*.tsx"
---

# Conventions TypeScript

## Typage
- Utiliser des types explicites, jamais `any`
- Préférer `interface` à `type` pour les objets
- Toujours typer les paramètres de fonction et les retours

## Nommage
- Variables et fonctions : camelCase
- Interfaces et classes : PascalCase
- Constantes : SCREAMING_SNAKE_CASE
- Fichiers de composants React : PascalCase.tsx

## Gestion des erreurs
- Ne jamais ignorer les erreurs avec try/catch vide
- Utiliser les custom error classes dans `src/errors/`
- Logger les erreurs via `logger.error()` (jamais `console.error`)
```

---

## Le frontmatter YAML

Chaque fichier `.instructions.md` peut avoir un frontmatter YAML en tête :

```yaml
---
description: Description courte de ces instructions
applyTo: "glob/pattern/**/*.ts"
---
```

| Champ | Obligatoire | Description |
|-------|:-----------:|-------------|
| `description` | Non | Description affichée dans VS Code pour identifier la règle |
| `applyTo` | Non | Pattern glob des fichiers auxquels s'appliquent ces instructions |
| `name` | Non | Nom lisible de l'instruction (utile dans les gros repos) |

!!! tip "applyTo avancé"
  Pour des exemples réels multi-patterns et les pièges fréquents, voir [applyTo avancé](applyto-avance.md).

### Patterns `applyTo` courants

| Pattern | Cible |
|---------|-------|
| `**` | Tous les fichiers (comportement global) |
| `**/*.ts` | Tous les fichiers TypeScript |
| `**/*.{ts,tsx}` | TypeScript et TSX |
| `src/api/**` | Tout le dossier `src/api/` |
| `**/*.test.ts` | Uniquement les fichiers de test |
| `**/components/**` | Tous les composants |

!!! warning "Sans frontmatter"
    Si le fichier `.instructions.md` n'a pas de frontmatter `applyTo`, il s'applique à **tous** les fichiers — comme le fichier global `copilot-instructions.md`.

---

## Exemples concrets

### Instructions globales projet

```markdown
---
description: Règles globales du projet MonApp
applyTo: "**"
---

# Règles globales — MonApp

## Stack technique
Ce projet utilise : Node.js 20, TypeScript 5, Express 4, PostgreSQL 15, Prisma ORM.

## Conventions générales
- Code en anglais (variables, fonctions, commentaires)
- Commentaires explicatifs en français
- Longueur de ligne maximale : 120 caractères
- Indentation : 2 espaces

## Sécurité
- Ne jamais utiliser `eval()` ni `Function()`
- Toujours valider les entrées utilisateur avec Zod
- Ne jamais logger de données personnelles (email, mot de passe, token)
- Utiliser des requêtes paramétrées — jamais de concaténation SQL

## Tests
- Chaque fonction publique doit avoir au moins un test unitaire
- Nommage des tests : `describe('nomDeLaFonction')` + `it('should ...')`
- Coverage minimum : 80%
```

### Instructions spécifiques aux composants React

```markdown
---
description: Conventions composants React
applyTo: "src/components/**/*.tsx"
---

# Conventions Composants React

## Structure d'un composant
1. Imports (React en premier, puis librairies, puis locaux)
2. Types/interfaces du composant
3. Composant principal (function component, pas class component)
4. Styles (si inline)
5. Export par défaut

## Props
- Définir une interface `<NomComposant>Props`
- Déstructurer les props dans la signature de la fonction
- Fournir des valeurs par défaut quand pertinent

## Hooks
- Respecter les règles des hooks (appels au top-level)
- Créer des custom hooks dans `src/hooks/` si logique réutilisable
- Nommer les custom hooks avec le préfixe `use`

## Exemple de composant attendu
```tsx
interface ButtonProps {
  label: string;
  onClick: () => void;
  variant?: 'primary' | 'secondary';
  disabled?: boolean;
}

export default function Button({ label, onClick, variant = 'primary', disabled = false }: ButtonProps) {
  return (
    <button
      className={`btn btn-${variant}`}
      onClick={onClick}
      disabled={disabled}
    >
      {label}
    </button>
  );
}
```
```

### Instructions pour les tests

```markdown
---
description: Conventions de tests Jest
applyTo: "**/*.test.{ts,tsx},**/*.spec.{ts,tsx}"
---

# Conventions de Tests

## Structure
- Un fichier de test par fichier source
- Tests dans le même dossier que le fichier testé (`*.test.ts`)

## Nommage
```typescript
describe('UserService', () => {
  describe('createUser', () => {
    it('should create a user with valid data', () => { ... });
    it('should throw ValidationError when email is invalid', () => { ... });
    it('should throw ConflictError when email already exists', () => { ... });
  });
});
```

## Mocking
- Mocker les dépendances externes (DB, API) avec `jest.mock()`
- Utiliser des factories dans `src/__tests__/factories/` pour les données de test
- Éviter les données hardcodées dans les tests

## Assertions
- Une assertion principale par test (une seule chose testée)
- Utiliser `toMatchObject()` pour les objets partiels
- Utiliser `toThrow()` pour vérifier les erreurs
```

---

## Fichier global copilot-instructions.md

Emplacement : `.github/copilot-instructions.md` (sans sous-dossier)

Ce fichier est le moyen le plus simple pour donner des instructions globales à Copilot. Il n'a **pas besoin de frontmatter** — tout son contenu est injecté dans le contexte de toutes les interactions.

```markdown
# Instructions GitHub Copilot — MonProjet

Ce projet est une application React/TypeScript avec un backend Node.js/Express.

## Conventions clés
- TypeScript strict mode activé
- Pas de `any` sauf commentaire justificatif `// eslint-disable-next-line @typescript-eslint/no-explicit-any`
- State management : Redux Toolkit
- Styling : Tailwind CSS (pas de CSS modules)
- Tests : Vitest + Testing Library

## Ce que tu dois savoir sur ce projet
- Les API calls sont dans `src/api/` avec Axios
- Les types globaux sont dans `src/types/`
- Les utils sont dans `src/utils/`
- Les composants partagés sont dans `src/components/shared/`
```

---

## Bonnes pratiques

### Garder les instructions concises

```markdown
# ✅ Bon — Instructions claires et directes
- Utiliser `async/await` plutôt que `.then()/.catch()`
- Tolérance zéro pour les `console.log` en production
- Toujours fermer les connexions DB dans `finally`

# ❌ Mauvais — Trop verbeux, risque d'être ignoré
Il est important de noter que dans ce projet, qui a été créé en 2023 avec une équipe de 5 développeurs,
nous avons décidé après de longues discussions d'utiliser async/await...
```

### Organiser par responsabilité

```
.github/instructions/
├── project-overview.instructions.md     ← Vue d'ensemble du projet
├── coding-conventions.instructions.md   ← Conventions de code
├── security.instructions.md             ← Règles de sécurité (applyTo: **)
├── api.instructions.md                  ← Règles API (applyTo: src/api/**)
├── react.instructions.md                ← Règles React (applyTo: **/*.tsx)
└── tests.instructions.md                ← Règles tests (applyTo: **/*.test.*)
```

### Versionner avec le projet

Les fichiers `.instructions.md` doivent être **committés dans Git** — ils font partie de la configuration du projet et doivent être partagés avec toute l'équipe.

```
# .gitignore
# NE PAS ignorer ces fichiers !
# .github/instructions/ ← À versionner
# .github/copilot-instructions.md ← À versionner
```

---

## Pièges à éviter

!!! danger "Erreurs courantes"

    **1. Instructions contradictoires entre fichiers**
    Si `global.instructions.md` dit "utiliser JavaScript" et `api.instructions.md` dit "utiliser TypeScript", Copilot peut se retrouver confus.
    ✅ Auditez régulièrement vos instructions pour les incohérences.

    **2. Trop d'instructions (surcharge)**
    Plus de 2000 tokens d'instructions réduisent l'espace disponible pour le contexte du code.
    ✅ Priorisez les règles les plus impactantes.

    **3. Instructions vagues**
    "Écrire du bon code" n'aide pas Copilot.
    ✅ Soyez précis : "Utiliser des fonctions pures sans effets de bord dans `src/utils/`".

    **4. Oublier `applyTo` pour les règles ciblées**
    Sans `applyTo`, toutes les instructions s'appliquent à tous les fichiers — même celles qui ne concernent que les tests.
    ✅ Définissez `applyTo` pour limiter la portée.

---

## Prochaines étapes

- [applyTo avancé](applyto-avance.md) — Cibler précisément vos instructions par type de fichier
- [Prompt Files (.prompt.md)](prompt-files.md) — Prompts réutilisables pour des tâches récurrentes
- [Agents (.agent.md)](agents.md) — Agents IA custom avec comportements spécialisés

