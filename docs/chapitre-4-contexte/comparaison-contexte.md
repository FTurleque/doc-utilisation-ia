# Comparaison — Contexte & Personnalisation entre Éditeurs

<span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span>

## Présentation

Cette page compare les fonctionnalités de Copilot entre **VS Code** et **IntelliJ IDEA**. Les deux offrent des capacités riches, mais avec approches différentes.

---

## Features Copilot par IDE

### Inline Suggestions (Autocomplétion)

| Feature | VS Code | IntelliJ IDEA |
|---------|:-------:|:------------:|
| Suggestions en temps réel | ✅ | ✅ |
| Accepter avec Tab/Enter | ✅ | ✅ |
| Naviguer entre suggestions | ✅ | ✅ |
| Mode manuel/auto | ✅ | ✅ |
| Générer multi-ligne | ✅ | ✅ |

**Résultat** : ✅ Équivalentes

### Chat Interactif

| Feature | VS Code | IntelliJ IDEA |
|---------|:-------:|:------------:|
| Chat panneau dédié | ✅ | ✅ |
| Inline Chat (dans éditeur) | ✅ | ✅ |
| Slash commands (/explain, /tests) | ✅ | ✅ |
| Contexte participants (@workspace, @project) | ✅ | ✅ |
| Chat multi-fichiers | ✅ | ✅ |

**Résultat** : ✅ Équivalentes (légère avance VS Code en UX)

### Copilot Agents

| Feature | VS Code | IntelliJ IDEA |
|---------|:-------:|:------------:|
| Agent autonome | ✅ | ✅ |
| Créer PR automatiquement | ✅ | ✅ |
| Implémenter feature depuis issue | ✅ | ✅ |
| Analyser et corriger bugs | ✅ | ✅ |
| Plans | Pro+/Enterprise | Pro+/Enterprise |

**Résultat** : ✅ Équivalentes

### Copilot Edits (Multi-fichiers)

| Feature | VS Code | IntelliJ IDEA |
|---------|:-------:|:------------:|
| Edit mode (aprouver chaque change) | ✅ | ✅ |
| Agent mode (autonome) | ✅ | ✅ |
| Modifications coordonnées | ✅ | ✅ |
| Itération automatique | ✅ | ✅ |

**Résultat** : ✅ Équivalentes

### Code Revie & PR Summaries

| Feature | VS Code | IntelliJ IDEA |
|---------|:-------:|:------------:|
| Review suggestions (Free) | Sélection | Sélection |
| Review complète (Pro+) | ✅ | ✅ |
| PR summary auto | ✅ | ✅ |

**Résultat** : ✅ Équivalentes

---

## Contextualisation & Personnalisation

Ici, les éditeurs **divergent significativement**.

### Custom Instructions

| Mécanisme | VS Code | IntelliJ IDEA |
|-----------|:-------:|:------------:|
| **Repository-level** | ✅ `.github/copilot-instructions.md` | ✅ `.idea/ai/copilot-instructions.md` ou settings |
| **Personal-level** | ✅ GitHub settings | ✅ GitHub settings |
| **Format** | Markdown | Markdown ou settings UI |
| **Partage équipe** | ✅ Via Git | ✅ Via `.idea/` versionnée |

### Instructions Ciblées

| Mécanisme | VS Code | IntelliJ IDEA |
|-----------|:-------:|:------------:|
| `.github/instructions/*.instructions.md` | ✅ | ✅ (via settings UI) |
| Par langage/domaine | ✅ | Partiellement |
| Appliqué auto | ✅ Basé sur `applyTo` glob | ✅ Basé sur fichier ouvert |

### Prompt Files

| Mécanisme | VS Code | IntelliJ IDEA |
|-----------|:-------:|:------------:|
| **Prompt files** (`.prompt.md`) | ✅ Réutilisables, invoquables via `#fichier` | ✅ |
| Stockage | `.github/prompts/` | `.github/prompts/` |
| Partage équipe via Git | ✅ | ✅ |

### Skills (`SKILL.md`)

