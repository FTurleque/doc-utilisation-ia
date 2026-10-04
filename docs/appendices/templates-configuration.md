# Templates GitHub Copilot — référence

Adaptez ces exemples aux conventions, commandes et versions de votre dépôt. Aucun secret ne doit être écrit dans un fichier versionné.

## GitHub Copilot — templates conservés

### `.github/copilot-instructions.md`

```markdown
# GitHub Copilot — instructions projet

- Réutiliser les patterns existants.
- Exécuter les tests pertinents.
- Ne pas ajouter de dépendance sans justification.
- Ne jamais exposer de secret.
```

### `.github/instructions/java.instructions.md`

```markdown
---
applyTo: "**/*.java"
---

- Respecter les conventions Java du dépôt.
- Réutiliser le framework de test existant.
- Préférer les refactorings sûrs de l'IDE pour les opérations mécaniques.
```

Les [prompt files](../chapitre-4-contexte/prompt-files.md) et [instructions ciblées](../chapitre-4-contexte/applyto-avance.md) sont également référencés dans cette annexe. Vérifiez les formats réellement pris en charge par votre client.

---


## Prochaine étape

Poursuivez avec **[Installation — Accueil](../chapitre-1-installation/index.md)**, la page suivante dans le menu.
