# Cas d'usage Claude Code par technologie

Claude Code peut travailler sur des projets Java, Node.js, React, Python et d'autres stacks dès lors que le dépôt expose clairement sa structure, ses commandes et ses critères de validation. Ce chapitre montre comment adapter le workflow **Explore → Plan → Implement → Verify** aux principaux écosystèmes du dépôt.


---

## Choisir son guide

<div class="grid cards" markdown>

- **[Comparaison des écosystèmes](comparaison-ecosystemes.md)**

    Comparer stacks et IDE selon build, tests, exploitation et compétences — sans score IA arbitraire.

- :simple-java: **[Java](java.md)**

    Maven/Gradle, tests, refactoring, APIs et conventions JVM.

- :simple-java: **[Java & Spring Boot](java-spring-boot.md)**

    Controllers, services, repositories, JPA, configuration et tests d'intégration.

- **[Node.js & React](nodejs-react.md)**

    Workflow full-stack et séparation du contexte frontend/backend.

- :simple-nodedotjs: **[Node.js & Express](nodejs-express.md)**

    TypeScript, validation, middlewares, tests et dépendances npm.

- :simple-react: **[React & TypeScript](react-typescript.md)**

    Composants, hooks, rendering, tests et contrats frontend.

- :simple-python: **[Python & FastAPI](python.md)**

    Pydantic, async, pytest, packaging et APIs Python.

</div>

---

## Principes communs

Quel que soit le langage :

1. **lire la configuration réelle du projet** avant de proposer une API ou une version ;
2. **réutiliser un pattern voisin** plutôt que générer une architecture théorique ;
3. **faire un plan** pour les changements multi-fichiers ;
4. **tester au niveau le plus ciblé possible**, puis élargir ;
5. **vérifier la documentation officielle actuelle** pour toute API externe ou migration de version ;
6. **relire le diff** avant commit.

---

## Instructions projet

Exemple racine :

```markdown
# CLAUDE.md

## Repository
- `backend/`: API
- `frontend/`: UI

## Commands
- Backend tests: `...`
- Frontend tests: `...`
- Full build: `...`

## Rules
- Preserve public APIs unless requested.
- Run relevant tests before finishing.
- Never add dependencies without explaining why.
```

Dans un monorepo, ajoutez des `CLAUDE.md` locaux ou des rules ciblées lorsque les commandes et conventions diffèrent réellement.

---

## Choisir l'IDE

Claude Code s'intègre à VS Code et JetBrains. Le choix d'IDE doit rester guidé par la stack, les outils de navigation/refactoring et les habitudes de l'équipe.

| Contexte | Choix souvent naturel |
|---|---|
| Java / Kotlin / Spring | IntelliJ IDEA / IDE JetBrains |
| TypeScript / React / Node | VS Code ou IDE JetBrains adapté |
| Python | VS Code ou PyCharm |
| Polyglotte | IDE principal + CLI Claude à la racine du repo |

Ce tableau décrit des affinités, pas des obligations.

Le panneau VS Code fournit une CLI privée pour son interface, mais n'installe pas `claude` dans le PATH du terminal. Pour les commandes CLI de ces guides, installez la CLI standalone et utilisez le même environnement que le build (Windows, WSL ou conteneur). Distinguez une panne de cette CLI d'une panne du panneau IDE.

---

## Validation par stack

| Stack | Contrôles typiques |
|---|---|
| Java | tests Maven/Gradle, compilation, analyse statique |
| Node/TypeScript | tests, typecheck, lint, build |
| React | tests composants, typecheck, build, éventuellement E2E |
| Python/FastAPI | pytest, lint/typecheck, tests HTTP, packaging |

La commande exacte vient du dépôt, pas de cette documentation.

---

## Dépendances et versions

Ne demandez pas à Claude d'utiliser « la dernière version » sans vérification. Le workflow correct :

```text
1. Lis la version installée dans le projet.
2. Vérifie la documentation/changelog officiel actuel si une migration est demandée.
3. Identifie les breaking changes pertinents.
4. Modifie code + lockfile.
5. Exécute tests et build.
```

---

## Sources

- [Claude Code — extension VS Code et CLI standalone](https://code.claude.com/docs/en/vs-code#vs-code-extension-vs-claude-code-cli) — vérifié le 2026-10-03

- [Claude Code — VS Code](https://code.claude.com/docs/en/vs-code) — consulté le 2026-09-28
- [Claude Code — JetBrains](https://code.claude.com/docs/en/jetbrains) — consulté le 2026-09-28
- [Anthropic — Building effective agents](https://www.anthropic.com/engineering/building-effective-agents) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-10-cas-usage.md#page-chapitre-10-cas-usage-index).

## Prochaine étape

Poursuivez avec **[Comparaison Écosystèmes](comparaison-ecosystemes.md)**, la page suivante dans le menu.
