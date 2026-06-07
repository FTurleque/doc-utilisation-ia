# Concepts Fondamentaux du Contexte Copilot

<span class="badge-intermediate">Intermédiaire</span>

## Qu'est-ce que le "contexte" ?

GitHub Copilot génère ses réponses à partir d'un **prompt de travail** construit automatiquement avec différents éléments de votre environnement. Ce contexte peut inclure :

1. le contenu du fichier actuel
2. des extraits d'autres fichiers pertinents
3. des instructions personnalisées
4. des informations sur le dépôt, la stack et les outils
5. des éléments externes si vous utilisez MCP ou d'autres mécanismes de contexte

Le point clé à retenir : **tout n'entre pas en même temps**. Copilot travaille toujours dans une **fenêtre de contexte limitée**, dont la taille et le coût varient selon le mode, le modèle et le type d'interaction.

---

## La fenêtre de contexte

### Une limite réelle, mais variable

Il est tentant de raisonner avec des chiffres fixes du type « tant de tokens pour le chat » ou « tant de tokens pour l'agent ». En pratique, ces valeurs évoluent selon :

- le **modèle** utilisé
- le **mode** (complétion, chat, agent, revue, etc.)
- l'**environnement** (IDE, CLI, GitHub.com)
- les **fonctionnalités actives** (MCP, fonctions agentiques, mémoire, etc.)

!!! info "Bonne règle mentale"
    Pensez la fenêtre de contexte comme un **budget partagé**. Si vous ajoutez plus d'instructions, plus de fichiers, plus de résultats d'outils ou plus de sortie MCP, il reste moins de place pour le reste.

### Ce qui compte plus qu'un chiffre exact

| Élément | Effet sur la qualité | Effet sur le coût |
|---|---|---|
| Fichier courant bien structuré | Très fort | Faible à moyen |
| Fichiers voisins pertinents | Fort | Moyen |
| Instructions de dépôt concises | Très fort | Faible |
| Instructions longues et bavardes | Faible à négatif | Moyen à fort |
| Sorties MCP volumineuses | Variable | Fort |
| Questions floues ou trop larges | Faible | Fort |

---

## Ordre de priorité pratique du contexte

Dans la plupart des usages, Copilot raisonne mieux quand le contexte suit cet ordre :

```text
1. Le fichier courant et la zone proche du curseur
2. Les fichiers directement liés à la tâche
3. Les fichiers de structure du projet (README, build, config)
4. Les instructions de dépôt et règles ciblées
5. Les outils externes / contextes additionnels si vraiment nécessaires
```

!!! tip "Règle d'or"
    Plus un élément est **proche de la tâche**, plus il mérite d'entrer dans le contexte. Le reste doit être soit supprimé, soit repoussé à une étape suivante.

---

## Le contexte est aussi un budget de coût

Depuis la facturation basée sur les **AI Credits**, mieux gérer le contexte n'est plus seulement une question de qualité : c'est aussi une question de **coût**.

### Pourquoi un mauvais contexte coûte plus cher

Un contexte médiocre entraîne souvent :

- plus de reformulations
- plus d'itérations
- plus d'étapes agentiques inutiles
- plus de relectures de fichiers non pertinents
- plus de sorties intermédiaires volumineuses

### Pourquoi un bon contexte coûte moins cher

Un contexte bien préparé permet souvent à Copilot de :

- comprendre plus vite la demande
- éviter des hypothèses erronées
- proposer un premier résultat plus proche du besoin
- demander moins de corrections
- terminer une tâche en moins d'étapes

!!! success "Conséquence pratique"
    Le moyen le plus simple de réduire votre facture n'est pas seulement de choisir un modèle moins cher : c'est de **mieux cadrer la tâche**.

---

## Stratégies pour améliorer la qualité du contexte

### 1. Garder les fichiers pertinents ouverts

Si vous travaillez sur un service qui dépend d'un type ou d'un repository, gardez ouverts uniquement les fichiers qui ont une vraie valeur pour la tâche.

```text
Exemple utile :
├── UserService.ts      ← fichier courant
├── User.ts             ← type principal
├── UserRepository.ts   ← contrat d'accès aux données
└── README.md           ← conventions utiles si nécessaire
```

### 2. Positionner le curseur intelligemment

Copilot réagit mieux quand le point d'insertion est clair et déjà cadré.

```typescript
/**
 * Filtre les utilisateurs actifs créés dans les 30 derniers jours.
 */
function filterRecentActiveUsers(users: User[]): User[] {
  // curseur ici
}
```

### 3. Utiliser des noms explicites

```text
# ❌ Contexte pauvre

def calc(x, y, z):
    pass

# ✅ Contexte riche

def calculate_compound_interest(principal: float, rate: float, periods: int) -> float:
    pass
```

### 4. Documenter les types et interfaces

Les types bien nommés et bien structurés réduisent les ambiguïtés.

```typescript
interface ProductSearchResult {
  products: Product[];
  totalCount: number;
  hasNextPage: boolean;
  filters: AppliedFilter[];
}
```

### 5. Structurer le projet clairement

```text
✅ Structure claire
src/
├── controllers/
├── services/
├── repositories/
└── models/

❌ Structure ambiguë
src/
├── stuff/
├── things/
└── misc/
```

---

## Les meilleurs leviers de contexte à faible coût

### `.github/copilot-instructions.md`

C'est le meilleur levier global pour donner à Copilot :

- les conventions importantes
- la stack
- les validations obligatoires
- les anti-patterns à éviter
- les commandes build/test utiles

