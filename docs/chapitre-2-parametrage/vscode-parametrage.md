# :material-microsoft-visual-studio-code: Paramétrage Avancé — GitHub Copilot sur VS Code

<span class="badge-vscode">VS Code</span> <span class="badge-intermediate">Intermédiaire</span>

## Présentation

Ce guide couvre **tous les paramètres Copilot** pour VS Code : activation par langage, modes d'autocomplétion, actions de code, et configuration avancée.

---

## Accès aux Paramètres

### Méthode 1 : Interface Graphique (Recommandée pour débuter)

1. Ouvrez les préférences :
   - Windows/Linux : ++ctrl+comma++
   - macOS : ++cmd+comma++

2. Tapez `"copilot"` dans la barre de recherche

3. Tous les paramètres Copilot apparaissent avec descriptions

**Avantage** : Interface conviviale, documentation en ligne, aperçu immédiat.

### Méthode 2 : Fichier JSON (Recommandée pour équipes)

1. Ouvrez la palette de commandes : ++ctrl+shift+p++ (++cmd+shift+p++ macOS)
2. Tapez : `"Open User Settings (JSON)"`
3. Modifiez directement le fichier `settings.json`

**Avantage** : Plus rapide, peut être partagé en équipe, versionné dans Git.

!!! tip "User Settings vs Workspace Settings"
    Les **User Settings** s'appliquent à VS Code entièrement. Pour un projet spécifique, créez `.vscode/settings.json` **à la racine du projet** : les settings du workspace ont priorité.
    
    Exemple workspace settings `.vscode/settings.json` :
    ```json
    {
        "github.copilot.enable": {
            "plaintext": false,
            "markdown": false
        }
    }
    ```

---

## Référence Complète des Paramètres

### `github.copilot.enable`

**Description** : Activer/désactiver Copilot par type de fichier/langage.

**Type** : Objet `{ [langage]: boolean }`

**Défaut** : 
```json
{
    "github.copilot.enable": {
        "*": true
    }
}
```

**Exemples de cas d'usage** :

**Cas 1 — Désactiver pour fichiers sensibles**
```json
{
    "github.copilot.enable": {
        "*": true,
        "plaintext": false,
        "markdown": false,
        "dotenv": false,
        "env": false,
        "sql": false
    }
}
```

Effet :
- ✓ Copilot actif sur `.js`, `.python`, `.java`, etc.
- ✗ Copilot **inactif** sur `.env` (sécurité clés API), `.md` (documentation), `.sql` (sensible)

**Cas 2 — Activer sélectivement**
```json
{
    "github.copilot.enable": {
        "*": false,
        "javascript": true,
        "typescript": true,
        "python": true
    }
}
```

Effet : Copilot SEULEMENT sur JS, TS, Python. Désabusé ailleurs.

**Cas 3 — Actif partout sauf pour votre format custom**
```json
{
    "github.copilot.enable": {
        "*": true,
        "requirements": false,
        "dockerfile": false
    }
}
```

---

### `github.copilot.editor.enableAutoCompletions`

**Description** : Mode automatique vs manuel pour suggestions inline.

**Type** : Boolean

**Défaut** : `true`

**Valeurs** :

| Valeur | Comportement | Quand utiliser |
|--------|-------------|---|
| `true` | Suggestions automatiques pendant frappe | Développeurs normaux (défaut) |
| `false` | Mode manuel : ++alt+backslash++ pour déclencher | Mais très expérimentés / flux spécifique |

**Exemple** :
```json
{
    "github.copilot.editor.enableAutoCompletions": false
}
```

**Effet** : Vous devez appuyer ++alt+backslash++ pour déclencher Copilot. Pas de suggestions spontanées.

---

### `github.copilot.editor.enableCodeActions`

**Description** : Afficher les "Light Bulb" AI (actions rapides Copilot).

**Type** : Boolean

**Défaut** : `true`

**Exemples d'actions de code** :
- Ampoule jaune sur une erreur de console → clic → "Copilot: Fix This"
- Sélection de code → clic droit → "Copilot: Explain This"

