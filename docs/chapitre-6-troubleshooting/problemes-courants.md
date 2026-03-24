# Problèmes Courants

## 1. Copilot ne génère aucune suggestion

### Symptôme
Le curseur est dans un fichier de code, vous tapez, mais aucune suggestion "ghost text" n'apparaît.

### Causes possibles et solutions

=== ":material-microsoft-visual-studio-code: VS Code"
    **1. Extension désactivée**
    
    Vérifiez la barre de statut en bas : l'icône Copilot doit être présente et non barrée.
    
    Si l'icône est absente : ++ctrl+shift+x++ → cherchez "GitHub Copilot" → **Enable**.
    
    **2. Completion désactivée pour ce langage**
    ```json
    // Vérifiez .vscode/settings.json
    {
        "github.copilot.enable": {
            "javascript": false  // <- Remettre true ou supprimer la ligne
        }
    }
    ```
    
    **3. Conflit avec autre extension d'autocomplétion**
    
    Désactivez temporairement Tabnine, Kite, IntelliCode, etc. pour tester.
    
    **4. `editor.inlineSuggest.enabled` désactivé**
    ```json
    {
        "editor.inlineSuggest.enabled": true  // Doit être true
    }
    ```

=== ":simple-intellijidea: IntelliJ"
    **1. Plugin désactivé**
    
    **Settings → Plugins** → vérifiez que "GitHub Copilot" est coché et actif.
    
    **2. Completions désactivées via status bar**
    
    Cliquez sur l'icône Copilot en bas à droite → **"Enable GitHub Copilot completions"**.
    
    **3. Langage dans la liste des exclusions**
    
    **Settings → GitHub Copilot → Disabled Languages** → vérifiez que le langage courant ne figure pas dans la liste.
    
    **4. IDE en mode Power Save**
    
    En mode Power Save (**File → Power Save Mode**), Copilot est automatiquement suspendu. Désactivez ce mode.

---

## 2. Authentification échouée

### Symptôme
Message d'erreur : "You are not signed in", "Authentication failed", ou l'icône Copilot affiche une croix rouge.

### Solution

=== ":material-microsoft-visual-studio-code: VS Code"
    1. ++ctrl+shift+p++ → **"GitHub Copilot: Sign Out"**
    2. ++ctrl+shift+p++ → **"GitHub Copilot: Sign In"**
    3. Suivez le flux OAuth dans le navigateur
    4. Si le navigateur ne s'ouvre pas : copiez le code affiché et allez manuellement sur [github.com/login/device](https://github.com/login/device)

=== ":simple-intellijidea: IntelliJ"
    1. **Tools → GitHub Copilot → Log Out**
    2. **Tools → GitHub Copilot → Login to GitHub**
    3. Alternativement : ++ctrl+shift+a++ → cherchez **"GitHub Copilot"**

### Vérifier le statut d'abonnement

