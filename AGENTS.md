# AGENTS — recommandations pour ce dépôt

Ce fichier contient les conventions communes aux assistants et agents utilisés pour maintenir **l'ensemble du dépôt**. Claude Code est l'outil principal ; les configurations GitHub Copilot restent maintenues pour la compatibilité et la référence.

## Périmètre

- Documentation publique : `docs/`
- Navigation : `mkdocs.yml`
- Instructions/gouvernance : fichiers Markdown à la racine
- Claude Code : `CLAUDE.md` et `.claude/`
- GitHub Copilot : `.github/copilot-instructions.md`, `.github/agents/`, `.github/instructions/`, `.github/prompts/`, `.github/skills/`, `.github/hooks/`
- CI/CD : `.github/workflows/`
- Scripts : `scripts/`
- Notes internes : `user/`
- Templates : `docs/assets/templates/`

## Règles communes

- Écrire en français pour le contenu publié.
- Vérifier les faits évolutifs auprès de sources officielles avant publication.
- Présenter Claude Code comme parcours principal dans les pages génériques.
- Conserver les références Copilot utiles et les identifier clairement.
- Ne pas traiter `.claude/*` et `.github/*` comme des formats interchangeables.
- Mettre `mkdocs.yml` à jour pour les pages publiques ajoutées/déplacées, sauf ressources volontairement hors navigation.
- Auditer aussi les scripts, templates, agents et workflows lorsqu'une migration transverse les affecte.
- Ne jamais pousser ou merger directement dans `main` dans un workflow d'agent.

## Rôles Claude disponibles

Sous `.claude/agents/` :

- `doc-writer` — rédaction et mise à jour ;
- `doc-reviewer` — audit en lecture seule ;
- `nav-maintainer` — navigation MkDocs ;
- `official-doc-audit` — comparaison aux sources officielles ;
- `official-doc-sync` — synchronisation documentée.

Le skill `.claude/skills/doc-writer/` fournit le workflow de rédaction réutilisable.

Les agents/skills sous `.github/` restent les équivalents ou outils spécifiques GitHub Copilot.

## Sources

Prioriser :

1. documentation officielle du produit ;
2. changelog/release notes officiels ;
3. dépôt ou spécification officielle ;
4. source secondaire seulement en complément.

Pour Claude : `code.claude.com/docs`, `platform.claude.com/docs`, `anthropic.com`.
Pour Copilot : GitHub Docs et GitHub Changelog.

## Validation du site

Commande de référence :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```

Sous Windows, `py -m` peut remplacer `python -m` selon l'installation.

La CI de PR exécute ces validations. Ne masque pas un échec par un assouplissement du validateur sans démontrer qu'il s'agit d'un faux positif.

## Git et déploiement

- Travail sur branche.
- Push : `git push -u origin HEAD`.
- Pull Request vers `main`.
- Merge manuel après revue.
- Déploiement par `.github/workflows/deploy.yml` après intégration dans `main`.

Le script `scripts/push-and-deploy.ps1` porte un nom historique mais refuse désormais de pousser `main/master`.

## Sécurité

- Ne jamais committer de secrets ou credentials.
- `.claude/settings.local.json` et les réglages personnels restent locaux.
- Considérer hooks, skills, agents et workflows comme du code/configuration exécutable à relire.
- Les exemples offensifs du chapitre cybersécurité doivent rester orientés défense, détection et contrôle.

## Relation avec `CLAUDE.md`

`CLAUDE.md` importe ce fichier et contient les priorités spécifiques Claude. Les deux doivent rester cohérents et suffisamment courts pour ne pas surcharger le contexte.
