---
name: "Nouvelle page"
description: "Créer une nouvelle page de documentation MkDocs Material en français pour ce projet. Fournir le sujet, le chapitre cible et le niveau de difficulté."
argument-hint: "Sujet de la page, chapitre cible et niveau (débutant/intermédiaire/expert)"
mode: agent
---

# Créer une nouvelle page de documentation

Crée une nouvelle page de documentation en suivant les conventions de ce projet.

## Ce que tu dois faire

1. **Lire le contexte existant** :
   - Lis `mkdocs.yml` pour comprendre la structure de navigation actuelle
   - Lis le fichier `index.md` du chapitre cible pour comprendre le ton et le niveau attendu
   - Consulte une page existante du même chapitre comme modèle de style

2. **Créer le fichier Markdown** :
   - Respecte la convention de nommage : `kebab-case.md` dans `docs/chapitre-N-slug/`
   - Commence par un titre `# H1`
   - Place les badges de niveau et IDE sous le H1
   - Structure le contenu avec `## H2` et `### H3`
   - Utilise des admonitions pour les conseils (`!!! tip`), avertissements (`!!! warning`) et infos (`!!! info`)
   - Utilise des onglets `=== "IntelliJ IDEA"` / `=== "Visual Studio Code"` pour les différences entre IDEs
   - Termine par un résumé ou des points clés

3. **Mettre à jour la navigation** :
   - Ajoute l'entrée dans la section `nav:` de `mkdocs.yml`
   - Respecte l'ordre logique dans le chapitre (comparaisons en dernier)

4. **Valider** :
   - Vérifie que la syntaxe Markdown est correcte
   - Confirme que l'entrée nav dans `mkdocs.yml` est bien formée

## Badges disponibles

```html
<span class="badge-beginner">Débutant</span>
<span class="badge-intermediate">Intermédiaire</span>
<span class="badge-expert">Expert</span>
<span class="badge-vscode">VS Code</span>
<span class="badge-intellij">IntelliJ</span>
```

## Rappel des admonitions valides

`note`, `tip`, `info`, `warning`, `danger`, `example`, `question`, `success`, `failure`

## Instructions finales

- Langue : **français exclusivement**
- Ton : pédagogique, direct, tutoiement acceptable
- Ne pas créer de page redondante avec une existante — vérifier d'abord
- Si la page doit couvrir les deux IDEs, utiliser des onglets et non deux fichiers séparés
