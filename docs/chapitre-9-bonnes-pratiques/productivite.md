# Productivité avec Claude Code

<span class="badge-intermediate">Intermédiaire</span>

La productivité avec Claude Code vient surtout de deux choses : **réduire les boucles inutiles** et **donner à l'agent un moyen de vérifier son travail**. Il n'existe pas de ratio universel entre chat, planification et agents ; choisissez le mécanisme le plus simple qui convient à la tâche.

---

## Choisir le bon niveau d'interaction

| Situation | Mécanisme recommandé |
|---|---|
| Question ciblée / petite correction | Conversation directe |
| Tâche multi-fichiers avec inconnues | Exploration puis Plan |
| Procédure répétitive | Skill |
| Recherche volumineuse | Subagent |
| Système externe | MCP |
| Invariant automatique | Hook |

L'erreur classique consiste à utiliser un agent complexe pour une tâche de cinq lignes ou, à l'inverse, à demander une migration entière en un seul prompt sans plan.

---

## 1. Préparer une tâche avant de lancer Claude

Une demande productive contient quatre éléments :

```text
Objectif    : quel résultat concret ?
Périmètre   : quels fichiers/composants ?
Contraintes : ce qui ne doit pas changer ?
Validation  : comment prouver que c'est terminé ?
```

Exemple :

```text
Corrige la désérialisation des dates dans `src/api/orders`.
Ne change pas le contrat HTTP.
Ajoute un test de régression reproduisant le bug.
Exécute les tests du module et le typecheck avant de terminer.
```

---

## 2. Réutiliser les patterns du dépôt

Au lieu d'expliquer longuement un style :

```text
Implémente `InvoiceService` en suivant le pattern de `OrderService` :
même injection de dépendances, même gestion d'erreurs et même structure de tests.
```

Un exemple existant est souvent un meilleur contexte qu'une page de prose.

---

## 3. Faire produire le test ou la reproduction d'abord

Pour un bug :

```text
Reproduis le problème avec un test qui échoue.
Ne modifie pas le code de production avant d'avoir confirmé l'échec.
```

Pour une optimisation :

```text
Ajoute d'abord un benchmark reproductible.
N'optimise que si le benchmark montre le problème.
```

Cette stratégie réduit les itérations où l'agent « améliore » quelque chose qui n'était pas la cause du problème.

---

## 4. Garder les tâches courtes et cohérentes

Préférez :

```text
1. tests
2. changement métier
3. validation
4. doc si nécessaire
```

à une demande regroupant migration, refactor, nouvelle fonctionnalité, tests, CI et documentation sans étapes intermédiaires.

Chaque étape terminée fournit un point de contrôle et un diff plus facile à relire.

Après plusieurs corrections sans progrès, arrêtez la boucle : consignez la reproduction, les hypothèses écartées et les contraintes découvertes, puis démarrez une session propre avec cette synthèse. La documentation officielle propose ce changement d'approche après deux corrections infructueuses ; ce repère aide à éviter une conversation saturée d'essais contradictoires.

---

## 5. Utiliser les skills comme raccourcis d'équipe

Les meilleurs gains viennent des workflows récurrents :

```text
.claude/skills/
├── review-pr/SKILL.md
├── add-api-endpoint/SKILL.md
├── migrate-schema/SKILL.md
└── release-check/SKILL.md
```

Le skill doit contenir la procédure, les commandes et les critères de réussite. Évitez d'y copier une encyclopédie : chargez les références détaillées uniquement si nécessaire.

---

## 6. Subagents : paralléliser seulement les travaux indépendants

Bons candidats :

- rechercher les appelants d'une API ;
- auditer sécurité et tests séparément ;
- explorer plusieurs modules indépendants ;
- comparer plusieurs hypothèses techniques.

Mauvais candidat : modifier le même fichier à plusieurs endroits avec plusieurs agents sans coordination.

La parallélisation améliore le débit uniquement lorsque les sous-tâches sont réellement indépendantes.

---

## 7. Réduire le coût du contexte

Anthropic décrit Claude Code comme utilisant une stratégie hybride : instructions de base chargées au départ, puis recherche dynamique par chemins, glob/grep et outils au moment nécessaire.

Pratiques utiles :

- garder `CLAUDE.md` court ;
- utiliser rules et skills ciblés ;
- ne pas coller des fichiers déjà accessibles ;
- utiliser `/clear` entre tâches indépendantes ;
- compacter les sessions longues ;
- faire retourner des synthèses courtes aux subagents.

---

## 8. Exécution en parallèle : commandes, pas chaos

Lorsque des vérifications sont indépendantes, Claude peut les lancer séparément :

```text
Lance en parallèle si possible :
- les tests unitaires du backend ;
- le typecheck frontend ;
- le lint docs.
Ensuite agrège uniquement les échecs utiles.
```

Ne parallélisez pas des commandes qui écrivent dans les mêmes artefacts ou partagent un état non isolé.

---

## 9. Éviter les longues attentes actives

Pour un job long (training, build lourd, migration), privilégiez les mécanismes du système : CI, logs, scheduler, observabilité. Claude peut préparer, lancer ou diagnostiquer le job, mais ne doit pas devenir votre système de monitoring permanent.

---

## 10. Sandboxing et permissions

Plus vous autorisez Claude à agir, plus le **blast radius** potentiel augmente. Un sandbox bien configuré peut réduire les prompts d'autorisation sans donner un accès illimité au poste.

Réflexes :

- filesystem limité au projet quand possible ;
- réseau limité aux domaines nécessaires ;
- accès en écriture seulement quand utile ;
- credentials à portée minimale ;
- confirmation humaine pour les actions irréversibles ou de production.

---

## 11. Mesurer la productivité sur le résultat

Évitez les métriques artificielles du type « pourcentage de lignes générées » ou « temps par suggestion ». Mesurez plutôt :

- temps jusqu'à un changement validé ;
- nombre de boucles correction/retest ;
- bugs échappés ;
- temps de revue ;
- stabilité du build ;
- facilité à reproduire la modification.

Un changement plus lent mais correctement testé peut être plus productif qu'une génération instantanée suivie d'une longue correction.

---

## Sources

- [Claude Code — erreurs de workflow fréquentes](https://code.claude.com/docs/en/best-practices#avoid-common-failure-patterns) — vérifié le 2026-10-03

- [Anthropic — Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) — consulté le 2026-09-28
- [Anthropic — Claude Code sandboxing](https://www.anthropic.com/engineering/claude-code-sandboxing) — consulté le 2026-09-28
- [Claude Code — fonctionnalités et extensions](https://code.claude.com/docs/en/features-overview) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-9-bonnes-pratiques.md#page-chapitre-9-bonnes-pratiques-productivite).

## Prochaine étape

Poursuivez avec **[Sécurité & Qualité](securite-qualite.md)**, la page suivante dans le menu.
