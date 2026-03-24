# Node.js & React — Cas d'Usage

## Stack couverte

- **Runtime** : Node.js ≥ 18
- **Langage** : TypeScript (obligatoire pour tirer le maximum de Copilot)
- **Frontend** : React 18+ avec TypeScript
- **Backend** : Express ou Fastify
- **Tests** : Jest + Testing Library
- **IDE** : VS Code (recommandé) ou IntelliJ IDEA Ultimate

---

## Structure de projet optimale

Une structure cohérente aide Copilot à comprendre le rôle de chaque fichier :

```
mon-projet/
├── .github/
│   ├── copilot-instructions.md        # Instructions globales
│   └── instructions/
│       ├── react-components.instructions.md
│       ├── api-routes.instructions.md
│       └── tests.instructions.md
├── src/
│   ├── components/
│   │   ├── Button/
│   │   │   ├── Button.tsx
│   │   │   ├── Button.test.tsx
│   │   │   ├── Button.stories.tsx
│   │   │   └── index.ts
│   ├── api/
│   │   ├── routes/
│   │   ├── middleware/
│   │   └── types/
│   ├── hooks/
│   ├── utils/
│   └── types/
├── package.json
├── tsconfig.json
└── jest.config.ts
```

---

## Configuration Copilot pour TypeScript/React

### `.github/copilot-instructions.md`

```markdown
---
applyTo: '**'
---

# Instructions globales du projet

## Stack
- React 18 avec TypeScript strict
- State management: Zustand (pas Redux)
- API calls: TanStack Query v5
- Styling: Tailwind CSS (pas CSS-in-JS)
- Tests: Jest + React Testing Library

## Conventions
- Composants: functional components avec hooks uniquement
- Props: toujours typer avec une interface, pas un type alias
- Exports: named exports uniquement (pas de default export pour les composants)
- Fichiers: un composant par fichier, même nom que le composant
```

### `.github/instructions/react-components.instructions.md`

```markdown
---
applyTo: 'src/components/**/*.tsx'
---

## Conventions des composants React

- Pattern: `interface <ComponentName>Props { ... }` suivi du composant
- Mémorisation: utiliser `React.memo()` uniquement si profiling le justifie
- Effets: préférer les custom hooks pour la logique complexe dans useEffect
- Accessibilité: inclure les attributs aria quand nécessaire
- Erreurs: retourner null avec un log plutôt que crasher silencieusement

## Pattern standard

```tsx
interface ButtonProps {
  label: string;
  onClick: () => void;
  disabled?: boolean;
  variant?: 'primary' | 'secondary' | 'danger';
}

export const Button: React.FC<ButtonProps> = ({
  label,
  onClick,
  disabled = false,
  variant = 'primary',
}) => {
  return (
    <button
      className={`btn btn-${variant}`}
      onClick={onClick}
      disabled={disabled}
      aria-label={label}
    >
      {label}
    </button>
  );
};
```
```

---

## Cas d'usage pratiques

### 1. Générer un composant React complet

Stratégie : écrire le type des props + un commentaire descriptif, laisser Copilot compléter.

```tsx
// Composant de carte produit pour la marketplace
// Affiche image, nom, prix, note moyenne, et bouton d'ajout au panier
// Variant: compact (liste) ou full (grille)
interface ProductCardProps {
    product: Product;
    variant: 'compact' | 'full';
    onAddToCart: (productId: string) => void;
}

export const ProductCard: React.FC<ProductCardProps> = ({
    // Copilot complète ici avec destructuring et JSX approprié
```

### 2. Créer un custom hook

```typescript
// Hook pour gérer la pagination côté client
// Prend un array, retourne la page courante, la liste de pages et les handlers
function usePagination<T>(
    items: T[],
    itemsPerPage: number = 10
) {
    // Copilot génère l'état et les fonctions next/prev/goTo
```

### 3. Générer les tests avec Copilot Chat

Dans Copilot Chat :
```
Génère les tests React Testing Library pour le composant ProductCard.
Couvre :
- Rendu avec les deux variants (compact/full)
- Click sur "Ajouter au panier" appelle onAddToCart avec le bon productId
- Affichage correct du prix formaté
- État disabled du bouton si stock épuisé
```

### 4. Route Express avec validation

```typescript
// Route POST pour créer un utilisateur
// Validation: email required, password min 8 chars, role enum USER|ADMIN
// Returns: 201 avec l'utilisateur créé (sans le mot de passe)
// Errors: 400 validation, 409 email déjà utilisé
router.post('/users', async (req, res) => {
    // Copilot génère la validation Zod et la logique
```

---

## Configuration `tsconfig.json` pour maximiser le contexte

```json
{
    "compilerOptions": {
        "strict": true,
        "noImplicitAny": true,
        "strictNullChecks": true,
        "noUncheckedIndexedAccess": true,
        "exactOptionalPropertyTypes": true,
        "paths": {
            "@components/*": ["./src/components/*"],
            "@api/*": ["./src/api/*"],
            "@types/*": ["./src/types/*"]
        }
    }
}
```

!!! tip "strict: true est votre meilleur allié"
    Le mode strict force les types explicites partout — Copilot a beaucoup plus de contexte pour générer du code correct.

---

## Configuration IDE

=== ":material-microsoft-visual-studio-code: VS Code"
    ```json
    // .vscode/settings.json
    {
        "typescript.preferences.quoteStyle": "single",
        "typescript.suggest.autoImports": true,
        "editor.formatOnSave": true,
        "editor.codeActionsOnSave": {
            "source.organizeImports": "explicit"
        },
        "github.copilot.enable": {
            "typescript": true,
            "typescriptreact": true,
            "javascript": true,
            "javascriptreact": true
        }
    }
    ```

=== "IntelliJ IDEA Ultimate"
    - Activez le support TypeScript : **Settings → Languages → TypeScript**
    - Configurez le formatter TypeScript : **Settings → Editor → Code Style → TypeScript**
    - Le plugin GitHub Copilot utilise le service TypeScript d'IntelliJ pour enrichir le contexte

---

## Workflow TDD avec Copilot

La séquence optimale pour du code Node.js/TypeScript de qualité :

```
1. Écrire l'interface/type de la fonction
       ↓
2. Écrire un commentaire JSDoc décrivant la logique
       ↓
3. Écrire les tests (Copilot Chat ou inline)
       ↓
4. Laisser Copilot générer l'implémentation basée sur les tests
       ↓
5. Valider que les tests passent, ajuster si nécessaire
```

---

## Prochaines étapes

- [Python — Cas d'Usage](python.md)
- [Java — Cas d'Usage](java.md)
