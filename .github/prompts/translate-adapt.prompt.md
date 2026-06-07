---
name: "Traduire et adapter"
description: "Traduire et adapter du contenu technique en anglais vers une page de documentation française MkDocs Material pour ce projet. Utile pour adapter des release notes, des guides officiels ou des changelogs GitHub Copilot."
argument-hint: "Contenu en anglais à traduire et adapter (coller le texte ou donner le lien)"
mode: agent
---

# Traduire et adapter du contenu technique

Traduis et adapte du contenu technique (en anglais) en une page de documentation française conforme aux conventions de ce projet.

## Procédure

1. **Analyser le contenu source** :
   - Identifier le sujet principal et le niveau technique
   - Repérer les éléments spécifiques à IntelliJ, VS Code, ou les deux
   - Identifier les exemples de code à conserver

2. **Traduire en français** :
   - Traduction naturelle, pas mot-à-mot — prioriser la fluidité
   - Conserver les termes techniques anglais quand ils n'ont pas d'équivalent français usuel
   - Termes à NE PAS traduire : "pull request", "merge", "commit", "branch", "prompt", "token", "workspace", "snippet", "inline completion"
   - Termes à traduire : "settings" → "paramètres", "shortcut" → "raccourci", "feature" → "fonctionnalité", "suggestion" → "suggestion" (inchangé)

3. **Adapter au format MkDocs Material** :
   - Structurer avec H1/H2/H3
   - Transformer les listes numérotées en étapes claires
   - Convertir les avertissements en admonitions `!!! warning`
   - Convertir les astuces en admonitions `!!! tip`
   - Séparer les sections IntelliJ/VS Code avec des onglets `=== "..."`

4. **Ajouter le contexte projet** :
   - Intégrer des références aux autres chapitres quand pertinent
   - Ajouter des exemples adaptés aux développeurs francophones si possible
   - Préciser si l'information est spécifique à une version de Copilot

5. **Créer le fichier et mettre à jour la nav** :
   - Nommer le fichier en kebab-case français
   - Ajouter l'entrée dans `mkdocs.yml`

## Règles de traduction des éléments UI

| Original (EN) | Traduction (FR) |
|---|---|
| Settings / Preferences | Paramètres |
| Extensions | Extensions |
| Command Palette | Palette de commandes |
| Marketplace | Marketplace (inchangé) |
| Status bar | Barre de statut |
| Sign in | Se connecter |
| Enable / Disable | Activer / Désactiver |
| Reload window | Recharger la fenêtre |
