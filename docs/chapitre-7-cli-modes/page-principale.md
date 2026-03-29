# Modes CLI Copilot : Yolo, Review, Edit, Chat...

<span class="badge-intermediate">Intermédiaire</span>

## Présentation

La CLI Copilot permet d'utiliser différents modes pour automatiser des tâches : génération, revue, édition, chat, etc.

---

## Liste des modes disponibles

| Mode | Commande | Usage | Résultat |
|------|----------|-------|----------|
| yolo | `copilot yolo <fichier>` | Génère du code sans validation | Fichier modifié ou créé, sans review |
| review | `copilot review <fichier>` | Analyse et propose des corrections | Rapport de review, suggestions |
| edit | `copilot edit <fichier> --prompt "..."` | Modifie le code selon un prompt | Fichier modifié |
| chat | `copilot chat` | Dialogue interactif en ligne de commande | Réponses en temps réel |
| explain | `copilot explain <fichier>` | Explique le code sélectionné | Explication détaillée |
| test | `copilot test <fichier>` | Génère des tests pour le code | Fichier de test créé |

---

## Détail des modes

### Mode Yolo

!!! danger "Attention : mode non supervisé"
    Le mode yolo modifie le code sans validation ni review. À utiliser pour des prototypes ou des scripts jetables.

- Commande : `copilot yolo <fichier>`
- Usage : Génération rapide, sans contrôle qualité
- Résultat : Fichier modifié directement

### Mode Review

!!! tip "Pour sécuriser vos commits"
    Utilisez le mode review avant de pousser du code en production.

- Commande : `copilot review <fichier>`
- Usage : Analyse du code, suggestions d'amélioration
- Résultat : Rapport structuré, corrections proposées

### Mode Edit

- Commande : `copilot edit <fichier> --prompt "Refactorise en TypeScript strict"`
- Usage : Modification ciblée selon un prompt
- Résultat : Fichier modifié

### Mode Chat

- Commande : `copilot chat`
- Usage : Dialogue interactif, questions/réponses
- Résultat : Réponse en temps réel

### Mode Explain

- Commande : `copilot explain <fichier>`
- Usage : Explication du code
- Résultat : Explication détaillée

### Mode Test

- Commande : `copilot test <fichier>`
- Usage : Génération de tests unitaires
- Résultat : Fichier de test créé

---

## Exemples d'utilisation

```bash
copilot yolo src/app.js
copilot review src/app.js
copilot edit src/app.js --prompt "Ajoute des logs"
copilot chat
copilot explain src/app.js
copilot test src/app.js
```

---

## Résultats produits

- Fichiers modifiés ou créés
- Rapports de review
- Suggestions de correction
- Explications détaillées
- Tests unitaires

## CLI & automatisation

Le document source mentionnait une CLI avec :

```bash
npm install -g copilot
copilot
```

Et un mode avancé :

```bash
copilot --yolo -p "prompt"
```

!!! warning "Compatibilité des CLI"
    Les commandes CLI varient selon l'outil réellement installé (`copilot`, `gh`, extension IDE).
    Vérifiez toujours `--help` avant d'industrialiser un script.

=== "Notes divers"
    ### Plugins et écosystème
    - Atlassian / Jira
    - Chrome DevTools
    - Context7

---

## Bonnes pratiques

- Toujours tester le code généré en mode yolo
- Utiliser review pour valider les modifications
- Privilégier edit pour des changements précis
- Utiliser chat pour des questions complexes

---

## Prochaine étape

**[Comparaison des modes CLI VS Code / IntelliJ](comparaison.md)** : voir les différences de support et d'intégration selon l'IDE.

Concepts clés couverts :

- **Disponibilité par IDE** — quels modes fonctionnent sur VS Code et IntelliJ
- **Intégration éditeur** — terminal intégré, explorateur de fichiers, panels
- **Prompts `.prompt.md` en CLI** — réutiliser vos prompts sauvegardés depuis le terminal
- **Compatibilité** — les modes sont identiques dès lors que le terminal est configuré
