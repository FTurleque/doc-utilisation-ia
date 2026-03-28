# :material-microsoft-visual-studio-code: VS Code — Contexte & Personnalisation

<span class="badge-vscode">VS Code</span> <span class="badge-intermediate">Intermédiaire</span>

## Présentation

Ce guide vous montre comment structurer votre projet VS Code pour donner à Copilot le meilleur contexte possible — et comment le personnaliser pour vos besoins spécifiques.

**Principe clé** : Un projet bien structuré + instructions claires = suggestions pertinentes et conformes.

---

## Custom Instructions Officielles

GitHub Copilot lire vos **instructions personnalisées** pour adapter son comportement.

### Niveaux de Configuration

<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 200" style="max-width: 90%;">
  <rect x="10" y="10" width="180" height="80" fill="#e3f2fd" stroke="#1976d2" stroke-width="2"/>
  <text x="100" y="45" text-anchor="middle" font-weight="bold">Personal-Level</text>
  <text x="100" y="65" text-anchor="middle" font-size="14">GitHub Settings</text>
  <text x="100" y="80" text-anchor="middle" font-size="12" fill="#666">(Global)</text>

  <rect x="210" y="10" width="180" height="80" fill="#f3e5f5" stroke="#7b1fa2" stroke-width="2"/>
  <text x="300" y="45" text-anchor="middle" font-weight="bold">Repository-Level</text>
  <text x="300" y="65" text-anchor="middle" font-size="14">.github/copilot-instructions.md</text>
  <text x="300" y="80" text-anchor="middle" font-size="12" fill="#666">(Ce projet)</text>

  <rect x="410" y="10" width="180" height="80" fill="#fce4ec" stroke="#c2185b" stroke-width="2"/>
  <text x="500" y="45" text-anchor="middle" font-weight="bold">Organization-Level</text>
  <text x="500" y="65" text-anchor="middle" font-size="14">Admin GitHub</text>
  <text x="500" y="80" text-anchor="middle" font-size="12" fill="#666">(Enterprise+)</text>

  <text x="300" y="130" text-anchor="middle" font-size="12" fill="#666">↓ Priorité (bas) vers (haut) ↑</text>
  <text x="300" y="150" text-anchor="middle" font-size="12" fill="#666">Repository-Level override Personal-Level</text>
</svg>

### Repository-Level Instructions

Créez le fichier `.github/copilot-instructions.md` à la **racine du projet** :

```
mon-projet/
├── .github/
│   └── copilot-instructions.md    ← Créer ce fichier
├── src/
└── ...
```

**Exemple complet pour un projet MERN** :

```markdown
# Copilot Instructions — Mon Projet

## Stack & Versions
- **Frontend** : React 19, TypeScript 5.3, Vite 5
- **Backend** : Node.js 20, Express 4, PostgreSQL 15
- **ORM** : Prisma 5
- **Testing** : Jest, React Testing Library, Supertest
- **Formatting** : Prettier (80 chars), ESLint + TypeScript

## Architecture & Conventions

### Dossiers Backend (`./api`)
- `controllers/` : Gestion HTTP/requêtes (20-50 lignes max)
- `services/` : Logique métier (pas de requêtes DB directes ici)
- `repositories/` : **Seul** accès à la DB via Prisma
- `models/` : Types TypeScript, interfaces, Zod schemas
- `middlewares/` : Authentification, logging, erreurs globales
- `errors/` : Classes d'erreurs custom héritant d'AppError

### Dossiers Frontend (`./app`)
- `components/shared/` : Composants réutilisables sans state
- `components/pages/` : Composants associés aux routes
- `hooks/` : Custom React hooks (useState, useEffect, etc.)
- `store/` : Redux slices (actions, reducers, selectors)
- `api/` : Appels API via Axios avec intercepteurs
- `types/` : Interfaces TypeScript partagées (avec backend)

## Règles Strictes

### TypeScript
- Mode **strict** obligatoire (`tsconfig.json`)
- Pas de `any` — utiliser `unknown` + type guards si nécessaire
- Interface > type pour objets publics

### Tests
- Couverture minimum : **80%**
- Tests unitaires + intégration
- AAA pattern : Arrange / Act / Assert
- Tests d'APIs : Supertest + fixtures

### Erreurs & Logging
- Jamais `throw new Error("message")` — utiliser AppError custom
- Logger : DEBUG, INFO, WARN, ERROR levels
- Include contexte dans les logs (userId, requestId)

### Sécurité
- Jamais d'env vars directement sugérées → utilizar process.env
- Pas de hardcoded secrets dans le code
- Valider **toujours** les inputs (Zod schemas)
- CORS : Whitelist explicite, pas `*`

### Performance
- Requêtes DB : indexes obligatoires sur forekey/recherches
- Éviter N+1 queries (Prisma `include/select`)
- API responses : pagination si > 100 items
- Cache : Redis pour sessions longues

## Stack Des-Recommandations
- ❌ Pas de `promise.then()` — utiliser `async/await`
- ❌ Pas de `console.log` en production (utiliser système logging)
- ❌ Pas de données sensibles dans commentaires
- ❌ Pas d'une ternaire > 2 niveaux — extraire en fonction

## Exemples Patterns Clés

### Backend — Structure Service
```typescript
// repositories/UserRepository.ts — Seul accès DB
export class UserRepository {
  async findById(id: string) {
    return prisma.user.findUnique({ where: { id } });
  }
}

