# Copilot — archives : Contexte & Personnalisation

Extraits déplacés du parcours principal le **3 octobre 2026**. Les affirmations, exemples et dates de vérification sont ceux des pages d’origine ; ils ne constituent pas une nouvelle validation des fonctionnalités Copilot. Les passages comparatifs peuvent aussi citer Claude afin de conserver leur sens.


## Accueil { #page-chapitre-4-contexte-index }

Origine : [chapitre-4-contexte/index.md](../../chapitre-4-contexte/index.md).

<!-- Extrait original : chapitre-4-contexte/index.md:5 ; paragraphe -->

Dans ce dépôt, ce chapitre est désormais organisé autour de **Claude Code**. Les mécanismes GitHub Copilot restent documentés dans les pages historiques et dans des encadrés de compatibilité.

<!-- Extrait original : chapitre-4-contexte/index.md:40 ; tableau comparatif -->

| Besoin | Claude Code — recommandé | Copilot — conservé comme référence |
|---|---|---|
| Conventions globales projet | `CLAUDE.md` ou `AGENTS.md` | `.github/copilot-instructions.md` |
| Règles ciblées par chemins | `.claude/rules/*.md` avec `paths` | `.github/instructions/*.instructions.md` avec `applyTo` |
| Procédure / expertise réutilisable | `.claude/skills/<nom>/SKILL.md` | skills Copilot, y compris `.claude/skills` sur certaines surfaces |
| Agent spécialisé | `.claude/agents/*.md` | `.github/agents/*.agent.md` |
| Automatisation d'événements | hooks Claude configurés dans settings | hooks Copilot sur les surfaces compatibles |
| Outils et données externes | MCP | MCP |
| Recherche rapide de snippets dans un gros dépôt | outil tiers comme Semble si les outils natifs deviennent trop verbeux | outil tiers compatible selon surface |
| Navigation symbolique / références / refactoring | outil tiers comme Serena si le backend langage est pertinent | outil tiers compatible selon surface |
| Cartographie relationnelle du dépôt | outil tiers comme Graphify si nécessaire | outil tiers compatible selon surface |
| Réglages d'équipe | `.claude/settings.json` | réglages/politiques Copilot + fichiers `.github/` |
| Préférences locales | `.claude/settings.local.json`, `CLAUDE.local.md` | réglages IDE locaux |

<!-- Extrait original : chapitre-4-contexte/index.md:88 ; exemple ou liste -->

- :material-file-code: **[Instructions projet et règles](../../chapitre-4-contexte/guide-instructions.md)**

    `CLAUDE.md`, `AGENTS.md`, `.claude/rules/`, imports et équivalents Copilot conservés.

<!-- Extrait original : chapitre-4-contexte/index.md:92 ; exemple ou liste -->

- :material-robot: **[Agents](../../chapitre-4-contexte/guide-agents.md)**

    Agents spécialisés et différences entre Claude subagents et custom agents Copilot.

<!-- Extrait original : chapitre-4-contexte/index.md:100 ; exemple ou liste -->

- :material-lightbulb: **[Skills (SKILL.md)](../../chapitre-4-contexte/guide-skills.md)**

    Capacités réutilisables Claude Code et interopérabilité possible avec GitHub Copilot.

<!-- Extrait original : chapitre-4-contexte/index.md:104 ; exemple ou liste -->

- :material-hook: **[Hooks](../../chapitre-4-contexte/guide-hooks.md)**

    Automatisations et garde-fous ; distinguer hooks Claude, hooks Copilot et hooks Git classiques.

<!-- Extrait original : chapitre-4-contexte/index.md:147 ; section dédiée -->

#### Copilot reste documenté

Les fichiers `.github/copilot-instructions.md`, `.github/instructions/`, `.github/prompts/`, `.github/agents/`, `.github/skills/` et `.github/hooks/` ne sont pas supprimés de ce dépôt.

Cette conservation sert à :

- maintenir une référence pour les utilisateurs Copilot ;
- comparer les deux écosystèmes ;
- conserver les migrations réversibles ;
- profiter des zones d'interopérabilité, notamment certains `SKILL.md`.

---

<!-- Extrait original : chapitre-4-contexte/index.md:160 ; section dédiée -->

