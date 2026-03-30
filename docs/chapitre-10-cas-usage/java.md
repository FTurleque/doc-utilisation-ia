# Java — Cas d'Usage

## Stack couverte

- **Langage** : Java 17 ou 21 (LTS)
- **Framework** : Spring Boot 3.x
- **Build** : Maven ou Gradle
- **Tests** : JUnit 5 + Mockito + AssertJ
- **IDE** : IntelliJ IDEA (recommandé) ou VS Code avec Java Extension Pack

---

## IntelliJ IDEA : l'IDE optimal pour Java

Avec Java, IntelliJ IDEA offre l'expérience Copilot la plus riche grâce au PSI (Program Structure Interface) :

- Analyse sémantique complète — Copilot voit la vraie structure du code, pas juste du texte
- Résolution des types génériques (`List<UserDTO>` comprise nativement)
- Navigation bean Spring — les `@Autowired` et `@Component` sont analysés
- Auto-import intelligent — les suggestions Copilot viennent avec les bons imports

---

## Structure de projet Spring Boot

```
mon-projet-spring/
├── .github/
│   ├── copilot-instructions.md
│   └── instructions/
│       ├── spring-components.instructions.md
│       └── tests.instructions.md
├── src/
│   ├── main/
│   │   └── java/com/example/monprojet/
│   │       ├── MonProjetApplication.java
│   │       ├── config/
│   │       ├── controller/
│   │       │   └── UserController.java
│   │       ├── service/
│   │       │   ├── UserService.java
│   │       │   └── UserServiceImpl.java
│   │       ├── repository/
│   │       │   └── UserRepository.java
│   │       ├── entity/
│   │       │   └── User.java
│   │       └── dto/
│   │           ├── CreateUserRequest.java
│   │           └── UserResponse.java
│   └── test/
│       └── java/com/example/monprojet/
│           ├── controller/
│           └── service/
├── pom.xml
└── application.yml
```

---

## Configuration Copilot pour Java/Spring

### `.github/copilot-instructions.md`

```markdown
---
applyTo: 'src/**/*.java'
---

# Conventions Java du projet

## Stack
- Java 21 (utiliser les features Java 21: records, text blocks, pattern matching)
- Spring Boot 3.2
- Spring Data JPA avec Hibernate
- MapStruct pour les mappings DTO ↔ Entity
- Validation: Jakarta Validation (@Valid, @NotNull, @Size, etc.)
- Tests: JUnit 5 + Mockito + AssertJ

## Conventions
- Entités JPA: annotées @Entity, @Table, utiliser Lombok @Data ou records pour les simples
- DTOs: utiliser des records Java pour les DTOs immuables
- Services: interface + implémentation (UserService + UserServiceImpl)
- Repositories: étendre JpaRepository<Entity, ID>
- Exceptions: créer des exceptions métier spécifiques (UserNotFoundException, etc.)

## Patterns interdits
- Pas de @Autowired sur les champs (utiliser injection par constructeur)
- Pas d'entités JPA retournées directement dans les controllers (utiliser des DTOs)
- Pas de logique métier dans les controllers
```

### `.github/instructions/spring-components.instructions.md`

```markdown
---
applyTo: 'src/main/java/**/controller/*.java'
---

## Pattern Controller Spring

- Annoter avec @RestController et @RequestMapping("/api/v1/resource")
- Utiliser @Valid sur les @RequestBody
- Retourner ResponseEntity<T> avec le status code explicite
- Swagger/OpenDoc: annoter avec @Operation et @ApiResponse

## Template de méthode

```java
@PostMapping
@Operation(summary = "Créer une ressource")
@ApiResponse(responseCode = "201", description = "Ressource créée")
@ApiResponse(responseCode = "400", description = "Données invalides")
public ResponseEntity<UserResponse> create(
    @Valid @RequestBody CreateUserRequest request
) {
    UserResponse response = userService.create(request);
    return ResponseEntity.status(HttpStatus.CREATED).body(response);
}
```
```

---

## Cas d'usage pratiques

### 1. Entité JPA avec Java 21

```java
// Entité JPA User avec Jakarta Persistence
// Champs: id (UUID généré auto), email (unique, non null), 
//         username, createdAt (auto), roles (Set<Role>)
// Utiliser Lombok @Builder et @NoArgsConstructor pour JPA
@Entity
@Table(name = "users")
public class User {
    // Copilot génère les champs avec les annotations correctes
```

### 2. Repository Spring Data avec requêtes custom

