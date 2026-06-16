# Leviers d'économie (pragmatiques)

<span class="badge-intermediate">Intermédiaire</span>

Économiser des **AI Credits** ne signifie pas moins utiliser Copilot. Cela signifie l'utiliser de façon plus ciblée. La plupart des gaspillages viennent de mauvaises habitudes facilement corrigeables.

---

## Levier 1 — Choisir le bon modèle pour la bonne tâche

Le levier le plus impactant. Les modèles puissants ne sont pas toujours meilleurs pour la tâche. La bonne stratégie est d'adapter le modèle au niveau de complexité réel.

| Type de tâche | Modèle recommandé | Justification |
|---------------|-------------------|---------------|
| Autocomplétion, snippets courts | Modèle inclus (GPT-5 mini / GPT-4.1) | Vitesse > profondeur, coût minimal |
| Refactoring simple, renommage | Modèle inclus | Tâche mécanique, faible raisonnement |
| Génération de tests unitaires | Modèle inclus ou modèle avancé léger | Standard suffisant sur des patterns connus |
| Implémentation d'algo complexe | Sonnet 4.x ou GPT-5.x Codex | Raisonnement + qualité du code |
| Debug multi-fichiers | Sonnet 4.x | Compréhension du contexte large |
| Architecture / design système | Modèle avancé "powerful" | Chaîne de raisonnement longue |
| Revue de sécurité approfondie | Modèle avancé "powerful" | Analyse critique plus robuste |
| Question de syntaxe | Modèle inclus, voire documentation | Modèle avancé inutile |

!!! tip "Règle heuristique"
    Si la tâche peut être résolue en 2 minutes via doc ou autocomplétion, évite un modèle coûteux.

!!! info "Réduction officielle"
    Sur les plans payants, GitHub indique une réduction de **10%** sur le coût des modèles lorsque l'**auto model selection** est utilisé dans Copilot Chat, Copilot CLI ou Copilot cloud agent.

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

## Levier 6 — Éviter les requêtes exploratoires avec des modèles avancés

La recherche d'idées, le brainstorming d'architecture, l'exploration de solutions alternatives : ces activités génèrent beaucoup d'échanges courts. Utiliser le modèle standard pour ces phases d'exploration, puis basculer vers un modèle avancé uniquement pour l'implémentation finale.

```
Phase exploration  → modèle léger (rapide, faible coût)
Phase implémentation → modèle plus puissant si nécessaire
```

---

## Levier 7 — Limiter l'Agent Mode aux vraies tâches multi-fichiers

L'Agent Mode multiplie les appels et donc les tokens consommés. Il est contre-productif sur des tâches single-file.

| Tâche | Mode optimal |
|-------|-------------|
| Ajouter une méthode à une classe existante | Chat ou autocomplétion |
| Refactoriser un seul fichier | Chat guidé |
| Créer une fonctionnalité traversant 3+ fichiers | Agent Mode |
| Migrer un module complet | Agent Mode |

---

## Récapitulatif — Checklist quotidienne

```
□ Autocomplétion en premier pour tout code répétitif
□ Fermer les onglets non pertinents avant une session Chat/Agent
□ Ouvrir une nouvelle conversation si le sujet change
□ Modèle léger pour l'exploration, modèle puissant uniquement si nécessaire
□ Instructions communes dans copilot-instructions.md (pas réexpliquées)
□ Agent Mode uniquement pour les tâches ≥ 3 fichiers
```

---

## Prochaine étape

**[Quand utiliser quel mode ?](modes-quand-utiliser.md)** : guide complet des modes Copilot (Inline, Chat, Plan, Agent) avec impact AI Credits et matrice de décision.

Concepts clés couverts :

- **Quatre modes principaux** — Inline, Chat, Plan, Agent avec coûts croissants
- **Matrice décision par tâche** — Quel mode pour refactoring, génération, exploration
- **Comparatif de coûts** — Validée sur des exemples concrets
- **Anti-patterns courants** — Agent Mode par défaut = gaspillage maximal
