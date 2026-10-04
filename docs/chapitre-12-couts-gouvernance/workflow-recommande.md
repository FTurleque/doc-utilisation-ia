# Workflow recommandé avec Claude Code

<span class="badge-expert">Expert</span>

Un workflow efficace avec Claude Code minimise surtout le **rework** et le **contexte inutile**. Le parcours de référence est :

```text
Explore → Plan → Implement → Verify
```

Toutes les tâches n'ont pas besoin des quatre étapes formelles ; adaptez le niveau de contrôle à la complexité et au risque.

---

## 1. Explore — comprendre avant de modifier

Claude doit d'abord récupérer le minimum de contexte nécessaire :

- fichiers concernés ;
- tests voisins ;
- configuration ;
- conventions du dépôt ;
- erreur ou comportement observé.

```text
Explore le chemin d'exécution de `createOrder`.
Identifie les fichiers réellement impliqués et les tests existants.
Ne modifie rien.
Retourne uniquement : flux, invariants, risques et questions ouvertes.
```

Pour une exploration volumineuse, utilisez un subagent afin de ne pas saturer le contexte principal.

---

## 2. Plan — seulement quand le risque le justifie

Un plan est utile si la tâche touche plusieurs composants ou si une erreur de direction serait coûteuse.

```text
Propose un plan minimal pour corriger le bug.
Pour chaque étape : fichiers, changement, risque, test de validation.
Préserve l'API publique.
```

Validez surtout :

- périmètre ;
- ordre ;
- migrations éventuelles ;
- compatibilité ;
- stratégie de test.

---

## 3. Implement — modifier par incréments

Évitez les réécritures massives lorsque des étapes indépendantes sont possibles.

```text
Implémente uniquement les étapes 1 et 2 du plan.
Respecte les patterns voisins.
N'ajoute pas de dépendance.
Exécute les tests ciblés après modification.
```

Une petite boucle observée est souvent moins coûteuse qu'une génération massive suivie de plusieurs corrections.

---

## 4. Verify — obtenir du ground truth

La vérification doit venir autant que possible de l'environnement :

```text
Avant de terminer :
1. exécute les tests pertinents ;
2. exécute lint/typecheck/build selon le dépôt ;
3. inspecte le diff ;
4. vérifie qu'aucun fichier hors périmètre n'a changé ;
5. résume les commandes exécutées et leur résultat.
```

Une phrase comme « cela devrait fonctionner » n'est pas une validation.

---

## Exemple — corriger un bug

```text
1. Reproduis le bug avec le test ou la commande fournie.
2. Localise la cause racine ; ne change rien avant de l'avoir identifiée.
3. Ajoute ou adapte un test qui démontre le bug.
4. Applique le correctif minimal.
5. Exécute le test ciblé puis la suite pertinente.
6. Relis le diff et signale toute modification annexe.
```

Cette séquence est généralement plus robuste qu'une demande « corrige ce bug » sans preuve reproductible.

---

## Exemple — nouvelle fonctionnalité multi-fichiers

```text
Explore les patterns similaires dans le dépôt.
Passe en Plan et propose les fichiers à modifier.
Après validation : implémente par petites étapes.
Après chaque étape significative, exécute le test le plus ciblé.
À la fin : tests + build + diff.
```

Pour les composants indépendants, des subagents peuvent explorer en parallèle puis retourner des synthèses courtes.

---

## Exemple — migration de dépendance

```text
1. Lis la version actuelle dans le lockfile / build file.
2. Consulte la documentation et le changelog officiels actuels.
3. Identifie uniquement les breaking changes applicables à ce dépôt.
4. Mets à jour dépendance + code concerné.
5. Exécute tests et build.
6. N'affirme pas la compatibilité si le runtime cible n'a pas été testé.
```

Le coût de recherche initiale est souvent inférieur au coût d'une migration basée sur une API obsolète.

---

### Nouvelle tâche sans rapport

Utilisez `/clear` pour ne pas transporter l'historique précédent.

### Session longue mais même objectif

Utilisez `/compact` quand le contexte devient lourd, en conservant décisions, erreurs non résolues et état courant.

### Gros logs ou données

Préférez :

- `head`, `tail`, filtres et recherches ciblées ;
- fichiers intermédiaires ;
- références légères ;
- subagents pour les explorations bruyantes.

Anthropic décrit cette logique comme du **just-in-time context** : charger les informations quand elles deviennent nécessaires au lieu de tout injecter au départ.

---

## Checklist de fin de tâche

```markdown
- [ ] Objectif atteint sans élargissement non demandé
- [ ] Tests ciblés exécutés
- [ ] Build/lint/typecheck exécutés si pertinents
- [ ] Diff relu
- [ ] Aucun secret ou artefact temporaire ajouté
- [ ] Documentation mise à jour si comportement public modifié
- [ ] Commandes et limites de validation résumées
```

---

## Ce qui réduit réellement le coût

| Mauvaise pratique | Alternative |
|---|---|
| Tout le dépôt dans le prompt | Recherche ciblée / just-in-time |
| Session unique pour plusieurs sujets | `/clear` entre sujets |
| Longues instructions permanentes | `CLAUDE.md` court + rules/skills |
| Agent sans test | boucle avec validation exécutable |
| Plusieurs corrections spéculatives | reproduire → corriger → tester |
| Sous-agents systématiques | uniquement pour contexte isolable |

---

## Sources

- [Anthropic — Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) — consulté le 2026-09-28
- [Claude Code — Best practices](https://code.claude.com/docs/en/best-practices) — consulté le 2026-09-28
- [Anthropic — Effective harnesses for long-running agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-12-couts-gouvernance.md#page-chapitre-12-couts-gouvernance-workflow-recommande).

## Prochaine étape

Poursuivez avec **[Outils — Accueil](../chapitre-13-outils-economies/index.md)**, la page suivante dans le menu.
