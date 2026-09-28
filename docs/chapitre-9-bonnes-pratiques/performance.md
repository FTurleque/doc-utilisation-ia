# Performance & Ressources avec Claude Code

<span class="badge-beginner">Débutant</span>

La performance de Claude Code dépend moins d'un chiffre fixe de RAM ou CPU que de la **taille du contexte utile**, des commandes exécutées, du nombre d'outils exposés et de la complexité de la tâche. Cette page remplace les anciens profils matériels Copilot non vérifiés par des pratiques mesurables.

---

## 1. Les quatre budgets à surveiller

| Budget | Ce qui le consomme |
|---|---|
| Contexte | historique, fichiers lus, sorties d'outils, règles |
| Temps | builds, tests, recherches, appels externes |
| Machine locale | linters, compilateurs, tests, conteneurs, IDE |
| Services externes | API, MCP, CI, modèles, bases de données |

Optimiser Claude signifie souvent réduire le **bruit** avant de chercher à accélérer le modèle lui-même.

---

## 2. Contexte : charger juste ce qui est utile

Anthropic décrit Claude Code comme combinant des instructions de base avec du **just-in-time retrieval** via les outils du système.

Pratiques :

- `CLAUDE.md` court ;
- rules ciblées ;
- skills chargés pour les procédures spécialisées ;
- références de fichiers plutôt que copier-coller massif ;
- subagents pour les explorations qui produisent beaucoup de texte ;
- `/clear` entre tâches indépendantes ;
- compaction pour les tâches longues.

---

## 3. Sorties de commandes

Une commande qui imprime 50 000 lignes pollue le contexte et complique le diagnostic.

Préférez :

```bash
pytest -q
```

ou des filtres ciblés :

```bash
rg "ERROR|FAIL" logs/test.log | head -100
```

Demandez à Claude de stocker une sortie volumineuse dans un fichier puis d'en lire uniquement les portions nécessaires.

---

## 4. Tests ciblés avant suite complète

Boucle efficace :

```text
modification locale
→ test ciblé
→ lint/typecheck ciblé
→ suite plus large lorsque le changement est stable
```

Évitez de lancer un build global coûteux après chaque édition si un test de module peut fournir le même signal plus rapidement.

Le contrôle final doit toutefois couvrir le niveau requis par votre Definition of Done.

---

## 5. Parallélisme

Les tâches indépendantes peuvent être parallélisées :

- tests backend et frontend ;
- analyses de modules indépendants ;
- recherches de documentation distinctes.

Ne parallélisez pas :

- migrations modifiant la même base ;
- commandes qui écrivent le même artefact ;
- plusieurs agents éditant le même fichier sans coordination.

Le débit augmente seulement si le travail est réellement indépendant.

---

## 6. Subagents et contexte

Un subagent est utile quand une sous-tâche :

- produit beaucoup de sorties intermédiaires ;
- peut être résumée proprement ;
- n'a pas besoin de tout l'historique principal.

Exemple : cartographier 300 fichiers puis retourner uniquement les 10 composants et dépendances significatives.

---

## 7. MCP : exposer peu d'outils, avec des réponses compactes

Un serveur MCP peut fournir de nombreux outils, mais plus n'est pas automatiquement mieux.

Anthropic recommande pour les outils d'agents :

- frontières fonctionnelles claires ;
- noms et descriptions explicites ;
- réponses utiles mais compactes ;
- evals réalistes des appels d'outils.

Pour le code local, utilisez d'abord les capacités natives de lecture/recherche de Claude Code. MCP est surtout utile pour les **systèmes externes**.

---

## 8. Gros fichiers et données

Ne chargez pas entièrement un gros dump, log ou dataset lorsque quelques requêtes suffisent.

Pattern :

```text
1. inspecter taille/schema ;
2. échantillonner ;
3. filtrer ;
4. exécuter une requête ciblée ;
5. charger seulement le résultat utile.
```

Claude Code peut utiliser des commandes shell pour effectuer ce tri avant d'intégrer le contenu au contexte.