### `README.md`

Il donne une vue d'ensemble rapide du projet sans surcharger chaque interaction.

### Quelques fichiers de référence bien choisis

Mieux vaut **3 fichiers très pertinents** que **20 fichiers ouverts par habitude**.

### Une demande découpée en étapes

Préférez :

1. comprendre
2. planifier
3. implémenter
4. valider

plutôt qu'une requête unique trop large.

---

## Ce que Copilot ne voit pas toujours automatiquement

Il faut éviter les formulations absolues du type « Copilot voit tout » ou « Copilot ne voit jamais cela ». Selon l'IDE, le mode et les outils activés, la réalité est plus nuancée.

### Ce qui n'est généralement pas pris en compte automatiquement

| Élément | Point d'attention |
|---|---|
| Secrets et vraies valeurs de `.env` | Ne pas compter dessus pour guider Copilot |
| Données de bases réelles | Le modèle ne connaît pas votre contenu métier réel |
| Documentation externe non reliée | Elle doit être fournie ou intégrée via un mécanisme explicite |
| Fichiers hors périmètre de travail | Ils ne sont pas toujours utilisés de façon utile |
| Dossiers générés ou bruités | Ils dégradent souvent le contexte plus qu'ils ne l'aident |

!!! warning "Ne comptez pas sur l'implicite"
    Si une règle, une contrainte métier ou une étape de validation est importante, écrivez-la dans le dépôt au lieu de supposer que Copilot va la deviner.

---

## Contexte vs capacité : deux notions complémentaires

Ces deux concepts sont souvent confondus, alors qu'ils remplissent des rôles différents.

### Contexte

L'ensemble des informations utiles pour raisonner **dans la situation actuelle** : besoin, état du projet, contraintes, fichiers pertinents, décisions déjà prises.

> Ce que Copilot doit savoir *maintenant* pour réussir cette tâche.

### Capacité

Une procédure ou un savoir-faire réutilisable : écrire des tests, faire une revue, migrer du code, auditer une doc, etc.

> Ce que Copilot sait *faire* indépendamment du projet.

!!! warning "La règle d'or"
    **Sans contexte, une capacité est aveugle.**
    **Sans capacité, le contexte reste sous-exploité.**

---

## La technologie de prompt : penser en système, pas en phrase unique

Un bon prompt ne se résume pas à une demande bien formulée. Il s'appuie aussi sur :

- le rôle implicite ou explicite donné à Copilot
- le périmètre de la tâche
- le format attendu
- les critères de validation
- le contexte déjà présent dans le dépôt

### Les éléments d'un prompt efficace

```text
Rôle       → Qui agit ?
Objectif   → Que faut-il produire ?
Périmètre  → Ce qui est inclus / exclu
Contexte   → Quels fichiers, règles, contraintes ?
Validation → Comment sait-on que c'est correct ?
```

### Traiter les prompts comme du code

| Pratique de développement | Équivalent côté Copilot |
|---|---|
| Versioning Git | Versionner les instructions et artefacts de personnalisation |
| Refactoring | Raccourcir les règles devenues trop bavardes |
| Tests | Vérifier que les réponses suivent encore les conventions |
| Observabilité | Suivre le coût, le bruit, les itérations |
| Code review | Relire les instructions importantes |

---

## Les 5 réflexes les plus rentables ce mois-ci

Avec la hausse des coûts, voici les réflexes qui donnent le plus de valeur rapidement :

1. **Maintenir un `copilot-instructions.md` concis**
2. **Choisir le bon modèle pour la bonne tâche**
3. **Découper les demandes larges en étapes**
4. **Limiter le bruit du dépôt et des onglets ouverts**
5. **N'activer les outils externes et fonctions agentiques qu'en cas de vrai besoin**

!!! tip "Si vous ne savez pas par quoi commencer"
    Commencez par réduire de moitié la longueur de vos instructions globales, puis retirez du périmètre les dossiers inutiles. C'est souvent le gain le plus rapide sur la précision **et** le coût.

---

## Sources

- GitHub Docs — *[Support for different types of custom instructions](https://docs.github.com/en/copilot/reference/custom-instructions-support)* (consulté le 2026-06-03)
- GitHub Docs — *[Adding repository custom instructions for GitHub Copilot in your IDE](https://docs.github.com/en/copilot/how-tos/configure-custom-instructions-in-your-ide/add-repository-instructions-in-your-ide)* (consulté le 2026-06-03)
- GitHub Docs — *[Models and pricing for GitHub Copilot](https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing)* (consulté le 2026-06-03)
- GitHub Docs — *[Improving agent quality to optimize AI usage](https://docs.github.com/en/copilot/tutorials/optimize-ai-usage)* (consulté le 2026-06-03)
- GitHub Docs — *[Extending GitHub Copilot Chat with Model Context Protocol (MCP) servers](https://docs.github.com/en/copilot/how-tos/provide-context/use-mcp-in-your-ide/extend-copilot-chat-with-mcp)* (consulté le 2026-06-03)

---

## Prochaine étape

**[Guide Instructions (.instructions.md)](guide-instructions.md)** : formaliser vos conventions en règles persistantes et ciblées pour améliorer la précision sans surcharger le contexte global.

Concepts clés couverts :

- **Frontmatter YAML** — `description`, `applyTo` et autres champs utiles
- **Portée des règles** — quand rester global et quand cibler un dossier ou un langage
- **Éviter la surcharge** — comment écrire des instructions courtes et efficaces
- **Patterns concrets** — exemples réutilisables par type de fichier