| Mécanisme | VS Code | IntelliJ IDEA |
|-----------|:-------:|:------------:|
| **Création** via interface | ✅ | ❌ |
| **Lecture / utilisation** | ✅ | ⭐ En lecture seule |
| URI de référence | `copilot-skill://domain/SKILL.md` | — |
| Chargement | À la demande (≠ instructions toujours actives) | À la demande |
| Stockage | `.github/skills/<domain>/SKILL.md` | `.github/skills/<domain>/SKILL.md` |
| Partage équipe via Git | ✅ | ✅ (lecture) |

**Résultat** : ✅ VS Code (création + usage), ⭐ IntelliJ (lecture seulement)

### Agents Personnalisés (`.agent.md`)

| Mécanisme | VS Code | IntelliJ IDEA |
|-----------|:-------:|:------------:|
| Fichiers `.agent.md` dans `.github/agents/` | ✅ | ✅ |
| Invocation `@nom-agent` dans le chat | ✅ | ✅ |
| Restriction des outils par agent | ✅ (`tools:` frontmatter) | ✅ |
| Modèle IA par agent (`model:` frontmatter) | ✅ | ✅ |
| Instructions permanentes intégrées à l'agent | ✅ | ✅ |
| Workflows IDE natifs (actions, intentions) | ⭐ Via agent mode | ✅ Natif IDE |

**Résultat** : ✅ Équivalentes

### Hooks Automatiques

| Mécanisme | VS Code | IntelliJ IDEA |
|-----------|:-------:|:------------:|
| Hooks d'éditeur (`onSave`, `onOpen`, `onCodeAction`) | ✅ | ❌ |
| Hooks de workflow (`pre-commit`, `post-merge`, `on-build-error`) | ✅ | ❌ |
| Génération auto de messages de commit | ✅ (icône ✨ Source Control) | ❌ |
| Intégration GitHub Actions pour revue PR | ✅ | ✅ (via GitHub) |
| Configuration dans `settings.json` | ✅ | ❌ |

**Résultat** : ✅ VS Code exclusif (sauf GitHub Actions)

!!! info "Hooks et IntelliJ"
    IntelliJ IDEA dispose de ses propres mécanismes d'automatisation (file watchers, intentions, macros), mais ceux-ci ne sont pas des hooks Copilot — ils ne déclenchent pas d'actions Copilot directement.

### Exclusion & Sensibilité

| Mécanisme | VS Code | IntelliJ IDEA |
|-----------|:-------:|:------------:|
| `.copilotignore` | ✅ | ❌ |
| Exclusion dossiers | Limitée | ✅ Natif "Excluded Folders" |
| Cache context privé | ✅ | ✅ |

---

## Analyses Sémantique & Contexte Inferred

Les deux IDEs n'utilisent pas la même technologie pour comprendre votre code. Cette différence est fondamentale : elle détermine **combien Copilot "voit" sans que vous ayez à ouvrir des fichiers**.

### Comment ça fonctionne ?

=== "VS Code — LSP (Language Server Protocol)"

    **Principe** : VS Code délègue l'analyse du code à des serveurs de langage externes (un par langage). Copilot récupère le contexte via ces serveurs.

    **Ce que Copilot voit automatiquement** :

    - Fichiers ouverts dans les onglets (contexte principal)
    - Fichiers récemment modifiés
    - Imports et dépendances lus depuis `package.json`, `tsconfig.json`, `pyproject.toml`, etc.
    - Types et symboles exposés par le Language Server actif
    - `.github/copilot-instructions.md` et instructions ciblées

    **Profondeur d'analyse** : **Moyenne** — dépend du Language Server installé

    !!! info "LSP = extensible mais fragmenté"
        L'avantage du LSP est que chaque langage peut avoir son propre serveur optimisé (TypeScript LS, Pylance, rust-analyzer…). L'inconvénient : la profondeur varie selon la qualité du serveur, et les fichiers non ouverts sont souvent invisibles.

=== "IntelliJ IDEA — PSI (Program Structure Interface)"

    **Principe** : IntelliJ indexe l'intégralité du projet au démarrage via le PSI — un arbre syntaxique *et* sémantique résolu pour chaque fichier. Copilot hérite de cet index complet.

    **Ce que Copilot voit automatiquement** :

    - Hiérarchie complète du projet (classes, méthodes, types, interfaces)
    - Imports et références détectées sur **tous les fichiers** (pas seulement les ouverts)
    - Héritage et polymorphisme résolus nativement
    - `pom.xml`, `build.gradle` pour dépendances et modules
    - Structure multi-module Maven/Gradle comprise sans configuration extra
    - Annotations Spring, JPA, Jakarta EE interprétées par l'IDE

    **Profondeur d'analyse** : **Élevée** — index complet du projet disponible en permanence

    !!! info "PSI = profond mais spécialisé JVM"
        L'avantage du PSI est sa précision exceptionnelle pour Java, Kotlin, Scala. L'inconvénient : il est principalement taillé pour les langages JVM ; pour TypeScript ou Python pur, la valeur ajoutée est moindre.

