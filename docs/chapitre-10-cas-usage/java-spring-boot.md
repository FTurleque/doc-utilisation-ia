# Java & Spring Boot avec Claude Code

<span class="badge-expert">Expert</span>

Sur Spring Boot, Claude Code doit d'abord comprendre **la version et les conventions réelles du projet**. Spring évolue vite et les architectures d'équipe diffèrent : cette page évite donc de figer un JDK, une version Spring, un mapper, un ORM ou une stratégie de sécurité comme choix universel.

---

## 1. Cartographier un projet Spring

Avant une modification :

```text
Lis le build et les packages principaux.
Identifie :
- version Java/Spring ;
- MVC ou WebFlux ;
- couche persistence ;
- migrations DB ;
- sécurité ;
- gestion globale des erreurs ;
- tests unitaires/intégration ;
- commandes du wrapper.
Ne modifie rien encore.
```

Cette étape évite de proposer JPA dans un projet R2DBC, Mockito dans un projet qui utilise un autre style ou `javax.*` dans un codebase Jakarta moderne.

---

## 2. Architecture : suivre le projet, pas un template générique

Structure fréquente :

```text
src/main/java/com/example/app/
├── api/
├── application/
├── domain/
├── persistence/
└── config/
```

Une structure `controller/service/repository/entity` est également légitime. Claude doit prolonger **la convention existante** au lieu d'imposer une architecture DDD ou layered différente.

---

## 3. Controller : garder la frontière HTTP explicite

Exemple générique :

```java
@RestController
@RequestMapping("/users")
class UserController {
    private final UserService userService;

    UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping
    ResponseEntity<UserResponse> create(@Valid @RequestBody CreateUserRequest request) {
        UserResponse created = userService.create(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }
}
```

Les annotations, types de retour et conventions d'erreur doivent refléter le projet réel.

---

## 4. Service : tester le comportement métier

```text
Ajoute la règle métier demandée dans `UserService`.
Avant de coder :
- trouve les exceptions métier existantes ;
- trouve le pattern transactionnel utilisé ;
- trouve les tests du service.
Ajoute le test qui exprime la nouvelle règle puis implémente le changement minimal.
```

Évitez de créer systématiquement une interface `XService` + `XServiceImpl` si le dépôt n'utilise pas ce pattern.

---

## 5. JPA et persistence

Points à faire vérifier par Claude :

- requêtes N+1 ;
- frontières transactionnelles ;
- lazy/eager loading ;
- contraintes DB vs validation applicative ;
- migrations ;
- pagination ;
- concurrence et unicité.

Demande :

```text
Revois ce changement JPA.
Vérifie le SQL attendu, les relations chargées et le nombre de requêtes.
Si un test d'intégration DB existe, ajoute un cas qui prouve le comportement.
```

Ne remplacez pas une contrainte de base de données par une simple vérification applicative si l'invariant doit résister à la concurrence.

---

## 6. Configuration et secrets

Spring permet de nombreuses sources de configuration. Claude doit distinguer :

- valeurs publiques versionnables ;
- secrets injectés ;
- configuration par environnement ;
- valeurs de test.

Ne demandez jamais de copier de vrais tokens dans `application.yml`, un prompt ou `CLAUDE.md`.

---

## 7. Spring Security

Pour toute modification auth/authz :

```text
Cartographie la configuration Spring Security actuelle.
Identifie les filtres, SecurityFilterChain, annotations de méthode et tests sécurité.
Ne modifie pas l'authentification ou les rôles sans test explicite des cas autorisé/refusé.
```

Les APIs de Spring Security dépendent fortement de la version : vérifiez la documentation officielle correspondant à la version du projet avant une migration.

---

## 8. Tests

Hiérarchie pratique :

| Test | Usage |
|---|---|
| test unitaire | logique pure/service isolé |
| slice test | couche MVC/JPA ciblée si le projet l'utilise |
| intégration | wiring Spring, DB, sécurité |
| Testcontainers | dépendance réelle conteneurisée lorsque nécessaire |

Claude doit réutiliser les annotations et fixtures déjà présentes au lieu de choisir automatiquement `@SpringBootTest` pour tout.

**Migration vers Spring Boot 4 :** `@MockBean` et `@SpyBean` ont été retirées au profit de `@MockitoBean` et `@MockitoSpyBean` de Spring Framework. Ne recopiez pas des tests d'un tutoriel Boot 3 sans vérifier les imports et les règles de remplacement des beans. Les dépendances et annotations de certains tests HTTP changent aussi ; consultez le guide de migration pour la version visée.

---

## 9. Migration de version

Pour une montée de version Spring Boot :

```text
1. lis la version actuelle et le BOM ;
2. consulte les release notes et migration guides officiels actuels ;
3. liste uniquement les breaking changes qui touchent ce dépôt ;
4. mets à jour build + code par étapes ;
5. exécute tests et build après chaque étape importante.
```

N'utilisez pas cette documentation comme liste de versions « recommandées » : la compatibilité de l'application est la contrainte principale.

---

## 10. Skill Spring optionnel

`.claude/skills/spring-change/SKILL.md` :

```markdown
---
name: spring-change
description: Implémente un changement Spring Boot en respectant architecture, sécurité, persistence et tests existants.
---

1. Lire le build et les conventions voisines.
2. Identifier la couche réellement affectée.
3. Ajouter ou adapter le test le plus proche.
4. Implémenter le changement minimal.
5. Exécuter le test ciblé puis le build pertinent.
6. Vérifier migration/config/docs si le contrat change.
```

---

## Sources

- [Spring Boot 4 — migration des tests](https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-4.0-Migration-Guide) — vérifié le 2026-10-03
- [Spring Framework — `@MockitoBean` et `@MockitoSpyBean`](https://docs.spring.io/spring-framework/reference/testing/annotations/integration-spring/annotation-mockitobean.html) — vérifié le 2026-10-03

- [Spring Boot — documentation](https://docs.spring.io/spring-boot/) — à vérifier pour la version du projet
- [Spring Security — documentation](https://docs.spring.io/spring-security/reference/) — à vérifier pour la version du projet
- [Claude Code — JetBrains](https://code.claude.com/docs/en/jetbrains) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-10-cas-usage.md#page-chapitre-10-cas-usage-java-spring-boot).

## Prochaine étape

Poursuivez avec **[Node.js & React](nodejs-react.md)**, la page suivante dans le menu.
