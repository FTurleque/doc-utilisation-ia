# OpenSkills — skills portables pour agents IA

<span class="badge-intermediate">Intermédiaire</span>

**OpenSkills** est un CLI open source indépendant qui installe et synchronise des skills au format `SKILL.md`. Son intérêt principal est la **portabilité** : il peut exposer à d'autres agents un système de skills compatible avec le modèle utilisé par Claude Code.

Dans cette documentation, Claude Code reste le parcours principal. OpenSkills devient utile lorsque vous devez partager les mêmes procédures avec plusieurs agents ou maintenir un catalogue externe de skills.

---

## Claude Code n'a pas besoin d'OpenSkills pour lire ses propres skills

Claude Code sait nativement utiliser des skills placés dans les emplacements qu'il supporte, notamment `.claude/skills/`. OpenSkills n'est donc pas une dépendance obligatoire pour Claude.

Utilisez OpenSkills surtout pour :

- installer des skills depuis un autre dépôt ;
- synchroniser un catalogue dans `AGENTS.md` ;
- exposer ces skills à des agents qui ne possèdent pas le mécanisme natif de Claude ;
- gérer un setup multi-agents via `.agent/skills/`.

---

## Démarrage rapide

```bash
npx openskills install anthropics/skills
npx openskills sync
```

Par défaut, OpenSkills installe les skills au niveau projet dans `.claude/skills/`. Pour une installation multi-agents :

```bash
npx openskills install anthropics/skills --universal
```

Le mode `--universal` utilise `.agent/skills/` afin d'éviter de dépendre d'un seul agent.

---

## Commandes principales

```bash
npx openskills install <source>
npx openskills sync
npx openskills list
npx openskills read <name>
npx openskills update
npx openskills manage
```

Options importantes :

- `--global` : installation utilisateur ;
- `--universal` : cible `.agent/skills/` ;
- `-y` / `--yes` : évite les confirmations interactives ;
- `-o` / `--output` : choisit le fichier manifeste généré.

Les prérequis documentés par le projet sont Node.js 20.6+ et Git.

---

## Progressive disclosure

Une skill contient un fichier principal `SKILL.md` et peut embarquer :

```text
ma-skill/
├── SKILL.md
├── references/
├── scripts/
└── assets/
```

Le but est de garder l'instruction principale courte et de charger les références ou scripts uniquement lorsqu'ils sont nécessaires.

Cette organisation aide à maîtriser le contexte, mais elle ne « réduit pas les crédits » automatiquement. Le bénéfice dépend de ce que l'agent charge réellement.

---

Le dossier universel `.agent/skills/` est un choix d’OpenSkills, pas une garantie de découverte native par tous les clients. Vérifiez le mécanisme de chaque agent. Claude Code charge `CLAUDE.md` ; un `AGENTS.md` généré doit être explicitement importé/référencé si vous voulez lui rendre ce manifeste disponible. Ne confondez pas compatibilité du contenu `SKILL.md` et chargement automatique du manifeste. [OpenSkills — fonctionnement](https://github.com/numman-ali/openskills), revérifié le 3 octobre 2026.

## OpenSkills et `AGENTS.md`

`npx openskills sync` peut générer dans `AGENTS.md` une liste structurée des skills disponibles. Les agents capables de lire ce manifeste peuvent ensuite charger une skill avec :

```bash
npx openskills read <skill-name>
```

Claude Code, lui, possède son propre mécanisme natif de découverte/invocation de skills. Ne forcez pas Claude à passer par OpenSkills si une skill native `.claude/skills/` suffit.

---

## Multi-agents

OpenSkills est particulièrement pertinent lorsque le même dépôt doit fonctionner avec :

- Claude Code ;
- Cursor / Windsurf ;
- Codex ;
- Aider ou un autre agent capable de lire `AGENTS.md`.

Dans ce cas, le mode universel donne un emplacement neutre :

```text
.agent/
└── skills/
    └── java-review/
        ├── SKILL.md
        └── references/
```

Gardez cependant les instructions propres à chaque agent dans leur mécanisme natif lorsque celles-ci ne sont pas réellement portables.

---

## Sécurité : une skill est du code/instructions à auditer

Installer une skill tierce revient à introduire dans votre environnement des instructions, et parfois des scripts, que l'agent pourra lire ou exécuter.

Avant installation :

1. vérifiez le dépôt source et son propriétaire ;
2. lisez `SKILL.md` ;
3. inspectez `scripts/` et les dépendances éventuelles ;
4. évitez d'installer automatiquement une branche non épinglée dans un environnement sensible ;
5. utilisez un dépôt interne ou une révision contrôlée pour les skills d'équipe ;
6. réauditez les mises à jour avant déploiement large.

Le projet OpenSkills recommande lui-même de n'installer que des skills provenant de sources de confiance et de relire leur contenu.

---

## OpenSkills vs MCP

| Besoin | Skills / OpenSkills | MCP |
|---|---|---|
| Instructions statiques | Oui | Non nécessaire |
| Scripts et références versionnés | Oui | Possible mais souvent excessif |
| Appeler une API ou un service vivant | Non | Oui |
| Accéder à Sonar, une DB ou un service externe | Non | Oui |
| Portabilité multi-agents de procédures | Oui | Dépend du client MCP |

Les deux mécanismes sont complémentaires : **skill = savoir-faire versionné**, **MCP = capacité/outillage dynamique**.

---

## Sources

- [OpenSkills — dépôt officiel](https://github.com/numman-ali/openskills) — consulté le 2026-09-28
- [Anthropic Skills](https://github.com/anthropics/skills) — consulté le 2026-09-28
- [Claude Code — Skills](https://code.claude.com/docs/en/skills) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-13-outils-economies.md#page-chapitre-13-outils-economies-openskills).

## Prochaine étape

Poursuivez avec **[Présentation et choix](mcps/index.md)**, la page suivante dans le menu.
