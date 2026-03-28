---
description: "Conventions de structure et d'organisation de ce projet de documentation MkDocs. Utiliser pour créer une nouvelle page, un nouveau chapitre, ou mettre à jour la navigation dans mkdocs.yml."
applyTo: "docs/**"
---

# Structure et Organisation du Projet de Documentation

## Arborescence des chapitres

```
docs/
├── index.md                              ← Page d'accueil (hero banner)
├── chapitre-1-installation/
│   ├── index.md                          ← Intro du chapitre
│   ├── comparaison.md                    ← Comparaison IntelliJ vs VS Code
│   ├── intellij/
│   │   ├── tutoriel.md                   ← Guide pas à pas
│   │   └── reference.md                  ← Référence rapide
│   └── vscode/
│       ├── tutoriel.md
│       └── reference.md
├── chapitre-2-parametrage/
├── chapitre-3-contexte/
├── chapitre-4-prompt-engineering/
├── chapitre-5-machine-learning/
├── chapitre-6-rag/
├── chapitre-7-cli-modes/
├── chapitre-8-bonnes-pratiques/
├── chapitre-9-cas-usage/
├── chapitre-10-troubleshooting/
└── appendices/
```

## Conventions de nommage des fichiers

| Type de page | Convention de nommage | Exemple |
|---|---|---|
| Index de chapitre | `index.md` | `chapitre-3-contexte/index.md` |
| Page de contenu | `kebab-case.md` | `securite-qualite.md` |
| Page de comparaison | `comparaison-*.md` | `comparaison-parametres.md` |
| Page spécifique IDE | `intellij-*.md` ou `vscode-*.md` | `intellij-parametrage.md` |
| Page dans sous-dossier IDE | `tutoriel.md`, `reference.md` | `intellij/tutoriel.md` |

**Interdictions :**
- Pas de majuscules dans les noms de fichiers
- Pas d'espaces (utiliser des tirets)
- Pas de caractères accentués dans les noms de fichiers

## Structure d'une page index de chapitre

Chaque `chapitre-N-*/index.md` présente :
1. Un titre H1 décrivant le chapitre
2. Un court paragraphe d'introduction (2-3 phrases)
3. Un tableau ou liste des pages du chapitre avec descriptions
4. Des liens de navigation vers les pages clés

```markdown
# Titre du Chapitre

Introduction courte du chapitre.

## Contenu de ce chapitre

| Page | Description |
|------|-------------|
| [Page 1](page1.md) | Ce que couvre cette page |
| [Page 2](page2.md) | Ce que couvre cette page |
```

## Structure d'une page de comparaison

Les pages `comparaison-*.md` suivent ce schéma :

```markdown
# Comparaison — [Sujet] IntelliJ vs VS Code

## Présentation
Contexte de la comparaison.

---

## Tableau comparatif complet

| Critère | IntelliJ IDEA | Visual Studio Code |
|---------|:-------------:|:-----------------:|
| ... | ... | ... |

---

## Différences détaillées

### [Critère 1]

=== "IntelliJ IDEA"
    Détails IntelliJ...

=== "Visual Studio Code"
    Détails VS Code...

---

## Recommandation

Conclusion et recommandation basée sur le contexte.
```

## Mise à jour de la navigation (mkdocs.yml)

**Règle absolue** : toute nouvelle page DOIT être ajoutée dans `mkdocs.yml` sous `nav:`.

Structure de la nav dans `mkdocs.yml` :

```yaml
nav:
  - Accueil: index.md
  - "Nom du Chapitre":
    - Introduction: chapitre-N-nom/index.md
    - "Nom de la page": chapitre-N-nom/fichier.md
    - "Sous-section":
      - "Page": chapitre-N-nom/sous-dossier/fichier.md
```

**Règles de la nav :**
- Les labels utilisent des guillemets doubles si ils contiennent des accents ou caractères spéciaux
- L'ordre dans la nav reflète l'ordre de lecture recommandé
- Les pages de comparaison vont en fin de chapitre
- Les `index.md` de chapitre ont le label "Introduction"

## Numérotation et ordre des chapitres

| N° | Slug | Thème |
|----|------|-------|
| 1 | `installation` | Installation par IDE |
| 2 | `parametrage` | Paramétrage et réglages |
| 3 | `contexte` | Contexte et personnalisation |
| 4 | `bonnes-pratiques` | Bonnes pratiques |
| 5 | `troubleshooting` | Résolution de problèmes |
| 6 | `cas-usage` | Cas d'usage par langage |

Pour ajouter un nouveau chapitre, continuer la numérotation à partir de 7.

## Pages spéciales

| Page | Rôle | Notes |
|------|------|-------|
| `docs/index.md` | Page d'accueil | Contient le hero banner HTML, ne pas modifier la structure |
| `appendices/faq.md` | Questions fréquentes | Format Q&A avec `???` details |
| `appendices/raccourcis-clavier.md` | Référence raccourcis | Tableaux par IDE |
| `appendices/ressources-externes.md` | Liens externes | Liens vers docs officielles |
| `appendices/templates-configuration.md` | Templates copiables | Blocs de code à copier-coller |

## Checklist pour une nouvelle page

- [ ] Fichier créé dans le bon chapitre avec nommage `kebab-case.md`
- [ ] Page commence par un `# Titre H1`
- [ ] Badges de niveau et/ou IDE présents après le H1
- [ ] Contenu structuré avec `## H2` et `### H3`
- [ ] Admonitions utilisées pour les conseils et avertissements
- [ ] Onglets utilisés pour les différences IntelliJ / VS Code
- [ ] `mkdocs.yml` mis à jour avec l'entrée de navigation
- [ ] `py -m mkdocs build` exécuté sans erreur
