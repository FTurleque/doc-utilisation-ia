---
name: doc-writer
description: "Rédiger ou mettre à jour des pages MkDocs de ce dépôt Claude-first, en conservant GitHub Copilot comme référence lorsqu'il est pertinent."
---

# Skill — rédaction documentaire

## Objectif

Créer ou améliorer une documentation technique française cohérente avec le dépôt actuel.

## Avant d'écrire

Lire :

- `CLAUDE.md` et `AGENTS.md` ;
- `mkdocs.yml` ;
- l'index du chapitre cible ;
- une page voisine comparable.

## Orientation produit

- Pour une page générique sur les assistants/agents, partir de **Claude Code**.
- Conserver les informations GitHub Copilot utiles comme référence, comparaison ou compatibilité.
- Une page explicitement Copilot peut rester Copilot-first.
- Ne jamais mélanger les formats `.claude/*` et `.github/*` comme s'ils étaient interchangeables.

## Références du skill

- [Structure actuelle](./references/structure.md)
- [Syntaxe MkDocs Material](./references/mkdocs-syntax.md)
- [Patterns de rédaction](./references/patterns.md)

## Validation

Pour une modification qui affecte le site :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```

## Contraintes

- français pour le contenu publié ;
- ne pas inventer de prix, quotas, modèles, versions, raccourcis ou statuts preview ;
- vérifier les faits évolutifs auprès de sources officielles ;
- éviter les pages redondantes ;
- mettre `mkdocs.yml` à jour pour une nouvelle page publiée, sauf ressource volontairement hors nav ;
- ne jamais pousser/merger directement dans `main`.
