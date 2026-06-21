# :material-microsoft-visual-studio-code: Paramétrage Avancé — GitHub Copilot sur VS Code

<span class="badge-vscode">VS Code</span> <span class="badge-intermediate">Intermédiaire</span>

## Présentation

Ce guide couvre **tous les paramètres Copilot** pour VS Code : activation par langage, modes d'autocomplétion, actions de code, et configuration avancée.

---

## Accès aux Paramètres

### Méthode 1 : Interface Graphique (Recommandée pour débuter)

1. Ouvrez les préférences :

=== "Windows/Linux"

    ++ctrl+comma++

**Effet** :
- Copilot **lit automatiquement** ce fichier
- Toutes ses suggestions respectent ces contraintes
- S'applique à toute équipe qui clone le repo

### Personal-Level Instructions

1. Allez sur [github.com/settings/copilot](https://github.com/settings/copilot)
2. Scroll jusqu'à **"Copilot personalization"**
3. Ajoutez vos instructions personnelles (400 caractères max)

**Exemple** :
```
Je suis expert Python/Django. Préfère les class-based views. 
Utilise PostgreSQL + SQLAlchemy. Format PEP 8 strict.
```

**Effet** : Vos instructions s'appliquent à **tous vos repos** (Global).

### Organization-Level Instructions (Enterprise+)

Disponible pour administrateurs GitHub Enterprise :
- Settings → Code security → Copilot configuration
- Configure instructions pour **toute l'org**

---

## 🔗 Model Context Protocol (MCP)

### Qu'est-ce que MCP ?

Model Context Protocol est un **protocole standard** qui permet à Copilot d’utiliser des **outils et données externes** dans le Chat. Pour ce chapitre, retiens surtout ceci : un MCP doit **filtrer le contexte**, pas le gonfler.

### À retenir

- Le client IA appelle un serveur MCP.
- Le serveur expose des tools et des resources.
- Les transports courants sont `stdio` et HTTP.
- Un serveur bien borné renvoie peu de données, mais les bonnes données.

### Lecture recommandée

- [Présentation et choix](../chapitre-13-outils-economies/mcps/index.md)
- [MCP Web local](../chapitre-13-outils-economies/mcps/configuration.md)
- [MCP Web gratuit](../chapitre-13-outils-economies/mcps/serveurs.md)
- [Comparaison](../chapitre-13-outils-economies/mcps/securite.md)

!!! warning "Contexte et coût"
    Un MCP mal borné peut augmenter le contexte injecté dans Copilot et donc le coût d’usage. Garde les résultats courts, les domaines filtrés et les outils strictement nécessaires.

---

## Configuration des Raccourcis Clavier

### Modifier les Raccourcis

1. ++ctrl+shift+p++ → `"Preferences: Open Keyboard Shortcuts"`
2. Cherchez le raccourci (ex: `"copilot"`, `"inlineSuggest"`)
3. Double-cliquez pour éditer, tapez le nouveau raccourci

### Exemple : Changer "Accepter" de Tab à Entrée

Cherchez `editor.action.inlineSuggest.commit` et modifiez la bind :

```json
{
    "key": "enter",
    "command": "editor.action.inlineSuggest.commit",
    "when": "inlineSuggestVisible && !editorTextFocus"
}
```

### Commandes Copilot Disponibles

| Commande | Raccourci Défaut |
|----------|--|
| `editor.action.inlineSuggest.commit` | ++tab++ |
| `editor.action.inlineSuggest.hide` | ++escape++ |
| `editor.action.inlineSuggest.trigger` | ++alt+backslash++ |
| `github.copilot.openSymbolFromEditor` | `?` (dans Chat) |
| `workbench.action.chat.open` | ++ctrl+alt+i++ |

---

## Modèles IA par plan

La disponibilité des modèles évolue fréquemment. Utilisez la page officielle comme source de vérité: [Plans GitHub Copilot](https://docs.github.com/fr/copilot/get-started/plans).

| Plan | Positionnement |
|------|----------------|
| **Free** | Accès limité à un sous-ensemble de modèles |
| **Pro** | Modèles inclus + accès aux modèles avancés selon allocation AI Credits |
| **Pro+** | Accès élargi aux modèles avancés |
| **Business / Enterprise** | Accès piloté par l'organisation et ses politiques |

Sélection du modèle:
- Dans Chat: choix via le sélecteur de modèle
- En suggestions inline: sélection automatique par Copilot selon le contexte

---

## Configuration Privacy & Telemetry

### `telemetry.level`

**Description** : Envoyer usage anonyme à GitHub pour améliorer Copilot.

```json
{
    "telemetry.level": "all"
}
```

| Valeur | Comportement |
|--------|---|
| `"all"` | Toutes données anonymes (défaut) |
| `"error"` | Erreurs seulement |
| `"off"` | Aucun telemetry |

### `github.copilot.enable` pour Sécurité

Documentation sensible = settings restrictifs :

```json
{
    "github.copilot.enable": {
        "*": true,
        "dotenv": false,
        "env": false,
        "sql": false,
        "dockerfile": false
    }
}
```

---

## Exemples de Configurations Complètes

### Configurat Backend Python (Strict)

```json
{
    "github.copilot.enable": {
        "*": false,
        "python": true,
        "yaml": true,
        "json": true
    },
    "github.copilot.editor.enableAutoCompletions": true,
    "github.copilot.editor.enableCodeActions": true,
    "github.copilot.editor.inlineSuggestCount": 3,
    "telemetry.level": "off"
}
```

### Configuration Frontend TypeScript (Production)

```json
{
    "github.copilot.enable": {
        "*": true,
        "plaintext": false,
        "dotenv": false,
        "env": false
    },
    "github.copilot.editor.enableAutoCompletions": true,
    "github.copilot.editor.enableCodeActions": true,
    "github.copilot.editor.inlineSuggestCount": 5,
    "github.copilot.advanced": {
        "listCount": 10
    }
}
```

### Configuration Workspace (Désactiver pour le Projet)

Fichier `.vscode/settings.json` :

```json
{
    "github.copilot.enable": {
        "*": false
    }
}
```

Effet : Copilot désactivé **dans ce projet uniquement**, actif ailleurs.

---

## Dépannage

| Problème | Solution |
|----------|----------|
| **Copilot n'émet aucune suggestion** | Vérifiez `enableAutoCompletions: true` et `enable: {"*": true}` |
| **Performance VS Code ralentie** | Réduisez `inlineSuggestCount`, désactivez pour gros fichiers |
| **Suggestions ignoran votre style** | Créez `.github/copilot-instructions.md` with contraintes |
| **Raccourcis ne fonctionnent pas** | Allez dans *Preferences: Open Keyboard Shortcuts*, cherchez `copilot` |

---

## Ressources & Prochaines Étapes

- [Guide Installation](../chapitre-1-installation/vscode/tutoriel.md)
- [Guide Référence Complet](../chapitre-1-installation/vscode/reference.md)
- [Contexte & Personnalisation](../chapitre-4-contexte/vscode-contexte.md)
- [Docs Officielles](https://docs.github.com/en/copilot)
```

| Sous-paramètre | Description |
|----------------|-------------|
| `listCount` | Nombre de suggestions dans le panneau "Copilot: Open Completions Panel" (défaut: 10) |
| `inlineSuggestCount` | Nombre de suggestions inline à précharger (défaut: 1) |

---

### `github.copilot.chat.localeOverride`

**Quoi :** Force la langue d'interface de Copilot Chat, indépendamment de la langue de VS Code.

**Pourquoi :** Si VS Code est en anglais mais que vous voulez interagir avec Chat en français (ou vice versa).

```json
{
    "github.copilot.chat.localeOverride": "fr"
}
```

**Valeurs courantes :** `"auto"` (défaut), `"fr"`, `"en"`, `"de"`, `"ja"`, `"zh-CN"`

---

### `github.copilot.chat.useProjectTemplates`

**Quoi :** Autorise Copilot Chat à utiliser les templates de projet GitHub pour les suggestions de structure de projet.

```json
{
    "github.copilot.chat.useProjectTemplates": true
}
```

---

### `github.copilot.renameSuggestions.triggerAutomatically`

**Quoi :** Active les suggestions de renommage automatiques de Copilot lorsque vous renommez un symbole.

**Pourquoi :** Copilot peut suggérer des noms cohérents avec le style du projet quand vous renommez une variable ou une fonction.

```json
{
    "github.copilot.renameSuggestions.triggerAutomatically": true
}
```

---

### `editor.inlineSuggest.enabled`

**Quoi :** Paramètre VS Code natif (pas Copilot-spécifique) qui active les suggestions inline en général. **Doit être `true`** pour que Copilot fonctionne.

**Pourquoi :** Si vous avez désactivé l'inlineSuggest globalement dans VS Code pour d'autres raisons, Copilot ne pourra pas afficher ses suggestions.

```json
{
    "editor.inlineSuggest.enabled": true
}
```

!!! danger "Paramètre critique"
    Si `editor.inlineSuggest.enabled` est `false`, Copilot ne fonctionnera pas même s'il est activé. C'est l'une des causes les plus fréquentes de "Copilot ne donne aucune suggestion".

---

### `editor.suggest.preview`

**Quoi :** Affiche un aperçu de la complétion sélectionnée directement dans l'éditeur avant acceptation.

```json
{
    "editor.suggest.preview": false
}
```

!!! info "Conflit potentiel"
    Si `editor.suggest.preview` et les suggestions Copilot sont activés simultanément, vous pouvez voir deux types de suggestions en même temps. Certains développeurs préfèrent désactiver `preview` pour ne voir que les suggestions Copilot.

---

## Profils de configuration

### 🟢 Profil Débutant

```json
{
    "github.copilot.enable": {
        "*": true
    },
    "github.copilot.editor.enableAutoCompletions": true,
    "github.copilot.editor.enableCodeActions": true,
    "github.copilot.chat.localeOverride": "fr",
    "github.copilot.renameSuggestions.triggerAutomatically": true,
    "editor.inlineSuggest.enabled": true
}
```

### 🔴 Profil Expert

```json
{
    "github.copilot.enable": {
        "*": true,
        "plaintext": false,
        "markdown": false,
        "dotenv": false,
        "sql": false,
        "yaml": false
    },
    "github.copilot.editor.enableAutoCompletions": false,
    "github.copilot.editor.enableCodeActions": true,
    "github.copilot.chat.localeOverride": "auto",
    "github.copilot.advanced": {
        "inlineSuggestCount": 1
    },
    "editor.inlineSuggest.enabled": true
}
```

### 👥 Profil Équipe

À placer dans `.vscode/settings.json` à la racine du projet (versionné avec Git) :

```json
{
    "github.copilot.enable": {
        "*": true,
        "dotenv": false,
        "plaintext": false
    },
    "github.copilot.editor.enableAutoCompletions": true,
    "github.copilot.chat.localeOverride": "fr",
    "editor.inlineSuggest.enabled": true,
    "github.copilot.editor.enableCodeActions": true
}
```

!!! warning "Ne jamais versionner des secrets"
    Le fichier `.vscode/settings.json` peut être versionné — mais assurez-vous qu'il ne contient **aucun token, clé API ou mot de passe**. Les paramètres Copilot sont sûrs à versionner.

### ⚡ Profil Minimaliste

```json
{
    "github.copilot.enable": {
        "*": true,
        "markdown": false,
        "plaintext": false,
        "yaml": false,
        "json": false,
        "xml": false,
        "dotenv": false,
        "sql": false,
        "shellscript": false
    },
    "github.copilot.editor.enableAutoCompletions": false,
    "github.copilot.editor.enableCodeActions": false,
    "github.copilot.renameSuggestions.triggerAutomatically": false,
    "editor.inlineSuggest.enabled": true
}
```

---

## Paramètres workspace spécifiques (.vscode/settings.json)

Pour surcharger les paramètres utilisateur uniquement pour un projet :

```json
{
    "github.copilot.enable": {
        "*": true,
        "sql": false
    }
}
```

Les settings du workspace **ont la priorité** sur les settings utilisateur. Utile pour désactiver Copilot sur un projet contenant des données sensibles.

---

## Pièges à éviter

!!! danger "Erreurs de configuration courantes"

    **1. `editor.inlineSuggest.enabled` à `false`**
    Copilot ne peut pas afficher de suggestions.
    ✅ Vérifiez ce paramètre en premier si vous n'avez aucune suggestion.

    **2. Copilot désactivé pour un langage sans s'en souvenir**
    Vous ouvrez un fichier Python, aucune suggestion → Copilot est désactivé pour `"python"` dans `github.copilot.enable`.
    ✅ Vérifiez les langages dans `github.copilot.enable`.

    **3. `settings.json` avec erreur de syntaxe JSON**
    VS Code cesse de charger les settings si le JSON est invalide.
    ✅ VS Code affiche une erreur en bas → corrigez la syntaxe JSON (accolades, virgules).

    **4. Settings workspace qui écrasent les settings utilisateur**
    Un fichier `.vscode/settings.json` dans un projet peut désactiver Copilot uniquement dans ce projet.
    ✅ Vérifiez s'il existe un `.vscode/settings.json` avec des paramètres Copilot.

---

## Sources

- [Configuring GitHub Copilot in your environment](https://docs.github.com/en/copilot/configuring-github-copilot) - consulté le 2026-06-20
- [GitHub Copilot in VS Code — Settings reference](https://code.visualstudio.com/docs/copilot/copilot-settings) - consulté le 2026-06-20

## Prochaine étape

- [Comparaison des paramètres](comparaison-parametres.md) — IntelliJ vs VS Code côte à côte
