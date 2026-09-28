# Guide de contribution

Ce dépôt publie une documentation MkDocs **Claude Code-first** tout en conservant GitHub Copilot comme référence, compatibilité et solution alternative.

## Règle fondamentale

**Ne poussez jamais directement sur `main`.** Toute modification passe par une branche dédiée et une Pull Request vers `main`.

Cette règle vaut aussi pour les scripts, les agents IA et les automatisations : aucun outil ne doit merger ou pousser directement vers `main` sans action humaine explicite.

## Branches

| Préfixe | Usage | Exemple |
|---|---|---|
| `feat/` | Nouvelle fonctionnalité ou nouveau parcours | `feat/claude-skill-audit` |
| `docs/` | Ajout ou amélioration documentaire | `docs/actualiser-mcp` |
| `fix/` | Correction ciblée | `fix/lien-casse` |
| `chore/` | Maintenance, CI ou configuration | `chore/validation-mkdocs` |

Avant de travailler :

```bash
git fetch origin
git switch main
git pull --ff-only origin main
git switch -c docs/mon-changement
```

Si vous travaillez déjà sur une branche existante, synchronisez-la avec `main` selon la stratégie de votre équipe (rebase ou merge), sans pousser directement sur `main`.

## Workflow de contribution

1. **Lire les instructions du dépôt** : `CLAUDE.md` et `AGENTS.md`. Si vous utilisez GitHub Copilot, lire aussi `.github/copilot-instructions.md`.
2. **Identifier la portée** : page publiée, configuration IA, template, script ou CI.
3. **Vérifier les faits évolutifs** auprès des sources officielles avant de modifier modèles, prix, quotas, fonctionnalités, sécurité ou compatibilité IDE.
4. **Appliquer un changement cohérent** sans supprimer les contenus Copilot uniquement parce que Claude est le parcours principal.
5. **Valider localement** avant le push.
6. **Pousser la branche courante** et ouvrir/mettre à jour une Pull Request vers `main`.

### Validation locale

Après installation de `requirements.txt` :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```

Sous Windows, `py -m` peut être utilisé à la place de `python -m` si nécessaire.

Le build strict vérifie la configuration et la génération MkDocs. `scripts/validate-links.py` vérifie les chemins et ancres internes du site généré.

## Conventions de commit

Format recommandé : `type: description courte`.

| Type | Usage |
|---|---|
| `docs` | Contenu documentaire |
| `feat` | Nouvelle capacité ou nouveau parcours |
| `fix` | Correction d'erreur |
| `chore` | Maintenance, CI, dépendances, configuration |
| `refactor` | Restructuration sans changement fonctionnel |
| `style` | Présentation pure |

Exemples :

```text
docs: actualiser les modèles Claude
fix: corriger les ancres du chapitre hooks
chore: renforcer la validation MkDocs
docs: mettre à jour la référence Copilot JetBrains
```

## Règles éditoriales IA

### Claude Code — parcours principal

Les pages génériques et les nouveaux workflows doivent partir de Claude Code lorsque le sujet s'y prête. Les artefacts projet Claude vivent notamment dans :

- `CLAUDE.md` et `AGENTS.md` ;
- `.claude/rules/` ;
- `.claude/skills/` ;
- `.claude/agents/` ;
- `.claude/settings.json` lorsque des réglages partagés sont nécessaires.

### GitHub Copilot — référence conservée

Les artefacts `.github/copilot-instructions.md`, `.github/instructions/`, `.github/prompts/`, `.github/agents/`, `.github/skills/` et `.github/hooks/` restent volontairement dans le dépôt. Ils doivent être maintenus lorsqu'une fonctionnalité Copilot est documentée, mais ne doivent pas faire repasser les pages génériques en Copilot-first.

### Sources

Pour un fait susceptible d'évoluer, privilégier :

1. documentation officielle du produit ;
2. changelog/release notes officiels ;
3. dépôt ou spécification officielle ;
4. source secondaire uniquement en complément.

Ne pas conserver de version minimale, prix, quota ou nom de modèle figé sans nécessité et sans source récente.

## Navigation MkDocs

Toute page destinée au site doit être intégrée à `mkdocs.yml`, sauf fichiers explicitement utilisés comme templates/assets.

Après une modification de navigation :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```

Ne supposez pas que toute page `docs/**/*.md` doit être visible dans la navigation : les fichiers sous `docs/assets/templates/` sont des ressources copiables et peuvent volontairement rester hors nav.

## Pull Request

Avant de soumettre :

- la branche doit être synchronisée avec `main` ;
- le build strict doit réussir ;
- les liens et ancres internes doivent être valides ;
- les faits évolutifs modifiés doivent avoir été vérifiés ;
- les contenus Copilot utiles doivent rester identifiables comme référence ;
- aucun secret, token, identifiant personnel ou donnée sensible ne doit être commité.

Poussez uniquement la branche de travail :

```bash
git push -u origin HEAD
```

Puis ouvrez une PR avec `base: main`.

## Développement local

### Windows PowerShell

```powershell
py -3 -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python -m mkdocs serve
```

### macOS / Linux

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python -m mkdocs serve
```

Le site est ensuite accessible sur `http://127.0.0.1:8000/` par défaut.

Pour les notes internes Windows, voir `user/developpement-local.md`.

## Gouvernance

`.github/CODEOWNERS` définit les propriétaires de fichiers. Les règles de protection/rulesets GitHub restent la source de vérité pour les contrôles réellement imposés côté plateforme : ce guide décrit le workflow attendu mais ne prétend pas refléter automatiquement chaque réglage d'administration GitHub.

## Questions

Ouvrir une issue dans le dépôt avec le contexte, le fichier concerné et, lorsqu'il s'agit d'une divergence documentaire, la source officielle utilisée pour la comparaison.
