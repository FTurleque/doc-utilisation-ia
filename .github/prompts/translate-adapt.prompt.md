---
name: "Traduire et adapter"
description: "Traduire une source technique vers la documentation française du dépôt, avec Claude Code comme parcours principal et Copilot conservé comme référence."
argument-hint: "Contenu ou source à adapter, produit/version et page cible"
mode: agent
---

# Traduire et adapter une source technique

1. Identifier le produit, la version/date et la source d'origine.
2. Vérifier la source officielle lorsque le contenu concerne un comportement évolutif.
3. Traduire naturellement en français sans traduire artificiellement les termes techniques usuels.
4. Adapter au format MkDocs du dépôt : H1/H2/H3, code typé, admonitions utiles, liens descriptifs.
5. Si le contenu source concerne Claude Code, l'intégrer dans le parcours principal approprié.
6. Si le contenu source concerne GitHub Copilot, le conserver comme référence Copilot et ne pas le généraliser à Claude.
7. Ne pas créer de comparaison IDE si elle n'est pas pertinente.
8. Mettre à jour `mkdocs.yml` uniquement si une nouvelle page publiée est créée.
9. Valider avec le build strict et `scripts/validate-links.py`.

Ne copie pas de longs passages textuels d'une source : synthétise et cite la référence officielle.
