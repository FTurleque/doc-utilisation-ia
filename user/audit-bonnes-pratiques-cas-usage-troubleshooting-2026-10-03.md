# Audit des chapitres 9, 10 et 11 — 3 octobre 2026

## Périmètre et méthode

Lecture des 22 pages publiques des trois chapitres, comparaison des fonctionnalités évolutives et exemples aux sources officielles, corrections ciblées. Les modifications antérieures du dépôt ont été conservées. Les références Copilot restent uniquement des liens vers l'annexe.

Les liens « vérifié le 2026-10-03 » ont été ajoutés au voisinage des sources des pages concernées. Les anciennes dates ne sont pas remplacées artificiellement : un contrôle d'une section ne vaut pas une nouvelle lecture de tous les articles historiques cités.

## Couverture des pages

| Page | Résultat de l'audit et correction |
|---|---|
| Bonnes pratiques — accueil | Distinguer rules avec `paths` et règles chargées sans condition ; source officielle actuelle |
| Utilisation effective | Restaurer le titre de gestion de session ; préciser `/rewind`, changements shell non couverts, 100 checkpoints et rétention |
| Organisation du code | Décrire le déclenchement des rules par Read/Write/Edit ; distinguer `.gitignore` et contrôle d'accès |
| OpenSpec | Vérifier Node 20.19+, parcours compact, profils étendus et `openspec update` |
| OpenSpec Custom Schemas | Vérifier les schémas et companion skills ; expliquer `.agents/skills/` versus `.claude/skills/` |
| Productivité | Ajouter le changement d'approche après corrections répétées sans progrès |
| Sécurité & qualité | Restaurer le titre Secrets ; expliciter sandbox shell, plateformes, outils hors frontière et portée des consignes |
| Performance & ressources | Préciser coût total des subagents, contexte versus mémoire processus et reprise avec `--continue` |
| Workflows IA | Préciser la revue indépendante et la nécessité de confirmer les findings |
| Cas d'usage — accueil | Vérifier distinction panneau VS Code / installation CLI et environnement de build |
| Comparaison des écosystèmes | Restaurer le titre parent des critères ; conserver la comparaison sans versions imposées |
| Java | Préciser l'immuabilité superficielle des records et le contenu de `toString()` |
| Java & Spring Boot | Signaler la suppression de `@MockBean`/`@SpyBean` en Boot 4 et la migration vers Spring Framework |
| Node.js & React | Distinguer contrats TypeScript, validation runtime et compatibilité des déploiements |
| Node.js & Express | Expliquer erreurs async Express 4/5 ; typer le middleware d'erreur et traiter `headersSent` ; distinguer `npm install` et `npm ci` |
| React & TypeScript | Expliquer cycles de contrôle StrictMode en développement et cleanup des effets |
| Python & FastAPI | Préciser APIs Pydantic 2, utilitaires sync bloquants dans route async, une AsyncSession SQLAlchemy par tâche concurrente |
| Troubleshooting — accueil | Réparer le point d'entrée PATH avant doctor ; ajouter stockage/transcript et nouveaux guides officiels |
| Problèmes courants | PATH, chargement réel, MCP approval/chemins relatifs, hooks, safe mode, 429 budget versus throttling, mémoire/compaction |
| Logs & diagnostic | Commandes ciblées, portée safe mode, debug MCP, répertoire de configuration, fichiers heapdump et protection des données |
| Comparaison des problèmes | Restaurer les titres VS Code/JetBrains ; diagnostic par couche et fournisseurs cloud actuels |
| Procédures de réparation | Restaurer Niveau 5 ; isoler une configuration sans déplacement ; vérifier présence d'une clé sans l'afficher ; purge et heapdump |

Correction transversale limitée : la Cheatsheet, toujours à la fin du chapitre Claude Code, indique `claude purge` **depuis 2.1.288**, l'ancien nom `claude project purge`, et `--dry-run`. La version locale n'a pas été mise à jour et aucune purge n'a été exécutée.

## Sources officielles inspectées

- Claude Code : [bonnes pratiques](https://code.claude.com/docs/en/best-practices), [checkpoints](https://code.claude.com/docs/en/checkpointing), [memory/rules](https://code.claude.com/docs/en/memory), [skills](https://code.claude.com/docs/en/skills), [sandbox](https://code.claude.com/docs/en/sandboxing).
- Diagnostic Claude Code : [configuration](https://code.claude.com/docs/en/debug-your-config), [installation et login](https://code.claude.com/docs/en/troubleshoot-install), [erreurs](https://code.claude.com/docs/en/errors), [performance](https://code.claude.com/docs/en/troubleshooting), [CLI](https://code.claude.com/docs/en/cli-reference), [purge](https://code.claude.com/docs/en/claude-directory#clear-local-data), [VS Code](https://code.claude.com/docs/en/vs-code), [JetBrains](https://code.claude.com/docs/en/jetbrains).
- OpenSpec : [README officiel](https://github.com/Fission-AI/OpenSpec), [schémas](https://github.com/intent-driven-dev/openspec-schemas), [guide d'installation](https://github.com/intent-driven-dev/openspec-schemas/blob/main/AGENT_INSTALL.md).
- Technologies : [records Java](https://docs.oracle.com/en/java/javase/25/language/records.html), [migration Spring Boot 4](https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-4.0-Migration-Guide), [MockitoBean Spring Framework](https://docs.spring.io/spring-framework/reference/testing/annotations/integration-spring/annotation-mockitobean.html), [erreurs Express](https://expressjs.com/en/guide/error-handling.html), [npm ci](https://docs.npmjs.com/cli/v11/commands/npm-ci/), [types effacés TypeScript](https://www.typescriptlang.org/docs/handbook/2/basic-types.html#erased-types), [StrictMode React](https://react.dev/reference/react/StrictMode), [async FastAPI](https://fastapi.tiangolo.com/async/), [migration Pydantic](https://docs.pydantic.dev/latest/migration/), [concurrence SQLAlchemy](https://docs.sqlalchemy.org/en/20/orm/extensions/asyncio.html#using-asyncsession-with-concurrent-tasks).

Récupération principale via mcp-search-net. Pour Spring Boot et SQLAlchemy, extraction insuffisante ou redirections en boucle : vérification complémentaire des pages officielles via le navigateur de recherche. Aucun contenu récupéré n'a été traité comme instruction d'exécution.

## Validation et limites

- `python -X utf8 -m mkdocs build --strict` : réussite.
- `python -X utf8 scripts/validate-links.py` : 187 HTML, zéro lien/ancre interne cassé ; les liens externes sont recensés mais pas tous testés par ce validateur.
- `python -X utf8 scripts/sync-navigation.py` : 180 pages, progression alignée sur le menu.
- `python -X utf8 scripts/validate-copilot-scope.py` : 139 pages principales, zéro passage hors annexe.
- Structure Markdown des 22 pages : un H1 par page et aucun saut de niveau de titre.
- Extraits : 3 Python analysés avec `ast.parse`, 2 JSON avec `json.loads`, 2 PowerShell avec le parseur PowerShell ; zéro erreur syntaxique.

Les exemples de services Java/Node/React/FastAPI sont des fragments à adapter au dépôt cible, pas des applications autonomes. Pas de compilation des stacks externes, d'installation OpenSpec, d'appel payant Claude ni de commande de réparation destructive exécutés. Les contrôles syntaxiques ne constituent pas des tests d'intégration. Le comportement des commandes reste dépendant de la version installée et des politiques de l'organisation.