```java
// Repository Spring Data pour User
// Méthodes custom: findByEmail, findByUsernameContainingIgnoreCase,
// findAllByRolesContaining, findAllActiveUsersSince(LocalDateTime)
@Repository
public interface UserRepository extends JpaRepository<User, UUID> {
    // Copilot génère les signatures de méthodes Spring Data
```

### 3. Service avec logique métier

```java
// Implémentation du service User
// create: valider unicité email, hasher mot de passe, sauvegarder, retourner DTO
// getById: lancer UserNotFoundException si absent
// update: vérifier que l'utilisateur existe, mettre à jour les champs fournis
@Service
@Transactional
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final UserMapper userMapper;
    
    // Copilot génère les méthodes avec la logique appropriée
```

### 4. Tests JUnit 5 avec Mockito via Copilot Chat

```
Dans Copilot Chat (IntelliJ) :
"Génère les tests JUnit 5 + Mockito pour UserServiceImpl.create().
Utilise @ExtendWith(MockitoExtension.class).
Mock : UserRepository, PasswordEncoder, UserMapper.
Couvre :
- Création réussie : verify que save() est appelé, assertThat sur le retour
- Email déjà utilisé : when(repository.existsByEmail()).thenReturn(true) → UserAlreadyExistsException
- Utilise AssertJ pour les assertions"
```

---

## Records Java 21 pour les DTOs

Les records Java sont idéaux pour les DTOs — Copilot les génère facilement :

```java
// DTO de réponse pour User (record Java)
// Exposer: id, email, username, createdAt, rôles
// Ne pas exposer: mot de passe, date de dernière connexion
public record UserResponse(
    // Copilot complète les champs avec les bons types
) {}

// DTO de création avec validation Jakarta
// email: @Email @NotBlank
// password: @NotBlank @Size(min=8)  
// username: @NotBlank @Size(min=2, max=50) @Pattern(alnum + underscore)
public record CreateUserRequest(
    // Copilot génère avec les annotations de validation
) {}
```

---

## Configuration IDE

=== ":simple-intellijidea: IntelliJ IDEA"
    Paramètres recommandés pour maximiser l'efficacité Copilot + Java :
    
    1. **Settings → Editor → Code Style → Java** : configurez selon les conventions du projet
    2. **Settings → Build → Compiler** : activez "Build project automatically"
    3. **Settings → GitHub Copilot** : conservez le delay à 300ms pour Java (analyse PSI légèrement plus lente)
    4. Ouvrez les fichiers liés dans des onglets : `User.java`, `UserService.java`, `UserRepository.java`

=== ":material-microsoft-visual-studio-code: VS Code"
    ```json
    // .vscode/settings.json
    {
        "java.configuration.runtimes": [
            {
                "name": "JavaSE-21",
                "path": "/path/to/jdk21",
                "default": true
            }
        ],
        "java.format.settings.profile": "GoogleStyle",
        "java.saveActions.organizeImports": true,
        "github.copilot.enable": {
            "java": true
        }
    }
    ```
    
    Extensions Java requises :
    - Extension Pack for Java (`vscjava.vscode-java-pack`)
    - Spring Boot Extension Pack (`vmware.vscode-boot-dev-pack`)

---

## Utiliser Copilot pour générer la documentation Javadoc

```java
/**
 * [Positionnez le curseur ici et demandez à Copilot de générer le Javadoc]
 * Ou utilisez Copilot Chat : "Ajoute le Javadoc complet pour cette méthode"
 */
public UserResponse create(CreateUserRequest request) {
```

---

## Workflow Maven avec Copilot

```xml
<!-- pom.xml : Copilot peut vous aider à trouver les bonnes dépendances -->
<!-- Dans un commentaire XML, décrivez ce dont vous avez besoin : -->
<!-- Dépendance pour JWT authentication avec Spring Security, version récente -->
<dependency>
    <!-- Copilot complète avec le bon groupId/artifactId/version -->
</dependency>
```

---

## Prochaine étape

**[Java & Spring Boot](java-spring-boot.md)** : maîtriser les patterns Spring Boot pour les backends enterprise et comment Copilot génère des services, controllers et tests de haute qualité.

Concepts clés couverts :

- **Custom Instructions pour Spring Boot** — Configuration Copilot par couche
- **Pattern Service complet** — Service class optimisée pour la génération
- **Entités JPA annotées** — Maximiser le contexte pour Copilot
- **Tests avec Copilot Chat** — Générer tests unitaires complets avec Mockito
