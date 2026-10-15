# Archgate CLI — installer, écrire et vérifier des décisions d'architecture

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-cli">CLI</span>

**Archgate** transforme des décisions d'architecture en garde-fous versionnés : un ADR Markdown décrit la décision, et un fichier compagnon `.rules.ts` peut l'appliquer automatiquement au code. Avec Claude Code, le bon modèle mental est donc :

```text
Décision humaine durable
        ↓
ADR lisible par l'équipe et l'agent
        ↓
règle Archgate quand elle est automatisable
        ↓
archgate check + tests applicatifs
        ↓
CI / revue
```

Cette page est un **tutoriel de mise en place dans un projet existant**. Pour décider quelles décisions méritent réellement un ADR, voir **[Gérer les ADR avec Claude Code et OpenSpec](../chapitre-9-bonnes-pratiques/adr-claude.md)**.

!!! info "Vérifié le 15 octobre 2026"
    La documentation Archgate recommande aujourd'hui l'installation standalone pour la plupart des postes. Les plugins d'éditeur/agent, dont Claude Code, restent une couche distincte et actuellement en bêta. Vous pouvez utiliser tout le parcours CLI sans plugin.

## Ce qu'Archgate fait — et ce qu'il ne fait pas

| Besoin | Archgate | Outil complémentaire |
|---|---|---|
| documenter un arbitrage durable | ADR Markdown | OpenSpec / arc42 pour le changement et les vues |
| vérifier une convention structurelle | règle `.rules.ts` | tests, linter, ArchUnit, analyse statique |
| donner le contexte architectural à un agent | `review-context` / plugin | `CLAUDE.md`, skills, code |
| bloquer une violation en CI | `archgate check` | build/tests du projet |
| corriger automatiquement une architecture | non | agent + revue humaine |
| prouver que toute l'architecture est correcte | non | plusieurs niveaux de tests et de revue |

Un `archgate check` vert signifie uniquement que **les règles configurées et exécutées n'ont pas trouvé de violation bloquante**. Ce n'est pas une certification de l'ensemble de l'architecture.

---

## Parcours recommandé en 10 étapes

Pour un projet existant, procédez dans cet ordre :

```text
1. choisir le mode d'installation
2. vérifier la version et le PATH
3. créer une branche de pilote
4. lancer archgate init
5. inspecter .archgate/ avant de modifier quoi que ce soit
6. migrer ou écrire UN ADR réel
7. ajouter UNE règle si la décision est automatisable
8. tester la règle avec un cas conforme + un cas en violation
9. lancer check sur le diff puis sur un périmètre plus large
10. ajouter la CI seulement après validation du pilote
```

Ne commencez pas en convertissant tout votre historique d'architecture. Un pilote avec une décision claire permet de vérifier que le modèle vous convient.

---

## 1. Choisir le bon mode d'installation

### Option A — standalone : recommandée pour Java, polyglotte et postes de développement

Aucun Node.js n'est nécessaire.

**Windows PowerShell :**

```powershell
irm https://cli.archgate.dev/install-windows | iex
archgate --version
```

**macOS / Linux :**

```bash
curl -fsSL https://cli.archgate.dev/install-unix | sh
archgate --version
```

Le binaire est installé sous `~/.archgate/bin/`. Si `archgate` reste introuvable après installation, fermez et rouvrez le terminal puis contrôlez le `PATH`.

Pour figer une version dans un environnement reproductible, utilisez le mécanisme `ARCHGATE_VERSION` documenté par Archgate au lieu de laisser chaque poste installer implicitement une version différente.

### Option B — dépendance du projet Node.js

Pour une application Node/TypeScript où vous voulez **verrouiller Archgate par projet** :

```bash
npm install --save-dev archgate
npx archgate --version
npx archgate check
```

La commande `npm install --save-dev archgate` ajoute normalement Archgate dans les `devDependencies` du **`package.json` du projet courant** et met à jour le lockfile.

Le bloc suivant ne va pas dans un fichier Archgate : il se met dans le **`package.json`**, à l'intérieur de la propriété `"scripts"`.

Si votre `package.json` contient déjà des scripts :

