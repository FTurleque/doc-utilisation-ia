---
name: doc-writer
description: Rédiger, restructurer ou actualiser la documentation MkDocs française de ce dépôt Claude-first tout en préservant les références GitHub Copilot utiles.
allowed-tools: Read Grep Glob Edit Write
---

# Rédaction documentaire

Avant d'écrire :

1. lire `CLAUDE.md` et `AGENTS.md` ;
2. lire `mkdocs.yml` si la navigation peut être affectée ;
3. lire la page cible, l'index du chapitre et une page voisine ;
4. rechercher les concepts identiques dans le dépôt pour éviter les doublons.

## Règles

- Claude Code est le parcours principal des pages génériques liées aux assistants/agents.
- Les contenus GitHub Copilot utiles restent présents et clairement identifiés comme références lorsque nécessaire.
- Le contenu publié est en français.
- Utiliser un H1 unique puis H2/H3 sans saut de niveau.
- Spécifier le langage des blocs de code et un alt text utile pour les images.
- Ne pas inventer prix, quotas, versions, raccourcis, modèles, previews ou comportements produit.
- Pour un fait évolutif, privilégier une source officielle récente et maintenir `## Sources` lorsque la page en dépend.
- Ne pas confondre `.claude/*` et `.github/*` : ce sont des contrats différents.
- Une nouvelle page publiée doit être placée dans `mkdocs.yml`, sauf ressource/template volontairement hors navigation.
- Ne jamais pousser/merger directement dans `main`.

## Validation

Après modification du site, exécuter lorsque l'environnement le permet :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```

Corriger les erreurs au lieu de les masquer ou d'affaiblir les validateurs.
