# Organisation du Code pour Copilot

<span class="badge-intermediate">Intermédiaire</span>

## Pyramide d'Efficacité Copilot

Pour maximaliser la qualité des suggestions, respectez cet ordre de priorité :

```
                    ▲
                   ╱ ╲
                  ╱   ╲  Nommage descriptif
                 ╱     ╱ + Typage explicite
                ╱─────╱  + Structure claire
               ╱     ╱   + Commentaires intentionnels
              ╱─────╱    + Custom instructions
             ╱     ╱     + Tests en place
            ╱─────╱      + IDE optimisé
           ╱     ╱       
          ╱─────╱        ← BASE : Nommage
```

**Impact** : Chaque couche = 20-30% d'amélioration. À la base, Copilot fonctionne avec 40% accuracy. Au sommet → 95%+.

---

## Principe fondamental

**Un code bien organisé n'est pas seulement plus lisible pour les humains — il est aussi plus compréhensible pour Copilot.** Plus votre code est expressif, plus les suggestions de Copilot seront pertinentes et contextualisées.

---

## 1️⃣ Nommage : la Clé d'un Bon Contexte

### Variables et Constantes

```typescript
// ❌ Nommage opaque — Copilot génère des suggestions génériques
const d = new Date();
const u = await db.query(q);
const r = u.filter(x => x.s === 1);

// ✅ Nommage expressif — Copilot comprend le domaine
const orderCreatedAt = new Date();
const activeUsers = await database.query(findActiveUsersQuery);
const recentOrders = activeUsers.filter(user => user.status === 'ACTIVE');
```

**Règle** : `NounAdjective` (ex: `activeUserList`, `pendingOrderCount`)

### Fonctions et Méthodes

```java
// ❌ Nom trop court — Copilot ne sait pas quoi suggérer
public List<User> get(int id) { }
public boolean check(String s) { }

// ✅ Noms clairs — Copilot génère des implémentations pertinentes
public List<Order> getOrdersByCustomerId(int customerId) { }
public boolean isValidEmailFormat(String email) { }
```

**Règle** : `Verb + Noun` (ex: `fetchUserById`, `validateEmailFormat`)

### Classes et Interfaces

```python
# ❌ Nommage générique
class Handler:
class Manager:
class Helper:

# ✅ Nommage spécifique au domaine
class PaymentGatewayHandler:
class UserSessionManager:
class CurrencyConversionHelper:
```

**Règle** : `Domain + Pattern` (ex: `UserAuthenticationService`, `OrderValidationHelper`)

---

## 2️⃣ Typage Explicite

### Typage Complet (TypeScript, Java, Python)

```typescript
// ❌ Typage faible — Copilot a peu de contexte
function processData(data) {
  return data.map(x => x.value);
}

// ✅ Typage explicite — Copilot génère code de qualité
interface DataItem {
  id: string;
  value: number;
  timestamp: Date;
}

function processData(data: DataItem[]): number[] {
  return data.map(item => item.value);
}
```

---

## 3️⃣ Séparation des Responsabilités

Copilot comprend mieux le code quand chaque fichier a une responsabilité claire :

```
✅ Bonne organisation — chaque fichier a un rôle précis
src/
├── validation/
│   ├── userValidation.ts      ← Validations des données user
│   └── orderValidation.ts     ← Validations des données commande
├── services/
│   ├── userService.ts         ← Logique métier user
│   └── orderService.ts        ← Logique métier commande
├── models/
│   ├── user.ts                ← Types/interfaces User
│   └── order.ts               ← Types/interfaces Order
└── utils/
    ├── dateUtils.ts           ← Utilitaires dates
    └── stringUtils.ts         ← Utilitaires chaînes

❌ Mauvaise organisation — responsabilités mélangées
src/
├── stuff.ts                   ← Mélange de tout
├── helpers.ts                 ← Fonctions sans lien
└── misc/
    └── whatever.ts
```

### Fichiers index pour les barrel exports

```typescript
// src/services/index.ts
// Ce fichier donne à Copilot une vue d'ensemble des services disponibles

export { UserService } from './UserService';
export { OrderService } from './OrderService';
export { PaymentService } from './PaymentService';
export { NotificationService } from './NotificationService';

// src/models/index.ts
export type { User, UserRole, UserStatus } from './User';
export type { Order, OrderStatus, OrderItem } from './Order';
export type { Product, ProductCategory } from './Product';
```

---

## Type hints et annotations

### TypeScript

```typescript
// ❌ Sans types — Copilot ne peut pas inférer les suggestions correctes
async function createOrder(data) {
    const user = await getUserById(data.userId);
    // Copilot ignore ce que data contient
}

// ✅ Avec types — Copilot suggère des accès corrects aux propriétés
interface CreateOrderRequest {
    userId: string;
    items: Array<{ productId: string; quantity: number }>;
    shippingAddress: Address;
    couponCode?: string;
}

async function createOrder(request: CreateOrderRequest): Promise<Order> {
    const user = await getUserById(request.userId);
    // Copilot sait exactement ce que request contient
}
```

