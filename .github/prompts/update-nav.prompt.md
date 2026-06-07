---
name: "Mise à jour de navigation"
description: "Mettre à jour la section nav: de mkdocs.yml après l'ajout d'une ou plusieurs nouvelles pages de documentation."
argument-hint: "Chemin(s) de la/les nouvelle(s) page(s) à ajouter à la navigation"
mode: agent
---

# Mise à jour de la navigation MkDocs

Mets à jour la section `nav:` de `mkdocs.yml` pour inclure la ou les nouvelles pages.

## Procédure

1. **Lis `mkdocs.yml`** pour comprendre la structure actuelle de navigation
2. **Détermine la position correcte** :
   - Dans quel chapitre la page s'intègre-t-elle ?
   - Quel est l'ordre logique de lecture ?
   - Si c'est une page de comparaison, elle va en fin de chapitre
   - Si c'est un `index.md`, il va en première position avec le label "Introduction"
3. **Construis le label d'affichage** :
   - Utiliser des guillemets doubles si le label contient des accents
   - Le label doit être clair et descriptif (pas juste le nom de fichier)
4. **Insère l'entrée** dans la bonne position dans `nav:`
5. **Vérifie la syntaxe YAML** — l'indentation doit être cohérente (2 espaces)

## Règles de nommage dans la nav

| Type de page | Label recommandé |
|---|---|
| `index.md` d'un chapitre | "Introduction" |
| Page principale d'un sujet | Nom du sujet (ex: "Instructions Copilot") |
| Page spécifique IntelliJ | "IntelliJ — [Sujet]" |
| Page spécifique VS Code | "VS Code — [Sujet]" |
| Page de comparaison | "Comparaison IntelliJ / VS Code" |
| Tutoriel | "Tutoriel pas à pas" |
| Référence | "Guide de référence" |

## Format YAML attendu

```yaml
nav:
  - Accueil: index.md
  - "Nom du chapitre":
    - Introduction: chapitre-N-nom/index.md
    - "Nom de la page": chapitre-N-nom/page.md
    - "Sous-section":
      - "Page A": chapitre-N-nom/sous-dossier/page-a.md
```

## Validation

Après modification, confirme que :
- La syntaxe YAML est valide (indentation correcte, guillemets bien fermés)
- Le chemin de fichier existe bien dans `docs/`
- L'ordre des entrées reste logique
