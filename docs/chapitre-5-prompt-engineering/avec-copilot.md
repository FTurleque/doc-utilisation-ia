# Prompt Engineering avec GitHub Copilot — référence conservée

<span class="badge-beginner">Débutant</span> <span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span>

!!! info "Copilot reste documenté"
    Ce dépôt est désormais **Claude-first**, mais cette page reste la référence pratique pour GitHub Copilot. Les principes généraux du prompt engineering restent les mêmes ; seuls les mécanismes de contexte et de personnalisation changent.

Pour l'usage principal du dépôt, voir **[Prompt Engineering avec Claude Code](../chapitre-3b-claude-code-migration-copilot/prompt-engineering-claude.md)**.

---

## 1. Le contexte Copilot

Copilot construit ses réponses à partir des éléments disponibles dans la surface utilisée : code, sélection, fichiers référencés, instructions du dépôt, historique et outils.

Évitez de documenter des tailles fixes de fenêtre de contexte ou une liste figée de modèles : ces valeurs dépendent du modèle, du plan, de l'IDE et évoluent régulièrement.

Le principe durable est le même que pour Claude :

> fournir le minimum de contexte pertinent, puis demander une validation observable.

---

## 2. Complétion inline

Pour les suggestions inline, le **code lui-même** reste une source de contexte majeure.

Préférez :

```typescript
/**
 * Valide une requête de recherche utilisateur.
 * Retourne une valeur nettoyée sans modifier l'entrée.
 * Lève ValidationError si la taille maximale est dépassée.
 */
function sanitizeSearchQuery(rawQuery: string): SanitizedQuery {
```

à :

```typescript
function process(data) {
```

Des noms explicites, types précis et commentaires utiles donnent de meilleurs signaux que des commentaires verbeux décrivant chaque ligne.

---

## 3. Copilot Chat

Une demande robuste suit le même schéma que dans les fondamentaux :

```text
Objectif   : corriger la régression d'authentification
Périmètre  : src/auth/ uniquement
Contexte   : suivre le pattern de UserSession.ts
Contraintes: ne pas changer l'API publique
Validation : exécuter les tests auth
```

### Référencer des fichiers

Utilisez les mécanismes de référence proposés par votre IDE et votre version de Copilot pour pointer les fichiers, sélections et dossiers réellement utiles.

---

## 4. Instructions persistantes

Copilot peut utiliser :

```text
.github/copilot-instructions.md
.github/instructions/*.instructions.md
```

Exemple ciblé :

```markdown
---
applyTo: "src/api/**/*.ts"
---

- Valider toutes les entrées.
- Utiliser le format d'erreur standard du projet.
- Ajouter ou mettre à jour les tests concernés.
```

Pour Claude, l'équivalent est `.claude/rules/*.md` avec `paths` et non `applyTo`.

---

## 5. Prompt files

Les `.github/prompts/*.prompt.md` permettent de sauvegarder des tâches récurrentes. Ils restent en preview selon les surfaces Copilot.

Exemples :

- revue de code ;
- génération de tests ;
- audit de sécurité ;
- création de documentation.

Voir [Prompt Files](../chapitre-4-contexte/prompt-files.md).

---

## 6. Agents et skills

Copilot prend en charge des custom agents et des agent skills selon la surface et la version.

```text
.github/agents/*.agent.md
.github/skills/*/SKILL.md
.claude/skills/*/SKILL.md
.agents/skills/*/SKILL.md
```

La prise en charge exacte varie : utilisez la **Copilot feature matrix** plutôt que de supposer une parité complète entre VS Code, Visual Studio, JetBrains, GitHub.com et la CLI.

---

## 7. Techniques utiles dans Copilot

- **Few-shot** : pointer vers un exemple existant.
- **Contraintes explicites** : préciser ce qui ne doit pas changer.
- **Décomposition** : séparer analyse, modification et validation.
- **Sortie structurée** : tableau ou JSON si le résultat doit être consommé.
- **Vérification** : tests, lint, build ou revue humaine.

Évitez de demander une longue chaîne de raisonnement visible. Demandez plutôt les **preuves vérifiables** : fichiers concernés, commandes exécutées, résultats et hypothèses restantes.

---

## 8. Claude + Copilot dans le même dépôt

Si vous conservez les deux outils :

| Besoin | Claude Code | GitHub Copilot |
|---|---|---|
| Instructions globales | `CLAUDE.md` | `.github/copilot-instructions.md` |
| Règles ciblées | `.claude/rules/` + `paths` | `.github/instructions/` + `applyTo` |
| Skills | `.claude/skills/` | Emplacements agent skills supportés |
| Agents | `.claude/agents/` | `.github/agents/` |
| Prompts réutilisables | Skills / commandes / prompt direct | `.github/prompts/*.prompt.md` |

Conservez une seule source métier de vérité autant que possible et évitez les consignes contradictoires entre les deux configurations.

---

## Sources

- [GitHub Docs — Copilot feature matrix](https://docs.github.com/en/copilot/reference/copilot-feature-matrix) — consulté le 2026-09-28
- [GitHub Docs — Prompt files](https://docs.github.com/en/copilot/tutorials/customization-library/prompt-files) — consulté le 2026-09-28
- [GitHub Docs — Repository custom instructions](https://docs.github.com/en/copilot/how-tos/configure-custom-instructions-in-your-ide/add-repository-instructions-in-your-ide) — consulté le 2026-09-28
- [VS Code — Custom instructions](https://code.visualstudio.com/docs/agent-customization/custom-instructions) — consulté le 2026-09-28

## Prochaine étape

Pour le parcours principal, revenez à **[Prompt Engineering avec Claude Code](../chapitre-3b-claude-code-migration-copilot/prompt-engineering-claude.md)**.