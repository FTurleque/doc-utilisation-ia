# Logs & Diagnostic

Lire les logs est la technique la plus fiable pour diagnostiquer un problème Copilot persistant. Ce guide explique comment accéder aux logs, ce qu'ils contiennent, et comment les interpréter.

---

## VS Code — Accès aux logs

### Méthode 1 : Panneau Output

1. **Menu Affichage → Sortie** (ou ++ctrl+shift+u++)
2. Dans le dropdown à droite, sélectionnez **"GitHub Copilot"** ou **"GitHub Copilot Chat"**

```
[2024-01-15T10:23:45.123Z] INFO  Copilot initialized, version 1.165.0
[2024-01-15T10:23:46.456Z] INFO  Authentication token refreshed
[2024-01-15T10:23:47.789Z] DEBUG Sending completion request for language: typescript
[2024-01-15T10:23:48.012Z] INFO  Received 3 completions (450ms)
```

### Méthode 2 : Developer Tools (logs détaillés)

1. **Aide → Activer/Désactiver les outils de développement** (++f12++ ou `Ctrl+Shift+I`)
2. Onglet **Console** — filtrez par "copilot" pour isoler les logs Copilot

### Méthode 3 : Log niveau DEBUG

Pour activer les logs de débogage complets :

```json
// .vscode/settings.json
{
    "github.copilot.advanced": {
        "debug.overrideLogLevels": {
            "*": "DEBUG"
        }
    }
}
```

!!! warning "Verbose logs"
    Les logs DEBUG sont volumineux. Désactivez cette option après votre diagnostic en supprimant la clé.

### Fichiers de logs VS Code

Les logs persistent dans :

=== "Windows"
    ```
    %APPDATA%\Code\logs\
    ```
    
    *(Passe automatiquement par ton appdata utilisateur : `C:\Users\[touNom]\AppData\Roaming\Code\logs`)*

=== "macOS"
    ```
    ~/Library/Application Support/Code/logs/
    ```

=== "Linux"
    ```
    ~/.config/Code/logs/
    ```

Chaque extension a son propre dossier de logs. Cherchez `exthost/GitHub.cpilot/` ou similaire.

### Commande pour ouvrir le dossier des logs

++ctrl+shift+p++ → **"Developer: Open Extension Logs Folder"**

---

## IntelliJ — Accès aux logs

### Fichier idea.log

Le log principal d'IntelliJ est `idea.log` :

**Accès depuis l'IDE :**
```
Help → Show Log in Explorer (Windows)
Help → Show Log in Finder (macOS)
Help → Show Log in Files (Linux)
```

**Emplacements par OS :**

=== "Windows"
    ```
    %APPDATA%\JetBrains\<IDE><version>\log\idea.log
    ```
    
    *(Passe automatiquement par ton appdata utilisateur : `C:\Users\[touNom]\AppData\Roaming\JetBrains\...`)*

=== "macOS"
    ```
    ~/Library/Logs/JetBrains/<IDE><version>/idea.log
    Exemple: ~/Library/Logs/JetBrains/IntelliJIdea2023.3/idea.log
    ```

=== "Linux"
    ```
    ~/.cache/JetBrains/<IDE><version>/log/idea.log
    ```

### Filtrer les logs Copilot dans idea.log

Le fichier `idea.log` contient tous les logs de l'IDE. Filtrez avec :

```bash
# Sous PowerShell (Windows)
Select-String -Path idea.log -Pattern "copilot|Copilot|github.copilot"

# Sous Bash (macOS/Linux)
grep -i "copilot" idea.log | tail -100
```

### Activer les logs DEBUG dans IntelliJ

1. **Help → Diagnostic Tools → Debug Log Settings**
2. Ajoutez les catégories :
   ```
   com.github.copilot
   com.github.tools
   ```
3. Reproduisez le problème
4. Récupérez le log via **Help → Show Log**

!!! tip "Retour aux logs normaux"
    Après le diagnostic, repassez dans **Debug Log Settings** et supprimez les catégories ajoutées. Sinon `idea.log` grossit rapidement.

