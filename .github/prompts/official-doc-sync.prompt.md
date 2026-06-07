---
name: "Official Doc Sync"
description: "Mettre à jour une page de documentation en s'appuyant sur des sources officielles, avec section Sources obligatoire."
argument-hint: "Chemin de page, périmètre de mise à jour, contexte produit/version"
mode: agent
---

# Mise à jour documentaire depuis sources officielles

Met à jour la documentation ciblée selon ce cadre:

1. Identifier les affirmations techniques à vérifier.
2. Vérifier les informations avec des sources adaptées au contexte, dont au moins une source officielle.
3. Appliquer un patch minimal, clair et traçable.
4. Préserver la structure MkDocs Material existante et le style éditorial du dépôt.

## Exigences de sortie

- Liste des fichiers modifiés
- Résumé des changements
- Justification factuelle des changements
- `## Sources` obligatoire (URL + date de consultation)
- Incertitudes restantes, le cas échéant

## Règles de qualité

- Ne pas inventer d'information non vérifiée
- Ne pas utiliser une source communautaire comme unique preuve
- Signaler explicitement toute ambiguïté de version ou de fonctionnalité
