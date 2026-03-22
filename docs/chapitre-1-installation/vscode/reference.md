# :material-microsoft-visual-studio-code: Guide Référence — GitHub Copilot sur VS Code

<span class="badge-vscode">VS Code</span> <span class="badge-intermediate">Intermédiaire</span>

## Présentation

Ce guide de référence est votre documentation complète pour GitHub Copilot sur VS Code : installations, raccourcis, fonctionnalités, et paramètres techniques.

---

## Installation & Authentification

### Localisation des fichiers VS Code

Les paramètres et configurations VS Code sont stockés à :

=== "Windows"
    ```
    %APPDATA%\Code\User\
    ```
    Chemin complet : `C:\Users\[SonNom]\AppData\Roaming\Code\User\`

=== "macOS"
    ```
    ~/Library/Application Support/Code/User/
    ```

=== "Linux"
    ```
    ~/.config/Code/User/
    ```

### Fichier `settings.json`

Le fichier `settings.json` contient **tous** les paramètres VS Code (incluant Copilot).

**Accès rapide :**

| Méthode | Raccourci/Action |
|---------|------------------|
| **Interface UI** | ++ctrl+comma++ (ou ++cmd+comma++ macOS) |
| **Fichier JSON** | ++ctrl+shift+p++ → `Open User Settings (JSON)` |
| **Via Menu** | *File → Preferences → Settings* → icône `{}` en haut à droite |

!!! tip "User Settings vs Workspace Settings"
    - **User Settings** (`%APPDATA%\Code\User\settings.json`) : globaux, s'appliquent à tous les projets
    - **Workspace Settings** (`.vscode/settings.json` dans le projet) : locaux au projet, **priorité plus haute**
    
    Utilisez Workspace Settings pour des configs par projet (ex: désactiver Copilot pour certains fichiers sensibles).

---

## Raccourcis Clavier Complets

### Suggestions Inline (Autocomplétion)

=== "Windows / Linux"

    | Action | Raccourci |
    |--------|-----------|
    | **Accepter la suggestion** | ++tab++ |
    | **Accepter mot par mot** | ++ctrl+right++ |
    | **Suggestion suivante** | ++alt+bracket-right++ |
    | **Suggestion précédente** | ++alt+bracket-left++ |
    | **Rejeter / Fermer suggestion** | ++escape++ |
    | **Déclencher Copilot manuellement** | ++alt+backslash++ |
    | **Voir les 10 meilleures suggestions** | ++ctrl+enter++ |

=== "macOS"

    | Action | Raccourci |
    |--------|-----------|
    | **Accepter la suggestion** | ++tab++ |
    | **Accepter mot par mot** | ++option+right++ |
    | **Suggestion suivante** | ++option+bracket-right++ |
    | **Suggestion précédente** | ++option+bracket-left++ |
    | **Rejeter / Fermer suggestion** | ++escape++ |
    | **Déclencher Copilot manuellement** | ++option+backslash++ |
    | **Voir les 10 meilleures suggestions** | ++ctrl+enter++ |

=== "Linux"

    | Action | Raccourci |
    |--------|-----------|
    | **Accepter la suggestion** | ++tab++ |
    | **Accepter mot par mot** | ++ctrl+right++ |
    | **Suggestion suivante** | ++alt+bracket-right++ |
    | **Suggestion précédente** | ++alt+bracket-left++ |
    | **Rejeter / Fermer suggestion** | ++escape++ |
    | **Déclencher Copilot manuellement** | ++alt+backslash++ |
    | **Voir les 10 meilleures suggestions** | ++ctrl+enter++ |

### Copilot Chat

=== "Windows / Linux"

    | Action | Raccourci |
    |--------|-----------|
    | **Ouvrir Chat (panneau droit)** | ++ctrl+alt+i++ |
    | **Inline Chat (dans l'éditeur)** | ++ctrl+i++ |
    | **Quick Chat (fenêtre flottante)** | ++ctrl+shift+i++ |
    | **Focus Chat** (si déjà ouvert) | ++ctrl+shift+alt+i++ |

=== "macOS"

    | Action | Raccourci |
    |--------|-----------|
    | **Ouvrir Chat (panneau droit)** | ++cmd+alt+i++ |
    | **Inline Chat (dans l'éditeur)** | ++cmd+i++ |
    | **Quick Chat (fenêtre flottante)** | ++cmd+shift+i++ |
    | **Focus Chat** (si déjà ouvert) | ++cmd+shift+alt+i++ |

=== "Linux"

    | Action | Raccourci |
    |--------|-----------|
    | **Ouvrir Chat (panneau droit)** | ++ctrl+alt+i++ |
    | **Inline Chat (dans l'éditeur)** | ++ctrl+i++ |
    | **Quick Chat (fenêtre flottante)** | ++ctrl+shift+i++ |
    | **Focus Chat** (si déjà ouvert) | ++ctrl+shift+alt+i++ |

### Menu Contextuel Copilot

Clic droit sur du code sélectionné → *Copilot* :

- **Ask Copilot** : Ouvrir Chat avec le code en contexte
- **Explain This** : Génère une explication du code
- **Fix This** : Génère une correction de bug
- **Generate Tests** : Crée des tests unitaires
- **Generate Docs** : Génère la documentation

### Copilot Edits (Modification Multi-Fichiers)

=== "Windows / Linux"

    | Action | Raccourci |
    |--------|-----------|
    | **Ouvrir Copilot Edits** | ++ctrl+shift+alt+o++ |
    | **Mode d'édition** | Utiliser l'interface Edits (GUI) |

=== "macOS"

    | Action | Raccourci |
    |--------|-----------|
    | **Ouvrir Copilot Edits** | ++cmd+shift+alt+o++ |

!!! info "Copilot Edits"
    Permet d'effectuer des modifications sur **plusieurs fichiers** à la fois, soit en mode AI autonome (agent) soit en mode collaboratif (vous approuvez chaque changement).

---

## Vue d'ensemble des Fonctionnalités

### Inline Suggestions

**Quoi** : Suggestions de code automatiques pendant que vous tapez.

**Où** : L'éditeur principal.

**Cas d'usage** :
- Complétions de lignes
- Génération de fonctions à partir de commentaires
- Getters/setters, boilerplate

**Raccouir** : ++alt+backslash++ (déclencher manuellement)

**Avantage** : Très rapide, flux continu, surtout pour code répétitif.

---

### Copilot Chat

**Quoi** : Interface conversationnelle pour des questions complexes.

**Où** : Panneau droit VS Code (par défaut) / fenêtre flottante / inline dans l'éditeur.

**Cas d'usage** :
- Questions exploratoires ("Comment implémenter un composant React ?")
- Explications de code existant
- Debugging et diagnostique
- Génération de tests / docs

**Raccourci** : ++ctrl+alt+i++ (panneau) / ++ctrl+i++ (inline) / ++ctrl+shift+i++ (quick)

**Avantage** : Contexte riche, explications détaillées, slash commands (`/explain`, `/tests`, `/doc`).

---

### Copilot Edits (Multi-fichiers)

**Quoi** : Modification AI-autonome ou semi-autonome de **plusieurs fichiers**.

**Où** : Interface dédiée (vue Edits).

**Cas d'usage** :
- Grandes refactorings
- Migrations de dépendances
- Restructurations d'architecture

**Raccourci** : ++ctrl+shift+alt+o++ / Commande *"Copilot: Open Edits"*

**Avantage** : Effectue plusieurs changements coordonnés, itère automatiquement.

**Note** : Disponible sur Copilot Pro+ et entreprise (pas sur Free).

---

### Copilot Code Review

**Quoi** : Suggestions d'amélioration pour les pull requests.

**Où** : GitHub.com (dans la PR) / VS Code (pour reviews locales).

**Cas d'usage** :
- Identifier problèmes de sécurité
- Suggérer refactorings
- Vérifier maintenabilité

**Plans** :
- **Free** : review sur sélection manuelle
- **Pro+/Enterprise** : review complète automatique

---

### Custom Instructions

**Quoi** : Instructions personnalisées pour adapter Copilot à **votre workflow**.

**Où** : 
- Repository-level : `.github/copilot-instructions.md` (dans le projet)
- Personal-level : GitHub settings (votre profil)
- Organization-level : Admin GitHub (Enterprise+)

**Cas d'usage** :
- Imposer un style de code (TypeScript strict, pas de `var`)
- Libérer Copilot vers certaines APIs ou frameworks
- Restrictions de sécurité (pas de secrets en suggestions)

---

### Copilot Agents

**Quoi** : Copilot **autonome** effectuant des tâches complexes (créer une PR, corriger un bug, implémenter une feature).

**Où** : VS Code Chat, ou invoqué depuis GitHub.com.

**Cas d'usage** :
- Assigner une GitHub Issue → Copilot crée une PR
- "Implémente une fonction de tri complète avec tests"

**Plans** : Copilot Pro+ et Enterprise uniquement (pas Free).

---

### Copilot CLI

**Quoi** : Utiliser Copilot en ligne de commande (Terminal).

**Commandes** :
```bash
# Demander un conseil
gh copilot explain "ls -la"

