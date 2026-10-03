# Prompt Engineering avec Claude Code

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span> <span class="badge-cli">CLI</span>

Avec Claude Code, le prompt engineering ne se limite pas à « mieux formuler une question ». Vous pilotez un **agent** capable de lire des fichiers, exécuter des commandes, modifier le dépôt et vérifier son travail.

La pratique efficace repose sur quatre leviers :

1. une tâche clairement bornée ;
2. le contexte réellement utile ;
3. un niveau de planification adapté au risque ;
4. un signal de vérification que Claude peut exécuter.

---

## 1. Donner une cible et un critère de réussite

Prompt trop vague :

```text
Améliore la validation utilisateur.
```

Prompt exploitable :

```text
Corrige la validation d'email dans src/users/validate.ts.

Contraintes :
- ne change pas la signature publique ;
- conserve le style actuel du module ;
- couvre les cas user@example.com, invalid et user@.com.

Lis les tests existants avant d'éditer.
Après la modification, exécute les tests ciblés et corrige les échecs liés à ton changement.
```

La différence essentielle est la **boucle de vérification**. Claude Code recommande de donner à l'agent un contrôle qu'il peut lire lui-même : test, build, lint, capture d'écran ou script produisant un succès/échec.

---

## 2. Fournir du contexte spécifique

Claude peut explorer le dépôt, mais une tâche mieux bornée consomme moins de contexte et nécessite moins de corrections.

Précisez si possible :

- le fichier ou module cible ;
- le scénario à traiter ;
- un exemple existant à reproduire ;
- les contraintes d'API ou de compatibilité ;
- les tests à exécuter.

```text
Dans src/api/orders/, ajoute la même stratégie de gestion d'erreurs
que celle utilisée dans src/api/users/.

Ne modifie pas les DTO publics.
Ajoute des tests pour 404 et 409, puis exécute uniquement la suite orders.
```

!!! tip "Un bon exemple vaut mieux qu'une longue description"
    Si un fichier existant incarne déjà le pattern voulu, dites à Claude de le lire et de s'en inspirer. Évitez de copier plusieurs centaines de lignes dans le prompt.

---

## 3. Explore → Plan → Implement → Verify

Pour une modification complexe ou un code que vous connaissez mal, séparez exploration et écriture.

### Activer le plan mode

Dans le terminal interactif, utilisez ++shift+tab++ jusqu'à l'activation du plan mode, ou lancez :

```bash
claude --permission-mode plan
```

### Phase 1 — Explorer

```text
Lis src/auth/ et explique le flux de session actuel.
Repère aussi où sont gérés les secrets et les variables d'environnement.
Ne modifie rien.
```

### Phase 2 — Planifier

```text
Je veux ajouter une authentification OAuth.
Propose un plan précis : fichiers touchés, séquence, risques,
compatibilité et tests à ajouter.
```

### Phase 3 — Implémenter

Sortez du plan mode, puis :

```text
Implémente le plan validé.
Écris les tests du callback et exécute la suite concernée.
Corrige les échecs introduits par tes changements.
```

### Phase 4 — Vérifier

Contrôlez le diff et les validations. Pour une tâche importante, un subagent séparé peut effectuer une revue contradictoire sans remplir le contexte principal.

!!! note "Le plan n'est pas obligatoire"
    Pour une typo, un renommage local ou une correction évidente, demander un plan ajoute surtout de la friction. Utilisez-le quand l'approche est incertaine, le changement multi-fichiers ou le domaine mal connu.

---

## 4. Où stocker les instructions récurrentes ?

| Type d'information | Mécanisme Claude Code |
|---|---|
| convention stable de tout le projet | `CLAUDE.md` |
| règle liée à certains chemins | `.claude/rules/*.md` |
| procédure / expertise réutilisable | `.claude/skills/<nom>/SKILL.md` |
| rôle avec contexte séparé | `.claude/agents/*.md` |
| contrôle avant/après une action | hook |
| outil ou donnée externe | MCP |

Ne répétez pas dans chaque prompt une règle qui doit vivre dans `CLAUDE.md`. À l'inverse, n'y mettez pas une procédure de cinquante lignes utilisée une fois par mois : faites-en un skill.

---

## 5. Skills pour les prompts récurrents

Exemple de skill de revue :

