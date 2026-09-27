# AGENTS — recommandations pour ce dépôt

Ce fichier contient les conventions communes aux assistants et agents utilisés pour maintenir la documentation. **Claude Code est désormais l'outil principal** pour les travaux de fond sur le dépôt. Les configurations GitHub Copilot restent conservées pour la compatibilité, la comparaison et un éventuel retour à Copilot.

## Périmètre

- Documentation publique : `docs/`
- Navigation du site : `mkdocs.yml`
- Documentation et règles de contribution : fichiers Markdown à la racine
- Configuration Claude : `CLAUDE.md` et, si nécessaire, `.claude/`
- Configuration Copilot historique : `.github/copilot-instructions.md`, `.github/agents/`, `.github/instructions/`, `.github/prompts/`

## Règles communes

- Écrire en français, avec un ton pédagogique et concret.
- Vérifier les faits évolutifs auprès de sources officielles avant publication.
- Présenter Claude Code comme parcours principal lorsqu'une page traite d'un usage IA générique.
- Ne pas supprimer les contenus Copilot : les conserver dans des sections ou pages clairement identifiées.
- Ne pas transformer une fonctionnalité propre à Copilot en fonctionnalité Claude sans vérification, et inversement.
- Maintenir `mkdocs.yml` lorsque des pages publiques sont ajoutées, déplacées ou renommées.
- Ne jamais merger directement dans `main` dans le cadre d'un travail d'agent ; travailler sur une branche et passer par une Pull Request.

## Rôles recommandés

### Rédaction documentaire

Objectif : rédiger, restructurer ou clarifier des pages Markdown.

Tâches typiques :

- proposer un plan ;
- adapter le niveau débutant/intermédiaire/expert ;
- réécrire une page Copilot-first en parcours Claude-first tout en conservant la partie Copilot ;
- harmoniser les admonitions, tableaux, badges et liens internes.

### Synchronisation avec la documentation officielle

Objectif : mettre à jour une page à partir de références éditeur actuelles.

Sources prioritaires :

- Claude Code : `code.claude.com/docs` ;
- Claude Platform : `docs.anthropic.com` / `platform.claude.com/docs` ;
- GitHub Copilot : documentation officielle GitHub ;
- outils tiers : documentation officielle et dépôt de l'éditeur.

Tâches typiques :

- vérifier les commandes d'installation ;
- contrôler les fonctionnalités IDE, CLI, MCP, hooks et permissions ;
- vérifier les modèles, quotas et prix uniquement quand ils sont nécessaires à la page ;
- dater les informations sensibles à l'évolution.

### Audit documentaire

Objectif : comparer la documentation du dépôt aux sources officielles sans réécrire aveuglément.

Tâches typiques :

- identifier les informations obsolètes ;
- signaler les pages encore trop dépendantes de Copilot pour un parcours générique ;
- détecter les contradictions entre pages Claude et pages Copilot ;
- classer les corrections par lot cohérent.

### Relecture et qualité

Objectif : vérifier la forme et la cohérence après modification.

Tâches typiques :

- orthographe et style ;
- liens relatifs ;
- titres et ancres ;
- navigation MkDocs ;
- cohérence des noms de produits et commandes ;
- accessibilité des images et captures.

### Build du site

Objectif : valider le rendu MkDocs avant de considérer un lot terminé.

Commande de référence :

```powershell
py -m mkdocs build
```

Si les dépendances ne sont pas présentes :

```powershell
py -m pip install -r requirements.txt
py -m mkdocs build
```

## Exemples de demandes

- « Mets à jour la page d'installation Claude Code à partir de la documentation officielle et conserve un encadré de migration depuis Copilot. »
- « Audite le chapitre Coûts & Gouvernance et sépare clairement les tarifs Claude des tarifs Copilot. »
- « Réoriente le guide de contexte vers `CLAUDE.md`, les règles Claude et MCP, sans supprimer les pages `.instructions.md` propres à Copilot. »
- « Vérifie les liens internes et la navigation après ce lot, puis exécute le build MkDocs. »

## Relation avec `CLAUDE.md`

`CLAUDE.md` contient les instructions spécifiques à Claude Code et importe ce fichier. Les deux fichiers doivent rester courts, complémentaires et cohérents. Les configurations sous `.github/` restent la référence pour les usages GitHub Copilot et ne doivent pas être supprimées au cours de la migration.
