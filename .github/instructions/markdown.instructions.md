---
description: 'Markdown standards for this MkDocs Material repository'
applyTo: '**/*.md'
---

# Règles Markdown du dépôt

Ces règles décrivent le format **réel** du projet. Elles remplacent les conventions de blog/front matter qui ne s'appliquent pas ici.

## Titres

- Une page publiée commence normalement par un unique `# H1`.
- Utiliser `## H2`, puis `### H3` sans saut de niveau.
- Ne pas utiliser du texte en gras comme substitut à un titre.
- Les fichiers techniques non publiés (`README.md`, instructions, agents, skills, templates) peuvent adapter leur structure à leur rôle, tout en conservant une hiérarchie cohérente.

## Front matter

Le front matter YAML **n'est pas obligatoire** pour les pages MkDocs de ce dépôt.

Ne pas ajouter de champs de blog Microsoft tels que `post_title`, `microsoft_alias`, `featured_image`, `categories`, `ai_note`, etc. sauf si un futur outil du dépôt les exige explicitement.

Les artefacts IA (`.github/agents`, `.github/prompts`, `.github/skills`, `.claude/agents`, `.claude/skills`) peuvent en revanche utiliser le front matter propre à leur plateforme.

## Listes, code et tableaux

- Utiliser la syntaxe Markdown native pour les listes.
- Spécifier le langage des blocs de code (`python`, `bash`, `powershell`, `json`, `yaml`, `markdown`, etc.).
- Ajouter une ligne vide autour des blocs structurants lorsque cela améliore la lisibilité.
- Utiliser des tableaux seulement quand la comparaison tabulaire est réellement utile.

## Liens

- Utiliser un libellé descriptif plutôt qu'un « cliquez ici ».
- Préférer les liens relatifs pour les pages internes.
- Ne pas copier un ancien chemin sans vérifier qu'il existe encore.
- Après modification du site, exécuter le validateur des liens et ancres.

## Images

- Fournir un texte alternatif descriptif.
- Ne pas utiliser le nom de fichier comme alt text par défaut.
- Une image décorative peut avoir un alt vide si elle est réellement décorative et si le rendu le justifie.
- Les captures UI doivent respecter `CONTRIBUTING-SCREENSHOTS.md`.

## Langue et style

- Documentation publiée : français, sauf termes techniques usuels.
- Préférer des phrases directes et vérifiables.
- Éviter les chiffres de performance, pourcentages, scores ou durées présentés comme universels sans mesure/source.
- Ne pas figer prix, quotas, versions minimales ou noms de modèles si une formulation durable suffit.

## Sources et traçabilité

Lorsqu'une page contient des faits externes évolutifs, utiliser une section `## Sources` et privilégier les références officielles.

Format recommandé :

```markdown
## Sources

- [Titre de la source](https://exemple.invalid/) — consulté le YYYY-MM-DD
```

Une date de consultation est particulièrement utile pour les pages sur modèles, tarifs, sécurité, compatibilité IDE, previews et APIs.

## MkDocs Material

Les admonitions, onglets, Mermaid, attributs et autres extensions doivent suivre `.github/instructions/mkdocs-material.instructions.md` et la configuration réellement active dans `mkdocs.yml`.

## Validation

Pour les changements qui affectent le site :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```

Ne prétends pas qu'un fichier est conforme uniquement parce que Markdown « ressemble » à du contenu valide : la CI est la référence technique.