---

## 9. IDE vs CLI

VS Code et JetBrains ajoutent une interface pratique, mais les coûts principaux d'une tâche agentique viennent souvent des outils exécutés : tests, builds, indexeurs, conteneurs, serveurs de développement.

Si votre machine ralentit :

1. profilez le processus réellement consommateur ;
2. réduisez les jobs parallèles lourds ;
3. limitez les watchers inutiles ;
4. utilisez des tests ciblés ;
5. fermez les environnements non utilisés.

Ne supposez pas qu'une extension IA est la cause sans mesure.

---

## 10. Sandboxing

Le sandbox peut permettre plus d'autonomie dans une zone limitée. Cela améliore aussi l'ergonomie en réduisant les validations manuelles répétitives lorsque les frontières sont bien définies.

La performance ne doit toutefois pas conduire à retirer les protections : mieux vaut une limite filesystem/réseau claire qu'un mode d'accès global simplement pour éviter quelques prompts.

---

## 11. Jobs longs

Pour entraînement ML, build massif ou tests end-to-end :

- utilisez la CI ou un job runner ;
- stockez les logs ;
- rendez l'état observable ;
- laissez Claude analyser le résultat plutôt que conserver une session active uniquement pour attendre.

---

## 12. Observabilité et GreenOps

Dès qu'un workflow devient distribué ou durable, ne mesurez plus seulement le temps ressenti dans l'IDE.

Suivez selon le système :

- latence et throughput ;
- erreurs/retries ;
- CPU, mémoire, GPU ;
- logs structurés ;
- métriques métier ;
- consommation énergétique si elle est pertinente.

Le chapitre **Outils** contient maintenant une section dédiée :

- **[Grafana](../chapitre-13-outils-economies/observabilite/grafana.md)** pour dashboards, exploration et alerting ;
- **[Loki](../chapitre-13-outils-economies/observabilite/loki.md)** pour les logs ;
- **[Kepler](../chapitre-13-outils-economies/observabilite/kepler.md)** pour les métriques d'énergie Kubernetes.

Architecture typique :

```text
application / agent
→ métriques + logs
→ Prometheus / Loki
→ Grafana

Kubernetes
→ Kepler
→ Prometheus
→ Grafana
```

Pour une optimisation, comparez toujours à **charge fonctionnelle comparable**. Une baisse de CPU ou de watts n'est pas un gain si le traitement devient beaucoup plus lent ou moins correct.

---

## 13. Mesurer avant/après

Pour une optimisation de workflow, mesurez :

- durée totale ;
- nombre d'échecs/retries ;
- taille des sorties ;
- appels externes ;
- métriques métier ou de qualité concernées ;
- ressources/énergie lorsque l'environnement permet une mesure pertinente.

Évitez les tables génériques « telle configuration = X MB RAM » : elles varient avec l'IDE, le projet, les extensions et les versions.

---

## Référence Copilot

Les réglages de complétion et diagnostics spécifiques Copilot restent documentés dans les pages Copilot. Ils ne sont plus utilisés comme base générique pour estimer les ressources d'un workflow Claude.

---

## Sources

- [Anthropic — Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) — consulté le 2026-09-28
- [Anthropic — Writing effective tools for agents](https://www.anthropic.com/engineering/writing-tools-for-agents) — consulté le 2026-09-28
- [Anthropic — Claude Code sandboxing](https://www.anthropic.com/engineering/claude-code-sandboxing) — consulté le 2026-09-28
- [Grafana — documentation](https://grafana.com/docs/grafana/latest/) — consulté le 2026-09-28
- [Grafana Loki — documentation](https://grafana.com/docs/loki/latest/) — consulté le 2026-09-28
- [CNCF — Kepler](https://www.cncf.io/projects/kepler/) — consulté le 2026-09-28

## Prochaine étape

**[Workflows IA complets](workflows-ia.md)** pour appliquer ces optimisations dans des cycles de développement complets.
