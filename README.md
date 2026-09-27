# Documentation IA

Documentation personnelle et pratique sur l'utilisation de l'IA pour le développement, publiée avec MkDocs Material.

## Orientation du projet

Le parcours principal du dépôt est désormais centré sur **Claude Code** : installation, configuration, contexte, prompt engineering, automatisation, MCP, sécurité, coûts et workflows de développement.

La documentation **GitHub Copilot est volontairement conservée**. Elle reste utile :

- comme référence pour les environnements qui utilisent encore Copilot ;
- pour comparer les deux écosystèmes ;
- pour documenter une migration progressive ou un fonctionnement hybride ;
- si l'offre ou la tarification de Copilot redevient intéressante à l'avenir.

Aucun contenu Copilot ne doit donc être supprimé uniquement parce que Claude Code devient l'outil principal.

## Parcours recommandés

- **Découvrir ou installer Claude Code** : `docs/chapitre-3b-claude-code-migration-copilot/`
- **Migrer depuis GitHub Copilot** : comparaison, migration pas à pas et checklist 30/60/90 jours dans le même chapitre
- **Conserver Copilot** : les chapitres historiques d'installation, paramétrage et personnalisation restent disponibles
- **Approfondir les pratiques transverses** : contexte, prompt engineering, sécurité, coûts, MCP, RAG, ML et cas d'usage

## Instructions pour les assistants IA

- `CLAUDE.md` : instructions principales pour Claude Code
- `AGENTS.md` : règles communes aux assistants et agents
- `.github/copilot-instructions.md` : instructions GitHub Copilot conservées
- `.github/agents/`, `.github/instructions/`, `.github/prompts/` : configurations Copilot historiques conservées et maintenues

## Lancer le site en local

### Prérequis

- Python 3.11+ recommandé
- Sous Windows, le lanceur Python `py` est utilisé dans les exemples

### Installation des dépendances

Depuis la racine du projet :

```powershell
py -m pip install --upgrade pip
py -m pip install -r requirements.txt
```

Si `requirements.txt` n'est pas disponible dans votre environnement, l'installation minimale reste :

```powershell
py -m pip install mkdocs-material
```

### Serveur de développement

```powershell
py -m mkdocs serve
```

Lancez la commande depuis le dossier contenant `mkdocs.yml`, puis ouvrez l'URL indiquée dans le terminal, généralement <http://127.0.0.1:8000>.

### Build statique

```powershell
py -m mkdocs build
```

Le site généré est écrit dans `site/`.

## Dépannage rapide sous Windows

Si `pip` ou `mkdocs` n'est pas trouvé dans le `PATH`, utilisez les modules Python explicitement :

```powershell
py --version
py -m pip --version
py -m mkdocs --version
```

Puis lancez les commandes avec `py -m ...` plutôt qu'avec les exécutables `pip` ou `mkdocs` directement.

## Contribution

Toute modification doit être réalisée sur une branche puis proposée via Pull Request vers `main`. Consultez `CONTRIBUTING.md` pour le workflow complet et exécutez `py -m mkdocs build` avant de considérer un lot documentaire terminé.
