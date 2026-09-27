# Techniques Intermédiaires de Prompt Engineering

<span class="badge-intermediate">Intermédiaire</span>

Après les fondamentaux, l'objectif est de rendre les demandes **plus reproductibles**, pas simplement plus longues. Les techniques ci-dessous sont adaptées aux assistants agentiques comme Claude Code.

---

## 1. Zero-shot et few-shot

### Zero-shot

Utilisez-le lorsque la tâche et le format sont évidents :

```text
Classe chaque finding de ce rapport en : bug, sécurité, performance ou style.
Retourne un tableau Markdown.
```

### Few-shot

Montrez quelques exemples lorsque le classement, le ton ou le format est propre à votre équipe.

```text
Classe les messages comme ACTION, INFORMATION ou IGNORER.

Exemples :
- "La migration échoue sur PostgreSQL 16" → ACTION
- "Le build est passé" → INFORMATION
- "Merci !" → IGNORER

Maintenant classe les messages suivants : ...
```

!!! tip "Utilisez le codebase comme few-shot"
    En développement, le meilleur exemple est souvent un fichier existant qui respecte déjà le style attendu.

---

## 2. Décomposition explicite plutôt que raisonnement à voix haute

Pour les tâches complexes, demandez une **procédure observable** et des artefacts intermédiaires utiles.

```text
Pour diagnostiquer ce bug :
1. reproduis le cas avec le test existant ;
2. identifie le premier point où l'état diverge ;
3. propose la cause racine avec les lignes concernées ;
4. applique le correctif minimal ;
5. relance le test et montre le résultat.
```

Cette approche est préférable à demander au modèle d'exposer une longue chaîne de raisonnement interne. Ce qui importe pour la revue est la **preuve** : fichiers lus, test exécuté, diff et résultat.

---

## 3. Role prompting : utile, mais ciblé

Un rôle améliore surtout le vocabulaire, l'angle d'analyse et les priorités.

### Bon exemple

```text
Agis comme un reviewer sécurité d'API REST.
Analyse uniquement les changements du diff.
Cherche en priorité : contrôle d'accès, validation d'entrée, secrets,
injections et erreurs de journalisation.
Pour chaque finding : fichier, ligne, impact, preuve, correction.
```

### À éviter

```text
Tu es le meilleur expert du monde, génial, extrêmement intelligent...
```

Le rôle doit ajouter une **spécialisation utile**, pas de l'emphase.

Pour un rôle récurrent dans Claude Code, préférez un subagent dans `.claude/agents/` plutôt que de recopier le persona dans chaque prompt.

---

## 4. Contraintes explicites

Les contraintes réduisent les modifications involontaires.

```text
Refactore @src/payment/PaymentService.ts.

Contraintes :
- ne change pas l'API publique ;
- n'ajoute aucune dépendance ;
- conserve le comportement transactionnel ;
- ne modifie pas les fichiers hors src/payment/ et tests/payment/ ;
- exécute les tests payment avant de terminer.
```

Ajoutez surtout des contraintes que le modèle **ne peut pas déduire** du code.

---

## 5. Sorties structurées

### Pour une revue humaine

```text
Retourne les problèmes par sévérité :
Critical / High / Medium / Low.
Pour chaque problème : preuve, impact, correction minimale.
```

### Pour un pipeline

```text
Retourne uniquement :
{
  "status": "pass|fail",
  "findings": [...],
  "checks": [...]
}
```

!!! warning "Un JSON valide n'est pas une preuve de vérité"
    Le format améliore l'intégration, pas l'exactitude. Conservez une étape de vérification indépendante.

---

## 6. Boucles de feedback courtes

Claude Code fonctionne mieux lorsque vous corrigez tôt une mauvaise direction.

- `Esc` : interrompre une action en cours ;
- `/rewind` ou double `Esc` : revenir à un checkpoint ;
- `/clear` : repartir proprement entre tâches indépendantes ;
- « Undo that » : demander l'annulation d'un changement récent.

Si vous avez dû corriger plusieurs fois la même erreur, une nouvelle session avec un prompt mieux cadré est souvent plus efficace qu'un historique rempli de tentatives ratées.

---

## 7. Prompt chaining

Découpez une tâche lorsque chaque étape dépend d'un résultat vérifiable de l'étape précédente.

```text
1. Cartographier l'existant.
2. Proposer le plan.
3. Implémenter une première tranche.
4. Exécuter les tests.
5. Relire le diff.
6. Continuer ou corriger.
```

Avec Claude Code, ce pattern correspond naturellement à **Explore → Plan → Implement → Verify**.

---

## 8. Instructions persistantes ou prompt ponctuel ?

| Information | Emplacement recommandé |
|---|---|
| Convention globale stable | `CLAUDE.md` |
| Règle ciblée par fichiers | `.claude/rules/` |
| Expertise/procédure réutilisable | `.claude/skills/` |
| Rôle spécialisé isolé | `.claude/agents/` |
| Contrainte propre à la tâche courante | Prompt |

Ne surchargez pas `CLAUDE.md` avec des consignes qui ne servent qu'une fois par mois.

---

## 9. Vérification par preuves

Une bonne demande finit par un critère mesurable :

```text
Avant de terminer :
- lance `npm test -- auth` ;
- lance le linter sur les fichiers modifiés ;
- montre les commandes exécutées et leur résultat ;
- signale explicitement ce qui n'a pas pu être vérifié.
```

Pour une tâche importante, un **subagent de revue** peut fournir une seconde opinion avec un contexte neuf.

---

## Sources

- [Claude Code — Best practices](https://code.claude.com/docs/en/best-practices) — consulté le 2026-09-28
- [Claude Code — Subagents](https://code.claude.com/docs/en/sub-agents) — consulté le 2026-09-28

## Prochaine étape

**[Techniques avancées](techniques-avancees.md)** : orchestration, RAG, évaluations, vérification indépendante et défense contre les injections.