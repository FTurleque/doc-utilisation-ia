# Captures — Visual Studio Code

Ce dossier contient actuellement des captures **GitHub Copilot** conservées comme références. Claude Code étant le parcours principal du dépôt, les nouvelles captures génériques doivent le privilégier lorsqu'une image apporte une information utile.

## Inventaire actuel

Fichiers présents :

- `vscode-auth-github-01.png`
- `vscode-chat-sidebar-01.png`
- `vscode-install-button-01.png`
- `vscode-marketplace-01.png`
- `vscode-status-bar-icon.png`

Ces images décrivent des écrans observés au moment de leur capture. Elles ne constituent pas une checklist de fonctionnalités actuelles et ne garantissent pas qu'un libellé, raccourci ou bouton est encore identique dans la dernière version.

## Nouvelles captures

Convention recommandée :

```text
vscode-{produit}-{fonction}-{numero}.png
```

Exemples :

```text
vscode-claude-chat-01.png
vscode-claude-permissions-01.png
vscode-copilot-marketplace-02.png
```

Ne renommez pas les images existantes sans mettre à jour toutes leurs références.

## Priorités Claude Code

Une nouvelle capture Claude est pertinente principalement pour :

- installation/intégration VS Code ;
- panneau Claude Code ;
- permissions et interactions IDE ;
- diagnostic ou réglage dont l'emplacement UI est difficile à expliquer uniquement par texte.

Pour les commandes CLI, rules, skills, agents, hooks ou settings JSON, privilégier les exemples texte qui vieillissent mieux.

## Qualité

- utiliser une version stable compatible de VS Code ;
- documenter la version de l'extension dans la PR si nécessaire ;
- masquer compte, dépôts privés, secrets et chemins personnels ;
- garder suffisamment de contexte pour comprendre l'écran ;
- ne pas fabriquer de device code ou d'état d'interface.

Voir `../SCREENSHOTS-GUIDE.md` et `CAPTURE-TEMPLATE.md`.
