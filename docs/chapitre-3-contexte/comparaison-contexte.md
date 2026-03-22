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
| `.github/instructions/*.instructions.md` | ✅ | ❌ (via settings UI) |
| Par langage/domaine | ✅ | Partiellement |
| Appliqué auto | ✅ Basé sur `applyTo` glob | ✅ Basé sur fichier ouvert |

### Prompt Files & Skills

| Mécanisme | VS Code | IntelliJ IDEA |
|-----------|:-------:|:------------:|
| **Prompt files** (`.prompt.md`) | ✅ Réutilisables, sauvegardés | ❌ |
| **Skills** (`SKILL.md`) | ✅ Packaging domain knowledge | ❌ |
| **Agents custom** (`.agent.md`) | ✅ Full automation | ⭐ Limité aux workflows IDE |

### Exclusion & Sensibilité

| Mécanisme | VS Code | IntelliJ IDEA |
|-----------|:-------:|:------------:|
| `.copilotignore` | ✅ | ❌ |
| Exclusion dossiers | Limitée | ✅ Natif "Excluded Folders" |
| Cache context privé | ✅ | ✅ |

---

## Analyses Sémantique & Contexte Inferred

### VS Code

**Contexte utilisé par Copilot** :
- Fichiers ouverts dans les tabs
- Fichiers récemment modifiés
- Imports / dépendances lues depuis `package.json`, `tsconfig.json`, etc.
- Language Server Protocol (LSP) pour types et symboles
- `.github/copilot-instructions.md` et autres directives

**Profondeur d'analyse** : Moyenne (LSP-dépendant)

### IntelliJ IDEA

**Contexte utilisé par Copilot** :
- Fichier courant ouvert
- Imports et références détectées par PSI (Persistent Syntax Index)
- Hiérarchie complète du projet (classes, méthodes, types)
- `pom.xml`, `build.gradle` pour dépendances
- Structure module (Maven/Gradle multi-module nativement compris)
- IntelliJ project structure

**Profondeur d'analyse** : **Plus profonde** (PSI natif, très complet pour JVM)

!!! tip "Comparaison"
    **IntelliJ** : Meilleure analyse sémantique **native** Pour Java/JVM. PSI = syntaxe *et* sémantique résolue.
    
    **VS Code** : LSP = plus **extensible**, pas aussi profond pour Java, excellent pour JS/TS.

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
├── instructions/
│   ├── vue.instructions.md              → Règles composants Vue (applyTo: **/*.vue)
│   └── stores.instructions.md           → Règles Pinia (applyTo: **/stores/**) 
├── prompts/
│   ├── create-component.prompt.md       → Template création de composant Vue
│   └── write-e2e-test.prompt.md         → Cypress E2E tests standards
└── agents/
    └── vue-expert.agent.md              → Agent spécialisé Vue 3
```

Résultat : Copilot se comporte comme s'il avait été formé spécifiquement pour ce projet.

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

## Prochaines étapes

- [Bonnes Pratiques](../chapitre-4-bonnes-pratiques/index.md) — Comment tirer le meilleur des deux IDEs
- [Cas d'usage Java](../chapitre-6-cas-usage/java.md) — Configuration complète pour un projet Java
- [Cas d'usage Node.js/React](../chapitre-6-cas-usage/nodejs-react.md) — Configuration complète pour un projet TypeScript