#### Références Copilot en annexe

Ces pages se trouvent dans **Annexe**, à la fin du menu de gauche.

<div class="grid cards" markdown>

- :material-file-document: **[Prompt files Copilot — référence](../../chapitre-4-contexte/prompt-files.md)**

    Ancien mécanisme Copilot conservé ; pour un nouveau workflow Claude, privilégier un skill ou une commande compatible.

- :material-tune-variant: **[applyTo Copilot — référence](../../chapitre-4-contexte/applyto-avance.md)**

    Ciblage des instructions Copilot. L'équivalent Claude est `paths` dans `.claude/rules/`.


---

<!-- Extrait original : chapitre-4-contexte/index.md:194 ; exemple ou liste -->

- [GitHub Docs — Copilot customization cheat sheet](https://docs.github.com/en/copilot/reference/customization-cheat-sheet)


## Concepts Clés { #page-chapitre-4-contexte-concepts }

Origine : [chapitre-4-contexte/concepts.md](../../chapitre-4-contexte/concepts.md).

<!-- Extrait original : chapitre-4-contexte/concepts.md:7 ; paragraphe -->

Dans ce dépôt, les exemples sont désormais centrés sur **Claude Code**, tout en gardant les principes suffisamment génériques pour être utiles avec Copilot et d'autres agents.

<!-- Extrait original : chapitre-4-contexte/concepts.md:181 ; section dédiée -->

#### Copilot — principes toujours valables

GitHub Copilot possède ses propres mécanismes de contexte et de personnalisation, conservés dans ce dépôt. Les principes restent les mêmes :

- contexte ciblé plutôt qu'exhaustif ;
- instructions courtes ;
- outils externes uniquement lorsqu'ils apportent une vraie information ;
- critères de réussite explicites ;
- vérification du résultat.

Pour les fichiers Copilot spécifiques, voir [Instructions projet et règles](../../chapitre-4-contexte/guide-instructions.md) et les pages de référence `.github/`.

---


## Instructions Claude & Rules { #page-chapitre-4-contexte-guide-instructions }

Origine : [chapitre-4-contexte/guide-instructions.md](../../chapitre-4-contexte/guide-instructions.md).

<!-- Extrait original : chapitre-4-contexte/guide-instructions.md:7 ; paragraphe -->

Dans ce dépôt, le mécanisme principal est désormais **Claude Code**. Les instructions GitHub Copilot restent documentées dans une section dédiée afin de préserver la compatibilité.

<!-- Extrait original : chapitre-4-contexte/guide-instructions.md:158 ; encadré -->

!!! important "Claude et Copilot n'utilisent pas le même champ"
    - Claude Code : `paths` dans `.claude/rules/*.md`.
    - GitHub Copilot : `applyTo` dans `.github/instructions/*.instructions.md`.

<!-- Extrait original : chapitre-4-contexte/guide-instructions.md:203 ; section dédiée -->

#### 8. GitHub Copilot — référence conservée

##### Instructions globales Copilot

```text
.github/copilot-instructions.md
```

Ce fichier reste présent dans ce dépôt pour les utilisateurs Copilot.

##### Instructions ciblées Copilot

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

<!-- Extrait original : chapitre-4-contexte/guide-instructions.md:238 ; section dédiée -->

#### 9. Migration progressive Copilot → Claude

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

<!-- Extrait original : chapitre-4-contexte/guide-instructions.md:288 ; exemple ou liste -->

- [GitHub Docs — Copilot customization cheat sheet](https://docs.github.com/en/copilot/reference/customization-cheat-sheet)


## Agents Claude { #page-chapitre-4-contexte-guide-agents }

Origine : [chapitre-4-contexte/guide-agents.md](../../chapitre-4-contexte/guide-agents.md).

<!-- Extrait original : chapitre-4-contexte/guide-agents.md:7 ; paragraphe -->

Les custom agents GitHub Copilot restent documentés plus bas comme référence distincte.

<!-- Extrait original : chapitre-4-contexte/guide-agents.md:217 ; section dédiée -->

#### GitHub Copilot — custom agents conservés

Le dépôt contient déjà des agents Copilot dans :

```text
.github/agents/*.agent.md
```

Ils sont **conservés** comme référence et pour une éventuelle utilisation Copilot future.

Les custom agents Copilot disposent de leur propre schéma, de leurs outils et de leur support par surface. Plusieurs fonctionnalités sont encore en preview dans JetBrains : n'utilisez pas un exemple Claude `.claude/agents/*.md` comme s'il était interchangeable avec un `.github/agents/*.agent.md`.

##### Stratégie de migration

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

<!-- Extrait original : chapitre-4-contexte/guide-agents.md:266 ; exemple ou liste -->

- [GitHub Docs — Copilot customization cheat sheet](https://docs.github.com/en/copilot/reference/customization-cheat-sheet)


## Orchestration multi-agents { #page-chapitre-4-contexte-orchestration-multi-agents }

Origine : [chapitre-4-contexte/orchestration-multi-agents.md](../../chapitre-4-contexte/orchestration-multi-agents.md).

<!-- Extrait original : chapitre-4-contexte/orchestration-multi-agents.md:9 ; paragraphe -->

Dans ce dépôt, **Claude Code est la référence principale** pour ces workflows. GitHub Copilot reste documenté comme alternative compatible.

<!-- Extrait original : chapitre-4-contexte/orchestration-multi-agents.md:133 ; section dédiée -->

#### GitHub Copilot — référence conservée

Copilot propose lui aussi des agents personnalisés dans `.github/agents/*.agent.md`, avec outils, modèle et mécanismes d'orchestration selon l'environnement.

```text
.github/agents/
├── security-reviewer.agent.md
└── test-reviewer.agent.md
```

Selon les versions et surfaces Copilot, on trouve notamment :

- custom agents ;
- sous-agents / délégation ;
- handoffs ;
- Copilot coding agent côté GitHub ;
- MCP et skills.

!!! warning "Ne supposez pas une parité parfaite entre IDE"
    GitHub publie une matrice de fonctionnalités par version. Les fonctions avancées peuvent être en preview et leur disponibilité varie entre VS Code, Visual Studio, JetBrains et GitHub.com.

---

<!-- Extrait original : chapitre-4-contexte/orchestration-multi-agents.md:158 ; tableau comparatif -->

| Besoin | Claude Code | GitHub Copilot |
|---|---|---|
| Agent projet versionné | `.claude/agents/*.md` | `.github/agents/*.agent.md` |
| Recherche isolée | Subagents intégrés/personnalisés | Agents selon surface |
| Permissions par agent | Oui | Oui selon agent/surface |
| Skills | `.claude/skills/` | `.github/skills/`, `.claude/skills/` ou `.agents/skills/` selon surface |
| Exécution réellement multi-session | Background agents / agent teams | Coding agent / workflows plateforme |
| Outil principal du dépôt | **Oui** | Référence conservée |

<!-- Extrait original : chapitre-4-contexte/orchestration-multi-agents.md:183 ; exemple ou liste -->

- [GitHub Docs — Copilot feature matrix](https://docs.github.com/en/copilot/reference/copilot-feature-matrix) — consulté le 2026-09-28


## Skills Claude (SKILL.md) { #page-chapitre-4-contexte-guide-skills }

Origine : [chapitre-4-contexte/guide-skills.md](../../chapitre-4-contexte/guide-skills.md).

<!-- Extrait original : chapitre-4-contexte/guide-skills.md:7 ; paragraphe -->

Les skills sont aussi une zone d'interopérabilité intéressante : certaines surfaces GitHub Copilot savent lire des skills placés sous `.claude/skills/`. Cela permet de conserver une seule source lorsque le contenu est réellement compatible.

<!-- Extrait original : chapitre-4-contexte/guide-skills.md:194 ; section dédiée -->

#### GitHub Copilot — référence et interopérabilité

GitHub Copilot documente aujourd'hui les skills dans plusieurs emplacements projet, dont :

```text
.github/skills/<skill>/SKILL.md
.claude/skills/<skill>/SKILL.md
.agents/skills/<skill>/SKILL.md
```

Cela ne signifie pas que tous les champs Claude Code ont exactement le même comportement dans Copilot. Pour un skill partagé :

1. gardez le frontmatter au sous-ensemble réellement compatible ;
2. évitez les commandes ou outils spécifiques à un seul agent si le skill doit rester portable ;
3. testez sur les surfaces Copilot réellement utilisées ;
4. créez une variante spécifique seulement si les comportements divergent réellement.

!!! info "Fin de `copilot-skill://` comme modèle principal de ce guide"
    L'ancien contenu de cette page présentait les skills essentiellement comme des URI `copilot-skill://`. Le guide est désormais centré sur le format `SKILL.md` et les emplacements documentés actuellement par Claude Code et GitHub Copilot.

---

<!-- Extrait original : chapitre-4-contexte/guide-skills.md:231 ; exemple ou liste -->

- distinguer Claude-first et référence Copilot ;

<!-- Extrait original : chapitre-4-contexte/guide-skills.md:248 ; exemple ou liste -->

- [GitHub Docs — Copilot customization cheat sheet](https://docs.github.com/en/copilot/reference/customization-cheat-sheet)


## Hooks Claude { #page-chapitre-4-contexte-guide-hooks }

Origine : [chapitre-4-contexte/guide-hooks.md](../../chapitre-4-contexte/guide-hooks.md).

<!-- Extrait original : chapitre-4-contexte/guide-hooks.md:251 ; section dédiée -->

#### GitHub Copilot — hooks conservés

Le dépôt conserve :

```text
.github/hooks/
```

pour les configurations Copilot existantes.

Les hooks Copilot et Claude ont des formats, événements et surfaces différents. GitHub documente actuellement les hooks Copilot notamment pour Copilot CLI et le cloud agent, avec d'autres surfaces signalées en preview ou non supportées selon la matrice produit.

Ne copiez donc pas un JSON `.github/hooks/*.json` dans `.claude/settings.json` en supposant une compatibilité directe.

---

<!-- Extrait original : chapitre-4-contexte/guide-hooks.md:267 ; section dédiée -->

#### Migration Copilot → Claude

Pour chaque hook existant :

1. identifiez l'**intention** : blocage, validation, notification, formatage ;
2. vérifiez si une permission Claude suffit ;
3. sinon choisissez l'événement Claude équivalent ;
4. adaptez le format de l'entrée JSON et la décision de sortie ;
5. testez un cas autorisé **et** un cas bloqué ;
6. conservez le hook Copilot d'origine s'il sert encore aux utilisateurs Copilot.

---

<!-- Extrait original : chapitre-4-contexte/guide-hooks.md:290 ; exemple ou liste -->

- [GitHub Docs — About hooks for GitHub Copilot](https://docs.github.com/en/copilot/concepts/agents/hooks)

<!-- Extrait original : chapitre-4-contexte/guide-hooks.md:291 ; exemple ou liste -->

- [GitHub Docs — Copilot customization cheat sheet](https://docs.github.com/en/copilot/reference/customization-cheat-sheet)


## Paramètres du Dépôt { #page-chapitre-4-contexte-parametres-depot }

Origine : [chapitre-4-contexte/parametres-depot.md](../../chapitre-4-contexte/parametres-depot.md).

<!-- Extrait original : chapitre-4-contexte/parametres-depot.md:7 ; paragraphe -->

Ce dépôt adopte une stratégie **Claude-first** tout en conservant les fichiers GitHub Copilot existants.

<!-- Extrait original : chapitre-4-contexte/parametres-depot.md:13 ; exemple ou liste -->

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

<!-- Extrait original : chapitre-4-contexte/parametres-depot.md:125 ; section dédiée -->

#### Ne pas dupliquer tout Copilot

La migration ne consiste pas à créer automatiquement deux copies de chaque fichier.

Utilisez cette règle :

- si le contenu est **spécifique Claude** → `.claude/` ;
- s'il est **spécifique Copilot** → `.github/` ;
- s'il peut être **réellement partagé** → choisissez un format compatible et documentez cette décision ;
- si personne n'utilise plus une copie mais qu'elle sert de référence historique, conservez-la clairement étiquetée plutôt que de la maintenir artificiellement en parallèle.

##### Exemple : skills

Certaines surfaces Copilot savent charger :

```text
.claude/skills/<skill>/SKILL.md
```

Un skill générique peut donc parfois rester unique. Testez cependant les champs utilisés sur chaque client concerné.

---

<!-- Extrait original : chapitre-4-contexte/parametres-depot.md:184 ; exemple ou liste -->

```text
CLAUDE.md
AGENTS.md
.github/                         # Copilot conservé
```

<!-- Extrait original : chapitre-4-contexte/parametres-depot.md:207 ; section dédiée -->

#### Copilot — configuration conservée

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

<!-- Extrait original : chapitre-4-contexte/parametres-depot.md:244 ; exemple ou liste -->

- [GitHub Docs — Copilot customization cheat sheet](https://docs.github.com/en/copilot/reference/customization-cheat-sheet)


## VS Code — Claude { #page-chapitre-4-contexte-vscode-contexte }

Origine : [chapitre-4-contexte/vscode-contexte.md](../../chapitre-4-contexte/vscode-contexte.md).

<!-- Extrait original : chapitre-4-contexte/vscode-contexte.md:149 ; section dédiée -->

#### GitHub Copilot — référence conservée

Si Copilot reste installé dans VS Code, conservez ses fichiers propres :

```text
.github/
├── copilot-instructions.md
├── instructions/
├── prompts/
├── agents/
└── skills/
```

VS Code sait aujourd'hui gérer plusieurs formats de personnalisation selon le harness sélectionné : Copilot utilise notamment `.github/copilot-instructions.md` et `*.instructions.md`, tandis que Claude utilise `CLAUDE.md` et `.claude/rules/`.

!!! warning "Évitez les règles contradictoires"
    Si Claude et Copilot cohabitent, gardez les conventions métier communes alignées entre les deux arborescences.

---


## IntelliJ IDEA — Claude { #page-chapitre-4-contexte-intellij-contexte }

Origine : [chapitre-4-contexte/intellij-contexte.md](../../chapitre-4-contexte/intellij-contexte.md).

<!-- Extrait original : chapitre-4-contexte/intellij-contexte.md:181 ; section dédiée -->

#### GitHub Copilot — référence conservée

Les équipes utilisant encore Copilot dans IntelliJ peuvent conserver :

- `.github/copilot-instructions.md` ;
- `.github/instructions/` ;
- `.github/prompts/` ;
- `.github/agents/` ;
- les agent skills supportés par leur version du plugin.

La matrice officielle GitHub doit être consultée pour distinguer les fonctions stables et celles en preview.

---

<!-- Extrait original : chapitre-4-contexte/intellij-contexte.md:199 ; exemple ou liste -->

- [GitHub Docs — Copilot feature matrix](https://docs.github.com/en/copilot/reference/copilot-feature-matrix) — consulté le 2026-09-28


## Comparaison des IDE { #page-chapitre-4-contexte-comparaison-contexte }

Origine : [chapitre-4-contexte/comparaison-contexte.md](../../chapitre-4-contexte/comparaison-contexte.md).

<!-- Extrait original : chapitre-4-contexte/comparaison-contexte.md:95 ; section dédiée -->

#### Et GitHub Copilot ?

Les pages Copilot sont conservées dans le dépôt. Si les deux assistants sont installés :

| Claude Code | GitHub Copilot |
|---|---|
| `CLAUDE.md` | `.github/copilot-instructions.md` |
| `.claude/rules/*.md` + `paths` | `.github/instructions/*.instructions.md` + `applyTo` |
| `.claude/skills/` | Agent skills dans les emplacements supportés |
| `.claude/agents/` | `.github/agents/` |

VS Code prend explicitement en charge plusieurs formats de customisation selon le harness sélectionné. Pour JetBrains, vérifiez la matrice Copilot actuelle avant d'affirmer qu'une fonctionnalité avancée est stable : plusieurs fonctions restent marquées preview selon la version.

---

<!-- Extrait original : chapitre-4-contexte/comparaison-contexte.md:129 ; exemple ou liste -->

- [GitHub Docs — Copilot feature matrix](https://docs.github.com/en/copilot/reference/copilot-feature-matrix) — consulté le 2026-09-28

---

## Prochaine étape

Poursuivez avec **[Prompt Engineering](chapitre-5-prompt-engineering.md)**, la page suivante dans le menu.