```json
{
  "scripts": {
    "test": "vitest run",
    "lint": "eslint .",
    "check:architecture": "archgate check --strict"
  },
  "devDependencies": {
    "archgate": "<version installée>"
  }
}
```

Ne remplacez pas le fichier complet : ajoutez seulement l'entrée `"check:architecture"` dans l'objet `"scripts"`.

Puis :

```bash
npm run check:architecture
```

Dans un monorepo, placez ce script dans le `package.json` **à partir duquel vous voulez exécuter le contrôle**. Si `.archgate/` gouverne tout le repository, le `package.json` racine est généralement le meilleur emplacement. Si chaque package possède des décisions indépendantes, un script par package peut être plus adapté.

Avantage : la version d'Archgate peut être verrouillée dans le lockfile et exécutée de façon identique sur les postes et en CI.

### Option C — environnement Python

Pour un outil CLI isolé :

```bash
pipx install archgate
archgate --version
```

`pip install archgate` existe aussi, mais `pipx` évite de mélanger le CLI avec les dépendances de votre application Python.

### Option D — projet Java sans Node.js ni Python

Le standalone reste le choix le plus simple. Archgate fournit aussi un JAR exécutable publié sur Maven Central :

```bash
java -jar archgate-cli-<version>.jar check
```

Java 11+ est requis pour ce mode. **Vous n'avez pas à transformer votre application Java en projet Node.**

### Recommandation pratique

| Projet | Choix conseillé |
|---|---|
| Java / Spring / multi-module | standalone, version figée en CI |
| repo polyglotte | standalone |
| Node / TypeScript | dépendance de développement ou standalone |
| Python | standalone ou pipx |
| équipe utilisant déjà proto | plugin proto Archgate |

---

## 2. Vérifier l'installation avant de toucher au projet

### Vérifier que le CLI fonctionne

Depuis un terminal neuf :

```bash
archgate --version
archgate --help
archgate check --help
```

Si ces commandes ne fonctionnent pas, **n'initialisez pas encore le projet**. Résolvez d'abord l'installation et le PATH.

### Identifier le mode d'installation réellement utilisé

`archgate --version` confirme la version, mais **pas le gestionnaire qui fournit la commande**. Si plusieurs installations coexistent, le premier exécutable trouvé dans le `PATH` gagne.

**Windows PowerShell :**

```powershell
Get-Command archgate -All | Format-Table CommandType, Source
where.exe archgate
```

**macOS / Linux / Git Bash :**

```bash
command -v archgate
type -a archgate
```

Ensuite, vérifiez le gestionnaire soupçonné :

| Installation possible | Commande de vérification |
|---|---|
| standalone | le chemin résolu pointe typiquement vers `~/.archgate/bin/archgate` |
| npm global | `npm ls -g --depth=0 archgate` |
| npm dépendance projet | `npm ls --depth=0 archgate` puis vérifier `package.json` |
| pipx | `pipx list` |
| pip | `python -m pip show archgate` |
| .NET global tool | `dotnet tool list -g` |
| jbang / Java | `jbang app list` ou vérifier le JAR utilisé |
| proto | `proto list` puis `proto pin archgate <version>` si nécessaire |

!!! tip "Plusieurs installations détectées"
    Évitez de conserver en parallèle un Archgate standalone, un npm global et un pipx global sauf raison précise. Les wrappers npm/pip/.NET/Go/Ruby/Java délèguent au binaire Archgate de la plateforme ; la différence principale est **qui gère l'installation et la version**, pas un ensemble de fonctionnalités différent.

### Quelle différence entre les modes ?

| Mode | Portée | Version | Dépendance runtime du wrapper | Quand le choisir |
|---|---|---|---|---|
| standalone | utilisateur/poste | via `ARCHGATE_VERSION` ou installateur | aucune | choix par défaut, Java, polyglotte |
| npm global | utilisateur | gérée par npm | Node pour le wrapper | équipe déjà standardisée npm |
| npm dev dependency | projet | lockfile | Node pour le wrapper | reproductibilité par repository |
| pipx | utilisateur isolé | gérée par pipx | Python 3.8+ pour le wrapper | environnement Python |
| JAR / jbang | utilisateur ou projet | gérée par Maven/jbang | Java 11+ | toolchain Java |
| proto | utilisateur/projet | pin explicite dans `.prototools` | proto | équipes déjà standardisées proto |

