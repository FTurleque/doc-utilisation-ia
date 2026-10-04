# Documentation IA — instructions GitHub Copilot

## Contexte du projet

Ce dépôt publie une documentation technique MkDocs Material en français. **Claude Code est le parcours principal**. GitHub Copilot reste volontairement documenté comme référence, compatibilité, comparaison et option future.

Ces instructions s'appliquent lorsque le dépôt est édité avec GitHub Copilot. Elles ne signifient pas que Copilot est le produit principal documenté.

Avant toute modification importante, lire aussi `AGENTS.md` et `CLAUDE.md` afin de respecter les règles communes du dépôt.

## Priorités éditoriales

1. Dans une page générique, présenter Claude Code en premier lorsque le sujet concerne les assistants/agents de développement.
2. Ne jamais supprimer un contenu Copilot uniquement parce qu'il n'est plus prioritaire.
3. Identifier clairement ce qui est : **Claude-only**, **Copilot-only** ou **commun**.
4. Ne pas présenter un format Copilot (`.github/prompts`, `.github/agents`, `applyTo`, hooks Copilot) comme un standard universel.
5. Pour les faits évolutifs, vérifier une source officielle récente avant d'écrire : modèles, prix, quotas, compatibilité IDE, previews, settings, MCP, skills, agents, hooks et sécurité.

## Structure actuelle du dépôt

```text
CLAUDE.md                         instructions Claude Code
AGENTS.md                         règles communes pour les agents
.claude/                          configuration native Claude Code (si présente)
.github/
├── copilot-instructions.md       ce fichier
├── instructions/                 custom instructions Copilot
├── prompts/                      prompt files Copilot
├── agents/                       custom agents Copilot
├── skills/                       skills Copilot
├── hooks/                        hooks Copilot
└── workflows/                    CI/CD GitHub

docs/
├── index.md
├── chapitre-1-installation/      GitHub Copilot — référence
├── chapitre-2-parametrage/       GitHub Copilot — référence
├── chapitre-3-cli-modes/         modes Copilot — référence
├── chapitre-3b-claude-code-migration-copilot/
├── chapitre-4-contexte/
├── chapitre-5-prompt-engineering/
├── chapitre-6-machine-learning/
├── chapitre-7-rag/
├── chapitre-8-deep-learning/
├── chapitre-9-bonnes-pratiques/
├── chapitre-10-cas-usage/
├── chapitre-11-troubleshooting/
├── chapitre-12-couts-gouvernance/
├── chapitre-13-outils-economies/
├── chapitre-14-veille-ia/
├── chapitre-15-hacker-ia/
├── appendices/
└── assets/

mkdocs.yml
requirements.txt
scripts/
user/
```

Ne recopier aucune ancienne arborescence depuis une instruction ou un prompt : `mkdocs.yml` et le tree du dépôt sont les sources de vérité.

## Conventions documentaires

- contenu publié en français ;
- un seul `# H1` par page publiée ;
- sections `## H2`, puis `### H3` sans saut de niveau ;
- blocs de code avec langage ;
- texte alternatif descriptif pour les images ;
- admonitions et onglets MkDocs uniquement quand ils améliorent réellement la lecture ;
- noms de fichiers en kebab-case sauf fichiers conventionnels (`README.md`, `CLAUDE.md`, etc.).

Pour une nouvelle page publiée, mettre à jour `mkdocs.yml` sauf si le fichier est volontairement un template/resource hors navigation.

## Validation

Après modification affectant `docs/`, `mkdocs.yml`, les templates ou la navigation :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```

Sous Windows, `py -m` peut être utilisé lorsque `python` ne pointe pas vers l'environnement voulu. Ne pas imposer `py` comme règle universelle.

## Git

- Ne jamais pousser directement sur `main`.
- Ne jamais merger automatiquement une Pull Request.
- Travailler sur une branche et pousser avec `git push -u origin HEAD`.
- Le déploiement GitHub Pages a lieu après intégration manuelle dans `main`.

## Artefacts IA

### Claude Code

Les équivalents natifs Claude Code appartiennent à `.claude/` : rules, skills, subagents et settings partagés. Ne pas placer un nouvel artefact Claude dans `.github/` par commodité.

### GitHub Copilot

Les artefacts sous `.github/instructions`, `.github/prompts`, `.github/agents`, `.github/skills` et `.github/hooks` restent des configurations Copilot. Les maintenir lorsqu'ils sont utiles, mais les adapter à la politique Claude-first du contenu.

## Rapports et fichiers temporaires

- rapports IA temporaires : `ai-reports/` ;
- logs locaux : `logs/` ;
- sortie MkDocs : `site/` ;
- ne pas versionner les settings Claude locaux ou secrets.

## Sources internes utiles

- `CLAUDE.md` — instructions principales Claude Code ;
- `AGENTS.md` — workflow commun ;
- `CONTRIBUTING.md` — contribution, validation et Git ;
- `MAINTENANCE_SCHEDULE.md` — veille repo-wide ;
- `docs/chapitre-4-contexte/` — instructions, rules, skills, agents, hooks et contexte ;
- `mkdocs.yml` — navigation réelle ;
- `scripts/validate-links.py` — validation interne du site généré.