---

### Comparaison directe LSP vs PSI

| Critère | VS Code (LSP) | IntelliJ IDEA (PSI) |
|---------|:-------------:|:-------------------:|
| Connaissance des fichiers **non ouverts** | ⭐ Partielle | ✅ Complète |
| Résolution de l'héritage de classes | ⭐ Via LS actif | ✅ Natif, complet |
| Inférence de types sans annotations | ⭐ Selon LS | ✅ Résolu par PSI |
| Qualité pour **Java / Kotlin / Scala** | Bon | **Excellent** |
| Qualité pour **TypeScript / JavaScript** | **Excellent** | Bon |
| Qualité pour **Python** | **Excellent** (Pylance) | Bon |
| Qualité pour **Go / Rust / C++** | Très bon | Bon |
| Support multi-module Maven/Gradle | Bon | **Natif** |
| Performance sur très grands projets | Bon | **Excellent** (cache PSI) |
| Extensibilité (nouveaux langages) | **Excellent** | Limité |

---

### Exemple concret : la différence en pratique

Imaginons une classe `OrderService` dans un projet Java de 200 fichiers.

=== "Sur IntelliJ IDEA"

    ```java
    @Service
    public class OrderProcessor {

        @Autowired
        private OrderService orderService;

        public void process(Long orderId) {
            orderService.  // ← Copilot suggère TOUTES les méthodes
                          //   de OrderService avec les bons types,
                          //   même si OrderService.java n'est PAS ouvert.
                          //   PSI a déjà tout indexé.
        }
    }
    ```

    ✅ Copilot voit `findById()`, `save()`, `cancelOrder()` et leurs signatures exactes.

=== "Sur VS Code"

    ```java
    @Service
    public class OrderProcessor {

        @Autowired
        private OrderService orderService;

        public void process(Long orderId) {
            orderService.  // ← Copilot suggère des méthodes génériques
                          //   ou rien de précis si OrderService.java
                          //   n'est pas dans un onglet ouvert.
        }
    }
    ```

    ⭐ Pour obtenir les bonnes suggestions, il faut ouvrir `OrderService.java` dans un onglet.

---

### Quand utiliser quel IDE ?

| Situation | IDE recommandé | Raison |
|-----------|:--------------:|--------|
| Projet **Java / Spring Boot** | ✅ IntelliJ | PSI résout héritage, annotations Spring, injection de dépendances sans configuration |
| Projet **Kotlin / Android** | ✅ IntelliJ | Support natif Kotlin + PSI = suggestions très précises |
| Projet **Scala** | ✅ IntelliJ | Analyse complexité Scala (implicits, type classes) via PSI |
| Projet **TypeScript / React / Next.js** | ✅ VS Code | TypeScript LS = inférence parfaite + extensions frontend riches |
| Projet **Python / FastAPI / Django** | ✅ VS Code | Pylance LSP = meilleur support Python actuel |
| Projet **Node.js / Express** | ✅ VS Code | Écosystème npm + LSP = contexte optimal |
| Projet **Go / Rust** | ✅ VS Code | gopls / rust-analyzer = Language Servers de référence |
| **Mono-repo multi-langage** | ✅ VS Code | `.instructions.md` ciblées + workspace multi-dossiers |
| Base de code **Java legacy massive** | ✅ IntelliJ | PSI comprend les hiérarchies complexes sans ouvrir chaque fichier |
| Dev en **GitHub Codespaces / Cloud** | ✅ VS Code | Natif web, LSP disponible en remote |
| **Gouvernance IA** (instructions, politiques, contrôle) | ✅ VS Code | `.instructions.md` versionnées dans `.github/`, `applyTo` pour cibler les équipes, agents avec restriction d'outils, `.copilotignore` pour exclure le code sensible |

