# Leviers d'économie (pragmatiques)

<span class="badge-intermediate">Intermédiaire</span>

Économiser des requêtes Copilot ne signifie pas moins s'en servir — cela signifie **mieux s'en servir**. La plupart des gaspillages viennent de mauvaises habitudes facilement corrigeables.

---

## Levier 1 — Choisir le bon modèle pour la bonne tâche

Le levier le plus impactant. Les modèles premium (Claude 3.5 Sonnet, o1, o3) ne sont pas toujours meilleurs — ils sont juste plus puissants. Et la puissance dont vous avez besoin dépend de la tâche.

| Type de tâche | Modèle recommandé | Justification |
|---------------|-------------------|---------------|
| Autocomplétion, snippets courts | Standard (GPT-4o mini) | Vitesse > précision, pas de premium |
| Refactoring simple, renommage | Standard | Tâche mécanique, faible raisonnement |
| Génération de tests unitaires | Standard ou Premium | Standard suffisant sur des patterns connus |
| Implémentation d'algo complexe | Claude 3.5 Sonnet | Raisonnement + qualité du code |
| Debug multi-fichiers | Claude 3.5 Sonnet | Compréhension du contexte large |
| Architecture / design système | o1-mini ou Claude 3.5 | Chaîne de raisonnement longue |
| Revue de sécurité approfondie | o1 | Raisonnement critique — mais utiliser avec parcimonie |
| Simple question de syntaxe | Standard, voire documentation | Requête premium inutile |

!!! tip "Règle heuristique"
    Si la tâche peut être résolue en recherchant dans la documentation en moins de 2 minutes, n'utilisez pas de modèle premium.

---

## Levier 2 — Préférer l'autocomplétion pour le code répétitif

L'autocomplétion inline est **gratuite** (sur les plans payants) et très efficace pour :

- Implémenter un pattern déjà présent dans le fichier
- Compléter des getters/setters, constructeurs, méthodes standard
- Écrire du code boilerplate (imports, interfaces, DTOs)

```
Ratio optimal : 70–80% du code par autocomplétion
               20–30% par Chat/Agent sur les parties complexes
```

---

## Levier 3 — Fermer les onglets inutiles

Chaque onglet ouvert est envoyé comme contexte. Plus de contexte = plus de tokens = réponses plus lentes et réponses moins précises quand le contexte est pollué.

**Bonne pratique :** ne garder ouverts que les fichiers directement liés à la tâche en cours.

=== ":material-microsoft-visual-studio-code: VS Code"

    `Ctrl+K W` ferme tous les onglets — puis rouvrir uniquement les fichiers pertinents.
    
    Ou utiliser les **Editor Groups** pour isoler le contexte d'une tâche.

=== ":simple-intellijidea: IntelliJ IDEA"

    Clic droit sur un onglet → **Close All** → rouvrir les fichiers nécessaires.
    
    IntelliJ prend en compte les fichiers **récemment consultés** plus fortement que VS Code.

---

## Levier 4 — Raccourcir les conversations chat

Chaque message dans une conversation chat renvoie **l'historique complet** au modèle. Une conversation de 20 messages consomme 20× plus de tokens que 20 conversations fraîches d'un message chacune.

**Règle pratique :**

- **< 5 échanges** sur un sujet : continuer dans la même conversation
- **> 5 échanges** ou changement de sujet : **ouvrir une nouvelle conversation**

!!! warning "Anti-pattern fréquent"
    Garder une conversation chat ouverte toute la journée et l'utiliser pour tout — chaque nouveau message est de plus en plus lent et coûteux. Préférer des conversations courtes et ciblées.

---

## Levier 5 — Utiliser des instructions fixes plutôt que de réexpliquer

Répéter les mêmes contraintes à chaque prompt (langage, framework, conventions) est du gaspillage pur.

Centraliser dans `.github/copilot-instructions.md` :

```markdown
## Conventions de ce projet

- TypeScript strict mode
- Tests avec Vitest (pas Jest)
- Style fonctionnel, éviter les classes sauf pour les services
- Toutes les fonctions publiques ont une JSDoc en français
- Les erreurs remontent via `Result<T, E>` (pattern Railway)
```

Ces instructions sont incluses automatiquement dans chaque échange — sans répétition manuelle.

---

## Levier 6 — Éviter les requêtes exploratoires avec des modèles premium

La recherche d'idées, la brainstorming d'architecture, l'exploration de solutions alternatives : ces activités génèrent beaucoup d'échanges courts. Utiliser le modèle standard pour ces phases d'exploration, puis basculer en premium uniquement pour l'implémentation finale.

```
Phase exploration  → modèle standard (cheap, rapide)
Phase implémentation → modèle premium (précis, puissant)
```

---

## Levier 7 — Limiter l'Agent Mode aux vraies tâches multi-fichiers

L'Agent Mode multiplie les tool calls (lecture de fichiers, recherches, écritures) et donc les tokens consommés. Il est contre-productif sur des tâches single-file.

| Tâche | Mode optimal |
|-------|-------------|
| Ajouter une méthode à une classe existante | Chat ou autocomplétion |
| Refactoriser un seul fichier | Copilot Edits |
| Créer une fonctionnalité traversant 3+ fichiers | Agent Mode |
| Migrer un module complet | Agent Mode |

---

## Récapitulatif — Checklist quotidienne

```
□ Autocomplétion en premier pour tout code répétitif
□ Fermer les onglets non pertinents avant une session Chat/Agent
□ Ouvrir une nouvelle conversation si le sujet change
□ Modèle standard pour l'exploration, premium pour l'implémentation
□ Instructions communes dans copilot-instructions.md (pas réexpliquées)
□ Agent Mode uniquement pour les tâches ≥ 3 fichiers
```
