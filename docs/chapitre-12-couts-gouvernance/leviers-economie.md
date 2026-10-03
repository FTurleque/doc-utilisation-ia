# Leviers d'économie avec Claude Code

<span class="badge-intermediate">Intermédiaire</span>

Réduire le coût de Claude Code ne consiste pas à « utiliser moins d'IA » par principe. Il s'agit de limiter le **travail inutile** : contexte trop volumineux, modèle surdimensionné, explorations répétées, sessions interminables et validations manuelles qui auraient pu être automatisées.

---

## Levier 1 — Utiliser le modèle et l'effort adaptés

La consommation dépend notamment du modèle et du niveau d'effort. Réservez les configurations les plus coûteuses aux tâches qui en ont réellement besoin.

| Tâche | Stratégie |
|---|---|
| Recherche locale, lecture, renommage | modèle/effort léger ou auto |
| Correction simple et bien localisée | interaction directe |
| Refactoring multi-fichiers | Plan puis agent principal |
| Audit architecture/sécurité | modèle plus capable si nécessaire |
| Exploration volumineuse indépendante | subagent isolé |

!!! tip "Règle pratique"
    N'utilisez pas un niveau d'effort élevé pour compenser un mauvais contexte. Commencez par améliorer les entrées et les critères de validation.

---

## Levier 2 — Garder `CLAUDE.md` court

`CLAUDE.md` est chargé dans les sessions du projet. Il doit contenir les invariants à forte valeur :

```markdown
## Commands
- Tests: `pytest -q`
- Lint: `ruff check .`

## Rules
- Preserve public APIs unless requested.
- Never commit secrets.
- Run relevant tests before finishing.
```

Déplacez les détails spécialisés vers :

- `.claude/rules/` pour les règles ciblées ;
- `.claude/skills/` pour les procédures ;
- `.claude/agents/` pour les rôles spécialisés.

---

## Levier 3 — Charger le contexte à la demande

Le dépôt entier n'a pas besoin d'être lu au début de chaque tâche.

Préférez :

```text
1. point d'entrée ;
2. recherche des dépendances ;
3. lecture des seuls fichiers utiles ;
4. action ;
5. vérification.
```

Claude Code peut utiliser ses outils pour récupérer le contexte au moment où il devient nécessaire. Cette approche évite de saturer la fenêtre de contexte avec des informations qui ne serviront jamais.

---

Déplacer du texte dans `.claude/rules/` ne réduit pas à lui seul le contexte : les règles sans frontmatter `paths` sont chargées au lancement. Utilisez des règles conditionnelles avec `paths` pour les contraintes ciblées et des skills pour les procédures occasionnelles. [Chargement des règles](https://code.claude.com/docs/en/memory#path-specific-rules), revérifié le 3 octobre 2026.

## Levier 4 — Isoler les explorations lourdes dans des subagents

Un subagent dispose d'un contexte séparé. Utilisez-le pour :

- cartographier un gros module ;
- rechercher tous les appelants d'une API ;
- auditer la sécurité ;
- comparer plusieurs fichiers ;
- analyser une documentation volumineuse.

Le résultat doit revenir sous forme de synthèse exploitable plutôt que de recopier toute l'exploration dans la session principale.

---

Un subagent préserve le contexte du parent en renvoyant une synthèse ; il effectue néanmoins ses propres appels modèle. Le coût total peut augmenter, surtout si plusieurs agents relisent les mêmes fichiers. Mesurez les appels de tous les agents, pas seulement la taille de la conversation principale.

## Levier 5 — Surveiller MCP et les outils externes

Les serveurs MCP peuvent ajouter des outils et du contexte. Dans `/mcp`, vérifiez les serveurs réellement actifs et désactivez ceux dont vous n'avez pas besoin pour la tâche.

Les outils inutilisés n'apportent pas de valeur et peuvent complexifier la sélection d'outils ou le contexte disponible.

---

## Levier 6 — Réinitialiser le contexte au bon moment

- `/compact` : conserver la continuité avec un résumé plus compact ;
- `/clear` : repartir proprement pour une tâche indépendante ;
- nouvelle session : utile après une grosse tâche ou une longue phase d'exploration.

Évitez les seuils arbitraires du type « après 5 messages ». Ce qui compte est la **pertinence du contexte restant**, pas le nombre brut de tours.

---

## Levier 7 — Faire vérifier automatiquement le travail

Une mauvaise implémentation suivie de trois corrections coûte plus qu'un changement correctement validé dès le premier passage.

Demandez à Claude d'exécuter :

- tests ciblés ;
- lint/typecheck ;
- build pertinent ;
- revue du diff ;
- éventuellement un smoke test.

La vérification est un levier d'économie parce qu'elle réduit le rework.

---

## Levier 8 — Distinguer abonnement et API

Sur Pro/Max et les offres par sièges avec usage inclus, Claude et Claude Code partagent l'enveloppe prévue par le plan. Selon l'offre et les réglages, des **usage credits** permettent de continuer à l'usage. Les contrats Enterprise à consommation doivent être lus séparément. Une clé `ANTHROPIC_API_KEY` configurée peut également faire basculer Claude Code vers une facturation API distincte.

Pour rester strictement dans l'allocation du plan :

- surveillez `/usage` pour les limites et la consommation ; `/status` décrit le compte et la configuration ;
- n'activez pas les usage credits si vous ne souhaitez pas de dépassement ;
- vérifiez les variables d'environnement d'API ;
- attendez le reset de limite si nécessaire.

---

### Mesure de coût et prompt caching

Dans `/usage`, le bloc de session est une estimation locale de consommation API ; il ne transforme pas l’usage inclus Pro/Max en facture supplémentaire. La Console ou le fournisseur reste la référence de facturation. Depuis v2.1.211, `/clear` remet le total de session à zéro : enregistrez vos mesures avant d’effacer la session. Le prompt caching réduit le coût de relecture d’un préfixe éligible ; il ne raccourcit pas la fenêtre de contexte et n’équivaut pas à une compression. Distinguez tokens d’entrée non cachés, écriture du cache, lecture du cache et sortie.

[Claude Code — mesure des coûts](https://code.claude.com/docs/en/costs#track-your-costs), revérifié le 3 octobre 2026.

## Checklist quotidienne

```text
□ CLAUDE.md reste concis
□ Contexte chargé uniquement quand nécessaire
□ Exploration lourde isolée si possible
□ MCP inutiles désactivés
□ Modèle/effort adaptés à la tâche
□ Tests et checks exécutés avant conclusion
□ /compact ou /clear quand le contexte n'est plus pertinent
□ /usage vérifié si l'usage devient contraignant
```

---

## Sources

- [Claude Help Center — How do usage and length limits work?](https://support.claude.com/en/articles/11647753-how-do-usage-and-length-limits-work) — consulté le 2026-09-28
- [Claude Help Center — Manage usage credits for paid Claude plans](https://support.claude.com/en/articles/12429409-manage-usage-credits-for-paid-claude-plans) — consulté le 2026-09-28
- [Claude Code — Features overview](https://code.claude.com/docs/en/features-overview) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-12-couts-gouvernance.md#page-chapitre-12-couts-gouvernance-leviers-economie).

## Prochaine étape

Poursuivez avec **[Caveman — Réduction des tokens](caveman.md)**, la page suivante dans le menu.
