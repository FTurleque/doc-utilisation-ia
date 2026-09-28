# Changelog — Documentation IA

Ce fichier suit les changements structurants du dépôt. Les détails très fins sur les prix, modèles et quotas restent dans les pages spécialisées et leur historique, afin d'éviter de dupliquer des données rapidement périssables.

## 2026-09-28 — Migration Claude Code-first et audit repo-wide

### Orientation

- Claude Code devient le parcours principal de la documentation.
- GitHub Copilot est conservé comme référence, comparaison, compatibilité et option future.
- Les pages génériques ne sont plus écrites comme si Copilot était l'unique assistant du dépôt.

### Documentation publiée

- Accueil et navigation réorientés vers Claude Code.
- Installation, architecture, modèles, prompting, coûts/quotas et migration Claude actualisés.
- Contexte, rules, skills, agents, hooks, MCP et IDE réécrits Claude-first.
- ML, RAG, Deep Learning, bonnes pratiques et cas d'usage réorientés vers des workflows Claude avec validation.
- Troubleshooting, coûts/gouvernance, outils et alternatives réaudités.
- Veille et cybersécurité actualisées avec perspective agentique.
- Appendices et références Copilot conservés mais clairement identifiés.

### Configuration Claude Code native

Ajout d'un socle versionné :

```text
.claude/
├── settings.json
├── rules/documentation.md
├── agents/
│   ├── doc-writer.md
│   ├── doc-reviewer.md
│   ├── nav-maintainer.md
│   ├── official-doc-audit.md
│   ├── official-doc-sync.md
│   └── sonar-remediation.md
└── skills/doc-writer/SKILL.md
```

`CLAUDE.md` et `AGENTS.md` ont été synchronisés avec cette architecture. `.claude/settings.local.json` est explicitement ignoré par Git.

### GitHub Copilot conservé

Les artefacts suivants restent versionnés et maintenus :

- `.github/copilot-instructions.md` ;
- `.github/instructions/` ;
- `.github/prompts/` ;
- `.github/agents/` ;
- `.github/skills/` ;
- `.github/hooks/`.

Les agents/prompts/skills spécifiques à la maintenance documentaire ont été adaptés pour éditer correctement un dépôt Claude-first, sans transformer leurs formats Copilot en formats Claude.

### Repo-wide / gouvernance

- `CONTRIBUTING.md` : workflow branche + PR, validation stricte et séparation Claude/Copilot.
- `MAINTENANCE_SCHEDULE.md` : veille Claude/Anthropic prioritaire et revue trimestrielle de tout le dépôt.
- `DEPLOYMENT.md` : déploiement après merge manuel, rollback par les sources.
- `CONTRIBUTING-SCREENSHOTS.md` et guides d'images : suppression des versions minimales figées, contacts fictifs et arborescences inexistantes.
- `scripts/push-and-deploy.ps1` : refus explicite de pousser `main/master`, validation avant push de la branche courante.
- `.github/CODEOWNERS` et template de PR : prise en compte de `.claude/` et des nouvelles validations.
- `docs/assets/templates/sonar/` : séparation explicite des templates Copilot et de l'équivalent Claude.

### CI et validation

Ajout d'un workflow PR non-déployant qui exécute :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```

Le validateur comprend le préfixe GitHub Pages (`site_url`) et contrôle les chemins **et les ancres HTML** internes.

Le workflow de déploiement exécute désormais ces mêmes validations avant publication vers `gh-pages`.

## 2026-06-15 — Intégration SonarQube

Ajout du chapitre/outillage SonarQube et du kit réutilisable sous `docs/assets/templates/sonar/` : collecte et réduction du bruit Sonar, triage, prompts de correction bornée, custom agent Copilot, configuration MCP d'exemple et règles de sécurité.

Ce kit a depuis été réaudité pour :

- rester utilisable comme référence Copilot ;
- ne plus figer un modèle Copilot particulier ;
- disposer d'un équivalent Claude natif pour la remédiation Sonar ;
- rappeler que les tokens, JSON bruts et données d'analyse peuvent être sensibles.

## 2026-05-04 — Audit coûts/modèles GitHub Copilot

Audit historique de la documentation Copilot avant les changements de facturation de juin 2026 : plans, quotas, modèles, premium requests/AI Credits, modes Agent/Chat et pages de gouvernance.

Les valeurs datées de cet audit ne doivent plus être utilisées comme état actuel sans vérification. Les pages du chapitre `docs/chapitre-12-couts-gouvernance/` et l'historique associé constituent désormais la référence maintenue.

## Politique de changelog

Pour les changements futurs :

- consigner ici les migrations, nouvelles capacités, changements de structure et évolutions de validation ;
- ne pas recopier des tableaux complets de prix/quota/modèles dans le changelog ;
- conserver ces données dans les pages spécialisées avec sources officielles et date de vérification ;
- ne jamais annoncer comme « futur » un changement dont la date est déjà passée.
