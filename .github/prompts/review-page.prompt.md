---
name: "Révision de page"
description: "Auditer une page MkDocs existante : exactitude, cohérence Claude/Copilot, accessibilité, sources, navigation et syntaxe."
argument-hint: "Chemin de la page à réviser"
mode: ask
---

# Révision d'une page

Audite la page sans la modifier.

## Vérifier

- H1 unique et hiérarchie H2/H3 cohérente ;
- code avec langage, tableaux lisibles, images avec alt text ;
- liens internes cohérents avec l'arborescence actuelle ;
- page présente dans `mkdocs.yml` si elle est destinée à la navigation ;
- Claude Code présenté comme parcours principal dans une page générique IA ;
- GitHub Copilot conservé et clairement identifié lorsqu'il s'agit d'une référence ;
- aucune confusion entre `.claude/*` et `.github/*` ;
- modèles, prix, quotas, versions, raccourcis, previews, APIs et informations sécurité sourcés quand ils sont évolutifs ;
- absence d'affirmations quantitatives arbitraires ou de recommandations universelles non démontrées.

## Rapport

Pour chaque écart : **Sévérité**, **preuve**, **risque**, **correction proposée**.

Terminer par les points conformes et les validations recommandées. Ne donner aucun score numérique global.
