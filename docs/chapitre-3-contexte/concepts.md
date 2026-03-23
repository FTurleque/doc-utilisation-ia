# Concepts Fondamentaux du Contexte Copilot

## Qu'est-ce que le "contexte" ?

GitHub Copilot est un modèle de langage (LLM) qui génère des suggestions en se basant sur un **prompt** construit automatiquement à partir de votre environnement de développement. Ce prompt contient :

1. Le contenu du fichier actuel (avant et après le curseur)
2. Des extraits des fichiers ouverts dans vos onglets
3. Les instructions de personnalisation configurées
4. Des métadonnées sur le langage et la structure du projet

Ce prompt est limité en taille : c'est ce qu'on appelle la **fenêtre de contexte**.

---

## La fenêtre de contexte

### Taille et limites

Copilot utilise une fenêtre de contexte qui varie selon le mode d'utilisation :

| Mode | Fenêtre de contexte approximative |
|------|----------------------------------|
| **Suggestions inline** | ~2 000 tokens (~1 500 mots / ~6 Ko de code) |
| **Copilot Chat** | ~8 000 à 128 000 tokens selon le modèle |
| **Copilot Edits** | ~32 000 tokens |
| **Mode Agent** | ~128 000 tokens (avec outils) |

!!! info "C'est quoi un token ?"
    Un token correspond approximativement à 3-4 caractères de texte. La ligne `function calculateTotal(items)` représente environ 7-8 tokens. Un fichier TypeScript de 200 lignes représente environ 800-1200 tokens.

### Priorité du contexte pour les suggestions inline

Copilot sélectionne le contenu à inclure dans le prompt selon cet ordre de priorité :

```
1. Fichier actuel (obligatoire, priorité absolue)
   └── Code avant le curseur (contexte immédiat)
   └── Code après le curseur (contexte lookahead)

2. Fichiers ouverts dans les onglets (par ordre de pertinence)
   └── Même langage que le fichier actuel en priorité
   └── Fichiers récemment édités

3. Fichiers de configuration du projet
   └── package.json, tsconfig.json, pom.xml, etc.

4. Instructions de personnalisation
   └── .github/copilot-instructions.md
   └── .github/instructions/*.instructions.md
```

---

## Stratégies pour améliorer la qualité du contexte

### 1. Garder les fichiers pertinents ouverts

Copilot utilise vos onglets ouverts comme contexte supplémentaire. Si vous travaillez sur un service qui dépend d'un modèle de données, **gardez le fichier du modèle ouvert** en parallèle.

```
Exemple :
├── UserService.ts (fichier actuel)  ← Contexte principal
├── User.ts (onglet ouvert)          ← Copilot verra les types User
├── UserRepository.ts (onglet)       ← Copilot verra les méthodes disponibles
```

### 2. Positionner le curseur intelligemment

Copilot priorise le code **proche du curseur**. Pour obtenir de meilleures suggestions pour une fonction :

- Écrivez d'abord le nom de la fonction + signature
- Ajoutez un commentaire décrivant ce que la fonction doit faire
- Puis demandez à Copilot de compléter

```typescript
// ❌ Moins efficace — pas de contexte pour Copilot
function process() {
    // curseur ici

// ✅ Plus efficace — contexte clair
/**
 * Filtre les utilisateurs actifs et retourne ceux créés dans les 30 derniers jours
 * @param users Liste complète des utilisateurs
 * @returns Utilisateurs actifs créés récemment
 */
function filterRecentActiveUsers(users: User[]): User[] {
    // curseur ici
```

### 3. Utiliser des noms explicites

Copilot comprend mieux un code bien nommé :

```python
# ❌ Contexte pauvre pour Copilot
def calc(x, y, z):
    pass

# ✅ Contexte riche pour Copilot  
def calculate_compound_interest(principal: float, rate: float, periods: int) -> float:
    pass
```

### 4. Documenter les interfaces et types

Les types et interfaces bien documentés aident Copilot à générer du code correct :

```typescript
// ✅ Copilot comprendra exactement ce qu'il doit retourner
interface ProductSearchResult {
    products: Product[];
    totalCount: number;
    hasNextPage: boolean;
    filters: AppliedFilter[];
}
```

### 5. Structurer le projet clairement

La structure des dossiers fournit un contexte implicite :