La documentation Archgate indique que ces wrappers téléchargent/délèguent vers le **même binaire natif de plateforme**, généralement mis en cache sous `~/.archgate/bin/`. Il n'y a donc pas un « Archgate npm » plus puissant qu'un « Archgate Python ».

Dans une équipe, choisissez **un propriétaire de version** : lockfile npm, `.prototools`, version d'action CI ou version d'installateur standalone. Le but est d'éviter qu'une règle se comporte différemment entre poste local et CI.

---

## 3. Faire le pilote sur une branche dédiée

Dans l'application cible :

```bash
git switch -c chore/archgate-pilot
git status --short
archgate --version
```

Le working tree doit être compris avant l'initialisation. Si le dépôt contient déjà des modifications, distinguez-les des fichiers générés par Archgate.

---

## 4. Initialiser Archgate dans le projet

À la racine du dépôt :

```bash
archgate init
git status --short
```

Le Quick Start officiel crée une structure de ce type :

```text
.archgate/
├── adrs/
│   └── GEN-001-example.md
├── lint/
│   └── README.md
└── rules.d.ts
```

### Que faut-il versionner ?

En règle générale, les ADR, leurs règles et la configuration projet sous `.archgate/` doivent être versionnés parce qu'ils définissent les garde-fous communs.

Inspectez toutefois le diff avant commit :

```bash
git diff -- .archgate
git status --short
```

L'ADR d'exemple généré sert uniquement à montrer le format. **Ne le laissez pas devenir une fausse décision du projet.** Remplacez-le par une décision réelle ou retirez-le après le pilote.

---

## 5. Plugin Claude Code : facultatif

Le CLI suffit pour documenter et vérifier les décisions.

Si vous avez accès au plugin Claude Code bêta, le parcours officiel actuel est :

```bash
archgate login
archgate init --install-plugin
```

Pour un projet déjà initialisé :

```bash
archgate plugin install
```

Le plugin peut configurer `.claude/settings.local.json`. Ce fichier est **local à l'utilisateur** et ne doit pas être traité comme une politique d'équipe à committer sans revue.

Le plugin ajoute notamment un agent `archgate:developer` et des skills d'onboarding, d'architecture, de qualité et de rédaction d'ADR. Le CLI reste la source locale des ADR et des contrôles.

!!! warning "Ne mélangez pas les versions de guides"
    Les anciennes instructions utilisant des variantes telles que `archgate init --editor claude` peuvent ne plus correspondre au parcours Claude Code actuel. Vérifiez toujours le guide officiel de la version installée.

---

## 6. Écrire un premier ADR utile

Un ADR Archgate est un Markdown avec frontmatter YAML sous `.archgate/adrs/`.

Exemple minimal :

```markdown
---
id: ARCH-001
title: Le domaine ne dépend pas de l'infrastructure
domain: architecture
rules: false
files:
  - "src/**/*.ts"
---

## Context

Le domaine métier doit rester testable sans base de données, HTTP ni framework.

## Decision

Le code du domaine ne doit importer aucun module d'infrastructure.

## Do's and Don'ts

### Do
- dépendre d'interfaces définies côté domaine ;
- injecter les implémentations depuis l'extérieur.

### Don't
- importer un repository SQL dans le domaine ;
- appeler directement un client HTTP depuis une entité métier.

## Consequences

La composition devient plus explicite, mais nécessite des ports/adapters.

## Compliance and Enforcement

Revue manuelle au début du pilote. Une règle automatique sera ajoutée après validation du périmètre.
```

### Choisir le domaine

Archgate fournit notamment les domaines :

| Domaine | Usage typique |
|---|---|
| `backend` | API, services, bases de données |
| `frontend` | UI et code client |
| `data` | modèles et pipelines de données |
| `architecture` | décision transverse |
| `general` | convention de projet |

N'ajoutez un domaine personnalisé que si les domaines intégrés ne conviennent réellement pas.

### Inventorier les ADR

