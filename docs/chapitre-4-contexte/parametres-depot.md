# Paramètres du dépôt — stratégie Claude-first

<span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span> <span class="badge-intermediate">Intermédiaire</span>

La configuration IA versionnée doit être lisible comme n'importe quelle autre configuration du projet : peu de fichiers globaux, des responsabilités claires et aucune règle de sécurité critique laissée à une simple phrase de prompt.

Ce dépôt adopte une stratégie **Claude-first** tout en conservant les fichiers GitHub Copilot existants.

---

## Arborescence recommandée

```text
mon-projet/
├─ CLAUDE.md
├─ AGENTS.md                       # optionnel, partageable entre outils
├─ .mcp.json                       # seulement si MCP projet nécessaire
├─ .claude/
│  ├─ settings.json               # réglages partagés Claude
│  ├─ rules/
│  │  └─ *.md
│  ├─ skills/
│  │  └─ <skill>/SKILL.md
│  ├─ agents/
│  │  └─ <agent>.md
│  └─ hooks/
│     └─ <scripts>
└─ .github/
   ├─ copilot-instructions.md      # référence Copilot conservée
   ├─ instructions/
   ├─ prompts/
   ├─ agents/
   ├─ skills/
   └─ hooks/
```

Tous ces dossiers ne sont pas obligatoires. Ajoutez-les seulement lorsqu'un besoin réel apparaît.

---

## Les couches Claude Code

### `CLAUDE.md`

Conventions et informations utiles dans presque toutes les sessions :

- commandes build/test/lint ;
- architecture du dépôt ;
- règles essentielles ;
- contraintes de contribution.

### `.claude/rules/`

Règles thématiques ou ciblées par chemins. Elles évitent d'allonger le contexte global.

### `.claude/skills/`

Procédures et expertises à charger à la demande.

### `.claude/agents/`

Subagents spécialisés avec contexte et outils propres.

### `.claude/settings.json`

Réglages partagés : permissions, hooks, environnement contrôlé, plugins et autres options prises en charge.

### `.mcp.json`

Serveurs MCP partagés au niveau projet. Gardez les secrets hors du fichier versionné.

---

## Ce qui doit rester local

Ne versionnez pas les préférences ou secrets personnels.

Exemples :

```text
CLAUDE.local.md
.claude/settings.local.json
```

Ajoutez explicitement les fichiers locaux créés manuellement au `.gitignore` si nécessaire.

Les credentials Claude Code sont gérés hors des fichiers projet ; ils ne doivent jamais être copiés dans `CLAUDE.md`, `settings.json` ou `.mcp.json`.

---

## `AGENTS.md` dans ce dépôt

`AGENTS.md` peut servir de socle compatible avec plusieurs agents de développement. Claude Code sait le lire nativement dans les versions récentes, mais lorsqu'un `CLAUDE.md` projet existe, celui-ci est lu par défaut à sa place.

La stratégie de ce dépôt est donc explicite :

```markdown
@AGENTS.md

# Claude Code — instructions du projet
...
```

Cela évite une ambiguïté de chargement et permet de séparer :

- les instructions génériques aux agents ;
- les consignes propres à Claude Code.

---

## Sécurité : fichier d'instructions ou réglage technique ?

| Besoin | Mécanisme |
|---|---|
| « toujours écrire les docs en français » | `CLAUDE.md` / rule |
| « ne jamais lire `.env` » | permission `deny` |
| « empêcher certains `git push` » | permissions ou hook `PreToolUse` |
| « exécuter un lint après une édition » | hook `PostToolUse` |
| « accéder à Jira/GitHub/BDD » | MCP avec permissions minimales |

Une règle textuelle est utile pour guider ; un réglage technique est nécessaire pour faire respecter une interdiction.

---

## Ne pas dupliquer tout Copilot

La migration ne consiste pas à créer automatiquement deux copies de chaque fichier.

Utilisez cette règle :

- si le contenu est **spécifique Claude** → `.claude/` ;
- s'il est **spécifique Copilot** → `.github/` ;
- s'il peut être **réellement partagé** → choisissez un format compatible et documentez cette décision ;
- si personne n'utilise plus une copie mais qu'elle sert de référence historique, conservez-la clairement étiquetée plutôt que de la maintenir artificiellement en parallèle.

### Exemple : skills

Certaines surfaces Copilot savent charger :

```text
.claude/skills/<skill>/SKILL.md
```

Un skill générique peut donc parfois rester unique. Testez cependant les champs utilisés sur chaque client concerné.

---

## Validation d'une configuration projet

Après un changement Claude :

```text
/status
```

permet de voir les sources de settings chargées.

```text
/context
```

permet d'inspecter le contexte et les fichiers d'instructions/mémoire.

Pour diagnostiquer une configuration :

```bash
claude doctor
```

Et pour ce dépôt documentaire :

```powershell
py -m mkdocs build
```

reste la validation fonctionnelle à exécuter lorsque l'environnement local est disponible.

---

## Exemple minimal pour `doc-utilisation-ia`

Aujourd'hui, le socle utile est :

```text
CLAUDE.md
AGENTS.md
.github/                         # Copilot conservé
```

À terme, les workflows de maintenance peuvent être migrés progressivement vers :

```text
.claude/
├─ rules/
│  └─ documentation.md
├─ skills/
│  ├─ doc-writer/SKILL.md
│  └─ official-doc-audit/SKILL.md
└─ agents/
   └─ official-doc-auditor.md
```

L'objectif est de **réduire les instructions permanentes** et de charger les capacités spécialisées uniquement lorsqu'elles sont nécessaires.

---

## Copilot — configuration conservée

La configuration historique reste sous `.github/` :

```text
.github/
├─ copilot-instructions.md
├─ instructions/
├─ prompts/
├─ agents/
├─ skills/
└─ hooks/
```

Elle reste utile pour :

- documenter Copilot ;
- comparer les mécanismes ;
- conserver une possibilité de retour ;
- maintenir les workflows encore utilisés sur certaines surfaces.

---

## Prochaine étape

- [Instructions projet et rules](guide-instructions.md)
- [Skills](guide-skills.md)
- [Agents spécialisés](guide-agents.md)
- [Hooks](guide-hooks.md)
- [Architecture Claude Code complète](../chapitre-3b-claude-code-migration-copilot/architecture-claude.md)

---

## Sources

Sources officielles consultées le **28 septembre 2026** :

- [Claude Code — `.claude` directory](https://code.claude.com/docs/en/claude-directory)
- [Claude Code — Memory / AGENTS.md](https://code.claude.com/docs/en/memory)
- [Claude Code — Settings](https://code.claude.com/docs/en/settings)
- [Claude Code — Skills](https://code.claude.com/docs/en/skills)
- [Claude Code — Subagents](https://code.claude.com/docs/en/sub-agents)
- [Claude Code — Hooks](https://code.claude.com/docs/en/hooks)
- [GitHub Docs — Copilot customization cheat sheet](https://docs.github.com/en/copilot/reference/customization-cheat-sheet)
