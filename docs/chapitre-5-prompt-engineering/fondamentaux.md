# Fondamentaux du Prompt Engineering

<span class="badge-beginner">Débutant</span>

Le prompt engineering consiste à donner à un modèle les **bonnes instructions, le bon contexte et un moyen de vérifier le résultat**. Dans ce dépôt, les exemples pratiques utilisent d'abord **Claude Code**, mais les principes restent valables pour Copilot et les autres assistants.

---

## 1. Ce qu'un modèle de langage fait réellement

Un LLM génère une réponse à partir de son entraînement et du **contexte disponible au moment de la requête**. Il ne connaît pas automatiquement votre besoin, vos décisions métier ni l'état exact de votre dépôt.

Le bon modèle mental n'est donc pas « un collègue qui sait tout », mais :

> un collaborateur très capable qui travaille à partir des informations et outils que vous lui rendez accessibles.

Dans un agent de développement, le contexte peut inclure :

- votre demande ;
- `CLAUDE.md` et les rules ;
- les fichiers lus ;
- le diff Git ;
- l'historique de session ;
- les résultats de commandes ;
- les outils MCP et skills utilisés.

---

## 2. Les cinq composants d'une bonne demande

Une demande de développement robuste contient généralement :

1. **Objectif** — ce qu'il faut accomplir ;
2. **Périmètre** — où intervenir et ce qu'il ne faut pas toucher ;
3. **Contexte** — fichiers, contraintes, conventions et exemples utiles ;
4. **Sortie attendue** — code, tableau, JSON, plan, rapport, etc. ;
5. **Validation** — comment savoir que le travail est correct.

```text
Objectif   : corriger le bug de session après expiration du token
Périmètre  : src/auth/ ; ne pas changer le schéma de base
Contexte   : suivre le pattern de src/auth/refresh.ts
Sortie     : correctif minimal + tests
Validation : exécuter les tests auth et montrer le résultat
```

!!! success "La validation change la qualité"
    Sans critère de vérification, un agent s'arrête quand le résultat semble plausible. Avec un test, un build, un linter ou une capture, il peut détecter lui-même un échec et itérer.

---

## 3. Être spécifique sans surcharger

Une bonne instruction réduit l'ambiguïté, mais un prompt plus long n'est pas automatiquement meilleur.

### Trop vague

```text
Corrige l'authentification.
```

### Mieux cadré

```text
Dans @src/auth/session.ts, corrige le cas où un refresh token expiré
provoque une boucle de reconnexion.

Contraintes :
- ne change pas le format du cookie ;
- conserve l'API publique ;
- ajoute un test de non-régression ;
- exécute les tests auth après la modification.
```

Le second prompt précise le besoin **sans raconter tout le projet**.

---

## 4. Pointer vers des exemples existants

Un fichier existant vaut souvent mieux qu'un paragraphe décrivant le style.

```text
Ajoute les tests de @src/services/PaymentService.ts.
Suis la structure et le nommage de @src/services/UserService.test.ts.
Couvre le succès, l'erreur fournisseur et le timeout.
Exécute uniquement la suite concernée puis montre le résultat.
```

Cette technique réduit les interprétations et produit un résultat plus homogène avec le codebase.

---

## 5. Décomposer les tâches complexes

Pour une petite correction claire, demandez directement le changement. Pour une tâche multi-fichiers ou incertaine, séparez recherche et exécution.

### Workflow recommandé avec Claude Code

```text
Explore → Plan → Implement → Verify
```

1. **Explore** : comprendre les fichiers, dépendances et contraintes.
2. **Plan** : lister les modifications et les validations.
3. **Implement** : appliquer le plan en étapes maîtrisées.
4. **Verify** : exécuter tests, build, lint ou contrôle visuel.

Le plan mode est utile quand vous ne pourriez pas décrire le diff attendu en une phrase.

---

## 6. Contraindre la sortie quand elle doit être exploitable

### Rapport Markdown

```text
Analyse ce diff et retourne :

## Bloquants
- fichier:ligne — problème — preuve — correctif

## Non bloquants
- ...

## Vérifications exécutées
- commande — résultat
```

### JSON pour automatisation

```text
Retourne uniquement un JSON valide :
{
  "risk": "low|medium|high|critical",
  "findings": [
    {"file":"...", "line":0, "issue":"...", "fix":"..."}
  ]
}
```

Un format strict est utile pour CI, scripts et génération de rapports.

---

## 7. Erreurs fréquentes

### Demande trop large

```text
Analyse tout le projet, refactore, optimise, teste et documente.
```

**Correctif :** découper par objectif et par validation.

### Contexte implicite

```text
Pourquoi ça plante ?
```

**Correctif :** fournir la cible, le symptôme et la commande reproductible.

### Instructions contradictoires

Si `CLAUDE.md`, une rule et votre prompt disent trois choses différentes, le résultat devient moins prévisible.

**Correctif :** garder les règles durables cohérentes et ne mettre dans le prompt que les contraintes propres à la tâche.

### Aucune vérification

```text
Implémente le changement.
```

**Correctif :** préciser le test, le build ou le comportement observable à valider.

---

## 8. Checklist avant d'envoyer

- [ ] L'objectif est-il observable ?
- [ ] Le périmètre est-il clair ?
- [ ] Ai-je référencé les fichiers utiles ?
- [ ] Ai-je indiqué une contrainte importante à ne pas casser ?
- [ ] Le format de sortie est-il nécessairement défini ?
- [ ] Claude peut-il **vérifier** son travail ?

Si quatre ou cinq cases suffisent, n'ajoutez pas de prose inutile.

---

## Sources

- [Claude Code — Best practices](https://code.claude.com/docs/en/best-practices) — consulté le 2026-09-28
- [Claude Code — Memory & rules](https://code.claude.com/docs/en/memory) — consulté le 2026-09-28

## Prochaine étape

**[Techniques intermédiaires](techniques-intermediaires.md)** : exemples, rôles, contraintes, décomposition et boucles de feedback.