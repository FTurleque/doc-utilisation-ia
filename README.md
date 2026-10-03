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
- Annexe, en fin de menu : ressources générales, références GitHub Copilot, comparaison et migration
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
python scripts/sync-navigation.py
python scripts/validate-copilot-scope.py
python -m mkdocs build --strict
python scripts/validate-links.py
```

La CI de PR exécute les mêmes contrôles de progression, génération, chemins internes et ancres HTML.

Après un changement d'ordre dans `mkdocs.yml`, exécutez `python scripts/sync-navigation.py --write` pour réaligner les sections « Prochaine étape ». Les sommaires des chapitres doivent également suivre cet ordre. Tout contenu Copilot reste dans « Annexe » ; le parcours principal conserve uniquement des liens vers ces références. `validate-copilot-scope.py` vérifie cette séparation.

Pour vérifier le comportement des tables des matières, construisez le site puis servez `site/` avec `python -m http.server 8765 --directory site`. Dans un autre terminal disposant de Node.js, Playwright et Chromium, lancez `node scripts/validate-toc.cjs http://127.0.0.1:8765/`. Le script contrôle l'ordre des ancres, la sélection après chaque clic et la reprise du suivi au défilement, sur ordinateur et mobile, pour toutes les pages navigables. Les ressources externes sont bloquées afin de tester le sommaire hors ligne ; ce contrôle ne valide pas le rendu Mermaid/MathJax. `PLAYWRIGHT_CHROMIUM_EXECUTABLE` permet de choisir un Chromium déjà installé.

## Contribution

Toute modification passe par une branche et une Pull Request vers `main` : aucun push direct sur `main` n'est attendu dans le workflow du projet.

Consultez :

- `CONTRIBUTING.md` — workflow complet ;
- `MAINTENANCE_SCHEDULE.md` — veille mensuelle/trimestrielle ;
- `DEPLOYMENT.md` — validation et publication GitHub Pages ;
- `CONTRIBUTING-SCREENSHOTS.md` — captures d'écran.
