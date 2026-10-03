# `applyTo` avancé — référence GitHub Copilot

<span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span> <span class="badge-expert">Expert</span>

!!! info "Page Copilot conservée"
    `applyTo` appartient aux fichiers `*.instructions.md` de **GitHub Copilot**. La documentation principale du dépôt est désormais Claude-first, mais cette page reste utile pour les équipes qui conservent Copilot.

    **Équivalent Claude Code :** utilisez `paths` dans les fichiers `.claude/rules/*.md`. Voir [Instructions & règles Claude](guide-instructions.md).

---

## `applyTo` côté Copilot

Dans `.github/instructions/*.instructions.md`, `applyTo` permet de charger automatiquement une règle lorsque Copilot travaille sur un fichier correspondant au glob.

```yaml
---
description: Conventions TypeScript du frontend
applyTo: "src/**/*.{ts,tsx}"
---

- TypeScript strict.
- Aucun `any` sans justification.
- Exécuter les tests ciblés après modification.
```

### Motifs utiles

| Objectif | `applyTo` Copilot |
|---|---|
| Tout le dépôt | `**` |
| Tous les fichiers Java | `**/*.java` |
| TypeScript + TSX | `**/*.{ts,tsx}` |
| API | `src/api/**` |
| Tests TypeScript | `**/*.test.ts,**/*.spec.ts` |
| Skills | `**/.github/skills/**/SKILL.md,**/.claude/skills/**/SKILL.md` |

!!! tip "N'utilisez `**` que pour une règle réellement globale"
    Plus la règle est spécifique, plus son glob doit être étroit. Une règle React appliquée à tout le dépôt ajoute du bruit et peut produire des instructions contradictoires.

---

## Équivalent Claude Code : `paths`

Claude Code utilise le champ `paths` dans `.claude/rules/*.md`.

```yaml
---
paths:
  - "src/**/*.{ts,tsx}"
  - "tests/**/*.test.ts"
---

# Règles TypeScript

- TypeScript strict.
- Ne pas utiliser `any` sans justification.
- Lancer les tests ciblés après modification.
```

Différence importante : **Claude ne lit que `paths` dans le frontmatter d'une rule**. Les autres champs éventuels du frontmatter sont ignorés.

| Besoin | Copilot | Claude Code |
|---|---|---|
| Règle globale | `.github/copilot-instructions.md` ou `applyTo: "**"` | `CLAUDE.md` ou rule sans `paths` |
| Règle ciblée | `*.instructions.md` + `applyTo` | `.claude/rules/*.md` + `paths` |
| Règle chargée à la demande | Prompt file / skill | Skill Claude |

---

## Pièges fréquents

1. **Glob trop large** : `**` pour une règle qui ne concerne qu'un module.
2. **Extensions oubliées** : `.ts` sans `.tsx`, ou tests `*.spec.*` oubliés.
3. **Règles contradictoires** entre instructions globales et ciblées.
4. **Copier `applyTo` dans une rule Claude** : Claude attend `paths`, pas `applyTo`.
5. **Copier `paths` dans une instruction Copilot** : Copilot attend `applyTo`.

---

## Stratégie multi-outils recommandée

Si le dépôt doit rester compatible Claude + Copilot :

```text
CLAUDE.md                         <- règles globales Claude
.claude/rules/                    <- règles ciblées Claude
.github/copilot-instructions.md   <- règles globales Copilot
.github/instructions/             <- règles ciblées Copilot
```

Gardez les règles métier communes cohérentes entre les deux formats. N'essayez pas de créer un seul fichier hybride avec `applyTo` et `paths` : les moteurs n'interprètent pas les mêmes métadonnées.

---

## Sources

- [Claude Code — mémoire et `.claude/rules/`](https://code.claude.com/docs/en/memory) — consulté le 2026-09-28
- [VS Code — Custom instructions](https://code.visualstudio.com/docs/agent-customization/custom-instructions) — consulté le 2026-09-28
- [GitHub Docs — Custom instructions](https://docs.github.com/en/copilot/how-tos/configure-custom-instructions-in-your-ide/add-repository-instructions-in-your-ide) — consulté le 2026-09-28

## Prochaine étape

Poursuivez avec **[Prompt Files Copilot (référence)](prompt-files.md)**, la page suivante dans le menu.