!!! tip "Stratégie combinée"
    Vous pouvez tirer le meilleur des deux : créez vos fichiers `.github/` (instructions, prompts, agents) en VS Code, puis ouvrez le même projet dans IntelliJ pour bénéficier du PSI. **Les instructions `.github/copilot-instructions.md` sont lues par les deux IDEs.**

---

## Avantages par IDE

### VS Code ✅

- **Personnalisation avancée** : instructions ciblées, skills, agents, prompts réutilisables
- **Légèreté** : moins exigeant en ressources
- **Écosystème extensible** : MCP (Model Context Protocol) pour intégrer outils externes
- **Workflow équipe** : tout se versionne via Git (`.github/`)
- **Web-based** : VS Code Web, GitHub Codespaces
- **TypeScript/JS excellence** : contexte optimal pour frontend

### IntelliJ IDEA ✅

- **Analyse JVM native** : Meilleure pour Java, Kotlin, Scala
- **Refactorings intelligents** : intégrés avant Copilot
- **Multi-module Maven/Gradle natif** : organise auto le contexte
- **Inspections & hints intégrées** : Copilot + IDE analysis combinés
- **Performance pour gros projets** : PSI cache = réactif
- **Workflows IDE sophistiqués** : debugging, profiling intégré

---

## Contexte par Écosystème

### Frontend (React, Vue, Angular, Next.js)

| Aspect | VS Code | IntelliJ |
|--------|:-------:|:--------:|
| Contexte langues | **Excellent** | Bien |
| Resolution types | Excellent | Bien |
| Plugins/extensions | Excellent | Limité |
| Recommandation | **Préféré** | Option secondaire|

⭐ **Gagnant : VS Code** (WebStorm meilleur si acheté)

### Backend Java / JVM

| Aspect | VS Code | IntelliJ |
|--------|:-------:|:--------:|
| Contexte sémantique | Bon | **Excellent** |
| Héritage multi-génération | Limité | **Compris natif** |
| Refactorings Copilot | Bon | **Meilleur** |
| Maven/Gradle multi-module | Bon | **Meilleur** |
| Recommandation | Acceptable | **Préféré** |

⭐ **Gagnant : IntelliJ** (ou IDEA complet)

### Backend Node.js / Python

| Aspect | VS Code | IntelliJ |
|--------|:-------:|:--------:|
| Contexte | Excellent | Bon |
| Types inference | Excellent | Bon |
| Recommandation | **Préféré** | Acceptable |

⭐ **Gagnant : VS Code**

### Polyglot (Mono-repo : Frontend + Backend + Shared)

| Aspect | VS Code | IntelliJ |
|--------|:-------:|:--------:|
| Multi-dossiers natif | ✅ `.code-workspace` | ✅ Multi-module |
| Contexte partagé | Excellent | Bon |
| Recommandation | Très bon (equipé ensemble) | Équipes séparées |

⭐ **Gagnant : VS Code** (meilleur pour équipes mixed)

---

## Recommandations par Contexte

### Équipe Frontend React/TypeScript
→ **VS Code** (+ optionnel WebStorm pour expérience UI)

### Équipe Backend Java/Spring
→ **IntelliJ IDEA** (meilleure analyse PSI + Spring tooling)

### Équipe Python/FastAPI
→ **VS Code** (avec Pylance)

### Mono-repo : Frontend + Backend + Shared Types
→ **VS Code** (`code-workspace` + instructions ciblées)
  
   Fonctionne aussi : **IntelliJ Fleet** (Lightweight, MCP-ready)

### Solo Dev Multi-skillée
→ **VS Code** (flexibilité, personnalisation profonde)

---

## Tableau Récapitulatif

| Catégorie | Gagnant |
|-----------|--------|
| **Inline suggestions** | 🤝 Égalité |
| **Chat & Agents** | 🤝 Égalité |
| **Edits multi-fichiers** | 🤝 Égalité |
| **Personnalisation avancée** | ✅ VS Code |
| **Prompt files réutilisables** | ✅ VS Code |
| **Skills domaine (SKILL.md)** | ✅ VS Code |
| **Agents personnalisés (.agent.md)** | 🤝 Égalité |
| **Hooks automatiques** | ✅ VS Code |
| **Contexte JVM natif** | ✅ IntelliJ |
| **Frontend excellent** | ✅ VS Code |
| **Backend JVM excellent** | ✅ IntelliJ |
| **Légèreté & flexibilité** | ✅ VS Code |
| **Analyse sémantique** | ✅ IntelliJ |

