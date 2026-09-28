---
description: "Conventions de structure de la documentation MkDocs actuelle. Utiliser pour créer ou déplacer une page et maintenir mkdocs.yml."
applyTo: "docs/**"
---

# Structure de la documentation

Ce dépôt est **Claude Code-first** et conserve GitHub Copilot comme référence. Ne déduis jamais l'arborescence à partir d'anciens numéros de chapitres : lis `mkdocs.yml` et les dossiers présents avant toute modification.

## Arborescence actuelle

```text
docs/
├── index.md
├── chapitre-1-installation/                 # Copilot — référence
├── chapitre-2-parametrage/                  # Copilot — référence
├── chapitre-3-cli-modes/                    # Copilot — référence
├── chapitre-3b-claude-code-migration-copilot/
├── chapitre-4-contexte/
├── chapitre-5-prompt-engineering/
├── chapitre-6-machine-learning/
├── chapitre-7-rag/
├── chapitre-8-deep-learning/
├── chapitre-9-bonnes-pratiques/
├── chapitre-10-cas-usage/
├── chapitre-11-troubleshooting/
├── chapitre-12-couts-gouvernance/
├── chapitre-13-outils-economies/
├── chapitre-14-veille-ia/
├── chapitre-15-hacker-ia/
├── appendices/
└── assets/
```

`docs/assets/templates/` contient des ressources copiables et peut volontairement rester hors navigation.

## Nommage

- `index.md` pour l'entrée d'un chapitre ;
- kebab-case pour les pages de contenu ;
- noms conventionnels existants (`README.md`, `CAPTURE-TEMPLATE.md`) conservés ;
- pas d'espace ou de caractère accentué dans un nouveau nom de fichier destiné à une URL.

## Structure d'une page publiée

```markdown
# Titre de la page

<span class="badge-intermediate">Intermédiaire</span>

Introduction courte.

---

## Première section

Contenu.

### Sous-section

Détail.
```

Règles :

- un H1 unique ;
- ne pas sauter de niveau de titre ;
- blocs de code avec langage ;
- alt text descriptif pour les images ;
- admonitions/onglets seulement lorsqu'ils améliorent la compréhension ;
- sources officielles pour les faits susceptibles d'évoluer.

## Claude et Copilot

Une page générique doit être Claude-first lorsqu'elle traite des assistants de développement. Si elle couvre Copilot, conserver une section explicite de référence/comparaison plutôt que supprimer l'information.

Une page strictement Copilot peut rester Copilot-first si son rôle est clairement identifié dans la navigation ou dans l'introduction.

## Navigation

Pour toute nouvelle page publiée, ajouter une entrée à `nav:` dans `mkdocs.yml`, sauf ressource volontairement hors navigation.

Principes :

- ordre de lecture logique plutôt que règle mécanique par type de fichier ;
- Claude Code reste présenté avant le bloc `GitHub Copilot (référence)` dans le parcours principal ;
- ne pas renommer/déplacer une page sans corriger ses liens internes ;
- ne pas inventer un numéro de chapitre : vérifier la structure courante.

## Validation obligatoire

Après modification structurelle :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```

Le build et le validateur de liens/ancres sont la vérification technique ; une inspection du contenu reste nécessaire pour la cohérence éditoriale.
