---
paths:
  - "docs/**/*.md"
  - "*.md"
---

# Documentation du dépôt

- Le parcours éditorial principal est **Claude Code** ; GitHub Copilot reste une référence à conserver lorsqu'elle est utile.
- Vérifier `mkdocs.yml` et les fichiers voisins avant de créer/déplacer une page.
- Une page publiée utilise un H1 unique, puis H2/H3 sans saut de niveau.
- Le contenu publié est en français, sauf termes techniques usuels.
- Ne pas figer prix, quotas, versions minimales, raccourcis ou modèles sans nécessité et source officielle récente.
- Pour un fait évolutif, privilégier documentation/release notes officielles et indiquer la date de vérification lorsque pertinent.
- Ne pas présenter `.github/*` comme format Claude ni `.claude/*` comme format Copilot.
- Ne pas supprimer les pages/configurations Copilot uniquement parce qu'elles sont secondaires.
- Après modification du site, exécuter si l'environnement le permet :
  - `python -m mkdocs build --strict`
  - `python scripts/validate-links.py`
- Ne jamais pousser ni merger directement dans `main` ; travailler sur une branche et passer par une Pull Request.
