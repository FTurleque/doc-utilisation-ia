---
description: 'Context engineering guidance for editing this Claude-first repository with GitHub Copilot'
applyTo: '**'
---

# Context engineering dans ce dépôt

Ces instructions s'exécutent dans **GitHub Copilot**, mais le dépôt lui-même est Claude Code-first. Utilise les formats Copilot pour ton propre contexte ; n'en déduis pas que les pages génériques doivent devenir Copilot-first.

## Sources de contexte du projet

Lire en priorité :

1. `CLAUDE.md` — orientation Claude Code et règles spécifiques ;
2. `AGENTS.md` — workflow commun ;
3. `.github/copilot-instructions.md` — règles propres à Copilot ;
4. `mkdocs.yml` — structure de navigation réelle ;
5. les fichiers proches de la page ou du template modifié.

Ne crée pas de `COPILOT.md` : ce dépôt utilise les mécanismes Copilot sous `.github/` et les mécanismes Claude sous `.claude/`.

## Contextualiser avant d'éditer

- Lire le fichier cible et son index de chapitre.
- Chercher les mêmes termes dans le dépôt avant d'introduire une nouvelle convention.
- Pour un déplacement/renommage, identifier les liens et entrées `mkdocs.yml` dépendants.
- Pour un fait externe évolutif, consulter une source officielle récente avant modification.

## Limiter le bruit

- Charger les fichiers utiles plutôt que de supposer qu'un grand dossier entier est nécessaire.
- Pour une modification locale, ne pas réécrire des chapitres sans rapport.
- Séparer les faits vérifiés des recommandations éditoriales.
- Une page Copilot de référence peut rester spécifique à Copilot ; une page générique doit respecter l'orientation Claude-first.

## Structure lisible par les assistants

Des noms et chemins explicites améliorent la recherche pour tous les agents, pas seulement Copilot :

- noms de fichiers descriptifs ;
- concepts proches regroupés ;
- commandes de validation documentées ;
- instructions persistantes courtes et non contradictoires ;
- templates spécialisés séparés du contenu publié.

## Changements multi-fichiers

Avant un changement transverse :

1. établir la liste des fichiers réellement touchés ;
2. préserver les artefacts Copilot lorsqu'ils restent utiles ;
3. ajouter/mettre à jour l'équivalent Claude lorsque le workflow doit être utilisable par Claude Code ;
4. exécuter `python -m mkdocs build --strict` et `python scripts/validate-links.py` si le site est affecté.

## En cas d'incertitude

Ne transforme pas une hypothèse sur le comportement de Claude Code, Copilot, un IDE ou un outil tiers en règle du dépôt. Vérifie la documentation officielle ou conserve une formulation explicitement conditionnelle.
