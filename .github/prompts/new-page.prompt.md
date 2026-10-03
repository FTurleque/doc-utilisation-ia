---
name: "Nouvelle page"
description: "Créer une page MkDocs française dans ce dépôt Claude-first, en conservant les références GitHub Copilot pertinentes."
argument-hint: "Sujet, chapitre cible, niveau et produit concerné si spécifique"
mode: agent
---

# Créer une nouvelle page

1. Lire `CLAUDE.md`, `AGENTS.md`, `mkdocs.yml`, l'index du chapitre cible et une page voisine.
2. Vérifier qu'une page équivalente n'existe pas déjà.
3. Si le sujet est générique à l'assistance au développement, partir de **Claude Code** ; si la page est explicitement Copilot, l'indiquer clairement.
4. Pour un fait évolutif (modèle, prix, version, compatibilité, preview, API), vérifier une source officielle récente.
5. Créer la page avec H1 unique, H2/H3 cohérents, blocs de code typés, alt text utile et liens relatifs vérifiés.
6. Ajouter la page à `mkdocs.yml` si elle est destinée à la navigation publique ; ne pas ajouter automatiquement les templates/assets.
7. Valider :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```

Ne supprime pas les contenus Copilot utiles et ne mélange pas les conventions `.claude/*` et `.github/*`.