```bash
archgate adr list
archgate adr list --domain architecture
archgate adr show ARCH-001
```

---

## 7. Transformer une décision en règle exécutable

Une règle n'est utile que si elle vérifie une propriété concrète du dépôt.

Passez l'ADR à :

```yaml
rules: true
```

puis créez un fichier compagnon portant exactement le même nom de base :

```text
.archgate/adrs/
├── ARCH-001-domain-independence.md
└── ARCH-001-domain-independence.rules.ts
```

Exemple volontairement simple, adapté à un dépôt TypeScript :

```typescript
/// <reference path="../rules.d.ts" />

export default {
  rules: {
    "no-direct-infrastructure-import": {
      description: "Le domaine ne doit pas importer l'infrastructure",
      async check(ctx) {
        for (const file of ctx.scopedFiles) {
          const matches = await ctx.grep(
            file,
            /from\s+["'][^"']*infrastructure[^"']*["']/
          );

          for (const match of matches) {
            ctx.report.violation({
              message: "Le domaine importe directement l'infrastructure",
              file: match.file,
              line: match.line,
              fix: "Introduire un port côté domaine et injecter l'adapter",
            });
          }
        }
      },
    },
  },
} satisfies RuleSet;
```

Le frontmatter `files` doit limiter cette règle aux fichiers réellement gouvernés, par exemple :

```yaml
files:
  - "src/domain/**/*.ts"
```

!!! important "Une regex n'est pas toujours la bonne vérification"
    Archgate expose aussi des APIs de recherche, glob et AST pour TypeScript/JavaScript, Python et Ruby. Pour une contrainte structurelle complexe, préférez un AST, un test d'architecture ou un outil spécialisé plutôt qu'une regex fragile. En Java, ArchUnit reste souvent plus naturel pour les dépendances de couches.

---

## 8. Tester une règle avant de la rendre bloquante

Une règle doit être testée dans les deux sens.

### Cas conforme

Créez ou choisissez un exemple respectant l'ADR puis exécutez :

```bash
archgate check --adr ARCH-001 --verbose
```

### Cas volontairement en violation

Sur votre branche de pilote, introduisez temporairement une violation contrôlée puis relancez la commande.

Vous devez observer :

- la règle exécutée ;
- le bon fichier ;
- la bonne ligne lorsque disponible ;
- un message compréhensible ;
- un code de sortie non nul pour une violation `error`.

Annulez ensuite le changement de test.

Une règle qui n'échoue jamais sur un contre-exemple connu est probablement mal scoped ou mal écrite.

---

## 9. Comprendre les différents modes de `check`

### Pendant le développement

```bash
archgate check
```

Archgate calcule le contexte des changements et exécute les règles pertinentes.

### Avant commit

```bash
git add <fichiers>
archgate check --staged
```

### Par rapport à la branche de base

```bash
git fetch origin
archgate check --base origin/main
```

Ce mode est particulièrement utile en CI et pour les règles qui doivent comprendre le diff complet.

### Une seule décision

```bash
archgate check --adr ARCH-001 --verbose
```

### Mode strict

```bash
archgate check --strict
```

Le mode strict transforme notamment les warnings/advisories concernés en échec. Vous pouvez aussi définir le comportement par défaut dans `.archgate/config.json` :

```json
{
  "strict": true
}
```

### Sorties machine

```bash
archgate check --output json
archgate check --output github
archgate check --output sarif
```

Utilisez JSON pour l'automatisation locale, `github` pour une CI lisible et SARIF si votre chaîne de sécurité/qualité sait le consommer.

---

## 10. Lire les décisions applicables avant de coder

```bash
archgate review-context
archgate review-context --verbose
```

Le but est de fournir un briefing condensé des ADR applicables au changement.

Pour une modification planifiée mais pas encore présente dans le diff, ne vous fiez pas uniquement à la détection automatique : inspectez explicitement les ADR du domaine ou ouvrez ceux que le plan risque d'impacter.

Avec Claude Code sans plugin, un prompt simple suffit :

