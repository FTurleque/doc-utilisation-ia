# Captures — IntelliJ IDEA

Ce dossier contient principalement des captures **GitHub Copilot** existantes. Elles sont conservées comme références. Les futures captures génériques doivent privilégier Claude Code lorsque l'interface est pertinente pour le parcours principal.

## Inventaire actuel

Captures Copilot / GitHub présentes dans le dépôt :

- `auth-dialog.png`
- `chat-copilot-1.png`
- `chat-copilot-2.png`
- `chat-copilot-3.png`
- `completions-copilot.png`
- `copilot-chat-panel.png`
- `customizations-copilot-agent-prompt-skill.png`
- `customizations-copilot-instructions.png`
- `general-copilot.png`
- `github-auth-browser.png`
- `github-mcp-registry.png`
- `keymap-copilot.png`
- `marketplace-search.png`
- `plugins-menu.png`
- `settings-copilot.png`
- `status-bar-icon.png`

Autre image conservée : `mark-directoy-as.jpg`.

Cette liste décrit **ce qui existe réellement** ; elle n'est pas une promesse que chaque capture est encore identique à l'UI actuelle. Vérifier la page qui l'utilise et la version du produit avant de s'appuyer sur un détail visuel.

## Nouvelles captures

Convention recommandée :

```text
intellij-{produit}-{fonction}-{numero}.png
```

Exemples :

```text
intellij-claude-plugin-01.png
intellij-claude-chat-01.png
intellij-copilot-settings-02.png
```

Pour Claude Code, ne capturer que les écrans qui apportent une valeur visuelle durable : installation du plugin, panneau IDE, permissions ou diagnostic. Les commandes CLI et configurations textuelles sont mieux documentées en Markdown/JSON.

## Qualité

- utiliser une version stable compatible d'IntelliJ IDEA ;
- noter la version du plugin dans la PR si l'écran est version-sensible ;
- masquer comptes, dépôts privés, chemins locaux et secrets ;
- garder le texte lisible ;
- ne pas retoucher une UI pour simuler un état qui n'a pas été observé.

Voir `../SCREENSHOTS-GUIDE.md` et `CAPTURE-TEMPLATE.md`.
