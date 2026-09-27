# Instructions projet — Claude Code, rules et compatibilité Copilot

<span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span> <span class="badge-expert">Expert</span>

Les instructions persistantes doivent contenir ce que vous ne voulez **pas réexpliquer à chaque session** : commandes de build, architecture, conventions, contraintes et pièges du projet.

Dans ce dépôt, le mécanisme principal est désormais **Claude Code**. Les instructions GitHub Copilot restent documentées dans une section dédiée afin de préserver la compatibilité.

---

## 1. `CLAUDE.md` — instructions principales du projet

Claude Code charge les instructions projet depuis :

```text
./CLAUDE.md
```

ou :

```text
./.claude/CLAUDE.md
```

Pour une équipe, versionnez ce fichier avec le dépôt.

### Que mettre dans `CLAUDE.md` ?

```markdown
# Mon projet

## Commandes
- Build : `npm run build`
- Tests : `npm test`
- Lint : `npm run lint`

## Architecture
- API : `src/api/`
- Domaine : `src/domain/`
- Accès aux données : `src/repositories/`

## Conventions
- TypeScript strict
- Pas de `any` sans justification
- Validation des entrées avec Zod
- Tests requis pour toute correction de bug
```

Claude recommande des instructions :

- **spécifiques** ;
- **vérifiables** ;
- **courtes** ;
- sans contradictions avec les autres fichiers d'instructions.

Une cible raisonnable est **moins de 200 lignes** par `CLAUDE.md`.

---

## 2. `AGENTS.md` — instructions partageables entre agents

Claude Code sait lire `AGENTS.md` nativement dans les versions récentes.

Le comportement par défaut est important :

| Fichiers présents dans le projet | Chargement par défaut |
|---|---|
| `AGENTS.md` sans `CLAUDE.md` | `AGENTS.md` est lu |
| `AGENTS.md` + `CLAUDE.md` | le `CLAUDE.md` projet est privilégié |
| `CLAUDE.md` contient `@AGENTS.md` | les deux sont chargés |

Ce dépôt choisit explicitement :

```markdown
@AGENTS.md

# Claude Code — instructions du projet
...
```

Cela permet de garder un socle `AGENTS.md` portable tout en donnant à Claude ses instructions spécifiques.

---

## 3. Imports avec `@`

Un `CLAUDE.md` peut importer des fichiers :

```markdown
@AGENTS.md
@docs/architecture.md
@docs/conventions.md
```

Les chemins relatifs sont résolus depuis le fichier qui contient l'import. Les imports sont ajoutés au contexte au démarrage : les utiliser pour « découper » un gros `CLAUDE.md` améliore l'organisation, **mais ne réduit pas nécessairement les tokens chargés**.

!!! warning "Import externe"
    Un import qui pointe en dehors du répertoire de travail peut déclencher une demande d'approbation. Cette protection évite qu'un dépôt partagé fasse charger silencieusement un fichier externe.

---

## 4. `CLAUDE.local.md` — préférences personnelles

Pour une préférence liée à un projet mais qui ne doit pas être partagée :

```text
CLAUDE.local.md
```

Exemples :

```markdown
# Préférences locales
- Utiliser mon environnement Docker local `dev-personal`.
- Pour les exemples de test, préférer les fixtures dans `sandbox/`.
```

Ajoutez le fichier au `.gitignore`.

---

## 5. `.claude/rules/` — règles thématiques

Quand une règle ne doit pas gonfler `CLAUDE.md`, créez un fichier sous :

```text
.claude/rules/
├── markdown.md
├── security.md
└── tests.md
```

Une rule sans frontmatter est globale. Pour la limiter à certains chemins, utilisez **`paths`** :

```markdown
---
paths:
  - "docs/**/*.md"
  - "mkdocs.yml"
---

# Règles documentation

- Rédiger en français.
- Préserver les liens relatifs.
- Vérifier la navigation après ajout d'une page.
```

### Patterns courants