```text
Avant toute modification :
1. exécute archgate review-context ;
2. lis les ADR complets nécessaires avec archgate adr show ;
3. explique quelles contraintes s'appliquent ;
4. implémente le changement ;
5. exécute archgate check --base origin/main et les tests du projet ;
6. distingue les contrôles exécutés de ce qui reste à vérifier manuellement.
```

---

## 11. Reprendre et améliorer des ADR existants

Oui, une partie de la reprise peut être automatisée, mais il faut distinguer **import** et **conversion**.

### Ce que `archgate adr import` automatise réellement

La commande officielle sait importer des ADR depuis :

- le registre de packs Archgate ;
- un chemin `org/repo/path` GitHub ;
- une URL Git clonable ;
- un sous-chemin GitHub de type `/tree/<ref>/<path>`.

Elle :

1. clone la source ;
2. lit les ADR ;
3. remappe les IDs pour éviter les collisions ;
4. copie les ADR et leurs éventuels fichiers `.rules.ts` dans `.archgate/adrs/` ;
5. enregistre la provenance dans `.archgate/imports.json`.

Toujours prévisualiser d'abord :

```bash
archgate adr import OWNER/REPO/path --dry-run
```

Puis seulement après revue :

```bash
archgate adr import OWNER/REPO/path
archgate adr import --list
```

Les ADR importés depuis une source suivie peuvent ensuite être surveillés avec :

```bash
archgate adr sync --check
archgate adr sync
```

`sync` compare les versions locales et amont ; en mode interactif, Archgate permet notamment de garder la version locale, prendre l'amont ou ignorer le changement.

### Ce que `adr import` ne fait pas

`archgate adr import` n'est **pas un convertisseur universel de Markdown historique**.

Un ancien dossier comme :

```text
docs/architecture/decisions/
├── 0001-use-postgresql.md
├── 0002-hexagonal.md
└── cache-strategy.md
```

peut utiliser un autre template, ne pas avoir de frontmatter Archgate, mélanger plusieurs décisions ou contenir des statuts historiques incompatibles. Il faut d'abord **auditer et normaliser** ces documents.

### Workflow recommandé : améliorer d'abord, importer ensuite

```text
ADR historiques
      ↓
inventaire en lecture seule
      ↓
conserver / clarifier / fusionner / remplacer / reclasser
      ↓
normalisation au format Archgate dans une zone de staging
      ↓
revue humaine
      ↓
archgate adr import --dry-run
      ↓
import réel
      ↓
règles automatisées ajoutées progressivement
```

#### Étape A — inventorier sans modifier

Créez un tableau de migration :

```text
legacy_id
path
title
status
decision_summary
evidence_in_code
duplicate_of
action
target_domain
target_files
target_rules
new_archgate_id
```

Actions possibles :

- `keep` : décision toujours utile ;
- `clarify` : décision valable mais texte insuffisant ;
- `merge` : plusieurs fichiers décrivent réellement la même décision ;
- `supersede` : décision remplacée ;
- `reclassify` : ce document est plutôt une procédure, une tâche ou une note ;
- `confirm` : intention historique impossible à établir sans validation humaine.

Ne laissez jamais Claude inventer des alternatives ou raisons historiques absentes des sources.

#### Étape B — améliorer chaque ADR avant import

Un ADR candidat doit idéalement devenir :

```text
une seule décision
+ contexte vérifiable
+ alternatives réellement connues
+ décision précise
+ Do / Don't concrets
+ conséquences positives/négatives/risques
+ mode de contrôle
+ références historiques
+ scope files si pertinent
```

Commencez avec `rules: false`. N'activez `rules: true` que lorsque le fichier compagnon `.rules.ts` existe et a été testé.

Le CLI peut ensuite créer ou mettre à jour les documents normalisés :

```bash
archgate adr create \
  --title "Isolation du domaine" \
  --domain architecture \
  --files "src/domain/**"

archgate adr update \
  --id ARCH-001 \
  --body "$(cat migration/ARCH-001-body.md)"
```

`archgate adr update` remplace le body et conserve les autres métadonnées si elles ne sont pas passées explicitement.

#### Étape C — utiliser le plugin Claude Code pour accélérer l'amélioration

Si le plugin bêta est installé, les rôles Archgate actuels sont utiles pour la migration :