// services/UserService.ts — Logique
export class UserService {
  async getUser(id: string) {
    const user = await userRepo.findById(id);
    if (!user) throw new UserNotFound();
    return user;
  }
}

// controllers/UserController.ts — HTTP
export async function getUser(req: Request, res: Response) {
  const user = await userService.getUser(req.params.id);
  res.json(user);
}
```

### Frontend — Custom Hook + Redux
```typescript
// hooks/useUser.ts
export function useUser(id: string) {
  const dispatch = useDispatch();
  const user = useSelector(selectUserById(id));
  
  useEffect(() => {
    dispatch(fetchUserAsync(id));
  }, [id]);

  return user;
}

// React component
function UserProfile() {
  const user = useUser('123');
  return <div>{user.name}</div>;
}
```

## Modèles IA Recommandés
- **Code** : Claude 3.5 Sonnet (meilleur pour architecture)
- **Tests** : GPT-5.x (proche du naturel)
- **Documentation** : Claude (explications détaillées)

## Ressources Repo
- Frontend README : `./app/README.md`
- Backend API docs : `./api/docs/` ou Swagger
- Database schema : `./api/prisma/schema.prisma`
```

### Personal-Level Instructions

1. Allez sur [github.com/settings/copilot](https://github.com/settings/copilot)
2. Scroll jusqu'à **"Copilot personalization"** ou **"Custom instructions"**
3. Remplissez vos préférences personnelles

**Exemple** :
```
Expertise : Python/FastAPI backend engineer.
Préférences : 
- Type hints obligatoires (Pydantic)
- PostgreSQL + SQLAlchemy ORM
- Tests Pytest avec fixtures
- Code style : Black formatter, PEP 8 strict
Éviter : Express.js, JavaScript callback hells

Frameworks autorisés : FastAPI, SQLAlchemy, Pytest, Pydantic
```

!!! tip "Personal + Repository = Combinées"
    Vos instructions **personnelles** s'appliquent à tous vos repos. Les instructions du **repository** les override pour ce projet spécifique.

---

## Structure Optimale du Projet VS Code

### Arborescence Recommandée

```
mon-projet/
├── .github/                              ← Hub de personnalisation
│   ├── copilot-instructions.md           ← Instructions principales
│   ├── instructions/                     ← Ciblées par domaine
│   │   ├── typescript.instructions.md
│   │   ├── react.instructions.md
│   │   ├── tests.instructions.md
│   │   └── api.instructions.md
│   ├── prompts/                          ← Prompts réutilisables
│   │   ├── code-review.prompt.md
│   │   ├── generate-tests.prompt.md
│   │   └── generate-docs.prompt.md
│   ├── agents/                           ← Agents custom (avancé)
│   │   └── docs-handler.agent.md
│   └── skills/                           ← Domain expertise (avancé)
│       └── architecture/
│           └── SKILL.md
├── .copilotignore                        ← Exclusions contexte
├── .vscode/
│   ├── settings.json                     ← Settings du workspace
│   ├── extensions.json                   ← Extensions recommandées
│   ├── launch.json                       ← Debug configurations
│   └── tasks.json                        ← Tâches VS Code
├── src/
│   ├── controllers/
│   ├── services/
│   ├── models/
│   ├── utils/
│   └── errors/
├── tests/
├── .env.example                          ← ✓ Versionné
├── README.md                             ← ✓ Important pour Copilot
├── package.json                          ← ✓ Copilot lit les dépendances
└── tsconfig.json                         ← ✓ Config TypeScript
```

### .copilotignore — Exclusion de Contexte

```gitignore
# .copilotignore — Fichiers exclus du contexte Copilot

# Fichiers sensibles
.env
.env.local
.env.*.local
*.secret
credentials.json
secrets/

# Données volumineuses ou générées
dist/
build/
coverage/
node_modules/
vendor/
.next/
__pycache__/

# Données de test/fixtures
test-data/
fixtures/large*.json
seeds/

# Données métier sensibles
data/clients/
data/financial/
reports/confidential/
```

---

## Configuration VS Code Workspace

Fichier `.vscode/settings.json` — Paramètres locaux au projet :

```json
{
    // Copilot
    "github.copilot.enable": {
        "*": true,
        "plaintext": false,
        "dotenv": false,
        "env": false
    },
    "github.copilot.editor.enableAutoCompletions": true,
    "github.copilot.chat.localeOverride": "fr",

    // TypeScript
    "typescript.tsdk": "node_modules/typescript/lib",
    "[typescript]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode",
        "editor.formatOnSave": true
    },

    // Validation
    "editor.codeActionsOnSave": {
        "source.fixAll.eslint": true
    }
}
```

Fichier `.vscode/extensions.json` — Extensions recommandées :

```json
{
    "recommendations": [
        "GitHub.copilot",
        "GitHub.copilot-chat",
        "esbenp.prettier-vscode",
        "dbaeumer.vscode-eslint",
        "orta.vscode-jest",
        "ms-playwright.test-for-vscode"
    ]
}
```

---

## Exemple Complet : Projet Node.js / React

### Arborescence

```
ecommerce-app/
├── .github/
│   ├── copilot-instructions.md
│   └── instructions/
│       ├── backend.instructions.md   ← Node/Express
│       └── frontend.instructions.md  ← React
├── api/                              ← Backend
│   ├── src/
│   │   ├── controllers/
│   │   ├── services/
│   │   ├── repositories/
│   │   ├── models/
│   │   └── middlewares/
│   ├── tests/
│   ├── prisma/schema.prisma
│   ├── package.json
│   └── tsconfig.json
├── app/                              ← Frontend
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   ├── hooks/
│   │   ├── store/
│   │   └── api/
│   ├── tests/
│   ├── package.json
│   └── vite.config.ts
├── shared/                           ← Types partagés
│   ├── types.ts
│   └── api-contracts.ts
├── .copilotignore
└── README.md
```

### .github/copilot-instructions.md

```markdown
# E-Commerce App — Copilot Instructions

Stack : Node 20 + Express 4 (backend), React 19 + Vite (frontend), PostgreSQL + Prisma

Architecture :
- Backend : controllers → services → repositories → Prisma
- Frontend : pages → components → hooks → Redux store
- Shared : types.ts, api-contracts.ts (interfaces API)

Conventions :
- TypeScript strict, pas de `any`
- Gestion erreurs : custom AppError + logging structuré
- Tests : Jest/Supertest (backend), RTL/Vitest (frontend), coverage 80%+
- Formatage : Prettier 80 chars, ESLint strict
```

### Résultat

✓ Copilot comprend votre architecture entière
✓ Suggestions cohérentes entre backend et frontend
✓ Respecte vos conventions tout seul
✓ Ignore les fichiers sensibles automatiquement

---

## Bonnes Pratiques

### Do's ✓

- ✓ Créez `.github/copilot-instructions.md` **dès le départ**
- ✓ Mettez à jour instructions si architecture change
- ✓ Versionnez `.github/` dans Git (partage avec équipe)
- ✓ Utilisez `.copilotignore` pour sécurité
- ✓ Ouvrez fichiers pertinents dans tabs (contexte)

### Don'ts ✗

- ✗ Ne versionnez PAS `.env`, secrets, credentials
- ✗ Ne modifiez pas instructions à chaque PR (pas utile)
- ✗ Ne confiez pas Copilot pour générer secrets
- ✗ N'ignorez pas `.github/copilot-instructions.md` — versionnez le !

---

## Ressources & Prochaines Étapes

- [Concepts Clés](concepts.md) — Explications détaillées
- [Instructions Avancées](instructions.md) — `.instructions.md` syntax
- [Agents Custom](agents.md) — Créer vos propres agents
- [Skills](skills.md) — Packager dans expertise
- [Best Practices](../chapitre-8-bonnes-pratiques/utilisation-effective.md)
├── package.json
├── tsconfig.json
└── tailwind.config.js        ← Copilot comprend votre config Tailwind
```

### Projet Python

```
my-python-project/
├── .github/
│   └── copilot-instructions.md
├── .copilotignore
├── src/
│   └── my_project/
│       ├── __init__.py
│       ├── models/           ← Modèles de données
│       ├── services/         ← Logique métier
│       ├── api/              ← Endpoints FastAPI/Django
│       └── utils/            ← Utilitaires
├── tests/
│   ├── unit/
│   └── integration/
├── pyproject.toml            ← Copilot lit les dépendances et config
├── requirements.txt          ← ou requirements/dev.txt, prod.txt
├── .python-version           ← Version Python pour Copilot
└── README.md
```

---

## Bonnes pratiques pour améliorer le contexte

### 1. Un README.md informatif

```markdown
# Mon Projet

## Description
API REST pour [description précise].

## Stack
- Language : TypeScript 5
- Framework : Express 4
- Base de données : PostgreSQL 15 avec Prisma ORM
- Tests : Jest + Supertest

## Architecture
[Décrire les couches et leur rôle]

## Conventions de code
[Ou lien vers CONTRIBUTING.md]
```

### 2. Commentaires de fichier (en tête)

```typescript
/**
 * UserService — Gestion du cycle de vie des utilisateurs
 * 
 * Ce service gère : création, authentification, mise à jour du profil,
 * désactivation de compte et gestion des rôles.
 * 
 * Dépendances : UserRepository, EmailService, AuditLogger
 */
export class UserService {
```

### 3. Fichiers index.ts / index.py bien exportés

```typescript
// src/services/index.ts — Tableau de bord des services disponibles
export { UserService } from './UserService';
export { ProductService } from './ProductService';
export { OrderService } from './OrderService';
// Copilot comprend immédiatement quels services existent
```

### 4. Variables d'environnement documentées (sans les valeurs)

```typescript
// src/config/env.ts — Configuration des variables d'environnement
export const config = {
    database: {
        url: process.env.DATABASE_URL!,    // postgresql://user:pass@host/db
        poolSize: Number(process.env.DB_POOL_SIZE ?? '10'),
    },
    auth: {
        jwtSecret: process.env.JWT_SECRET!,  // Min 256 bits
        jwtExpiry: process.env.JWT_EXPIRY ?? '24h',
    },
};
```

---

## Optimisation des onglets ouverts

Copilot utilise vos onglets ouverts comme contexte supplémentaire. Organisez vos onglets stratégiquement :

| Situation | Onglets recommandés à garder ouverts |
|-----------|-------------------------------------|
| Travail sur un service | Interface/type, Repository, Service, Tests du service |
| Création d'un endpoint | Controller pattern existant, Service correspondant, types de réponse |
| Debugging | Fichier avec l'erreur, logs, fichier de config |
| Refactoring | Fichier source, tests, et les fichiers qui l'importent |

---

## Prochaines étapes

- [IntelliJ — Contexte projet](intellij-contexte.md) — Équivalents pour IntelliJ
- [Comparaison contexte](comparaison-contexte.md) — Différences entre les deux IDEs
- [Bonnes pratiques](../chapitre-8-bonnes-pratiques/index.md) — Aller plus loin