```
✅ Structure claire → meilleures suggestions
src/
├── controllers/     ← Copilot comprend que c'est la couche HTTP
├── services/        ← Copilot comprend la logique métier
├── repositories/    ← Copilot comprend l'accès aux données
└── models/          ← Copilot comprend les structures de données

❌ Structure ambiguë → suggestions génériques
src/
├── stuff/
├── things/
└── misc/
```

---

## Ce que Copilot ne voit PAS

Il est important de comprendre les **limites du contexte** pour éviter les attentes déçues :

| Ce que Copilot ne voit pas | Conséquence |
|---------------------------|-------------|
| Fichiers non ouverts dans les onglets | Ne peut pas utiliser du code non chargé en mémoire |
| Variables d'environnement (`.env`) | Ne connaît pas vos vraies valeurs de config |
| Données de base de données | Ne sait pas ce que contient votre DB |
| Documentation externe (Confluence, Notion) | Ne lit pas vos docs d'architecture |
| Commits Git non ouverts | Ne lit pas l'historique Git automatiquement |
| Fichiers dans `.copilotignore` | Explicitement exclus du contexte (IntelliJ utilise les exclusions de projet et `.gitignore`) |

!!! tip "Copilot Chat voit plus"
    Dans Copilot Chat, Copilot peut indexer et rechercher dans l'ensemble du projet. Sur **VS Code**, utilisez le participant `@workspace` ; sur **IntelliJ**, posez directement une question dans le chat — Copilot accède à l'index du projet automatiquement. Dans les deux cas, c'est le bon mode pour des questions sur votre projet globalement.

---

## À quoi sert vraiment `copilot-instructions.md` ?

Le fichier `.github/copilot-instructions.md` est le **contrat permanent du dépôt** : GitHub Copilot (Chat, Agent, Code Review) l'intègre automatiquement comme contexte de base pour toutes les interactions sur ce projet.

!!! info "Pourquoi ce fichier change tout"
    Un modèle de langage sans instructions est comme un développeur qui rejoint votre équipe sans onboarding : il devine, improvise, et commet des erreurs évitables. `copilot-instructions.md` lui donne le contexte métier, les conventions et les règles dès le premier prompt.

Ce fichier contient typiquement :

- **Les contraintes non négociables** — conventions de nommage, frameworks imposés, patterns interdits
- **Le format attendu** — structure de réponse, niveau de détail, langue de sortie
- **L'architecture du projet** — structure des dossiers, rôle de chaque module
- **Les commandes essentielles** — comment builder, tester, déployer
- **Les choses à ne jamais faire** — règles de sécurité, anti-patterns connus

```markdown
# Mon Projet — Instructions Copilot

## Stack
API REST Node.js 20 / TypeScript / PostgreSQL + Prisma

## Conventions
- camelCase pour variables, PascalCase pour classes
- Messages d'erreur en français, logs en anglais

## Commandes
- Build : `npm run build`
- Tests : `npm test` (Jest, coverage > 80 %)

## Ne jamais faire
- Utiliser `any` en TypeScript
- Committer des secrets ou variables d'env
```

**Bénéfice concret** : moins d'itérations de correction → meilleure qualité → coût en tokens maîtrisé.

---

## Contexte vs. Capacité : deux notions complémentaires

Ces deux concepts sont souvent confondus, mais ils jouent des rôles fondamentalement différents :

<div class="grid cards" markdown>

- :material-map-marker-radius: **Contexte**

    ---

    L'ensemble des informations pertinentes pour raisonner et agir **dans la situation présente** : besoin exprimé, état du projet, contraintes du moment, décisions déjà prises.

    > "Ce que tu sais *là, maintenant*"

    Analogie : **la recette + les ingrédients réellement disponibles dans le frigo aujourd'hui.**

    ↺ Change constamment, spécifique à chaque situation.

- :material-cog-outline: **Capacité (Skill)**

    ---

    Des procédures, checklists et règles **réutilisables** pour exécuter une tâche de façon fiable et répétable, quel que soit le projet ou la situation.

    > "Ce que tu sais *faire*, indépendamment du contexte"

    Analogie : **savoir conduire + connaître le code de la route.**

    ↺ Stable, versionnable, transférable d'un projet à l'autre.

</div>

