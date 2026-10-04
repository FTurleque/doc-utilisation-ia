# Python & FastAPI avec Claude Code

<span class="badge-intermediate">Intermédiaire</span>

Claude Code doit travailler dans **l'environnement Python réel du projet**. Les versions de Python, FastAPI, Pydantic, SQLAlchemy, pytest ou Ruff viennent du `pyproject.toml`, du lockfile et de l'image de développement — pas de cette page.

---

## 1. Inspecter l'environnement

```text
Lis pyproject.toml / requirements / lockfile.
Identifie :
- version Python ;
- gestionnaire d'environnement ;
- FastAPI et Pydantic ;
- accès DB ;
- sync/async ;
- migrations ;
- tests, lint, typecheck ;
- commandes de démarrage.
```

Claude doit utiliser l'environnement virtuel ou le runner du projet.

---

## 2. `CLAUDE.md` Python minimal

```markdown
## Python API
- Use the project virtual environment/package manager.
- Run `pytest` for targeted tests before the full suite.
- Keep type annotations on public boundaries.
- Validate external input with the project's Pydantic conventions.
- Do not convert sync code to async without a concrete I/O reason.
```

Documentez les commandes exactes réellement présentes.

---

## 3. Route FastAPI

Exemple simple :

```python
@router.post("/users", response_model=UserResponse, status_code=201)
async def create_user(
    payload: UserCreate,
    service: UserService = Depends(get_user_service),
) -> UserResponse:
    return await service.create(payload)
```

La route doit rester une frontière HTTP : validation, auth, mapping et délégation selon les conventions du projet.

Ne transformez pas toute erreur métier en `HTTPException` au cœur du domaine si le projet possède une couche de mapping globale.

---

## 4. Pydantic : vérifier la version

Pydantic a connu des changements d'API importants. Avant de copier un exemple :

```text
Lis la version Pydantic installée et les modèles voisins.
Utilise la syntaxe et les validators déjà adoptés.
```

Ne mélangez pas les recettes historiques de versions différentes (`Config`, `model_config`, anciens decorators, etc.).

Pour **Pydantic 2**, utilisez notamment `model_dump()` pour sérialiser en dictionnaire et `model_validate()` pour valider des données. La lecture d'attributs ORM demande `from_attributes=True` dans `model_config` ; elle ne remplace pas la gestion du chargement des relations en base. Une migration de validators doit aussi vérifier le comportement, pas uniquement renommer les méthodes.

---

## 5. SQLAlchemy

Pour un changement DB :

- vérifier le style ORM réellement utilisé ;
- respecter sync/async ;
- gérer la durée de vie des sessions ;
- ajouter une migration si le schéma change ;
- tester rollback/contraintes lorsque pertinent.

```text
Ajoute cette requête en suivant le repository existant.
Vérifie qu'elle ne déclenche pas de N+1 et que les filtres sont indexables si la table est volumineuse.
Ajoute le test d'intégration le plus proche.
```

---

## 6. Async : ne pas l'ajouter par défaut

Une `AsyncSession` SQLAlchemy représente une transaction avec un état mutable : ne la partagez pas entre tâches concurrentes, notamment dans `asyncio.gather()`. Utilisez une session par tâche, avec une durée de vie explicite ; vérifiez aussi les relations qui déclencheraient des I/O implicites lors de la sérialisation.

`async def` est utile pour des opérations I/O compatibles async. Il n'accélère pas automatiquement du CPU-bound.

Claude doit identifier :

- driver DB ;
- client HTTP ;
- bibliothèques bloquantes ;
- threadpool éventuel.

Ne mélangez pas clients sync et async sans comprendre la conséquence sur la boucle événementielle.

FastAPI exécute ses routes et dépendances déclarées avec `def` dans un threadpool. En revanche, une fonction utilitaire synchrone appelée directement depuis une route `async def` reste un appel bloquant dans cette route : elle n'est pas automatiquement déportée. Choisissez un client async ou une exécution explicitement adaptée aux I/O bloquantes ; pour un entraînement CPU/GPU long, utilisez un worker ou un job séparé.

---

## 7. Tests pytest

```text
Ajoute un test de régression pour cet endpoint.
Réutilise les fixtures app/client/db existantes.
Couvre le succès et les erreurs métier pertinentes.
Exécute ce test seul d'abord.
```

Utilisez `parametrize` lorsqu'il réduit réellement la duplication et rend les cas plus lisibles.

---

## 8. Typage

Les type hints servent de contrat et améliorent les refactors :

```python
async def find_user(user_id: UUID) -> User | None:
    ...
```

Le niveau de strictness doit suivre la configuration mypy/Pyright du projet. N'imposez pas un nouveau type checker sans besoin.

---

## 9. Sécurité API

À vérifier systématiquement :

- validation des inputs ;
- authentification et autorisation ;
- secrets ;
- erreurs non divulguées ;
- uploads et tailles de payload ;
- timeouts externes ;
- CORS selon politique ;
- dépendances.

Pour les mots de passe et tokens, utilisez les bibliothèques et mécanismes de sécurité établis par le projet et la documentation officielle actuelle.

---

## 10. Dépendances et packaging

Claude doit modifier les dépendances via l'outil du projet (pip/uv/Poetry/PDM/etc.) afin de maintenir le lockfile cohérent.

Après ajout :

```text
- import réel ;
- tests ;
- lint/typecheck ;
- packaging/build si le projet en a un.
```

---

## 11. FastAPI docs et contrats

FastAPI génère OpenAPI à partir des routes et modèles. Si l'API publique change :

- vérifier le schéma généré ;
- mettre à jour les tests contractuels ;
- documenter breaking change si nécessaire.

---

## Sources

- [FastAPI — routes, dépendances et fonctions utilitaires sync/async](https://fastapi.tiangolo.com/async/) — vérifié le 2026-10-03
- [Pydantic — guide de migration vers la version 2](https://docs.pydantic.dev/latest/migration/) — vérifié le 2026-10-03
- [SQLAlchemy — sessions async et tâches concurrentes](https://docs.sqlalchemy.org/en/20/orm/extensions/asyncio.html#using-asyncsession-with-concurrent-tasks) — vérifié le 2026-10-03 ; choisir la documentation correspondant à la version installée

- [FastAPI — documentation](https://fastapi.tiangolo.com/) — vérifier la version du projet
- [Pydantic — documentation](https://docs.pydantic.dev/) — vérifier la version installée
- [SQLAlchemy — documentation](https://docs.sqlalchemy.org/) — vérifier la version installée
- [Claude Code — VS Code](https://code.claude.com/docs/en/vs-code) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-10-cas-usage.md#page-chapitre-10-cas-usage-python).

## Prochaine étape

Poursuivez avec **[Troubleshooting — Accueil](../chapitre-11-troubleshooting/index.md)**, la page suivante dans le menu.
