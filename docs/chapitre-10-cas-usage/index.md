# Cas d'Usage par Technologie

GitHub Copilot s'adapte à chaque écosystème technologique. Ce chapitre présente des configurations et workflows optimisés pour les stacks les plus courants, avec des exemples concrets pour IntelliJ et VS Code.

---

## 🎯 Choisir ton Écosystème

Commencez par cette **comparaison d'efficacité** pour sélectionner la meilleure stack avec Copilot :

<div class="grid cards" markdown>

-   **Comparaison Détaillée**
    
    ---
    
    Tableau comparatif : type safety, accuracy, tests, IDE, productivité par stack.
    
    [Consulter la comparaison →](comparaison-ecosystemes.md)

</div>

---

## Cas d'Usage Spécialisés

<div class="grid cards" markdown>

-   :simple-java: **Java & Spring Boot**
    
    ---
    
    Enterprise backend, microservices, IntelliJ IDEA. Entities JPA, Services, Controllers, Tests.
    
    [Expert guide →](java-spring-boot.md)

-   :simple-nodedotjs: **Node.js & Express**
    
    ---
    
    API rapide, TypeScript, Prisma ORM, middleware patterns, intégration tests avec Supertest.
    
    [Guide complet →](nodejs-express.md)

-   :simple-react: **React 19 & TypeScript**
    
    ---
    
    Frontend, composants, hooks, Server Components (Next.js), Tailwind CSS, RTL testing.
    
    [Guide complet →](react-typescript.md)

-   :simple-python: **Python & FastAPI**
    
    ---
    
    API Python-first, Pydantic validation, async native, deployment lightweight.
    
    [Voir le guide →](python.md)

</div>

---

## Principes Communs à Tous les Projets

Quel que soit le langage/framework, ces principes optimisent la qualité des suggestions Copilot :

| Principe | Impact | Implémentation |
|----------|--------|-----------------|
| **Types explicites** | ⭐⭐⭐⭐⭐ | TypeScript, `type User = {}`, `def func() -> User:` |
| **Noms descriptifs** | ⭐⭐⭐⭐⭐ | `activeUserList` > `data`; `getUserById()` > `getUser()` |
| **Custom Instructions** | ⭐⭐⭐⭐⭐ | `.github/copilot-instructions.md` avec conventions du projet |
| **Commentaires de fonction** | ⭐⭐⭐⭐ | Docstrings/JSDoc AVANT implémentation — guide génération |
| **Fichiers ouverts en tab** | ⭐⭐⭐ | Copilot scanne les tabs ouverts pour enrichir contexte |
| **Conventions cohérentes** | ⭐⭐⭐ | Copilot apprend et réplique le style du projet |

---

## Ressources du Chapitre

- [Diagrammes Architecture](comparaison-ecosystemes.md#matrice-decision-choisir-ton-ecosysteme) — Matrice décision pour choisir stack
- [Best Practices Universelles](../chapitre-9-bonnes-pratiques/index.md) — Patterns applicables à tous
- [Installation IDE](../chapitre-1-installation/index.md) — Setup initial par technologie

---

## Choisir son IDE par technologie

| Technologie | IDE recommandé | Raison |
|-------------|---------------|--------|
| Java / Kotlin | **IntelliJ IDEA** | PSI natif, refactoring avancé, Maven/Gradle intégré |
| JavaScript / TypeScript | **VS Code** | TS Language Service natif, écosystème extensions |
| Python | **VS Code** (Pylance) ou **PyCharm** | Pylance = meilleure inférence type que PyCharm |
| React / Vue / Angular (SPA) | **VS Code** | Extensions JSX/TSX, CSS modules, React DevTools |
| Spring Boot | **IntelliJ IDEA** | Bean navigation, auto-configuration, run configs |
| FastAPI / Django | **VS Code** ou **PyCharm** | Les deux sont excellents |
| Fullstack (Java + React) | **IntelliJ ou VS Code** | IntelliJ Ultimate gère les deux ; VS Code également |

---

## Prochaines étapes

- [Appendices](../appendices/raccourcis-clavier.md) — Référence complète des raccourcis et templates