!!! warning "La règle d'or"
    **Sans contexte, une capacité est aveugle.**
    **Sans capacité, le contexte est inutilisable.**

    Un agent avec un excellent Skill de rédaction mais sans contexte sur votre projet produira un contenu générique. Un agent avec tout le contexte du projet mais sans méthode structurée produira du contenu incohérent. Les deux sont nécessaires.

Dans les fichiers de configuration Copilot, cette distinction se traduit directement :

| Concept | Fichier correspondant | Stabilité |
|---------|----------------------|-----------|
| **Contexte** | `.github/copilot-instructions.md` | Évolue avec le projet |
| **Contexte** | `.github/instructions/*.instructions.md` | Évolue avec les règles |
| **Capacité** | `.github/skills/*/SKILL.md` | Stable, réutilisable |
| **Capacité** | `.github/agents/*.agent.md` | Stable, spécialisé |

---

## La technologie de prompt

La **technologie de prompt** est la couche de pilotage au-dessus du modèle de langage. Elle permet de passer d'une IA générique à un assistant précis et fiable.

### Les éléments d'un prompt bien structuré

```
┌─────────────────────────────────────────┐
│  PROMPT ENGINEERING                      │
│                                          │
│  Rôle       → Qui est l'agent ?          │
│  Objectif   → Que doit-il produire ?     │
│  Périmètre  → Ce qui est dans/hors scope │
│  Format     → JSON / Markdown / DTO...   │
│  Qualité    → Critères de validation     │
└──────────────────┬──────────────────────┘
                   ↓
┌─────────────────────────────────────────┐
│  LLM (Large Language Model)              │
│  Entraîné sur d'énormes volumes de texte │
│  → génération, synthèse, transformation  │
│  → raisonnement, planification           │
└──────────────────┬──────────────────────┘
                   ↓
┌─────────────────────────────────────────┐
│  INDUSTRIALISATION                       │
│  Templates de prompts réutilisables      │
│  Tool-calling : API, fichiers, DB...     │
│  Contraintes de schéma de sortie         │
└─────────────────────────────────────────┘
```

### Traiter les prompts comme du code

Un prompt de production se gère avec les mêmes exigences que du code :

| Pratique dev | Équivalent prompt |
|-------------|-------------------|
| Versioning Git | Versionner ses fichiers `.prompt.md` |
| Tests unitaires | Tests de régression (détecter les sorties qui changent) |
| Monitoring | Observabilité : logs, métriques de qualité des réponses |
| Code review | Relire et itérer sur les instructions |
| Guard-rails | Garde-fous contre les dérives de comportement |

!!! tip "Qui mieux que l'IA pour écrire pour l'IA ?"
    Un document rédigé avec Copilot, en lui donnant le bon contexte et les bonnes contraintes, sera souvent **structuré de façon plus compréhensible par un modèle de langage** qu'un document écrit librement. L'IA optimise naturellement pour sa propre lisibilité.

### L'impact sur la productivité

En formalisant le rôle, l'objectif et le format attendu :

- **Réduction des itérations** : moins de corrections manuelles post-génération
- **Fiabilité accrue** : sorties cohérentes et prévisibles
- **Coût maîtrisé** : moins de tokens consommés en reformulations

---

## L'importance du README

Un `README.md` bien écrit à la racine du projet améliore significativement le contexte :

```markdown
# Mon Projet API

## Description
API REST Node.js/TypeScript pour la gestion d'une plateforme e-commerce.
Stack : Node.js 20, Express 4, PostgreSQL, Prisma ORM.

## Architecture
- /src/controllers : Handlers HTTP (Express)
- /src/services : Logique métier
- /src/repositories : Accès données (Prisma)

## Conventions
- Nommage : camelCase pour variables, PascalCase pour classes
- Erreurs : custom Error classes dans /src/errors
- Tests : Jest, coverage minimum 80%
```

Avec ce README, Copilot comprend votre stack, votre architecture et vos conventions — sans que vous ayez à le répéter à chaque suggestion.

---

## Prochaines étapes

- [Instructions (.instructions.md)](instructions.md) — Formaliser vos conventions en instructions Copilot
- [applyTo Avancé](applyto-avance.md) — Cibler précisément vos instructions par type de fichier
- [Prompt Files (.prompt.md)](prompt-files.md) — Prompts réutilisables pour des tâches récurrentes