# Générer une commande
gh copilot suggest "Lister tous les fichiers Python"

# Modifier localement
gh copilot version
```

**Disponibilité** : Tous les plans (Free et payants).

---

## Paramètres GitHub Copilot

### `github.copilot.enable`

**Activation/désactivation par langage.**

```json
{
    "github.copilot.enable": {
        "*": true,
        "plaintext": false,
        "markdown": false,
        "dotenv": false
    }
}
```

**Effets** :
- `"*": true` : Activepar défaut pour tous les langages
- `"plaintext": false` : Désactive pour fichiers `.txt`
- `"dotenv": false` : Désactive pour `.env` (sécurité)

---

### `github.copilot.editor.enableAutoCompletions`

**Mode auto vs manuel**

```json
{
    "github.copilot.editor.enableAutoCompletions": true
}
```

| Valeur | Comportement |
|--------|-------------|
| `true` (défaut) | Suggestions automatiques pendant frappe |
| `false` | Mode manuel : déclencher avec ++alt+backslash++ |

**Quand utiliser `false`** : Développeurs expérimentés qui veulent contrôle total.

---

### `github.copilot.editor.enableCodeActions`

**Activer les actions de code Copilot (ampoule IA, suggestions).**

```json
{
    "github.copilot.editor.enableCodeActions": true
}
```

Si `true` :
- L'ampoule jaune IA apparaît pour les erreurs/warnings
- Cliquer → suggestions Copilot directes

---

### `github.copilot.editor.inlineSuggestCount`

**Nombre de suggestions à générer.**

```json
{
    "github.copilot.editor.inlineSuggestCount": 3
}
```

- Min `1`, Max `10`
- Plus de suggestions = plus d'options, mais plus lent

---

### `github.copilot.advanced`

**Paramètres de debug et tuning avancé.**

```json
{
    "github.copilot.advanced": {
        "debug.overrideEngine": "",
        "debug.overrideLogLevels": {},
        "debug.testOverrideProxyUrl": "",
        "debug.useNodeFetcher": false,
        "listCount": 10,
        "authProvider": "github"
    }
}
```

Rarement nécessaire en usage normal (pour debug/diagnostique).

---

## Personalisation des Raccourcis Clavier

Vous pouvez **redéfinir les raccourcis** Copilot.

### Accès aux keybindings

1. Ouvrez la palette : ++ctrl+shift+p++
2. Tapez `"Preferences: Open Keyboard Shortcuts"`
3. Cherchez `"copilot"` ou `"github"`
4. Cliquez sur le raccourci à modifier, tapez le nouveau

### Exemple : Changer "Accepter suggestion" de Tab à Enter

```json
{
    "key": "enter",
    "command": "editor.action.inlineSuggest.commit",
    "when": "inlineSuggestVisible"
}
```

---

## Dépannage Rapide

| Problème | Solution |
|----------|----------|
| **Copilot ne suggère rien** | Vérifiez extension installée, authentifié, et `enableAutoCompletions: true` |
| **Erreur d'authentification** | Sign out → Sign in (++ctrl+shift+p++ → "GitHub Copilot: Sign In") |
| **Suggestions très mauvaises** | Lisez [Best Practices](../../chapitre-4-bonnes-pratiques/utilisation-effective.md), améliorez vos prompts |
| **Performance VS Code ralentie** | Réduisez `inlineSuggestCount`, désactivez pour certains langages gros fichiers |
| **Chat n'apparaît pas** | Installez "GitHub Copilot Chat", rechargez VS Code |

---

## Ressources

- **Docs officielles** : [docs.github.com/copilot](https://docs.github.com/en/copilot)
- **Raccourcis VS Code** : ++ctrl+k++ ++ctrl+s++ (ouvre éditeur raccourcis)
- **Extensions recommandées** : Voir [Chapitre 7 — CLI & Modes](../../chapitre-7-cli-modes/index.md)

---

## Personnaliser les raccourcis (keybindings.json)

Pour modifier un raccourci Copilot :

1. Ouvrez le fichier keybindings : ++ctrl+shift+p++ → *"Open Keyboard Shortcuts (JSON)"*
2. Ajoutez une entrée au tableau JSON :

```json
[
  {
    "key": "ctrl+space",
    "command": "editor.action.inlineSuggest.trigger",
    "when": "editorTextFocus && !editorHasSelection"
  },
  {
    "key": "ctrl+tab",
    "command": "editor.action.inlineSuggest.acceptNextWord",
    "when": "inlineSuggestionVisible"
  }
]
```

### Identifiants des commandes Copilot utiles

| Commande | Identifiant |
|----------|-------------|
| Déclencher suggestion | `editor.action.inlineSuggest.trigger` |
| Accepter suggestion | `editor.action.inlineSuggest.commit` |
| Accepter mot suivant | `editor.action.inlineSuggest.acceptNextWord` |
| Suggestion suivante | `editor.action.inlineSuggest.showNext` |
| Suggestion précédente | `editor.action.inlineSuggest.showPrevious` |
| Rejeter suggestion | `editor.action.inlineSuggest.hide` |
| Ouvrir Chat | `workbench.panel.chat.view.copilot.focus` |
| Inline Chat | `inlineChat.start` |

---

## Extensions recommandées à installer avec Copilot

| Extension | Identifiant | Utilité |
|-----------|-------------|---------|
| **GitHub Copilot Chat** | `GitHub.copilot-chat` | Interface de chat avec Copilot *(indispensable)* |
| **GitHub Pull Requests** | `GitHub.vscode-pull-request-github` | Gestion des PR directement dans VS Code |
| **GitLens** | `eamodio.gitlens` | Historique Git enrichi — complémentaire à Copilot |
| **Error Lens** | `usernamehw.errorlens` | Affiche les erreurs inline — aide Copilot à cibler les corrections |
| **Auto Rename Tag** | `formulahendry.auto-rename-tag` | Complémente les suggestions HTML/JSX de Copilot |

!!! tip "Pack d'extensions"
    Vous pouvez créer un fichier `.vscode/extensions.json` dans votre projet pour recommander ces extensions à toute votre équipe :

    ```json
    {
        "recommendations": [
            "GitHub.copilot",
            "GitHub.copilot-chat",
            "GitHub.vscode-pull-request-github"
        ]
    }
    ```

---

## Exécution des paramètres Copilot dans settings.json

Exemple minimal d'un `settings.json` configuré pour Copilot :

```json
{
    "github.copilot.enable": {
        "*": true,
        "markdown": false,
        "plaintext": false
    },
    "github.copilot.editor.enableAutoCompletions": true,
    "github.copilot.chat.localeOverride": "fr"
}
```

Pour les paramètres complets avec explications détaillées, voir [Paramétrage VS Code](../../chapitre-2-parametrage/vscode-parametrage.md).

---

## Gestion des extensions

### Désactiver Copilot temporairement

- Cliquez sur l'icône Copilot dans la barre de statut (en bas)
- Sélectionnez "Disable Copilot" pour désactiver globalement ou pour le workspace courant

### Désactiver pour un langage spécifique

```json
{
    "github.copilot.enable": {
        "*": true,
        "sql": false,
        "markdown": false
    }
}
```

### Mettre à jour les extensions

VS Code met à jour automatiquement les extensions. Pour forcer une mise à jour manuelle :
1. Extensions panel → menu `...` → *"Check for Extension Updates"*
2. Ou : ++ctrl+shift+p++ → *"Extensions: Check for Extension Updates"*