| Pattern | Portée |
|---|---|
| `**/*.md` | tous les Markdown |
| `docs/**/*` | tout sous `docs/` |
| `src/**/*.{ts,tsx}` | TypeScript / TSX sous `src/` |
| `tests/**/*.test.ts` | tests TypeScript ciblés |

!!! important "Claude et Copilot n'utilisent pas le même champ"
    - Claude Code : `paths` dans `.claude/rules/*.md`.
    - GitHub Copilot : `applyTo` dans `.github/instructions/*.instructions.md`.

Ne copiez pas un frontmatter de l'un vers l'autre sans adaptation.

---

## 6. Quand préférer un skill ?

Utilisez un **skill** plutôt qu'une instruction permanente lorsqu'il s'agit :

- d'une procédure multi-étapes ;
- d'une expertise domaine détaillée ;
- d'un workflow seulement utile ponctuellement ;
- d'une tâche que Claude peut sélectionner quand elle devient pertinente.

Exemple : une checklist de revue de documentation de 100 lignes n'a pas besoin d'être injectée dans chaque session. Placez-la dans `.claude/skills/doc-review/SKILL.md`.

---

## 7. Instructions ≠ politique de sécurité

`CLAUDE.md`, `AGENTS.md` et les rules influencent le modèle. Ils ne constituent pas une barrière technique absolue.

Pour empêcher réellement une action, utilisez :

- `permissions.deny` / `permissions.allow` ;
- les settings gérés d'organisation ;
- le sandboxing lorsque disponible ;
- un hook `PreToolUse` lorsque le contrôle doit être dynamique.

```json
{
  "permissions": {
    "deny": [
      "Read(./.env)",
      "Read(./secrets/**)"
    ]
  }
}
```

---

## 8. GitHub Copilot — référence conservée

### Instructions globales Copilot

```text
.github/copilot-instructions.md
```

Ce fichier reste présent dans ce dépôt pour les utilisateurs Copilot.

### Instructions ciblées Copilot

```text
.github/instructions/
├── markdown.instructions.md
├── java.instructions.md
└── tests.instructions.md
```

Exemple :

```markdown
---
description: Conventions TypeScript
applyTo: "**/*.{ts,tsx}"
---

- TypeScript strict.
- Pas de `any` sans justification.
```

Le support précis dépend de la surface Copilot. Consultez la matrice officielle plutôt que de supposer que VS Code et JetBrains sont identiques.

---

## 9. Migration progressive Copilot → Claude

| Copilot existant | Claude-first |
|---|---|
| `.github/copilot-instructions.md` | `CLAUDE.md` ou import depuis celui-ci |
| `.github/instructions/*.instructions.md` + `applyTo` | `.claude/rules/*.md` + `paths` |
| longue procédure dans une instruction | `.claude/skills/<nom>/SKILL.md` |
| contrainte comportementale | `CLAUDE.md` / rules |
| interdiction de sécurité exprimée en texte | permissions/settings/hook |

!!! tip "Ne supprimez pas l'original Copilot pendant la migration"
    Tant que Copilot reste une référence du dépôt, créez l'équivalent Claude puis maintenez les deux seulement lorsqu'ils servent réellement des utilisateurs différents. Évitez les copies inutiles qui divergent silencieusement.

---

## Vérifier ce qui est chargé

Dans Claude Code :

```text
/context
```

permet d'inspecter notamment les fichiers de mémoire/instructions présents dans le contexte.

Pour les settings :

```text
/status
```

et, en cas de configuration invalide :

```bash
claude doctor
```

---

## Prochaine étape

Passez à **[Skills](guide-skills.md)** pour externaliser les workflows et connaissances qui ne doivent pas rester dans le contexte permanent.

---

## Sources

Sources officielles consultées le **28 septembre 2026** :

- [Claude Code — Memory, CLAUDE.md, AGENTS.md et rules](https://code.claude.com/docs/en/memory)
- [Claude Code — Settings](https://code.claude.com/docs/en/settings)
- [Claude Code — Best practices](https://code.claude.com/docs/en/best-practices)
- [GitHub Docs — Copilot customization cheat sheet](https://docs.github.com/en/copilot/reference/customization-cheat-sheet)