---

## Interprétation des messages de log

### Messages courants VS Code

| Message | Signification | Action |
|---------|---------------|--------|
| `Authentication token refreshed` | Auth réussie | ✅ Normal |
| `Received 0 completions` | Pas de suggestion retournée | Vérifier network/contexte |
| `Request timeout` | Délai dépassé | Problème réseau ou serveur |
| `Rate limit exceeded` | Trop de requêtes | Attendre quelques minutes |
| `Unauthorized` | Token invalide/expiré | Se reconnecter |
| `Network error` | Problème de connectivité | Vérifier proxy/firewall |
| `ExtensionEnablementError` | Extension en conflit | Désactiver autres extensions |

### Messages courants IntelliJ

| Message dans idea.log | Signification | Action |
|-----------------------|---------------|--------|
| `GitHub Copilot connected` | Connexion établie | ✅ Normal |
| `Failed to get completions` | Erreur API | Vérifier auth et réseau |
| `Token expired, refreshing` | Renouvellement auto | ✅ Normal, transitoire |
| `SSL handshake failure` | Problème certif proxy | Configurer proxy SSL |
| `OutOfMemoryError` | Mémoire insuffisante | Augmenter -Xmx |

### Codes d'erreur HTTP dans les logs

| Code | Signification |
|------|---------------|
| `401` | Non authentifié — se reconnecter |
| `403` | Autorisations insuffisantes — vérifier l'abonnement |
| `422` | Requête invalide — bug potentiel, vérifier la version |
| `429` | Rate limit — attendre et réessayer |
| `500/503` | Erreur serveur GitHub — vérifier githubstatus.com |

---

## Diagnostic réseau avancé

### Vérifier les endpoints Copilot

Copilot communique avec ces domaines — vérifiez qu'ils sont accessibles depuis votre réseau :

```bash
# PowerShell
Test-NetConnection -ComputerName "api.github.com" -Port 443
Test-NetConnection -ComputerName "copilot-proxy.githubusercontent.com" -Port 443

# Bash
curl -I "https://api.github.com" 2>&1 | head -5
curl -I "https://copilot-proxy.githubusercontent.com" 2>&1 | head -5
```

### Capture HAR (pour support GitHub)

Si vous devez contacter le support GitHub avec un problème de réseau :

**VS Code :**
1. Ouvrez Developer Tools (F12)
2. Onglet **Network**
3. Cochez "Preserve log"
4. Reproduisez le problème
5. Clic droit dans la liste network → **"Save all as HAR with content"**

---

## Rapport de bug

Si vous avez identifié un bug reproductible :

=== ":material-microsoft-visual-studio-code: VS Code"
    ++ctrl+shift+p++ → **"GitHub Copilot: Report Issue"**
    
    Cela ouvre GitHub avec un template pré-rempli incluant les informations système.

=== ":simple-intellijidea: IntelliJ"
    **Help → Submit a Bug Report**
    
    Ou directement : [youtrack.jetbrains.com/newissue?project=IDEA](https://youtrack.jetbrains.com/newissue?project=IDEA)

### Informations à inclure dans un rapport

```markdown
## Environnement
- IDE: VS Code 1.85 / IntelliJ IDEA 2023.3
- Extension/Plugin version: GitHub Copilot 1.165.0
- OS: Windows 11 / macOS 14 / Ubuntu 22.04

## Problème
Description claire et concise

## Étapes de reproduction
1. Ouvrir un fichier .ts
2. Taper "function get..."
3. Attendre 3 secondes

## Comportement attendu
Suggestion de code apparaît

## Comportement observé
Aucune suggestion, pas d'icône dans la status bar

## Logs pertinents
[Coller les lignes de log ici]
```

---

## Prochaines étapes

- [Comparaison des problèmes](comparaison-problemes.md) — Différences IDE-spécifiques
- [Problèmes courants](problemes-courants.md) — Solutions pour les cas les plus fréquents
