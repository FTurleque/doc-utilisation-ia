# Agents spécialisés — Claude Code et référence Copilot

<span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span> <span class="badge-expert">Expert</span>

Claude Code peut déléguer une tâche à un **subagent** qui possède son propre contexte, son prompt et ses outils. C'est particulièrement utile pour la recherche, la revue, l'exploration d'un gros dépôt ou une expertise que vous ne voulez pas laisser envahir la conversation principale.

Les custom agents GitHub Copilot restent documentés plus bas comme référence distincte.

---

## Où placer un subagent Claude ?

### Projet

```text
.claude/agents/
├─ doc-reviewer.md
├─ security-reviewer.md
└─ repo-explorer.md
```

Ces agents peuvent être versionnés avec le dépôt.

### Utilisateur

```text
~/.claude/agents/<nom>.md
```

Ils sont disponibles dans vos projets locaux.

---

## Structure minimale

Seuls `name` et `description` sont obligatoires dans le frontmatter d'un subagent Claude.

```markdown
---
name: doc-reviewer
description: Audite une page de documentation après modification. Vérifie cohérence, liens, sources et navigation.
tools: Read, Grep, Glob
model: inherit
---

Tu es un relecteur de documentation technique.

Pour chaque page :
1. repère les incohérences factuelles ;
2. vérifie les liens et renvois ;
3. contrôle la cohérence avec la navigation ;
4. retourne uniquement les problèmes actionnables, avec fichier et justification.
```

Claude utilise la `description` pour décider quand déléguer une tâche. Gardez-la courte et distinctive ; placez le détail dans le corps du fichier, chargé seulement lorsque l'agent s'exécute.

---

## Frontmatter utile

| Champ | Usage |
|---|---|
| `name` | identifiant unique — obligatoire |
| `description` | quand utiliser cet agent — obligatoire |
| `tools` | allowlist d'outils |
| `disallowedTools` | outils à retirer de l'ensemble hérité |
| `model` | alias, ID de modèle ou `inherit` |
| `permissionMode` | mode de permissions propre à l'agent |
| `mcpServers` | serveurs MCP accessibles |
| `skills` | skills préchargés |
| `hooks` | hooks propres au subagent |
| `maxTurns` | nombre maximal de tours |
| `memory` | mémoire persistante du subagent |
| `effort` | niveau d'effort pris en charge |
| `background` | comportement d'exécution en arrière-plan |
| `isolation` | isolation, notamment worktree lorsque prise en charge |

Les capacités disponibles évoluent rapidement : pour une configuration avancée, vérifiez la référence officielle avant de figer un champ dans un standard d'équipe.

---

## Restreindre les outils

Pour un agent de recherche en lecture seule :

```markdown
---
name: safe-researcher
description: Explore le code pour répondre à une question sans modifier le dépôt.
tools: Read, Grep, Glob
---

Retourne une synthèse courte avec les chemins de fichiers pertinents.
```

Pour hériter des outils disponibles mais interdire les écritures :

```markdown
---
name: no-writes
description: Analyse une modification sans toucher aux fichiers.
disallowedTools: Write, Edit
---
```

!!! important "Permissions de commandes spécifiques"
    `disallowedTools: Bash(git push *)` ne constitue pas une règle fine de commande : pour conserver Bash tout en bloquant certaines commandes, utilisez les règles `permissions.deny` appropriées dans les settings.

---

## Choisir le modèle

Évitez de figer un ID complet si ce n'est pas nécessaire.

```yaml
model: inherit
```

réutilise le modèle de la conversation principale.

Les alias documentés peuvent évoluer ; Claude Code prend actuellement en charge plusieurs familles via des alias et des IDs complets. Pour la plupart des agents projet génériques, `inherit` réduit la maintenance.

---

## Mémoire persistante du subagent

Un subagent peut conserver ses apprentissages :

```markdown
---
name: code-reviewer
description: Revoit les changements et mémorise les problèmes récurrents du projet.
memory: project
---

Avant une revue, consulte ta mémoire pour les patterns déjà observés.
Après la revue, ajoute uniquement les apprentissages durables et vérifiés.
```

Scopes principaux :

| Scope | Emplacement | Usage |
|---|---|---|
| `user` | `~/.claude/agent-memory/<agent>/` | apprentissages personnels multi-projets |
| `project` | `.claude/agent-memory/<agent>/` | connaissance partageable du projet |
| `local` | `.claude/agent-memory-local/<agent>/` | connaissance locale non versionnée |

!!! warning "Mémoire ≠ vérité"
    Une mémoire agentique peut devenir obsolète. N'y stockez que des faits durables et vérifiables, et prévoyez de la relire comme n'importe quelle documentation.

