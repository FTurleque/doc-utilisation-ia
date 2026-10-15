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

Pour une application Node/TypeScript où vous voulez versionner Archgate avec les autres outils :

```bash
npm install --save-dev archgate
npx archgate --version
npx archgate check
```

Ajoutez éventuellement :

```json
{
  "scripts": {
    "check:architecture": "archgate check --strict"
  }
}
```

Puis :

```bash
npm run check:architecture
```

Avantage : la version peut être verrouillée dans le lockfile du projet.

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

Depuis un terminal neuf :

```bash
archgate --version
archgate --help
archgate check --help
```

Si ces commandes ne fonctionnent pas, **n'initialisez pas encore le projet**. Résolvez d'abord l'installation et le PATH.

Dans une équipe, notez la version retenue dans votre documentation de développement ou votre toolchain. Le but est d'éviter qu'une règle se comporte différemment entre poste local et CI.

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

## 11. Reprendre un projet qui possède déjà des ADR

Ne copiez pas immédiatement tout votre dossier d'ADR dans `.archgate/adrs/`.

Procédure sûre :

1. inventorier les ADR existants ;
2. classer : actif, obsolète, remplacé, doublon, à clarifier ;
3. choisir le registre canonique ;
4. migrer d'abord quelques ADR actifs ;
5. conserver une table de correspondance ancien ID → nouvel ID ;
6. vérifier que les liens arc42/OpenSpec restent valides ;
7. ajouter les règles après compréhension de la décision, pas pendant une conversion automatique.

La commande `archgate adr import` existe pour les sources prises en charge, notamment certains packs et dépôts Git, mais ce n'est pas une garantie de conversion fidèle de n'importe quel corpus Markdown local.

Pour la méthode éditoriale complète, suivre **[Gérer les ADR avec Claude Code et OpenSpec](../chapitre-9-bonnes-pratiques/adr-claude.md#assainir-les-adr-existants)**.

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
- [Writing Rules](https://cli.archgate.dev/guides/writing-rules/)
- [CI Integration](https://cli.archgate.dev/guides/ci-integration/)
- [archgate check](https://cli.archgate.dev/reference/cli/check/)
- [Claude Code Plugin](https://cli.archgate.dev/guides/claude-code-plugin/)
- [Dépôt officiel du CLI](https://github.com/archgate/cli)
