# Skills — Claude Code

<span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span> <span class="badge-expert">Expert</span>

Un **skill** est une capacité réutilisable stockée dans un dossier contenant `SKILL.md`. Dans Claude Code, il sert à fournir une procédure, une expertise domaine ou un workflow qui ne mérite pas d'être chargé en permanence dans `CLAUDE.md`.

Cela permet de conserver une seule source lorsque le contenu est réellement compatible.

---

### Projet

```text
mon-projet/
└─ .claude/
   └─ skills/
      └─ review-docs/
         ├─ SKILL.md
         ├─ references/
         └─ scripts/
```

Un skill projet est disponible dans les sessions de ce dépôt et peut être versionné avec Git.

### Utilisateur

```text
~/.claude/skills/<nom>/SKILL.md
```

Il devient disponible dans vos projets locaux.

Des skills peuvent aussi être fournis par des plugins, une politique d'organisation ou des répertoires additionnels.

---

## Structure minimale

```markdown
---
name: review-docs
description: Audite une page MkDocs pour vérifier structure, liens, sources et cohérence avec le reste du dépôt.
---

# Review documentation

1. Lire la page ciblée et les pages directement liées.
2. Identifier les faits susceptibles d'être obsolètes.
3. Vérifier les liens internes.
4. Proposer ou appliquer des corrections minimales.
5. Exécuter le build MkDocs si l'environnement le permet.
```

### Frontmatter Claude Code

Tous les champs sont optionnels côté Claude Code, mais **`description` est fortement recommandé** : Claude s'en sert pour déterminer quand charger le skill.

| Champ | Usage |
|---|---|
| `name` | nom de commande affiché ; sinon le nom du dossier est utilisé |
| `description` | ce que fait le skill et quand l'utiliser |
| `when_to_use` | précisions supplémentaires de déclenchement |
| `argument-hint` | aide d'autocomplétion |
| `disable-model-invocation` | `true` : seul l'utilisateur peut déclencher le skill |
| `user-invocable` | `false` : skill utilisable par Claude mais masqué comme commande utilisateur |
| `allowed-tools` | pré-approuve certains outils pendant le tour d'invocation |
| `disallowed-tools` | retire temporairement certains outils pendant le tour |
| `context` | peut exécuter le skill dans un contexte isolé, par exemple `fork` |
| `agent` | type de subagent à utiliser avec un contexte forké |

!!! warning "`allowed-tools` n'est pas une sandbox"
    Ce champ pré-approuve les outils listés pendant le tour où le skill est invoqué. Il ne supprime pas automatiquement tous les autres outils et ne remplace pas les règles de permissions globales. Relisez les skills versionnés dans un dépôt avant de leur accorder des commandes larges.

---

## Invocation manuelle ou automatique

Par défaut :

- vous pouvez lancer un skill avec `/<nom>` ;
- Claude peut aussi l'invoquer lorsqu'il juge sa `description` pertinente ;
- seule la description est gardée dans la liste des capacités ; le contenu complet du skill est chargé lorsqu'il est invoqué.

### Workflow à effet de bord : invocation manuelle

```markdown
---
name: publish-docs
description: Publie le site de documentation après validation complète.
disable-model-invocation: true
---

Exécuter uniquement à la demande explicite de l'utilisateur.
```

Utilisez `disable-model-invocation: true` pour les actions que Claude ne doit jamais décider seul de lancer : déploiement, publication, envoi de message, changement externe, etc.

---

## Arguments

```markdown
---
name: audit-page
description: Audite une page précise de la documentation.
disable-model-invocation: true
---

Audite `$ARGUMENTS` et vérifie :
1. les faits techniques ;
2. les liens ;
3. la cohérence du niveau pédagogique ;
4. les sources officielles.
```

Invocation :

```text
/audit-page docs/chapitre-4-contexte/index.md
```

Claude Code accepte aussi les arguments indexés (`$ARGUMENTS[0]`, `$0`, etc.).

---

## Commandes injectées

Un skill peut injecter le résultat d'une commande shell avec la syntaxe dédiée :

```markdown
## État du dépôt

!`git status --short`
```

Ces commandes passent par les contrôles de permissions. Une commande refusée peut faire échouer l'invocation du skill.

!!! danger "Ne traitez pas l'injection shell comme du texte inoffensif"
    Un skill versionné peut contenir des commandes exécutées sur votre machine. Auditez son contenu, son `allowed-tools` et ses scripts comme du code.

---

## Isoler un skill dans un subagent

Pour une exploration lourde :

```markdown
---
name: pr-summary
description: Analyse un gros diff et retourne une synthèse courte.
context: fork
agent: Explore
allowed-tools: Bash(gh *)
---

## Contexte
- Diff : !`gh pr diff`
- Fichiers : !`gh pr diff --name-only`

## Tâche
Retourne uniquement une synthèse structurée des risques et changements.
```

Le contexte principal reçoit le résultat utile plutôt que tout le bruit de l'exploration.

---

## Skill ou autre mécanisme ?

| Besoin | Mécanisme |
|---|---|
| règle que Claude doit connaître dans presque toutes les sessions | `CLAUDE.md` |
| règle limitée à certains chemins | `.claude/rules/` |
| expertise / procédure réutilisable | **skill** |
| recherche lourde avec contexte séparé | subagent ou skill `context: fork` |
| contrôle avant/après un outil | hook |
| accès à un système externe | MCP |

---

## Compatibilité avec `.claude/commands/`

Les fichiers `.claude/commands/*.md` restent pris en charge. Les commandes mono-fichier reposent désormais sur le même mécanisme général que les skills et acceptent presque le même frontmatter.

Pour un nouveau workflow :

- un prompt très court et mono-fichier peut rester dans `commands/` ;
- une capacité avec références, scripts ou ressources associées est généralement mieux structurée comme **skill**.

---

## Exemple pour ce dépôt

```text
.claude/skills/
└─ doc-review/
   ├─ SKILL.md
   └─ references/
      ├─ mkdocs.md
      └─ sourcing.md
```

Le skill peut expliquer comment :

- respecter le français et le ton pédagogique ;
- mettre à jour `mkdocs.yml` si nécessaire ;
- vérifier les informations évolutives contre la documentation officielle ;
- lancer `py -m mkdocs build` lorsqu'un environnement local est disponible.

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-4-contexte.md#page-chapitre-4-contexte-guide-skills).

## Prochaine étape

Poursuivez avec **[Hooks Claude](guide-hooks.md)**, la page suivante dans le menu.

## Sources

Sources officielles consultées le **28 septembre 2026** :

- [Claude Code — Skills](https://code.claude.com/docs/en/skills)
- [Claude Code — Best practices](https://code.claude.com/docs/en/best-practices)
- [GitHub Docs — Adding agent skills](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/customize-cloud-agent/add-skills)