```markdown
---
name: review-diff
description: Revoit le diff courant pour détecter régressions, sécurité et tests manquants.
---

1. Lis le diff Git courant.
2. Identifie les changements de comportement.
3. Vérifie sécurité, gestion d'erreurs et compatibilité.
4. Repère les tests absents.
5. Retourne les problèmes par sévérité avec fichier et justification.
```

Vous pouvez ensuite appeler :

```text
/review-diff
```

Claude peut aussi invoquer un skill lorsque sa description correspond à la tâche, sauf si vous définissez :

```yaml
disable-model-invocation: true
```

Pour un workflow avec effet externe — publier, déployer, envoyer un message — privilégiez l'invocation manuelle.

---

## 6. Utiliser les subagents pour protéger le contexte principal

Une exploration large peut lire énormément de fichiers. Pour les investigations lourdes :

```text
Utilise un subagent pour comprendre comment les tokens de session sont renouvelés.
Retourne uniquement :
- le flux actuel ;
- les fichiers clés ;
- les fonctions réutilisables ;
- les risques pour la modification demandée.
```

Le subagent travaille dans un contexte séparé et remonte une synthèse. Cela évite de remplir la conversation principale avec toutes les lectures intermédiaires.

---

## 7. Gérer agressivement le contexte

Le contexte devient moins utile lorsqu'il accumule des fichiers, sorties de commandes et corrections liées à plusieurs tâches.

| Situation | Réflexe |
|---|---|
| tâche terminée, nouvelle tâche indépendante | `/clear` |
| session longue | laisser l'auto-compaction agir |
| besoin de contrôler le résumé | `/compact <instructions>` |
| revenir à un point antérieur | ++esc+esc++ ou `/rewind` |
| question annexe jetable | `/btw` si disponible dans votre version |
| investigation volumineuse | subagent |

Claude Code crée aussi des checkpoints avant les modifications faites par ses outils d'édition. `/rewind` peut restaurer conversation, code ou les deux ; cela **ne remplace pas Git**, notamment pour les modifications produites par des commandes externes.

---

## 8. Arrêter les boucles de correction

Après plusieurs corrections infructueuses, continuer dans le même contexte peut empirer la situation.

Approche recommandée :

1. identifiez ce que la tentative vous a appris ;
2. utilisez `/clear` ;
3. reformulez un nouveau prompt initial plus précis ;
4. ajoutez un critère de vérification automatique.

Un contexte propre avec une meilleure consigne est souvent plus efficace qu'une longue conversation remplie d'approches abandonnées.

---

## 9. Formats structurés

Quand la sortie doit alimenter un script ou une revue :

```text
Analyse le module de paiement.
Retourne uniquement un JSON valide :

{
  "risk": "low|medium|high|critical",
  "findings": [
    {
      "file": "...",
      "category": "...",
      "reason": "...",
      "remediation": "..."
    }
  ]
}
```

Pour les tâches automatisées, le mode non interactif propose aussi des formats de sortie machine, notamment JSON et streaming JSON selon les options CLI.

---

## 10. Anti-patterns

| Anti-pattern | Correctif |
|---|---|
| « Analyse tout le repo et améliore-le » | borner le module et le critère de réussite |
| session qui mélange cinq tâches | `/clear` entre sujets |
| `CLAUDE.md` encyclopédique | rules + skills, et supprimer ce que Claude fait déjà correctement |
| recherche énorme dans le contexte principal | subagent |
| changement sans moyen de validation | fournir tests/build/lint/screenshot |
| répéter un gros prompt à chaque fois | skill |
| demander systématiquement une longue chaîne de raisonnement | demander plutôt plan, résultat structuré et preuves vérifiables |

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-3b-claude-code-migration-copilot.md#page-chapitre-3b-claude-code-migration-copilot-prompt-engineering-claude).

## Prochaine étape

Poursuivez avec **[Cookbook — recettes prêtes](cookbook.md)**, la page suivante dans le menu.

## Sources

Sources officielles consultées le **28 septembre 2026** :

- [Claude Code — Best practices](https://code.claude.com/docs/en/best-practices)
- [Claude Code — Memory and project instructions](https://code.claude.com/docs/en/memory)
- [Claude Code — Skills](https://code.claude.com/docs/en/skills)
- [Claude Code — Subagents](https://code.claude.com/docs/en/sub-agents)
- [Claude Code — CLI reference](https://code.claude.com/docs/en/cli-reference)