### Python

```python
# ❌ Sans type hints — Copilot ne peut pas suggérer grand chose
def calculate_discount(price, user, config):
    pass

# ✅ Avec type hints — Copilot génère du code précis
from decimal import Decimal
from typing import Optional

def calculate_discount(
    price: Decimal,
    user: User,
    config: DiscountConfig,
    coupon: Optional[str] = None
) -> Decimal:
    """
    Calcule la remise applicable pour un utilisateur donné.
    
    Args:
        price: Prix original en décimal (en euros)
        user: Utilisateur pour vérifier les remises fidélité
        config: Configuration des remises actives
        coupon: Code coupon optionnel
        
    Returns:
        Montant de la remise en décimal (jamais négatif)
    """
    pass
```

### Java

```java
// ❌ Sans Javadoc ni annotations précises
public Object process(Object input) { }

// ✅ Avec annotations et types précis
/**
 * Traite une commande entrante et retourne le résultat de paiement.
 *
 * @param orderRequest Données de la commande validées par le controller
 * @return Résultat du traitement (jamais null — utilise Optional dans le service)
 * @throws InsufficientStockException si un produit est en rupture de stock
 * @throws PaymentDeclinedException si le paiement est refusé
 */
@Transactional
public OrderProcessingResult processOrder(@Valid OrderRequest orderRequest)
        throws InsufficientStockException, PaymentDeclinedException { }
```

---

## Commentaires utiles vs commentaires parasites

### Commentaires qui enrichissent le contexte Copilot

```typescript
// ✅ Décrit le POURQUOI (non-évident)
// Utiliser setTimeout de 100ms pour laisser le DOM se mettre à jour
// avant de déclencher l'animation (bug Safari)
setTimeout(() => triggerAnimation(), 100);

// ✅ Précise les contraintes
// Le montant est en centimes pour éviter les erreurs d'arrondi float
// Toujours diviser par 100 avant affichage
const amountInCents: number = order.total;

// ✅ Documente une règle métier
// Selon le contrat client, la remise fidélité ne s'applique pas
// en combinaison avec un coupon promotionnel
if (user.loyaltyLevel > 0 && !order.hasCoupon) {
    applyLoyaltyDiscount(order);
}
```

### Commentaires inutiles (éviter)

```typescript
// ❌ Dit ce que le code dit déjà
// Incrémente i de 1
i++;

// ❌ TODO sans deadline ni responsable
// TODO: fix this later

// ❌ Code commenté sans explication
// const result = oldFunction(data);
```

---

## README.md : l'outil de contexte le plus puissant

Un README bien structuré est la documentation que Copilot lit en priorité pour comprendre votre projet.

### Template README optimisé pour Copilot

```markdown
# Nom du Projet

## Description
[2-3 phrases précisant : quoi, pour qui, pourquoi ce projet existe]

## Stack technique
- **Langage** : TypeScript 5.3 / Python 3.12 / Java 21
- **Framework** : Express 4 / FastAPI / Spring Boot 3.2
- **Base de données** : PostgreSQL 15 + Prisma ORM
- **Tests** : Jest + Supertest / pytest / JUnit 5 + Mockito

## Architecture
```
src/
├── controllers/    Handlers HTTP, validation entrées
├── services/       Logique métier, règles
├── repositories/   Accès DB uniquement
├── models/         Types, interfaces, DTOs
└── utils/          Fonctions pures, helpers
```

## Conventions de code
- Nommage : camelCase / snake_case / PascalCase selon [règle]
- Erreurs : [comment les erreurs sont gérées dans ce projet]
- Tests : [coverage minimum, structure des fichiers de test]

## Variables d'environnement
[Liste des variables attendues avec description — sans valeurs]

## Démarrage rapide
[3-4 commandes pour lancer le projet localement]
```

---

## Configurer le Contexte IA du Projet

Au-delà du code lui-même, vous pouvez **configurer explicitement comment Copilot comprend votre projet** via trois types de fichiers de contexte.

### 1. `.github/copilot-instructions.md` — Instructions Système Persistantes

Ce fichier contient des **instructions qui s'appliquent automatiquement à toutes les conversations Copilot** pour votre dépôt. C'est l'équivalent d'un brief permanent donné à l'IA à chaque session.

```markdown
# Copilot Instructions — Mon Projet

## Stack technique
- TypeScript 5.3 strict, Node.js 20, Express 4.18
- Base de données : PostgreSQL 15 avec Prisma ORM
- Tests : Jest + Supertest, coverage minimum 80%

## Conventions
- Toujours utiliser les classes d'erreur de `src/errors/`
- Pas d'`any` TypeScript — utiliser `unknown` + type guard
- Les routes retournent toujours `{ data, meta }` (jamais directement le modèle)
- Validation des entrées avec Zod sur toutes les routes POST/PUT

## Patterns à suivre
- Nouveau controller → copier le pattern de `src/controllers/UserController.ts`
- Nouveau service → suivre l'interface de `src/services/BaseService.ts`
```

