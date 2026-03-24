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

## En résumé

- **Nommage expressif** : `activeAdultUsers` > `x` — les noms parlants génèrent de meilleures suggestions
- **Type hints partout** : interfaces TypeScript, annotations Python, Javadoc — le typage est du contexte
- **Un fichier, une responsabilité** : la séparation des concerns aide Copilot à comprendre l'intention
- **Les barrel exports** (`index.ts`) donnent à Copilot une vue d'ensemble des APIs disponibles
- **Le README est lu en priorité** : un README structuré améliore toutes les suggestions du projet

---

## Prochaines étapes

- [Productivité](productivite.md) — Raccourcis et workflows optimisés
- [Sécurité & Qualité](securite-qualite.md) — Vérifier et valider le code généré