Si la re-authentification ne fonctionne pas : connectez-vous sur [github.com/settings/copilot](https://github.com/settings/copilot) et vérifiez que votre plan Copilot est actif.

---

## 3. Suggestions lentes ou intermittentes

### Symptôme
Les suggestions apparaissent parfois, avec 2-5 secondes de délai, ou s'interrompent fréquemment.

### Diagnostic réseau

```bash
# Tester la connectivité depuis le terminal
curl -I https://api.github.com

# Devrait retourner HTTP/2 200 rapidement
# Si timeout ou erreur réseau → problème de connectivité ou proxy
```

### Solutions

**Proxy d'entreprise :**

=== ":material-microsoft-visual-studio-code: VS Code"
    ```json
    // .vscode/settings.json ou settings utilisateur
    {
        "http.proxy": "http://proxy.company.com:8080",
        "http.proxyStrictSSL": false,
        "github.copilot.advanced": {
            "debug.useNodeFetcher": true
        }
    }
    ```

=== ":simple-intellijidea: IntelliJ"
    **Settings → Appearance & Behavior → System Settings → HTTP Proxy**
    
    Configurez le proxy manuellement et testez la connexion.

**Réseau lent — augmenter la tolérance :**
```json
// VS Code
{
    "github.copilot.advanced": {
        "requestTimeout": 10000  // 10 secondes (défaut: 5000)
    }
}
```

---

## 4. Suggestions incorrectes ou hors sujet

### Symptôme
Copilot génère du code qui ne correspond pas au contexte du projet : mauvais framework, mauvaise langue, suggestions génériques.

### Solutions

1. **Ouvrir les fichiers pertinents** dans des onglets actifs — Copilot utilise les fichiers ouverts comme contexte
2. **Créer un fichier `.github/copilot-instructions.md`** avec des directives du projet
3. **Positionner le curseur après du code existant** plutôt qu'en début de fichier vide
4. **Décrire le contexte dans un commentaire** juste avant le code à générer :
   ```typescript
   // Projet: API REST Express TypeScript
   // Pattern: Repository, pas d'ORM, PostgreSQL via pg
   // Fonction: récupération d'un utilisateur par email
   function getUserByEmail(email: string) {
   ```

---

## 5. Copilot Chat ne répond pas

### Symptôme
Le panneau Chat s'ouvre mais reste vide, tourne indéfiniment, ou affiche une erreur.

=== ":material-microsoft-visual-studio-code: VS Code"
    1. Vérifiez que l'extension **GitHub Copilot Chat** est installée séparément de GitHub Copilot
    2. ++ctrl+shift+p++ → **"Developer: Reload Window"**
    3. Vérifiez les logs : **Output** → sélectionnez **"GitHub Copilot Chat"**
    4. Si "rate limit exceeded" : attendez quelques minutes

=== ":simple-intellijidea: IntelliJ"
    1. Le Chat est intégré au plugin principal — vérifiez la version du plugin (doit être ≥ 1.3)
    2. Fermez et rouvrez le panneau Copilot Chat
    3. Vérifiez dans **Help → Show Log** pour les erreurs Copilot

---

## 6. `.instructions.md` ignoré

### Symptôme
Les instructions dans `.github/copilot-instructions.md` ou `.github/instructions/*.instructions.md` ne semblent pas être prises en compte.

### Causes fréquentes

| Cause | Vérification |
|-------|-------------|
| Fichier mal nommé | Le fichier doit finir exactement en `.instructions.md` |
| `applyTo` incorrect | Vérifier le glob pattern : `applyTo: '**/*.ts'` pour TypeScript |
| Feature flag désactivé | VS Code : `"github.copilot.chat.codeGeneration.useInstructionFiles": true` |
| IntelliJ | Fonctionnalité absente — voir [comparaison contexte](../chapitre-3-contexte/comparaison-contexte.md) |

```json
// S'assurer que les instruction files sont actifs
{
    "github.copilot.chat.codeGeneration.useInstructionFiles": true
}
```

---

## 7. Code généré avec des imports manquants

### Symptôme
Copilot génère du code valide syntaxiquement, mais des imports sont absents et le code ne compile pas.

### Explications

Copilot génère les imports selon le contexte visible. Si les dépendances ne sont pas installées ou si `package.json`/`pom.xml` n'est pas ouvert, il peut générer des imports incorrects.

### Solutions

- **IntelliJ** : L'IDE propose automatiquement d'ajouter les imports manquants via Alt+Entrée — acceptez les suggestions
- **VS Code** : Activez les imports automatiques dans les paramètres du langage (TypeScript, Java via JDT, etc.)
- **Tous IDEs** : Ouvrez `package.json` dans un onglet pour que Copilot connaisse les dépendances disponibles

---

## 8. Copilot Edits / Agent mode ne fonctionne pas

### Symptôme
VS Code : l'option "Copilot Edits" ou le mode Agent dans Chat n'est pas disponible.

### Prérequis

- **GitHub Copilot Chat** version ≥ 0.13
- Compte avec accès aux fonctionnalités avancées (peut nécessiter Copilot Business ou accès anticipé)

### Solution

```
Extensions → GitHub Copilot Chat → Vérifier la version
Si version ancienne : Update
```

Si le mode Agent est toujours absent après mise à jour, consultez la page [GitHub Copilot Features](https://docs.github.com/copilot) pour vérifier la disponibilité.

---

## 9. Performances dégradées de l'IDE après installation

### Symptôme
IntelliJ ou VS Code devient globalement plus lent après l'activation de Copilot.

### Solutions rapides

1. Augmenter la mémoire allouée à IntelliJ (voir [Performance](../chapitre-5-bonnes-pratiques/performance.md))
2. Augmenter le délai de suggestions pour réduire les requêtes
3. Désactiver pour les langages non essentiels
4. Fermer les onglets inutilisés

---

## 10. Perte des préférences après mise à jour

### Symptôme
Après une mise à jour de l'extension/plugin ou de l'IDE, certains paramètres semblent réinitialisés.

### Bonnes pratiques de sauvegarde

=== ":material-microsoft-visual-studio-code: VS Code"
    Utilisez **Settings Sync** (++ctrl+shift+p++ → **"Settings Sync: Enable"**) pour synchroniser vos paramètres sur GitHub.

=== ":simple-intellijidea: IntelliJ"
    Utilisez **File → Manage IDE Settings → Sync Settings to JetBrains Account** pour sauvegarder en cloud.
    
    Ou exportez manuellement : **File → Manage IDE Settings → Export Settings**.

---

## Prochaines étapes

- [Logs & Diagnostic](logs-diagnostic.md) — Analyser les logs pour les problèmes persistants
- [Comparaison des problèmes](comparaison-problemes.md) — Problèmes spécifiques à chaque IDE
