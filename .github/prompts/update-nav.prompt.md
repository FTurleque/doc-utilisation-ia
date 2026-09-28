---
name: "Mise à jour de navigation"
description: "Mettre à jour nav: dans mkdocs.yml sans casser l'ordre Claude-first ni les références Copilot."
argument-hint: "Chemin(s) de page(s) à ajouter, déplacer ou renommer"
mode: agent
---

# Mettre à jour la navigation MkDocs

1. Lire `mkdocs.yml` avant toute décision.
2. Vérifier que chaque fichier cible existe.
3. Déterminer le rôle de la page : Claude principal, Copilot référence, sujet transverse, appendice ou ressource hors nav.
4. Conserver **Claude Code avant `GitHub Copilot (référence)`** dans le parcours principal.
5. Utiliser un label qui décrit le rôle réel de la page ; ajouter `Copilot`, `référence`, `legacy` ou `historique` uniquement lorsque cela évite une ambiguïté factuelle.
6. Ne pas ajouter automatiquement `docs/assets/templates/**` à la navigation.
7. En cas de déplacement/renommage, rechercher et corriger les liens internes dépendants.
8. Valider :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```

Ne suppose pas que toute comparaison concerne IntelliJ/VS Code et ne déduis pas la structure depuis un ancien numéro de chapitre.
