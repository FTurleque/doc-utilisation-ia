# Structure actuelle — Documentation IA

## Parcours

Le site est **Claude Code-first**. Les trois premiers chapitres historiques restent consacrés à GitHub Copilot comme référence ; le parcours Claude principal commence dans `chapitre-3b-claude-code-migration-copilot/` et se poursuit dans les chapitres génériques.

Toujours lire `mkdocs.yml` avant d'ajouter ou déplacer une page : la navigation réelle est plus fiable qu'une liste recopiée dans un skill.

## Dossiers principaux

| Dossier | Rôle |
|---|---|
| `chapitre-1-installation` | Installation Copilot — référence |
| `chapitre-2-parametrage` | Paramétrage Copilot — référence |
| `chapitre-3-cli-modes` | Modes Copilot — référence |
| `chapitre-3b-claude-code-migration-copilot` | Claude Code, architecture et migration |
| `chapitre-4-contexte` | Contexte, rules, skills, agents, hooks, MCP |
| `chapitre-5-prompt-engineering` | Prompt engineering Claude-first |
| `chapitre-6-machine-learning` | ML |
| `chapitre-7-rag` | RAG |
| `chapitre-8-deep-learning` | Deep Learning |
| `chapitre-9-bonnes-pratiques` | Bonnes pratiques |
| `chapitre-10-cas-usage` | Cas d'usage |
| `chapitre-11-troubleshooting` | Diagnostic |
| `chapitre-12-couts-gouvernance` | Coûts et gouvernance |
| `chapitre-13-outils-economies` | Outils, MCP et alternatives |
| `chapitre-14-veille-ia` | Veille |
| `chapitre-15-hacker-ia` | Cybersécurité et usages défensifs |
| `appendices` | FAQ, références, templates |
| `assets/templates` | Ressources copiables hors nav si nécessaire |

## Structure d'une page publiée

```markdown
# Titre

<span class="badge-intermediate">Intermédiaire</span>

Introduction courte.

---

## Section

Contenu.

### Sous-section

Détail.
```

Règles : H1 unique, niveaux non sautés, code avec langage, liens relatifs vérifiés, images avec alt text.

## Navigation

Une nouvelle page destinée à la lecture doit être positionnée dans `mkdocs.yml`. Les templates/assets peuvent rester hors navigation.

Ne force pas toutes les pages à suivre un modèle « IntelliJ vs VS Code » : Claude Code couvre aussi CLI, MCP, CI, settings et workflows indépendants de l'IDE.

## Validation

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```
