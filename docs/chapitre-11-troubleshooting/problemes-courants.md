# Problèmes Courants

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span>

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

### Repères de performance

| Latence | Interprétation | Action |
|---------|---------------|--------|
| < 2 secondes | ✅ Normal | Rien à faire |
| 2 à 5 secondes | ⚠️ Dégradé | Surveiller, tester le réseau |
| > 5 secondes ou timeout | ❌ Anormal | Diagnostiquer le réseau ou le proxy |

### Diagnostic réseau

=== "Windows (PowerShell)"
    ```powershell
    # Tester la connectivité
    Test-NetConnection -ComputerName "api.github.com" -Port 443
    # Résultat attendu : TcpTestSucceeded : True
    
    Test-NetConnection -ComputerName "copilot-proxy.githubusercontent.com" -Port 443
    # Résultat attendu : TcpTestSucceeded : True
    ```

=== "macOS / Linux"
    ```bash
    # Tester la connectivité
    curl -I https://api.github.com
    # Résultat attendu : HTTP/2 200 en < 500ms
    
    curl -I https://copilot-proxy.githubusercontent.com
    # Résultat attendu : HTTP/2 200 ou 204
    ```

!!! tip "VPN et réseau d'entreprise"
    Si vous êtes connecté à un VPN, testez en le déconnectant temporairement. Certains VPN d'entreprise interceptent le trafic HTTPS vers `githubusercontent.com` et causent des erreurs SSL silencieuses.

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

    === ":material-check: Commentaire contextualisé (bon)"
        ```typescript
        // Projet: API REST Express TypeScript
        // Pattern: Repository, pas d'ORM, PostgreSQL via pg
        // Fonction: récupération d'un utilisateur par email avec gestion d'erreur
        function getUserByEmail(email: string): Promise<User | null> {
        ```

    === ":material-close: Commentaire vague (mauvais)"
        ```typescript
        // get user
        function get(e) {
        ```

5. **Vérifier `.copilotignore`** — si le fichier en cours est listé dans `.copilotignore`, Copilot l'ignore entièrement (voir [Problème 11](#11-fichier-ignore-par-copilot))

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
| IntelliJ | Fonctionnalité absente — voir [comparaison contexte](../chapitre-4-contexte/comparaison-contexte.md) |

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

### Prérequis par offre

| Fonctionnalité | Copilot Free | Copilot Pro / Pro+ | Copilot Business / Enterprise |
|---------------|:------------:|:------------------:|:-----------------------------:|
| Suggestions inline | ✅ | ✅ | ✅ |
| Copilot Chat | ✅ (limité) | ✅ | ✅ |
| Mode Agent (Ask/Plan/Agent) | ✅ | ✅ | ✅ |
| Copilot Edits multi-fichiers | ✅ (périmètre variable) | ✅ | ✅ |
| Accès modèles premium | Limité | ✅ | ✅ |

### Solution

```
Extensions → GitHub Copilot Chat → Vérifier la version (doit être ≥ 0.13)
Si version ancienne : clic sur Update
```

