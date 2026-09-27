# Prompt Files (`.prompt.md`) — référence GitHub Copilot

<span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span> <span class="badge-expert">Expert</span>

!!! info "Page Copilot conservée"
    Les fichiers `.prompt.md` restent documentés ici pour **GitHub Copilot**. Ils sont actuellement proposés en preview dans VS Code, Visual Studio et JetBrains.

    Pour le parcours Claude-first de ce dépôt, utilisez plutôt un **skill Claude** dans `.claude/skills/<nom>/SKILL.md` lorsqu'un workflow doit être versionné et réutilisé. Voir [Skills Claude](guide-skills.md).

---

## À quoi sert un `.prompt.md` ?

Un prompt file encapsule une tâche récurrente : revue de code, génération de tests, documentation, audit, refactoring, etc.

Emplacement de référence :

```text
.github/prompts/
├── code-review.prompt.md
├── generate-tests.prompt.md
└── security-audit.prompt.md
```

Dans Copilot Chat, les prompt files peuvent être invoqués via `/nom-du-prompt` et complétés avec du contexte supplémentaire.

---

## Exemple minimal

```markdown
---
description: Revue de code focalisée sécurité et régressions
tools:
  - codebase
---

Analyse le code fourni ou sélectionné.

Retourne :
1. les bugs probables ;
2. les risques sécurité ;
3. les régressions possibles ;
4. les tests manquants ;
5. les corrections prioritaires.
```

!!! warning "Frontmatter : ne recopiez pas d'anciens exemples sans vérifier"
    Les champs et outils disponibles évoluent avec Copilot et l'IDE. Utilisez la documentation officielle de votre version pour valider `tools`, le mode d'exécution et les variables de contexte.

---

## Référencer du contexte

Les formats officiellement documentés incluent notamment les liens Markdown et les références `#file:`.

```markdown
Compare l'implémentation avec [nos conventions](../instructions/api.instructions.md).
Analyse aussi #file:../../src/api/UserController.ts.
```

Les chemins relatifs sont résolus à partir du fichier `.prompt.md`.

---

## Copilot prompt file ou Claude skill ?

| Besoin | Copilot | Claude Code |
|---|---|---|
| Prompt ponctuel réutilisable | `.github/prompts/*.prompt.md` | Skill ou prompt direct |
| Workflow récurrent avec fichiers de référence | Prompt file | `.claude/skills/<nom>/SKILL.md` |
| Connaissance chargée selon la tâche | Agent skill | Skill Claude |
| Instructions toujours actives | `.github/copilot-instructions.md` / `.instructions.md` | `CLAUDE.md` / `.claude/rules/` |
| Agent spécialisé | `.github/agents/*.agent.md` | `.claude/agents/*.md` |

### Exemple d'équivalent Claude

```text
.claude/skills/code-review/
├── SKILL.md
└── checklist.md
```

```markdown
---
name: code-review
description: Revue de changements avant commit ou PR ; recherche bugs, régressions, sécurité et tests manquants.
---

# Code review

1. Lire le diff et les fichiers impactés.
2. Vérifier les conventions du projet.
3. Chercher les régressions et risques sécurité.
4. Exécuter ou proposer les vérifications pertinentes.
5. Retourner les constats par sévérité avec preuves.
```

---

## Bonnes pratiques

- Un prompt = **une tâche clairement identifiable**.
- Référencer les conventions plutôt que les recopier partout.
- Définir le **résultat attendu** et les critères de validation.
- Ne pas donner d'outils d'écriture à un prompt de revue s'ils ne sont pas nécessaires.
- Vérifier le prompt après une mise à jour majeure de Copilot ou de l'IDE.
- Préférer un skill Claude si la même capacité doit devenir le workflow principal du dépôt.

---

## Sources

- [GitHub Docs — Prompt files](https://docs.github.com/en/copilot/tutorials/customization-library/prompt-files) — consulté le 2026-09-28
- [GitHub Docs — Repository custom instructions et prompt files](https://docs.github.com/en/copilot/how-tos/configure-custom-instructions-in-your-ide/add-repository-instructions-in-your-ide) — consulté le 2026-09-28
- [VS Code — Prompt files](https://code.visualstudio.com/docs/agent-customization/prompt-files) — consulté le 2026-09-28
- [Claude Code — Skills](https://code.claude.com/docs/en/skills) — consulté le 2026-09-28

## Prochaine étape

**[Agents spécialisés](guide-agents.md)** : comparer les agents Copilot conservés avec les subagents Claude désormais utilisés comme référence principale.