**Exemple** :
```json
{
    "github.copilot.editor.enableCodeActions": true
}
```

---

### `github.copilot.editor.inlineSuggestCount`

**Description** : Nombre de suggestions à générer pour sélection (voir avec ++ctrl+enter++).

**Type** : Integer

**Défaut** : `3`

**Plage** : 1–10

**Exemple** :
```json
{
    "github.copilot.editor.inlineSuggestCount": 5
}
```

**Effet** : Vous pouvez naviguer ++alt+bracket-right/left++ parmi 5 suggestions au lieu de 3.

---

### `github.copilot.editor.tabCompletionEnabled`

**Description** : Utiliser ++tab++ pour accepter suggestion.

**Type** : Boolean

**Défaut** : `true`

**Exemple** :
```json
{
    "github.copilot.editor.tabCompletionEnabled": true
}
```

Si `false`, le ++tab++ se comporte normalement (indentation) et vous devez utiliser autre raccourci.

---

### `github.copilot.advanced`

**Description** : Paramètres avancés (debug, tuning bas niveau).

**Type** : Object

Contient `debug.*`, `listCount`, `inlineSuggestCount`, etc.

**Exemple complet**:
```json
{
    "github.copilot.advanced": {
        "debug.overrideEngine": "",
        "debug.overrideLogLevels": {},
        "debug.testOverrideProxyUrl": "",
        "debug.useNodeFetcher": false,
        "listCount": 10,
        "inlineSuggestCount": 3,
        "authProvider": "github"
    }
}
```

**Cas d'usage** : Rarement utilisé. Surtout pour diagnostique avec support GitHub.

---

## Custom Instructions (Personnalisation Avancée)

### Qu'est-ce que les Custom Instructions ?

Les **Custom Instructions** sont des directives que vous donnez à Copilot pour adapter son comportement à **vos besoins spécifiques**.

**Exemple** : "Toujours utiliser TypeScript strict mode" ou "Ne jamais suggérer `var`".

### Repository-Level Instructions

Fichier : `.github/copilot-instructions.md` (à la racine du projet)

**Exemple** :
```markdown
# Copilot Instructions pour ce projet

## Contraintes de Style
- Utiliser TypeScript **strict mode**
- Pas de `any` type
- Préférer les `interfaces` aux `type` unions
- Prettier formatting (80 caractères max pour longues lignes)

## Conventions
- Noms de fonction : camelCase
- Noms de classe : PascalCase
- Constantes: UPPER_SNAKE_CASE

## Interdictions Sécurité
- **Jamais** écrire des clés API en dur
- Pas de mots de passe en suggestions
- Pas d'information sensible dans logs

## Frameworks Autorisés
- React 19+ (hooks, Suspense, RSC)
- Next.js 15+
- TailwindCSS 4

## Dépendances Favorisées
- PostgreSQL pour la DB
- Prisma pour l'ORM
- Jest pour les tests
```

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

## Modèles IA par Plan

Copilot supporte plusieurs modèles IA selon votre plan :

| Plan | Modèles Disponibles |
|------|---|
| **Free** | Claude Haiku 4.5, GPT-5 mini, Grok Code Fast 1 |
| **Pro** | Claude Haiku 4.5, GPT-5, Claude 3.5 Sonnet, Gemini 2 |
| **Pro+** | ✓ **Tous les modèles** (complet) |
| **Enterprise** | Selon config org + custom models |

Sélection du modèle :
- Dans Chat : Vous sélectionnez via dropdown
- Dans suggestions inline : Copilot choisit le mieux adapté

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
- [Contexte & Personnalisation](../chapitre-3-contexte/vscode-contexte.md)
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
// .vscode/settings.json (dans le projet)
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

## Prochaines étapes

- [Comparaison des paramètres](comparaison-parametres.md) — IntelliJ vs VS Code côte à côte
- [Contexte projet VS Code](../chapitre-3-contexte/vscode-contexte.md) — Fichiers `.instructions.md`, `.copilotignore`
- [Instructions & Personnalisation](../chapitre-3-contexte/instructions.md) — Aller plus loin avec les instructions Copilot
