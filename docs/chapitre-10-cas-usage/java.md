# Java — Cas d'usage avec Claude Code

Claude Code fonctionne bien sur les projets Java lorsque le dépôt expose son **JDK réel**, son wrapper Maven/Gradle, ses tests et ses conventions. Ne partez pas d'une version Java ou Spring écrite dans cette page : lisez le projet.

---

## 1. Commencer par la configuration réelle

Claude doit inspecter en priorité :

```text
pom.xml / build.gradle(.kts)
mvnw / gradlew
.tool-versions / .sdkmanrc / Dockerfile
src/main/java/
src/test/java/
```

Demande :

```text
Avant de modifier ce projet Java :
- identifie la version JDK et le build tool ;
- trouve les conventions de package ;
- trouve un service et un test représentatifs ;
- donne les commandes de test et build réellement disponibles.
```

---

## 2. `CLAUDE.md` Java minimal

```markdown
## Java
- Use the project Maven/Gradle wrapper.
- Run targeted tests before the full suite.
- Follow existing package and dependency-injection patterns.
- Do not introduce Lombok, MapStruct or another library unless already used or explicitly requested.
- Preserve public API compatibility unless the task says otherwise.
```

Ajoutez la commande exacte, par exemple `./mvnw test` ou `./gradlew test`, d'après le dépôt.

---

## 3. Pattern : corriger un service

```text
Le bug se trouve dans `OrderService`.
Trouve d'abord le test le plus proche et reproduis le problème.
Compare avec les services voisins pour respecter les patterns du projet.
Applique le correctif minimal puis exécute le test ciblé.
```

Claude doit utiliser les types, exceptions et abstractions déjà présents plutôt que générer automatiquement une nouvelle couche.

---

## 4. Pattern : refactoring Java

Pour un refactor de signature ou de package :

```text
1. trouve tous les appelants ;
2. identifie les APIs publiques ;
3. liste les tests impactés ;
4. propose un ordre de migration buildable ;
5. modifie une étape ;
6. compile/teste avant la suivante.
```

Sur un projet JVM volumineux, l'intégration JetBrains peut compléter le travail de Claude avec les capacités de navigation/refactoring de l'IDE.

---

## 5. DTO, records et langage moderne

N'utilisez un record, sealed class ou autre feature moderne que si la version JDK du projet le permet et si le pattern correspond au code existant.

Exemple :

```java
public record CreateUserRequest(
    String email,
    String displayName
) {}
```

La documentation doit éviter « utilisez Java 21 » comme règle universelle : un service maintenu sur une autre LTS peut avoir de bonnes raisons de rester ainsi.

Un record fournit des champs finaux et des méthodes générées, mais ne rend pas profondément immuables les objets qu'il référence. Si un composant contient une collection mutable, vérifiez les copies défensives nécessaires. Son `toString()` expose les composants : évitez d'y placer un secret qui pourrait être journalisé.

---

## 6. Tests

Claude peut générer des tests à partir du style existant :

```text
Ajoute des tests pour `PricingService.calculate`.
Utilise le framework, les assertions et les fixtures déjà employés dans ce module.
Couvre le cas nominal, les bornes métier et les erreurs observables.
Exécute uniquement cette classe de test d'abord.
```

Évitez d'imposer Mockito, AssertJ ou Testcontainers si le projet utilise autre chose.

---

## 7. Build et diagnostic

Lorsque le build échoue :

```text
Exécute le wrapper du projet avec le test/module ciblé.
Analyse la première cause racine, pas les erreurs en cascade.
Corrige-la puis relance la même commande.
```

Stockez les logs très longs dans un fichier et recherchez les premières erreurs utiles plutôt que d'injecter toute la sortie dans le contexte.

---

## 8. Dépendances

Avant d'ajouter une dépendance Java :

- vérifier si une dépendance existante couvre le besoin ;
- vérifier la documentation officielle actuelle ;
- respecter le BOM/dependency management du projet ;
- exécuter les tests et l'analyse de dépendances si disponible.

---

## Sources

- [Java — contrats des record classes](https://docs.oracle.com/en/java/javase/25/language/records.html) — vérifié le 2026-10-03 ; adapter au JDK du projet

- [Claude Code — JetBrains](https://code.claude.com/docs/en/jetbrains) — consulté le 2026-09-28
- [Claude Code — common workflows](https://code.claude.com/docs/en/common-workflows) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-10-cas-usage.md#page-chapitre-10-cas-usage-java).

## Prochaine étape

Poursuivez avec **[Java & Spring Boot](java-spring-boot.md)**, la page suivante dans le menu.
