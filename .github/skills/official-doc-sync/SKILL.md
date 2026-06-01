---
name: official-doc-sync
description: "Workflow multi-etapes pour verifier puis mettre a jour la documentation a partir de sources fiables, avec au minimum une source officielle et une section Sources obligatoire. Utiliser pour: mise a jour officielle, verification de validite technique, alignement release notes/changelog, correction d'obsolescence documentaire."
argument-hint: "Page cible, contexte produit/version, et niveau de profondeur"
---

# Skill : Official Doc Sync

## Objectif

Verifier et mettre a jour une page de documentation en minimisant les changements et en maximisant la tracabilite des sources.

## Quand l'utiliser

- Mettre a jour une page avec des nouveautes produit
- Corriger une section devenue obsolete
- Aligner une doc interne avec release notes/changelog officiels
- Verifier l'exactitude technique avant publication

## Procedure

### 1. Cadrer la cible

- Identifier le fichier cible et le perimetre exact (section, page complete, chapitre)
- Extraire les affirmations techniques a verifier

### 2. Verifier les faits

- Consulter des sources adaptees au contexte
- Inclure au minimum une source officielle
- Noter les points confirmes, contredits, et non tranchables

Utiliser la checklist:
- [Checklist de validation](./references/validation-checklist.md)

### 3. Appliquer les modifications

- Faire un patch minimal
- Preserver la structure, le style et les conventions MkDocs Material du depot
- Eviter les reformulations massives hors besoin factuel

### 4. Produire la tracabilite

- Ajouter un resume factuel des changements
- Ajouter une section `Sources` obligatoire (URL + date de consultation)
- Utiliser ce modele:
- [Template de trace des sources](./assets/source-log-template.md)

## Contraintes

- Ne pas inventer d'information technique
- Ne pas utiliser une source non officielle comme unique preuve
- Signaler explicitement les incertitudes

## Sortie attendue

- Fichiers modifies
- Resume des changements
- Faits verifies
- `## Sources` obligatoire
- Incertitudes restantes
