@AGENTS.md

# Claude Code — instructions du projet

Ce dépôt contient une documentation MkDocs en français sur l'utilisation de l'IA pour le développement. Le parcours principal doit désormais être **Claude Code**, tout en conservant la documentation GitHub Copilot existante comme référence, comparaison et solution de repli éventuelle.

## Priorités éditoriales

1. Présenter **Claude Code** comme outil principal dans les pages génériques et les parcours recommandés.
2. **Ne pas supprimer** les contenus GitHub Copilot, `.github/copilot-instructions.md`, `.github/agents/`, `.github/instructions/` ou `.github/prompts/` uniquement parce qu'ils concernent Copilot.
3. Quand une page générique est historiquement centrée sur Copilot, la réorienter vers Claude et conserver une section Copilot explicite, ou un lien vers la page Copilot dédiée.
4. Distinguer clairement les fonctionnalités propres à Claude, celles propres à Copilot et celles communes aux deux outils.
5. Traiter la migration **par lots cohérents** : installation, paramétrage, contexte, prompting, workflows, coûts, troubleshooting, outils, puis audit final.

## Sources et vérification

Pour toute information susceptible d'évoluer, vérifier les sources officielles avant de modifier la documentation.

Priorité des sources :

- Claude Code : `https://code.claude.com/docs/`
- Claude Platform / API : `https://docs.anthropic.com/` et `https://platform.claude.com/docs/`
- Anthropic : `https://www.anthropic.com/`
- GitHub Copilot : documentation officielle GitHub
- Outils tiers : documentation et dépôts officiels des éditeurs

Éviter de figer inutilement des numéros de version, noms de modèles ou tarifs dans les pages générales. Quand une valeur datée est utile, indiquer sa date de vérification et une source officielle.

## Conventions du dépôt

- Langue : français.
- Ton : pédagogique, concret, progressif.
- Site : MkDocs Material.
- Documentation publique : `docs/`.
- Navigation : `mkdocs.yml`.
- Les lots 0 à 3 de la migration Claude-first sont maintenant traités ; poursuivre avec les chapitres ML/RAG/Deep Learning/cas d'usage avant l'audit final.