| Rôle | Usage pendant la reprise |
|---|---|
| `archgate:onboard` | comprendre le codebase et faire émerger un premier jeu de décisions ; à exécuter une fois, pas comme convertisseur aveugle |
| `archgate:adr-author` | créer ou éditer un ADR suivant les conventions Archgate |
| `archgate:architect` | vérifier la cohérence structurelle du code avec les ADR applicables |
| `archgate:quality-manager` | repérer les patterns récurrents et proposer les décisions/règles qui manquent |

Prompt de migration conseillé avec `archgate:adr-author` :

```text
Analyse cet ADR historique et le code actuel en lecture seule.

1. Sépare les faits historiques prouvés des hypothèses.
2. Dis si la décision est encore active, remplacée, redondante ou hors périmètre.
3. Vérifie si un ADR Archgate existant couvre déjà la même décision.
4. Propose un ADR Archgate court avec :
   Context, Decision, Do's and Don'ts, Consequences,
   Compliance and Enforcement, References.
5. Conserve l'ancien identifiant et le chemin dans References.
6. Propose domain, files et rules:false.
7. Ne crée aucune règle automatique avant validation humaine.
```

La sortie doit être une **proposition de migration**, pas une réécriture silencieuse de l'historique.

#### Étape D — automatiser un lot entier de façon contrôlée

Pour un corpus important, créez un dossier de staging hors du registre canonique :

```text
migration/archgate/
├── migration-plan.csv
└── pack/
    ├── archgate-pack.yaml
    └── adrs/
        ├── ...
        └── ...
```

Faites normaliser les ADR par lots, relisez les diffs, puis publiez cette zone sur une branche de migration.

Vous pouvez alors tester l'import sans écrire :

```bash
archgate adr import https://github.com/OWNER/REPO/tree/chore/adr-migration/migration/archgate/pack --dry-run
```

Puis importer le lot validé :

```bash
archgate adr import https://github.com/OWNER/REPO/tree/chore/adr-migration/migration/archgate/pack
archgate adr import --list
```

Ce pattern sépare clairement :

```text
amélioration éditoriale
≠ import technique
≠ automatisation des règles
```

### Conserver la traçabilité des anciens IDs

Si Archgate remappe `ADR-0042` vers `ARCH-007`, conservez le lien dans `References` et dans un tableau de correspondance :

| Ancien ID | Nouvel ID | Action |
|---|---|---|
| ADR-0042 | ARCH-007 | migré |
| ADR-0043 | — | fusionné dans ARCH-007 |
| ADR-0044 | ARCH-008 | remplacé, référence historique conservée |

Ne renumérotez pas votre histoire comme si les nouveaux IDs avaient toujours existé.

### Après la reprise : ne pas automatiser toutes les décisions d'un coup

Une fois les ADR importés :

```bash
archgate adr list --json
archgate review-context --verbose
archgate check --verbose
```

Puis sélectionnez seulement les décisions pour lesquelles un contrôle automatique est fiable.

Pour chaque nouvelle règle :

1. passer l'ADR à `rules: true` ;
2. créer le compagnon `.rules.ts` ;
3. tester un cas conforme ;
4. introduire un contre-exemple contrôlé ;
5. vérifier que la règle échoue réellement ;
6. seulement ensuite la rendre bloquante en CI.