---

## Quand déléguer ?

Les subagents sont particulièrement utiles lorsque la tâche :

- demande de lire beaucoup de fichiers ;
- peut être isolée du fil principal ;
- nécessite une expertise spécialisée ;
- produit surtout une **synthèse** utilisée ensuite par l'agent principal ;
- sert de revue contradictoire après une implémentation.

Exemple :

```text
Utilise un subagent pour cartographier le système d'authentification.
Retourne uniquement :
- le flux principal ;
- les fichiers clés ;
- les dépendances ;
- les risques d'une migration OAuth.
```

Le bénéfice principal est la **protection du contexte** : les dizaines de lectures intermédiaires ne polluent pas la conversation d'implémentation.

---

## Agents coordinateurs

Un agent exécuté comme thread principal peut être autorisé à lancer seulement certains subagents :

```markdown
---
name: coordinator
description: Coordonne une modification après recherche et revue spécialisée.
tools: Agent(researcher, reviewer), Read, Bash
---

Délègue l'exploration à `researcher` et la revue finale à `reviewer`.
Ne délègue pas l'écriture du correctif si le thread principal peut la faire directement.
```

Utilisez cette orchestration seulement lorsqu'elle simplifie réellement la séparation des responsabilités. Multiplier les agents sans besoin clair ajoute du coût et de la complexité.

---

## Exemple adapté à ce dépôt

```markdown
---
name: official-doc-auditor
description: Audite une page IA contre les sources officielles actuelles, sans modifier le dépôt.
tools: Read, Grep, Glob, WebSearch, WebFetch
model: inherit
---

Pour la page demandée :
1. distingue les faits stables des faits évolutifs ;
2. vérifie les faits évolutifs contre les sources officielles ;
3. liste les écarts avec la source et la date ;
4. ne modifie aucun fichier ;
5. signale clairement les points non vérifiables.
```

---

## GitHub Copilot — custom agents conservés

Le dépôt contient déjà des agents Copilot dans :

```text
.github/agents/*.agent.md
```

Ils sont **conservés** comme référence et pour une éventuelle utilisation Copilot future.

Les custom agents Copilot disposent de leur propre schéma, de leurs outils et de leur support par surface. Plusieurs fonctionnalités sont encore en preview dans JetBrains : n'utilisez pas un exemple Claude `.claude/agents/*.md` comme s'il était interchangeable avec un `.github/agents/*.agent.md`.

### Stratégie de migration

| Besoin | Claude Code | Copilot conservé |
|---|---|---|
| agent spécialisé projet | `.claude/agents/<nom>.md` | `.github/agents/<nom>.agent.md` |
| description de délégation | `description` | champ équivalent selon schéma Copilot |
| outils | outils Claude (`Read`, `Grep`, etc.) | outils Copilot de la surface concernée |
| mémoire persistante agent | `memory` Claude | ne pas supposer un équivalent identique |
| orchestration | `Agent(...)`, subagents, skills | agents/subagents/handoffs selon surface |

!!! tip "Ne convertissez pas automatiquement les noms d'outils"
    `Read`, `Grep`, `Glob`, `Bash` côté Claude ne correspondent pas mécaniquement à `codebase`, `editFiles`, `runCommands` ou autres outils Copilot. Migrez le **rôle et l'intention**, puis adaptez les capacités au client cible.

---

## Bonnes pratiques

1. **Un rôle clair par agent** : évitez l'agent universel.
2. **Description courte et discriminante** : Claude s'en sert pour router les tâches.
3. **Outils minimaux** : ne donnez pas Write/Edit à un auditeur qui doit seulement lire.
4. **Contexte isolé pour la recherche** : gardez le thread principal propre.
5. **Versionner les agents projet** : relisez leurs instructions comme du code.
6. **Vérifier les résultats** : un subagent synthétise, il ne rend pas ses conclusions automatiquement vraies.

---

## Prochaine étape

Voir **[Orchestration multi-agents](orchestration-multi-agents.md)** puis **[Hooks](guide-hooks.md)** pour encadrer les actions des agents.

---

## Sources

Sources officielles consultées le **28 septembre 2026** :

- [Claude Code — Subagents](https://code.claude.com/docs/en/sub-agents)
- [Claude Code — Best practices](https://code.claude.com/docs/en/best-practices)
- [GitHub Docs — Custom agents configuration](https://docs.github.com/en/copilot/reference/custom-agents-configuration)
- [GitHub Docs — Copilot customization cheat sheet](https://docs.github.com/en/copilot/reference/customization-cheat-sheet)
