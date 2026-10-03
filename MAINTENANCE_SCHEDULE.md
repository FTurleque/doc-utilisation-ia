# Calendrier de maintenance — documentation IA

Ce calendrier maintient le dépôt **Claude Code-first** tout en conservant GitHub Copilot comme référence à jour.

**Cadence recommandée :** contrôle mensuel léger, revue trimestrielle approfondie et vérification immédiate après toute annonce majeure affectant les pages publiées.

## Sources de vérité à surveiller

### Claude / Anthropic

- [Claude Code documentation](https://code.claude.com/docs/)
- [Claude Code changelog](https://code.claude.com/docs/en/changelog)
- [Claude models](https://platform.claude.com/docs/en/about-claude/models/overview)
- [Claude pricing](https://claude.com/pricing)
- [Anthropic news](https://www.anthropic.com/news)

Surveiller en priorité : installation, authentification, modèles/alias, settings, permissions, skills, subagents, hooks, MCP, IDE integrations, usage et facturation.

### GitHub Copilot — référence

- [GitHub Copilot documentation](https://docs.github.com/en/copilot)
- [GitHub Copilot billing](https://docs.github.com/en/billing/concepts/product-billing/github-copilot)
- [GitHub Changelog](https://github.blog/changelog/)

Surveiller : plans, AI Credits, modèles, compatibilité IDE, custom instructions, prompt files, agents, skills, MCP et fonctionnalités en preview.

### Documentation et sécurité

- [MkDocs](https://www.mkdocs.org/)
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
- [OWASP GenAI Security Project](https://genai.owasp.org/)

## Contrôle mensuel

1. Lire les changelogs et annonces officielles Claude Code et GitHub Copilot.
2. Rechercher dans le dépôt les noms/modèles/plans/fonctionnalités concernés.
3. Vérifier les pages sensibles au temps avant d'éditer.
4. Modifier uniquement les éléments confirmés par une source officielle.
5. Exécuter :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```

6. Pousser la branche de travail et passer par une Pull Request vers `main`.
7. Ajouter une entrée au `CHANGELOG.md` si le changement est notable pour les lecteurs ou mainteneurs.

## Pages à surveiller en priorité

| Zone | Pourquoi | Cadence indicative |
|---|---|---|
| `docs/chapitre-3b-claude-code-migration-copilot/installation.md` | méthodes d'installation/authentification | mensuelle |
| `docs/chapitre-3b-claude-code-migration-copilot/modeles-claude.md` | modèles, alias, providers | mensuelle |
| `docs/chapitre-3b-claude-code-migration-copilot/couts-quotas.md` | usage, quotas, facturation | mensuelle |
| `docs/chapitre-4-contexte/` | rules, skills, agents, hooks, MCP | mensuelle |
| `docs/chapitre-12-couts-gouvernance/` | coûts Claude et référence Copilot | mensuelle |
| `docs/chapitre-1-installation/` et `docs/chapitre-2-parametrage/` | Copilot IDE de référence | trimestrielle ou après annonce |
| `docs/chapitre-14-veille-ia/` | sources et sécurité | trimestrielle |
| `docs/chapitre-15-hacker-ia/` | sécurité agentique et contrôles | trimestrielle ou après incident majeur |
| `.claude/` et `.github/` | contrats d'agents, skills, règles et hooks | après évolution des plateformes |

## Revue trimestrielle repo-wide

La revue trimestrielle ne se limite pas aux pages publiées. Vérifier aussi :

- `README.md`, `CLAUDE.md`, `AGENTS.md`, `CONTRIBUTING*.md`, `DEPLOYMENT.md` ;
- `.claude/**` ;
- `.github/agents/**`, `.github/instructions/**`, `.github/prompts/**`, `.github/skills/**`, `.github/hooks/**`, `.github/workflows/**` ;
- `docs/assets/templates/**` ;
- `scripts/**` et `user/**` ;
- `requirements.txt`, `mkdocs.yml` et fichiers de lint/configuration.

Pour chaque fichier, classer le résultat :

- **à modifier** — contenu faux, obsolète ou contradictoire ;
- **à conserver** — artefact Copilot volontaire ou configuration toujours valide ;
- **à compléter** — équivalent Claude manquant ;
- **hors migration** — binaire, licence ou configuration sans dépendance à l'assistant IA.

## Règles pour les faits évolutifs

- Ne pas conserver de date future comme « action requise » après son échéance.
- Éviter les quotas, prix et identifiants de modèle codés en dur si la page peut expliquer le mécanisme sans eux.
- Quand une valeur exacte est indispensable, ajouter une source officielle et une date de vérification.
- Une source communautaire peut signaler un changement, mais la modification documentaire doit être confirmée par une source primaire lorsque celle-ci existe.
- Distinguer clairement **Claude**, **Copilot** et les mécanismes communs ; ne pas présenter un format spécifique à un outil comme standard universel.

## Branches et validation

Ne jamais utiliser de script de maintenance qui pousse directement sur `main`.

```bash
git fetch origin
git switch -c docs/maintenance-YYYY-MM
# modifications + validation
git push -u origin HEAD
```

La PR est le point de contrôle avant intégration.

## Historique

Le fichier `docs/chapitre-12-couts-gouvernance/historique-modifications.md` conserve l'historique des changements de coûts/modèles lorsque cela apporte une valeur documentaire. `CHANGELOG.md` résume les changements importants du dépôt.

**Dernière révision du calendrier : 2026-09-28.**
