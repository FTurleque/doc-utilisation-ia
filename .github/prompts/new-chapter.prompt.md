---
name: "Nouveau chapitre"
description: "Ajouter un chapitre MkDocs cohérent avec la navigation actuelle du dépôt Claude-first."
argument-hint: "Sujet du chapitre, pages prévues et rôle dans le parcours"
mode: agent
---

# Créer un nouveau chapitre

Ne déduis pas le prochain numéro à partir d'une ancienne liste : lis `mkdocs.yml` et le tree `docs/`.

## Procédure

1. Lire `CLAUDE.md`, `AGENTS.md` et `mkdocs.yml`.
2. Vérifier que le sujet n'est pas déjà couvert.
3. Définir le rôle du chapitre : parcours Claude principal, référence Copilot, ou sujet transverse.
4. Créer un dossier `docs/chapitre-N-slug/` seulement si un nouveau chapitre est réellement justifié ; sinon enrichir le chapitre existant.
5. Créer `index.md` et uniquement les pages nécessaires.
6. Ajouter le chapitre dans la navigation à l'endroit logique, sans déplacer le bloc Copilot de référence devant le parcours Claude.
7. Vérifier les faits évolutifs auprès de sources officielles.
8. Exécuter :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```

Ne crée pas par défaut une page de comparaison IntelliJ/VS Code : cela dépend du sujet. Ne pousse ni ne merge directement dans `main`.
