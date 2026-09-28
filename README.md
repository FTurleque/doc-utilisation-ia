# Documentation IA

Documentation personnelle et pratique sur l'utilisation de l'IA pour le développement, publiée avec MkDocs Material.

## Orientation du projet

Le parcours principal est **Claude Code** : installation, configuration, contexte, prompt engineering, agents, skills, hooks, MCP, sécurité, coûts et workflows de développement.

La documentation **GitHub Copilot est volontairement conservée** :

- référence pour les environnements qui l'utilisent encore ;
- comparaison avec Claude Code ;
- migration progressive ou fonctionnement hybride ;
- option de retour si son offre/tarification redevient pertinente.

Aucun contenu Copilot n'est supprimé uniquement parce que Claude Code est prioritaire.

## Parcours

- Claude Code : `docs/chapitre-3b-claude-code-migration-copilot/`
- Contexte, rules, skills, agents, hooks et MCP : `docs/chapitre-4-contexte/`
- GitHub Copilot — référence : chapitres 1 à 3 et pages explicitement Copilot
- Pratiques transverses : prompt engineering, ML/RAG, sécurité, coûts, outils et cas d'usage

## Configuration des assistants

### Claude Code

- `CLAUDE.md` — instructions principales
- `AGENTS.md` — règles communes
- `.claude/settings.json` — réglages partagés
- `.claude/rules/` — règles ciblées
- `.claude/agents/` — subagents du dépôt
- `.claude/skills/` — skills réutilisables

### GitHub Copilot

- `.github/copilot-instructions.md`
- `.github/instructions/`
- `.github/prompts/`
- `.github/agents/`
- `.github/skills/`
- `.github/hooks/`

Ces deux ensembles sont maintenus séparément : ils ne partagent pas le même contrat de configuration.

## Installation locale

```bash
python -m venv .venv
```

Activez ensuite le venv selon votre système puis :

```bash
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python -m mkdocs serve
```

Sous Windows, `py -m` peut être utilisé si le launcher Python est la commande disponible.

## Validation

Avant une Pull Request :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```

La CI de PR exécute les mêmes contrôles de génération, chemins internes et ancres HTML.

## Contribution

Toute modification passe par une branche et une Pull Request vers `main` : aucun push direct sur `main` n'est attendu dans le workflow du projet.

Consultez :

- `CONTRIBUTING.md` — workflow complet ;
- `MAINTENANCE_SCHEDULE.md` — veille mensuelle/trimestrielle ;
- `DEPLOYMENT.md` — validation et publication GitHub Pages ;
- `CONTRIBUTING-SCREENSHOTS.md` — captures d'écran.