---

## Ressources

- [Guide VS Code Complet](../chapitre-1-installation/vscode/reference.md)
- [Guide IntelliJ Complet](../chapitre-1-installation/intellij/reference.md)
- [Contexte VS Code avancé](vscode-contexte.md)
- [Contexte IntelliJ avancé](intellij-contexte.md)

---

## L'avantage d'IntelliJ : analyse sémantique native

IntelliJ connaît votre code en profondeur **sans configuration** :

```java
// Exemple : IntelliJ comprend que orderService est un
// OrderService et connaît toutes ses méthodes disponibles
// sans avoir besoin d'onglets ouverts

@Autowired
private OrderService orderService;

public void process() {
    // Copilot sur IntelliJ suggère exactement les bonnes
    // méthodes de orderService avec les bons types de paramètres
    orderService.
    //           ↑ Suggestions précises car IntelliJ connaît
    //             le type exact et toutes ses méthodes
}
```

Sur VS Code, la même précision nécessiterait que le fichier `OrderService.java` soit ouvert dans un onglet.

---

## Stratégie recommandée selon le contexte

### Vous travaillez sur un projet Java/Spring Boot

```
Recommandation : IntelliJ IDEA en IDE principal
                 VS Code optionnel pour les fichiers de personnalisation

Pourquoi : L'analyse PSI d'IntelliJ donne un contexte Java exceptionnel.
           Si vous avez besoin d'instructions custom, créez-les sur VS Code
           et committez-les dans .github/ — elles bénéficieront à toute l'équipe.
```

### Vous travaillez sur un projet full-stack TypeScript

```
Recommandation : VS Code avec workspace multi-dossiers

Pourquoi : VS Code + Pylance/TypeScript Language Server = contexte TS 
           excellent + personnalisation .instructions.md possible + 
           .copilotignore pour exclure les fichiers générés.
```

### Vous avez les deux IDEs et alternez selon les projets

```
Recommandation : 
- Créez les fichiers .github/ dans votre projet (instructions, agents)
- Ces fichiers bénéficient à VS Code automatiquement
- IntelliJ ignore ces fichiers mais bénéficie de la structure propre 
  et du README bien écrit
- Win-win pour les deux IDEs !
```

---

## Migration de contexte : d'IntelliJ vers VS Code

Si vous souhaitez passer d'IntelliJ à VS Code pour un projet :

1. **Exportez votre connaissance projet** vers un `copilot-instructions.md`
2. **Créez des instructions** pour les conventions Java/Kotlin de votre équipe
3. **Installez les extensions** : Extension Pack for Java, Spring Boot Extension Pack
4. **Configurez le workspace** avec un `.code-workspace` si multi-module

```markdown
<!-- .github/copilot-instructions.md pour un projet Spring Boot -->
# Instructions — MonApp Spring Boot

Ce projet est une API REST Spring Boot 3.2 avec Java 21.

Architecture (packages) :
- `controller` : @RestController, validation des entrées, mapping DTOs
- `service` : @Service, logique métier, @Transactional pour les ops write
- `repository` : interfaces JpaRepository, queries JPQL dans @Query
- `model` : entités JPA, enums, DTOs (record Java 16+)
- `config` : @Configuration, beans, sécurité Spring Security
- `exception` : @ControllerAdvice, hiérarchie d'exceptions

Conventions Java :
- Java 21 features : Records, Pattern Matching, Sealed Classes bienvenues
- Lombok : @Data, @Builder, @RequiredArgsConstructor, @Slf4j
- Validation : @Valid sur les DTOs d'entrée, annotations javax.validation
- Tests : JUnit 5, Mockito, AssertJ, @SpringBootTest pour les IT
```

---

## Chapitres suivants

- [Prompt Engineering](../chapitre-4-prompt-engineering/index.md) — Vue d'ensemble des techniques de prompt engineering avec Copilot
- [Machine Learning — Concepts Fondamentaux](../chapitre-5-machine-learning/concepts-fondamentaux.md) — Notions essentielles de ML pour mieux utiliser Copilot sur ces sujets

