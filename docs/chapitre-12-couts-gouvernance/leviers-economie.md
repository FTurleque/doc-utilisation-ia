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

## Levier 4 — Isoler les explorations lourdes dans des subagents

Un subagent dispose d'un contexte séparé. Utilisez-le pour :

- cartographier un gros module ;
- rechercher tous les appelants d'une API ;
- auditer la sécurité ;
- comparer plusieurs fichiers ;
- analyser une documentation volumineuse.

Le résultat doit revenir sous forme de synthèse exploitable plutôt que de recopier toute l'exploration dans la session principale.

---

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

Avec les plans Claude payants, l'usage Claude et Claude Code partage des limites. Une fois la limite atteinte, des **usage credits** peuvent permettre de continuer en tarification à l'usage. Une clé `ANTHROPIC_API_KEY` configurée peut également faire basculer Claude Code vers une facturation API distincte.

Pour rester strictement dans l'allocation du plan :

- surveillez `/status` ;
- n'activez pas les usage credits si vous ne souhaitez pas de dépassement ;
- vérifiez les variables d'environnement d'API ;
- attendez le reset de limite si nécessaire.

---

## Checklist quotidienne

```text
□ CLAUDE.md reste concis
□ Contexte chargé uniquement quand nécessaire
□ Exploration lourde isolée si possible
□ MCP inutiles désactivés
□ Modèle/effort adaptés à la tâche
□ Tests et checks exécutés avant conclusion
□ /compact ou /clear quand le contexte n'est plus pertinent
□ /status vérifié si l'usage devient contraignant
```

---

## GitHub Copilot — référence

Pour Copilot, la logique de coût repose aujourd'hui sur les **GitHub AI Credits** pour les fonctions IA facturées, tandis que les code completions et next edit suggestions restent hors AI Credits sur les plans payants. Cette mécanique est documentée séparément dans [AI Credits — référence Copilot](premium-requests.md).

---

## Sources

- [Claude Help Center — How do usage and length limits work?](https://support.claude.com/en/articles/11647753-how-do-usage-and-length-limits-work) — consulté le 2026-09-28
- [Claude Help Center — Manage usage credits for paid Claude plans](https://support.claude.com/en/articles/12429409-manage-usage-credits-for-paid-claude-plans) — consulté le 2026-09-28
- [Claude Code — Features overview](https://code.claude.com/docs/en/features-overview) — consulté le 2026-09-28

## Prochaine étape

**[Quand utiliser quel mode ?](modes-quand-utiliser.md)** : choisir entre interaction directe, Plan, agent principal, subagents et skills selon la tâche.