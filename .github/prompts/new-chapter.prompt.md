---
name: "Nouveau chapitre"
description: "Ajouter un nouveau chapitre complet à la documentation : création du dossier, de l'index, des pages de contenu et mise à jour de la navigation."
argument-hint: "Nom et contenu du nouveau chapitre (ex: 'Chapitre 7 — Intégration CI/CD')"
mode: agent
---

# Créer un nouveau chapitre de documentation

Créer un nouveau chapitre complet dans ce projet MkDocs Material.

## Procédure

### Étape 1 — Analyser l'existant

1. Lis `mkdocs.yml` pour identifier le prochain numéro de chapitre disponible
2. Lis les `index.md` des chapitres existants pour comprendre le format attendu
3. Identifie le slug approprié pour le nouveau chapitre (kebab-case)

### Étape 2 — Créer la structure de fichiers

Créer les fichiers suivants :

```
docs/chapitre-N-slug/
├── index.md              ← Page d'introduction obligatoire
├── page-principale.md    ← Contenu principal
└── comparaison.md        ← Optionnel : comparaison IntelliJ/VS Code
```

### Étape 3 — Rédiger le fichier index.md

L'index d'un chapitre doit contenir :
- Un `# H1` avec le titre du chapitre
- Un paragraphe d'introduction de 2-3 phrases
- Un tableau listant les pages du chapitre avec leurs descriptions
- Des liens de navigation vers les pages importantes

### Étape 4 — Créer les pages de contenu

Chaque page respecte :
- `# H1` comme titre
- Badges de niveau sous le H1
- Sections `## H2` bien structurées
- Admonitions pour les points importants
- Onglets pour les différences IntelliJ/VS Code

### Étape 5 — Mettre à jour mkdocs.yml

Ajouter le nouveau chapitre dans la section `nav:` en respectant la numérotation.

## Structure de nav pour un nouveau chapitre

```yaml
- "Nom du Chapitre":
  - Introduction: chapitre-N-slug/index.md
  - "Page principale": chapitre-N-slug/page-principale.md
  - "Comparaison": chapitre-N-slug/comparaison.md
```

## Checklist de validation

- [ ] Dossier `docs/chapitre-N-slug/` créé
- [ ] `index.md` créé avec présentation du chapitre
- [ ] Au moins une page de contenu créée
- [ ] `mkdocs.yml` mis à jour avec les nouvelles entrées
- [ ] Tous les fichiers sont en français
- [ ] Badges de niveau présents sur les pages de contenu
