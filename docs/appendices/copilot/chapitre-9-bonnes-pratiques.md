# Copilot — archives : Bonnes Pratiques

Extraits déplacés du parcours principal le **3 octobre 2026**. Les affirmations, exemples et dates de vérification sont ceux des pages d’origine ; ils ne constituent pas une nouvelle validation des fonctionnalités Copilot. Les passages comparatifs peuvent aussi citer Claude afin de conserver leur sens.


## Accueil { #page-chapitre-9-bonnes-pratiques-index }

Origine : [chapitre-9-bonnes-pratiques/index.md](../../chapitre-9-bonnes-pratiques/index.md).

<!-- Extrait original : chapitre-9-bonnes-pratiques/index.md:5 ; paragraphe -->

GitHub Copilot reste documenté comme référence : les mécanismes spécifiques Copilot ne sont pas supprimés, mais le parcours principal devient Claude Code.

<!-- Extrait original : chapitre-9-bonnes-pratiques/index.md:133 ; section dédiée -->

#### Copilot

Les pages historiques Copilot restent utiles pour :

- complétions inline ;
- mécanismes `.github/` ;
- comparaison des workflows ;
- environnements qui utilisent encore Copilot ;
- éventuel retour si les prix ou capacités évoluent.

Lorsqu'une fonctionnalité est strictement Copilot, elle doit être marquée comme telle au lieu d'être présentée comme générique.

---


## Utilisation Effective { #page-chapitre-9-bonnes-pratiques-utilisation-effective }

Origine : [chapitre-9-bonnes-pratiques/utilisation-effective.md](../../chapitre-9-bonnes-pratiques/utilisation-effective.md).

<!-- Extrait original : chapitre-9-bonnes-pratiques/utilisation-effective.md:218 ; section dédiée -->

#### 12. Copilot — référence conservée

Les mécanismes suivants restent documentés dans les chapitres Copilot :

- complétion inline ;
- slash commands Copilot ;
- variables de contexte propres à VS Code/Copilot ;
- `.github/copilot-instructions.md` ;
- `.prompt.md` et `.agent.md`.

Ne transposez pas automatiquement ces syntaxes dans Claude Code : utilisez les équivalents `CLAUDE.md`, rules, skills, subagents, hooks et MCP.

---


## Organisation du Code { #page-chapitre-9-bonnes-pratiques-organisation-code }

Origine : [chapitre-9-bonnes-pratiques/organisation-code.md](../../chapitre-9-bonnes-pratiques/organisation-code.md).

<!-- Extrait original : chapitre-9-bonnes-pratiques/organisation-code.md:226 ; section dédiée -->

#### 12. Copilot — compatibilité conservée

Si le dépôt utilise encore Copilot :

- `.github/copilot-instructions.md` reste versionné ;
- `.github/instructions/`, `.github/agents/`, `.github/prompts/` et `.github/skills/` restent disponibles ;
- ne remplacez pas ces fichiers par les équivalents Claude si une équipe en dépend.

Le dépôt peut porter les deux configurations tant que leur rôle est explicite et qu'elles ne se contredisent pas.

---


## OpenSpec { #page-chapitre-9-bonnes-pratiques-openspec }

Origine : [chapitre-9-bonnes-pratiques/openspec.md](../../chapitre-13-outils-economies/openspec.md).

<!-- Extrait original : chapitre-9-bonnes-pratiques/openspec.md:72 ; paragraphe -->

Le nom exact de l'invocation peut varier selon l'agent. OpenSpec documente par exemple des variantes pour Cursor, Copilot, Codex et d'autres outils.


## Productivité { #page-chapitre-9-bonnes-pratiques-productivite }

Origine : [chapitre-9-bonnes-pratiques/productivite.md](../../chapitre-9-bonnes-pratiques/productivite.md).

<!-- Extrait original : chapitre-9-bonnes-pratiques/productivite.md:193 ; section dédiée -->

#### Référence Copilot

Les raccourcis IDE, suggestions inline et modes spécifiques Copilot restent documentés dans les chapitres **GitHub Copilot (référence)**. Ils ne sont pas repris ici car ils dépendent fortement de l'IDE et évoluent séparément de Claude Code.

---


## Sécurité & Qualité { #page-chapitre-9-bonnes-pratiques-securite-qualite }

Origine : [chapitre-9-bonnes-pratiques/securite-qualite.md](../../chapitre-9-bonnes-pratiques/securite-qualite.md).

<!-- Extrait original : chapitre-9-bonnes-pratiques/securite-qualite.md:201 ; section dédiée -->

#### 12. Référence Copilot

Les mécanismes de filtrage du code public, politiques Business/Enterprise et réglages spécifiques GitHub Copilot restent des sujets valides, mais ils appartiennent aux pages Copilot dédiées et doivent être vérifiés dans la documentation GitHub au moment de leur utilisation.

---


## Performance & Ressources { #page-chapitre-9-bonnes-pratiques-performance }

Origine : [chapitre-9-bonnes-pratiques/performance.md](../../chapitre-9-bonnes-pratiques/performance.md).

<!-- Extrait original : chapitre-9-bonnes-pratiques/performance.md:5 ; paragraphe -->

La performance de Claude Code dépend moins d'un chiffre fixe de RAM ou CPU que de la **taille du contexte utile**, des commandes exécutées, du nombre d'outils exposés et de la complexité de la tâche. Cette page remplace les anciens profils matériels Copilot non vérifiés par des pratiques mesurables.

<!-- Extrait original : chapitre-9-bonnes-pratiques/performance.md:225 ; section dédiée -->

#### Référence Copilot

Les réglages de complétion et diagnostics spécifiques Copilot restent documentés dans les pages Copilot. Ils ne sont plus utilisés comme base générique pour estimer les ressources d'un workflow Claude.

---


## Workflows IA Complets { #page-chapitre-9-bonnes-pratiques-workflows-ia }

Origine : [chapitre-9-bonnes-pratiques/workflows-ia.md](../../chapitre-9-bonnes-pratiques/workflows-ia.md).

<!-- Extrait original : chapitre-9-bonnes-pratiques/workflows-ia.md:276 ; section dédiée -->

#### Référence Copilot

Les anciens workflows Copilot (chat, édition multi-fichiers, agents, slash commands) restent documentés dans la section **GitHub Copilot (référence)** et les pages dédiées du chapitre Contexte. Ils ne sont pas supprimés ; les exemples génériques de cette page utilisent désormais Claude Code.

---

---

## Prochaine étape

Poursuivez avec **[Cas d'Usage](chapitre-10-cas-usage.md)**, la page suivante dans le menu.