!!! warning "Vérifier votre plan et vos politiques"
    Si une fonctionnalité est absente, vérifiez votre plan, la version de l'extension et les politiques d'organisation (le mode agent peut être désactivé côté admin). Consultez [github.com/settings/copilot](https://github.com/settings/copilot) pour confirmer l'état de votre accès.

---

## 9. Performances dégradées de l'IDE après installation

### Symptôme
IntelliJ ou VS Code devient globalement plus lent après l'activation de Copilot.

### Solutions rapides

1. **Augmenter la mémoire IntelliJ** :
   - **Help → Edit Custom VM Options**
   - Modifier ou ajouter : `-Xmx4096m` (4 Go, recommandé avec Copilot actif)
   - Redémarrer IntelliJ pour appliquer

2. **Réduire la fréquence des requêtes dans VS Code** :
    ```json
    {
        "editor.quickSuggestionsDelay": 500,
        "github.copilot.advanced": {
            "inlineSuggestCount": 1
        }
    }
    ```

3. **Désactiver pour les langages non essentiels** :
    ```json
    {
        "github.copilot.enable": {
            "markdown": false,
            "plaintext": false,
            "xml": false
        }
    }
    ```

4. **Fermer les onglets inutilisés** — Copilot indexe tous les fichiers ouverts comme contexte

Voir aussi [Performance & Ressources](../chapitre-9-bonnes-pratiques/performance.md) pour les réglages avancés.

---

## 10. Perte des préférences après mise à jour

### Symptôme
Après une mise à jour de l'extension/plugin ou de l'IDE, certains paramètres semblent réinitialisés.

### Bonnes pratiques de sauvegarde

=== ":material-microsoft-visual-studio-code: VS Code"
    Utilisez **Settings Sync** (++ctrl+shift+p++ → **"Settings Sync: Enable"**) pour synchroniser vos paramètres sur GitHub.

=== ":simple-intellijidea: IntelliJ"
    Utilisez **File → Manage IDE Settings → Sync Settings to JetBrains Account** pour sauvegarder en cloud.
    
    Ou exportez manuellement : **File → Manage IDE Settings → Export Settings** (génère un `.zip` réimportable).

!!! tip "Sauvegarder settings.json localement"
    Dans les deux IDEs, versionner le fichier de settings dans git est la méthode la plus fiable :
    - VS Code : `.vscode/settings.json` dans le dépôt
    - IntelliJ : `.idea/` dans le dépôt (activer le partage des settings de projet)

---

## 11. Fichier ignoré par Copilot

### Symptôme
Copilot génère des suggestions normalement dans d'autres fichiers, mais reste silencieux sur un fichier spécifique. Aucun message d'erreur.

### Cause
Le fichier correspond à un pattern dans `.copilotignore` (VS Code uniquement) ou son extension est désactivée dans les settings.

### Vérification

=== ":material-microsoft-visual-studio-code: VS Code"
    **1. Vérifier `.copilotignore`**
    
    Si un fichier `.copilotignore` existe à la racine du projet ou dans un dossier parent, ouvrez-le et vérifiez qu'il ne correspond pas au fichier concerné.
    
    Syntaxe identique à `.gitignore` :
    ```
    # Ignorer tous les fichiers de config
    *.config.js
    
    # Ignorer un dossier spécifique
    secrets/
    
    # Ignorer un fichier précis
    src/config/env.ts
    ```
    
    **2. Vérifier les settings par langage**
    ```json
    // Si la valeur est false, Copilot est désactivé pour ce langage
    {
        "github.copilot.enable": {
            "typescript": false  // <- voilà le problème
        }
    }
    ```

=== ":simple-intellijidea: IntelliJ"
    IntelliJ ne supporte pas `.copilotignore`. Vérifiez :
    
    **Settings → GitHub Copilot → Disabled Languages** — le langage du fichier y figure-t-il ?
    
    Si oui, décochez-le pour réactiver Copilot sur ce langage.

---

## 12. Chat : contexte de conversation saturé

### Symptôme
Après plusieurs échanges dans la même conversation, Copilot Chat donne des réponses hors sujet, oublie des informations données plus tôt, ou répond « Je n'ai pas accès à cette information ».

### Cause
Chaque modèle de langage a une fenêtre de contexte maximale. Quand l'historique de conversation la dépasse, les messages anciens sont tronqués.

### Solutions

=== ":material-microsoft-visual-studio-code: VS Code"
    1. **Démarrer une nouvelle conversation** — cliquez sur l'icône « + » dans le panneau Chat
    2. **Résumer le contexte au début** de la nouvelle conversation :
        ```
        Contexte : je travaille sur une API Express TypeScript avec PostgreSQL.
        Objectif : implémenter le service d'authentification JWT.
        Fichiers clés: src/auth/auth.service.ts, src/middleware/auth.middleware.ts
        ```
    3. **En mode Agent** : utilisez `#codebase` ou `@workspace` pour recharger le contexte

=== ":simple-intellijidea: IntelliJ"
    Fermez le panneau Chat et rouvrez-le pour démarrer une nouvelle session. Résumez votre contexte dans le premier message.

!!! tip "Bonne pratique"
    Pour les sessions longues, démarrez une nouvelle conversation toutes les 10-15 questions. Résumez les décisions prises pour ne pas perdre le fil.

---

## 13. Suggestions tronquées

### Symptôme
La suggestion apparaît mais s'arrête au milieu d'une ligne, d'une fonction, ou même au milieu d'un mot.

### Causes fréquentes

| Cause | Indice | Solution |
|-------|--------|----------|
| Timeout réseau | Suggestion rapide puis coupée | Augmenter `requestTimeout` |
| Rate limit | Se produit après une activité intense | Attendre 1-2 min |
| Contexte trop large | Fichier très long (> 1000 lignes) | Fermer des onglets, découper le fichier |
| Bug extension/plugin | Reproductible sur tout fichier | Mettre à jour l'extension |

### Solutions

=== ":material-microsoft-visual-studio-code: VS Code"
    ```json
    {
        "github.copilot.advanced": {
            "requestTimeout": 15000
        }
    }
    ```
    
    Si le problème persiste : ++ctrl+shift+p++ → **"Developer: Reload Window"**

=== ":simple-intellijidea: IntelliJ"
    Vérifiez `idea.log` pour des messages `PSI timeout` ou `Request timeout`.
    
    Si le fichier est très long, essayez de diviser le fichier ou de fermer des onglets inutilisés.
    
    Si le problème est reproductible : **Help → Submit a Bug Report** avec le log filtré.

---

## Prochaine étape

**[Logs & Diagnostic](logs-diagnostic.md)** : comment activer, lire et interpréter les logs Copilot dans VS Code et IntelliJ pour diagnostiquer les problèmes persistants.

Concepts clés couverts :

- **Accès aux logs** — Panneau Output VS Code, fichier idea.log IntelliJ
- **Interprétation des messages** — Types de logs courants et codes d'erreur HTTP
- **Diagnostic réseau** — Vérifier la connectivité aux endpoints Copilot
- **Rapport de bug** — Capturer et partager les informations essentielles
