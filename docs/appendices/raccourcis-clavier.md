# Raccourcis Clavier — Référence Complète

Référence exhaustive de tous les raccourcis GitHub Copilot pour IntelliJ IDEA et VS Code, sur Windows, macOS et Linux.

---

## VS Code — Raccourcis Copilot

### Suggestions inline

| Action | Windows / Linux | macOS |
|--------|----------------|-------|
| Accepter la suggestion | ++tab++ | ++tab++ |
| Rejeter la suggestion | ++escape++ | ++escape++ |
| Suggestion suivante | ++alt+bracket-right++ | ++option+bracket-right++ |
| Suggestion précédente | ++alt+bracket-left++ | ++option+bracket-left++ |
| Voir toutes les suggestions | ++ctrl+enter++ | ++cmd+enter++ |
| Accepter le mot suivant | ++ctrl+right++ | ++cmd+right++ |
| Accepter la ligne suivante | ++ctrl+alt+right++ | ++cmd+option+right++ |

### Copilot Chat

| Action | Windows / Linux | macOS |
|--------|----------------|-------|
| Ouvrir le panneau Chat | ++ctrl+alt+i++ | ++cmd+option+i++ |
| Ouvrir Quick Chat | ++ctrl+shift+i++ | ++cmd+shift+i++ |
| Ouvrir Inline Chat | ++ctrl+i++ | ++ctrl+i++ |
| Nouvelle conversation Chat | Icône + dans le panneau | Icône + dans le panneau |
| Envoyer le message | ++enter++ | ++enter++ |
| Nouvelle ligne dans le chat | ++shift+enter++ | ++shift+enter++ |
| Arrêter la génération | ++escape++ ou bouton Stop | ++escape++ ou bouton Stop |

### Variables de chat spéciales

| Variable | Description |
|----------|-------------|
| `@workspace` | Contexte de tout le workspace |
| `@vscode` | Questions sur VS Code lui-même |
| `@terminal` | Contexte du terminal actif |
| `#file` | Référencer un fichier spécifique |
| `#selection` | Référencer la sélection courante |
| `#codebase` | Recherche sémantique dans le projet |

### Commandes de la palette

| Commande | Description |
|----------|-------------|
| `GitHub Copilot: Enable Completions` | Activer les suggestions |
| `GitHub Copilot: Disable Completions` | Désactiver les suggestions |
| `GitHub Copilot: Sign In` | Connexion |
| `GitHub Copilot: Sign Out` | Déconnexion |
| `GitHub Copilot: Open Completions Panel` | Ouvrir le panneau des suggestions |
| `GitHub Copilot: Report Issue` | Signaler un problème |

---

## IntelliJ IDEA — Raccourcis Copilot

### Suggestions inline

| Action | Windows / Linux | macOS |
|--------|----------------|-------|
| Accepter la suggestion | ++tab++ | ++tab++ |
| Rejeter la suggestion | ++escape++ | ++escape++ |
| Suggestion suivante | ++alt+bracket-right++ | ++option+bracket-right++ |
| Suggestion précédente | ++alt+bracket-left++ | ++option+bracket-left++ |
| Déclencher manuellement | ++alt+backslash++ | ++option+backslash++ |
| Accepter le mot suivant | ++ctrl+right++ | ++option+right++ |

### Copilot Chat (IntelliJ)

| Action | Windows / Linux | macOS |
|--------|----------------|-------|
| Ouvrir Copilot Chat | Icône dans la sidebar | Icône dans la sidebar |
| Inline Chat / Ask Copilot | ++alt+enter++ sur sélection | ++option+enter++ sur sélection |
| Expliquer le code sélectionné | Clic droit → Copilot → Explain | Clic droit → Copilot → Explain |
| Générer des tests | Clic droit → Copilot → Generate Tests | Clic droit → Copilot → Generate Tests |
| Corriger un problème | Clic droit → Copilot → Fix | Clic droit → Copilot → Fix |

### Accès via le menu contextuel (clic droit)

| Action | Chemin |
|--------|--------|
| Expliquer | Clic droit → GitHub Copilot → Explain This |
| Générer tests | Clic droit → GitHub Copilot → Generate Tests |
| Suggérer noms | Clic droit → GitHub Copilot → Suggest Variable Names |
| Corriger | Clic droit → GitHub Copilot → Fix This |

