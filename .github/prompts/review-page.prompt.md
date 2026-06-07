---
name: "Révision de page"
description: "Réviser une page de documentation existante : qualité du contenu, accessibilité, cohérence de style MkDocs Material, hiérarchie des titres et complétude."
argument-hint: "Chemin de la page à réviser (ex: docs/chapitre-3-contexte/concepts.md)"
mode: ask
---

# Révision d'une page de documentation

Révise la page de documentation fournie et produis un rapport structuré.

## Critères de révision

### 1. Structure et hiérarchie

- [ ] La page commence par un `# H1` unique
- [ ] Les badges de niveau/IDE sont présents après le H1
- [ ] La hiérarchie des titres est logique (H1 → H2 → H3, pas de saut de niveau)
- [ ] Les sections sont séparées par des `---`
- [ ] Il y a un résumé ou des points clés en fin de page

### 2. Syntaxe MkDocs Material

- [ ] Les admonitions sont correctement utilisées (type et indentation)
- [ ] Les onglets sont cohérents ("IntelliJ IDEA" et "Visual Studio Code")
- [ ] Les blocs de code ont un langage spécifié
- [ ] Les tableaux sont bien formatés
- [ ] Les liens internes pointent vers des fichiers existants

### 3. Qualité du contenu

- [ ] Le contenu est en français
- [ ] Le ton est pédagogique et accessible
- [ ] Les exemples sont concrets et pertinents
- [ ] Les informations sont exactes (pas d'informations obsolètes sur Copilot)
- [ ] Les cas d'usage IntelliJ ET VS Code sont couverts si applicable

### 4. Accessibilité

- [ ] Les images ont un texte alt descriptif
- [ ] Les liens ont un texte descriptif (pas de "cliquez ici")
- [ ] Les tableaux ont des en-têtes clairs
- [ ] Le langage est suffisamment simple pour le niveau annoncé

### 5. Navigation

- [ ] La page est référencée dans `mkdocs.yml`
- [ ] Les liens internes vers d'autres chapitres sont cohérents

## Format du rapport

Pour chaque problème trouvé, indiquer :
- **Type** : Structure / Syntaxe / Contenu / Accessibilité / Navigation
- **Sévérité** : Critique / Important / Suggestion
- **Description** : Ce qui est incorrect ou manquant
- **Correction proposée** : La modification recommandée

Termine par un score global et 3 points forts de la page.