!!! tip "Lien vers le chapitre dédié"
    Pour aller plus loin sur les instructions Copilot : [Instructions et personnalisation](../chapitre-4-contexte/guide-instructions.md)

### 2. `COPILOT.md` — Documentation Architecturale pour l'IA

Un `COPILOT.md` à la racine du projet est un document de référence que Copilot lit pour comprendre **l'architecture et les décisions techniques**. Contrairement au README (destiné aux humains), COPILOT.md est optimisé pour être parsé par une IA.

```markdown
# COPILOT.md — Guide Architecture

## Vue d'ensemble
Application e-commerce multi-tenant. Chaque tenant a son schéma PostgreSQL isolé.

## Modules principaux
- `src/auth/` — JWT + refresh tokens (voir AuthService, TokenRepository)
- `src/orders/` — Cycle de vie commande (états : PENDING → CONFIRMED → SHIPPED → DELIVERED)
- `src/payments/` — Intégration Stripe (webhooks dans PaymentWebhookHandler)

## Règles d'architecture
- PAS de logique métier dans les controllers (déléguer aux services)
- PAS d'accès direct à la DB depuis les services (passer par les repositories)
- Les events domaine sont publiés via EventBus (src/events/)

## Décisions techniques (ADR)
- Choix Prisma vs TypeORM : Prisma retenu pour ses types générés automatiquement
- Multi-tenancy : schema-per-tenant (pas row-level) pour l'isolation des données
```

### 3. Fichiers `.prompt.md` — Prompts Réutilisables

Les fichiers `.prompt.md` (dans `.github/prompts/`) permettent de **standardiser des demandes récurrentes** pour l'équipe. Au lieu de retaper le même brief à chaque fois, vous référencez le fichier.

```markdown
# .github/prompts/new-api-endpoint.prompt.md

Crée un nouvel endpoint REST dans ce projet.

Contexte du projet :
- Express + TypeScript strict
- Validation Zod obligatoire sur les inputs
- Réponses au format `{ data: T, meta: {} }`
- Tests Jest dans le dossier `__tests__/`

Instructions :
1. Créer le schema Zod pour les inputs
2. Créer la route dans le controller approprié
3. Créer la méthode dans le service correspondant
4. Créer le test d'intégration (happy path + validation error)

Endpoint à créer : [DÉCRIRE L'ENDPOINT ICI]
```

---

## Gestion de la Fenêtre de Contexte

La **fenêtre de contexte** (context window) est la quantité maximale de texte que Copilot peut analyser en une seule fois pour générer une suggestion. Si trop de fichiers sont ouverts ou si vos fichiers sont trop longs, la qualité des suggestions baisse.

### Règles pratiques

| Situation | Impact | Action recommandée |
|-----------|--------|-------------------|
| Trop d'onglets ouverts | ⚠️ Contexte dilué | Fermer les fichiers non pertinents à la tâche |
| Fichier > 500 lignes | ⚠️ Contexte tronqué | Splitter en modules plus petits |
| Fichier > 1000 lignes | 🔴 Suggestions dégradées | Refactorer obligatoirement |
| Fichiers de données (JSON, CSV) ouverts | ⚠️ Bruit contextuel | Fermer ou exclure via `.copilotignore` |

!!! tip "Travaillez par modules"
    Pour une session de travail efficace : ouvrez **uniquement les fichiers liés à votre tâche en cours**. Si vous ajoutez une fonctionnalité à `UserService.ts`, ouvrez les types associés, le controller, et les tests — et fermez tout le reste.

---

## En résumé

- **Nommage expressif** : `activeAdultUsers` > `x` — les noms parlants génèrent de meilleures suggestions
- **Type hints partout** : interfaces TypeScript, annotations Python, Javadoc — le typage est du contexte
- **Un fichier, une responsabilité** : la séparation des concerns aide Copilot à comprendre l'intention
- **Les barrel exports** (`index.ts`) donnent à Copilot une vue d'ensemble des APIs disponibles
- **Le README est lu en priorité** : un README structuré améliore toutes les suggestions du projet
- **`.github/copilot-instructions.md`** : configurez les conventions de votre projet une fois, Copilot les applique toujours
- **`COPILOT.md`** : documentez l'architecture pour que Copilot comprenne vos décisions techniques
- **Gérez le contexte** : fermez les onglets non pertinents, gardez les fichiers < 500 lignes

---

## Prochaine étape

**[Productivité](productivite.md)** : optimiser votre flux de travail pour tirer le meilleur de Copilot au quotidien.

Concepts clés couverts :

- **Les 3 modes de suggestion** — Inline, Inline Chat, Chat Panel : choisir le bon outil selon la complexité
- **Raccourcis essentiels** — les gestes indispensables sur VS Code et IntelliJ
- **Gestion de la fenêtre de contexte** — quels fichiers garder ouverts, comment structurer les sessions
- **Copilot Edits multi-fichiers** — Working Set, mode collaboratif et autonome
- **Workflows TDD, refactoring, débogage** — intégrer Copilot dans les cycles de développement