### Actions dans IntelliJ (++ctrl+shift+a++)

Cherchez "Copilot" dans la boîte de recherche des actions pour trouver toutes les actions disponibles selon votre version.

---

## Claude Code — raccourcis et commandes

Claude Code étant centré sur la **CLI**, l'essentiel du pilotage passe par des **commandes slash** dans le REPL plutôt que par des raccourcis clavier. Cette section récapitule les deux.

!!! info "Vérifier selon votre version"
    Les raccourcis des extensions Claude (VS Code, JetBrains) évoluent et peuvent être personnalisés. En cas de doute, consultez la palette de commandes (VS Code) ou **Settings → Keymap** (JetBrains).

### Commandes slash du REPL (toutes plateformes)

| Commande | Description |
|----------|-------------|
| `/help` | Liste les commandes disponibles |
| `/init` | Génère un `CLAUDE.md` de départ |
| `/status` | Compte, plan, modèle et version |
| `/login` · `/logout` | Gérer l'authentification |
| `/model` | Changer de modèle (Haiku / Sonnet / Opus) |
| `/clear` | Vider le contexte de la conversation |
| `/compact` | Résumer/compacter le contexte |
| `/config` | Ouvrir la configuration |
| `/memory` | Éditer les fichiers mémoire (`CLAUDE.md`) |
| `/agents` | Gérer les subagents |
| `/mcp` | Gérer les serveurs MCP |
| `/plugin` | Gérer les plugins |
| `/cost` | Afficher le coût en tokens de la session |

### Raccourcis dans le REPL

| Action | Raccourci |
|--------|-----------|
| Interrompre la génération | ++escape++ |
| Nouvelle ligne dans le prompt | ++shift+enter++ |
| Envoyer le message | ++enter++ |
| Quitter la session | ++ctrl+c++ (deux fois) ou `/exit` |
| Référencer un fichier | `@chemin/fichier` |
| Référencer un dossier | `@chemin/dossier/` |

### Références de contexte (équivalent des variables Copilot)

| Claude Code | Équivalent Copilot |
|-------------|--------------------|
| `@fichier:chemin` | `#file` |
| `@dossier/` | `#codebase` (recherche) |
| Sélection IDE | `#selection` |
| `` !`commande` `` (dans une command) | — (injection dynamique) |

### VS Code & JetBrains — points d'entrée

| Action | VS Code | JetBrains |
|--------|---------|-----------|
| Ouvrir le panneau Claude | Icône barre latérale / palette `Claude` | Fenêtre d'outils Claude Code |
| Terminal Claude intégré | Terminal intégré → `claude` | Terminal intégré → `claude` |
| Personnaliser les raccourcis | ++ctrl+k++ ++ctrl+s++ → « Claude » | Settings → Keymap → « Claude » |

!!! tip "Le terminal reste le point d'entrée universel"
    Quel que soit l'IDE, ouvrir un terminal intégré et lancer `claude` donne accès à **toutes** les commandes slash, identiques sur Windows, macOS et Linux.

---

## Comparaison côte-à-côte

| Action | VS Code Windows | IntelliJ Windows |
|--------|----------------|-----------------|
| Accepter suggestion | ++tab++ | ++tab++ |
| Rejeter suggestion | ++escape++ | ++escape++ |
| Suggestion suivante | ++alt+bracket-right++ | ++alt+bracket-right++ |
| Inline Chat | ++ctrl+i++ | ++alt+enter++ (contextuel) |
| Ouvrir Chat | ++ctrl+alt+i++ | Via sidebar |
| Quick Chat | ++ctrl+shift+i++ | Non disponible |
| Déclencher manuellement | ++alt+backslash++ | ++alt+backslash++ |

---

## Personnaliser les raccourcis

=== ":material-microsoft-visual-studio-code: VS Code"
    ++ctrl+k++ ++ctrl+s++ → Raccourcis clavier → Recherchez "copilot"
    
    Ou modifiez directement `keybindings.json` :
    ```json
    [
        {
            "key": "ctrl+shift+space",
            "command": "editor.action.inlineSuggest.trigger",
            "when": "editorTextFocus"
        }
    ]
    ```

=== ":simple-intellijidea: IntelliJ"
    **Settings → Keymap** → Recherchez "Copilot" dans le champ de recherche.
    
    Double-cliquez sur une action pour lui assigner un raccourci personnalisé.