Pour la méthode éditoriale de tri et de pertinence, suivre **[Gérer les ADR avec Claude Code et OpenSpec](../chapitre-9-bonnes-pratiques/adr-claude.md#assainir-les-adr-existants)**.
---

## 12. Intégrer Archgate à GitHub Actions

L'action officielle évite de réinstaller manuellement le CLI :

```yaml
name: Architecture guardrails

on:
  pull_request:

permissions:
  contents: read

jobs:
  archgate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - uses: archgate/check-action@v1
        with:
          version: <version-validée>
```

Fixez une version après votre pilote afin que la CI ne change pas silencieusement de comportement.

Si vous avez besoin de plusieurs commandes :

```yaml
- uses: archgate/setup-action@v1
  with:
    version: <version-validée>

- run: archgate adr list --json
- run: archgate check --base origin/${{ github.base_ref }} --strict --output github
```

`fetch-depth: 0` est préférable quand vos contrôles dépendent d'une comparaison Git complète.

Les codes de sortie documentés sont :

| Code | Signification |
|---|---|
| `0` | contrôles réussis |
| `1` | violation bloquante |
| `2` | erreur d'exécution/configuration |

Ne mettez pas `continue-on-error: true` sur le job que vous utilisez comme Quality Gate.

---

## 13. Cas Java / Spring : Archgate + ArchUnit

Ne cherchez pas à remplacer ArchUnit.

Répartition recommandée :

```text
ADR
├── intention et compromis
├── Archgate
│   ├── fichiers/configurations
│   ├── conventions transverses
│   └── règles simples ou cross-language
└── ArchUnit
    ├── dépendances entre packages
    ├── couches
    ├── cycles
    └── règles structurelles Java
```

Dans l'ADR, documentez les deux preuves :

```markdown
## Compliance and Enforcement

- Archgate : ARCH-003/check-config-boundary
- ArchUnit : DomainLayerTest
- Commande : ./mvnw test
```

La CI doit exécuter **les deux**.

---

## 14. Dépannage concret

| Symptôme | Action |
|---|---|
| `archgate` introuvable | rouvrir le terminal, contrôler `~/.archgate/bin` et le PATH |
| le poste et la CI utilisent des comportements différents | comparer `archgate --version` et figer la version |
| aucun ADR reconnu | contrôler `.archgate/adrs/`, frontmatter et nommage |
| `rules: true` mais check plante | vérifier la présence du fichier compagnon `.rules.ts` |
| règle jamais exécutée | contrôler `files`, `ctx.scopedFiles` et le diff utilisé |
| check vert alors que vous attendiez une violation | relancer avec `--adr <id> --verbose` et un contre-exemple contrôlé |
| plugin Claude inaccessible | continuer en CLI ; le plugin n'est pas requis |
| trop d'ADR proposés | appliquer le filtre de pertinence du guide ADR avant création |
| trop de bruit dans `review-context` | raccourcir Decision/Do's & Don'ts et mieux scoper les ADR |

---

## Checklist d'adoption dans un nouveau projet

Avant de déclarer Archgate « en place », vérifiez :

- [ ] le CLI fonctionne sur au moins un poste propre ;
- [ ] la version est identifiable et reproductible ;
- [ ] `.archgate/` est relu et versionné ;
- [ ] l'ADR d'exemple a été remplacé ou retiré ;
- [ ] au moins un ADR réel est compris par l'équipe ;
- [ ] chaque règle automatique a un contre-exemple qui la fait échouer ;
- [ ] le build et les tests existants restent exécutés ;
- [ ] la CI exécute Archgate sur la bonne base Git ;
- [ ] les contrôles manuels non automatisables restent documentés ;
- [ ] le plugin Claude, s'il est utilisé, n'est pas confondu avec le CLI.

---

## Prochaine étape

Poursuivez avec **[Jupyter](jupyter.md)**, la page suivante dans le menu.

## Sources

Sources officielles vérifiées le **15 octobre 2026** :

- [Archgate — documentation](https://cli.archgate.dev/)
- [Installation](https://cli.archgate.dev/getting-started/installation/)
- [Quick Start](https://cli.archgate.dev/getting-started/quick-start/)
- [Architecture Decision Records](https://cli.archgate.dev/concepts/adrs/)
- [Domains](https://cli.archgate.dev/concepts/domains/)
- [Writing ADRs](https://cli.archgate.dev/guides/writing-adrs/)
- [Writing Rules](https://cli.archgate.dev/guides/writing-rules/)
- [Importing ADRs](https://cli.archgate.dev/guides/importing-adrs/)
- [archgate adr — create, update, import, sync](https://cli.archgate.dev/reference/cli/adr/)
- [CI Integration](https://cli.archgate.dev/guides/ci-integration/)
- [archgate check](https://cli.archgate.dev/reference/cli/check/)
- [Claude Code Plugin](https://cli.archgate.dev/guides/claude-code-plugin/)
- [Dépôt officiel du CLI](https://github.com/archgate/cli)
