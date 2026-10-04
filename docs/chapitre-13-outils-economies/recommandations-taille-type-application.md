# Recommandations pratiques par contexte projet

<span class="badge-intermediate">Intermédiaire</span>

La taille seule ne suffit pas pour choisir une stack IA. Un petit projet réglementé peut exiger plus de gouvernance qu'un grand projet open source. Cette page propose donc des décisions fondées sur **risque, données, architecture, outillage existant et capacité de validation**.

---

## Ordre de décision

1. Identifier les contraintes de données et de sécurité.
2. Identifier les validations déjà disponibles : tests, build, lint, Sonar, CI.
3. Choisir l'agent principal.
4. Choisir le backend de modèle si le local ou un fournisseur particulier est requis.
5. Ajouter uniquement les outils qui résolvent un problème mesuré.


---

## Petit projet ou prototype

Objectif : garder la stack simple.

```text
Claude Code
+ tests/lint du projet
+ aucun MCP inutile
```

Ajoutez Ollama/LM Studio seulement si le local répond à un besoin réel. Ajoutez Sonar ou RTK seulement si vous observez respectivement un besoin d'analyse statique ou des sorties terminal réellement trop volumineuses.

---

## Application métier avec CI mature

Objectif : faire de l'environnement la source de vérité.

```text
Claude Code
→ tests ciblés
→ lint/typecheck
→ Sonar/quality gate si présent
→ CI
```

Placez les commandes dans `CLAUDE.md` et créez des skills pour les procédures répétitives. N'autorisez pas l'agent à conclure « terminé » sans validation exécutable.

---

## Monolithe ou legacy

Objectif : éviter les réécritures massives.

- commencer par des tests de caractérisation ;
- utiliser les refactorings IDE déterministes ;
- travailler par petits lots ;
- utiliser Sonar pour prioriser le nouveau code ou une règle précise ;
- utiliser Plan avant un changement transversal ;
- exécuter build/tests à chaque étape.

Évitez les demandes « modernise tout le module » sans critères de compatibilité.

---

## Monorepo / nombreux services

Objectif : contrôler le contexte.

- `CLAUDE.md` racine court ;
- instructions/rules locales par sous-projet ;
- subagents pour les recherches indépendantes ;
- MCP uniquement pour les services nécessaires ;
- RTK si les builds/logs saturent effectivement le contexte ;
- validation service par service avant une passe globale.

La taille du repo n'implique pas qu'il faut tout charger dans une seule session.

---

## Projet sensible ou réglementé

Commencez par une revue de la chaîne de données :

```text
agent
→ backend modèle
→ logs/transcriptions
→ MCP
→ plugins/skills
→ services externes
```

Selon les exigences, évaluez :

- Claude Code avec politiques organisationnelles adaptées ;
- backend local via Ollama/LM Studio ;
- plateforme entreprise telle que Tabnine ;
- SonarQube Server/Cloud selon politique interne ;
- restrictions réseau et permissions d'outils.

« Local » n'est pas une conformité automatique : il faut aussi sécuriser le poste, les logs et les services exposés.

---

## Projet AWS

Claude Code peut rester l'agent principal et s'appuyer sur AWS CLI, IaC, documentation officielle et MCP/outils autorisés.

Si l'intégration AWS spécialisée est importante, évaluez **Kiro**. Pour les installations Amazon Q Developer existantes, préparez la migration avant la fin de support IDE annoncée au 30 avril 2027.

---

## Data / ML

Priorités : reproductibilité et absence de fuite de données.

- garder preprocessing/training/eval dans des scripts versionnés ;
- notebook mince ;
- dataset final de test hors boucle ;
- skills pour protocole d'évaluation ;
- Claude produit commandes, métriques et artefacts comme preuves ;
- backend local uniquement si les données l'exigent et si la qualité est suffisante.

---

## Frontend / Node / Python / JVM

Le langage change surtout les outils de validation, pas le principe :

| Stack | Preuves typiques |
|---|---|
| JVM | Maven/Gradle, tests, inspections, Sonar |
| Node/TypeScript | tests, typecheck, lint, build |
| React | tests composants/E2E, typecheck, build |
| Python | pytest, lint/typecheck, packaging |
| Data/ML | tests + protocole d'expérience + métriques reproductibles |

Claude doit découvrir les commandes réelles du dépôt plutôt que supposer une convention générique.

---

## Quand ajouter un modèle local

Ajoutez Ollama ou LM Studio lorsque l'un de ces critères est mesurable :

- contrainte de sortie de données ;
- coût cloud significatif ;
- besoin offline ;
- latence acceptable localement ;
- matériel disponible ;
- modèle local validé sur vos tâches agentiques.

Sinon, le local peut augmenter l'exploitation sans améliorer le résultat.

---

## Checklist avant d'ajouter un outil

- Quel problème précis résout-il ?
- Est-il activement maintenu ?
- Quelles données voit-il ?
- Quels secrets exige-t-il ?
- Quelle validation indépendante existe ?
- Quel coût d'exploitation ajoute-t-il ?
- Comment le retirer ou le remplacer ?

Si ces réponses ne sont pas claires, n'ajoutez pas l'outil à la stack standard.

---

## Chapitres suivants

**[Veille IA](../chapitre-14-veille-ia/index.md)** : maintenir les informations produits, modèles et sécurité sans laisser la documentation se périmer.

**[Hacker IA](../chapitre-15-hacker-ia/index.md)** : traiter les risques offensifs/défensifs et les contrôles opérationnels.

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-13-outils-economies.md#page-chapitre-13-outils-economies-recommandations-taille-type-application).

## Prochaine étape

Poursuivez avec **[Veille IA — Accueil](../chapitre-14-veille-ia/index.md)**, la page suivante dans le menu.
