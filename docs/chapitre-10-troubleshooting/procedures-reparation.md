# Procédures de Réparation

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span>

Cette page est destinée aux cas **où les solutions des [Problèmes Courants](problemes-courants.md) n'ont pas suffi**. Elle propose des procédures graduées, de la plus simple (niveau 1) à la plus complète (niveau entreprise).

---

## Quand utiliser ces procédures ?

| Symptôme persistant | Procédure recommandée |
|--------------------|-----------------------|
| Re-login ne résout pas l'auth | [Procédure 1 — Reset complet](#procedure-1-reset-complet-copilot) |
| Bug étrange après une mise à jour | [Procédure 2 — Nettoyage du cache](#procedure-2-nettoyage-du-cache) |
| Problème grave non résolu par le cache | [Procédure 3 — Réinstallation complète](#procedure-3-reinstallation-complete) |
| Erreurs SSL / proxy en entreprise | [Procédure 4 — Configuration proxy/SSL](#procedure-4-configuration-proxy-ssl) |
| Conflit avec d'autres extensions | [Procédure 5 — Résolution de conflits](#procedure-5-resolution-de-conflits-d-extensions) |

---

## Procédure 1 — Reset complet Copilot {#procedure-1-reset-complet-copilot}

**Durée estimée : 2 minutes**

La première étape avant toute action plus invasive est de forcer un cycle complet de déconnexion et reconnexion.

=== ":material-microsoft-visual-studio-code: VS Code"
    1. ++ctrl+shift+p++ → **"GitHub Copilot: Sign Out"**
    2. ++ctrl+shift+p++ → **"Developer: Reload Window"**
    3. Attendez que l'extension se réinitialise (icône Copilot dans la barre de statut)
    4. ++ctrl+shift+p++ → **"GitHub Copilot: Sign In"**
    5. Complétez le flux OAuth dans le navigateur
    6. Testez en ouvrant un fichier de code et en tapant quelques caractères

=== ":simple-intellijidea: IntelliJ"
    1. **Tools → GitHub Copilot → Log Out**
    2. **File → Invalidate Caches** → cochez toutes les cases → **"Invalidate and Restart"**
    3. Après le redémarrage : **Tools → GitHub Copilot → Login to GitHub**
    4. Complétez l'authentification dans le navigateur
    5. Testez en ouvrant un fichier de code

!!! tip "Check rapide"
    Après reconnexion, vérifiez que l'icône Copilot dans la barre de statut est verte/active et non barrée.

---

## Procédure 2 — Nettoyage du cache {#procedure-2-nettoyage-du-cache}

**Durée estimée : 5 minutes**

Quand une mise à jour de l'extension laisse des données corrompues ou des paramètres obsolètes en cache.

=== ":material-microsoft-visual-studio-code: VS Code"
    **Étape 1 — Fermer VS Code complètement**
    
    Assurez-vous que tous les processus VS Code sont arrêtés.
    
    **Étape 2 — Supprimer le cache de l'extension**
    
    === "Windows"
        ```powershell
        # Supprimer le cache des extensions Copilot
        Remove-Item -Recurse -Force "$env:APPDATA\Code\User\globalStorage\github.copilot" -ErrorAction SilentlyContinue
        Remove-Item -Recurse -Force "$env:APPDATA\Code\User\globalStorage\github.copilot-chat" -ErrorAction SilentlyContinue
        
        # Supprimer les logs de l'extension
        Remove-Item -Recurse -Force "$env:APPDATA\Code\logs" -ErrorAction SilentlyContinue
        ```
    
    === "macOS"
        ```bash
        rm -rf ~/Library/Application\ Support/Code/User/globalStorage/github.copilot
        rm -rf ~/Library/Application\ Support/Code/User/globalStorage/github.copilot-chat
        ```
    
    === "Linux"
        ```bash
        rm -rf ~/.config/Code/User/globalStorage/github.copilot
        rm -rf ~/.config/Code/User/globalStorage/github.copilot-chat
        ```
    
    **Étape 3 — Rouvrir VS Code et se reconnecter**
    
    Au premier démarrage, VS Code restaurera les fichiers nécessaires. Reconnectez-vous à GitHub Copilot.

=== ":simple-intellijidea: IntelliJ"
    IntelliJ offre une commande intégrée pour invalider tous les caches :
    
    1. **File → Invalidate Caches…**
    2. Cochez toutes les options :
        - Clear file system cache and local history
        - Clear VCS log caches and indexes
        - Clear downloaded shared indexes
    3. Cliquez **"Invalidate and Restart"**
    4. Après le redémarrage, reconnectez-vous à Copilot
    
    !!! tip "Cache spécifique au plugin Copilot"
        Si le problème persiste après l'invalidation des caches, supprimez manuellement le dossier de configuration du plugin :
        
        === "Windows"
            ```
            %APPDATA%\JetBrains\<IDE><version>\plugins\github-copilot\
            ```
        
        === "macOS"
            ```
            ~/Library/Application Support/JetBrains/<IDE><version>/plugins/github-copilot/
            ```

---

## Procédure 3 — Réinstallation complète {#procedure-3-reinstallation-complete}

**Durée estimée : 10-15 minutes**

À utiliser quand le cache nettoyé n'a pas suffi et que le comportement reste incorrect après une mise à jour ou une corruption.

=== ":material-microsoft-visual-studio-code: VS Code"

    **Étape 1 — Désinstaller les extensions Copilot**
    
    ```powershell
    # Depuis le terminal (ou PowerShell)
    code --uninstall-extension GitHub.copilot
    code --uninstall-extension GitHub.copilot-chat
    ```
    
    **Étape 2 — Supprimer les données persistantes** (voir [Procédure 2](#procedure-2-nettoyage-du-cache) pour les chemins)
    
    **Étape 3 — Réinstaller les extensions**
    
    ```powershell
    code --install-extension GitHub.copilot
    code --install-extension GitHub.copilot-chat
    ```
    
    Ou depuis l'interface : ++ctrl+shift+x++ → chercher "GitHub Copilot" → Install.
    
    **Étape 4 — Configuration minimale pour tester**
    
    ```json
    // .vscode/settings.json — configuration de test minimale
    {
        "github.copilot.enable": {
            "*": true
        },
        "editor.inlineSuggest.enabled": true
    }
    ```
    
    **Étape 5 — Valider le fonctionnement**
    
    Ouvrez un fichier TypeScript ou JavaScript et tapez `function ` — une suggestion doit apparaître.

=== ":simple-intellijidea: IntelliJ"

    **Étape 1 — Désinstaller le plugin**
    
    **Settings → Plugins** → Trouver "GitHub Copilot" → Clic droit → **"Uninstall"** → Redémarrer IntelliJ.
    
    **Étape 2 — Supprimer les données du plugin**
    
    Après désinstallation, supprimez les dossiers persistants :
    
    === "Windows"
        ```powershell
        Remove-Item -Recurse -Force "$env:APPDATA\JetBrains\IntelliJIdea*\plugins\github-copilot" -ErrorAction SilentlyContinue
        Remove-Item -Recurse -Force "$env:APPDATA\JetBrains\IntelliJIdea*\options\github.copilot*" -ErrorAction SilentlyContinue
        ```
    
    === "macOS"
        ```bash
        rm -rf ~/Library/Application\ Support/JetBrains/IntelliJIdea*/plugins/github-copilot
        ```
    
    **Étape 3 — Réinstaller le plugin**
    
    **Settings → Plugins → Marketplace** → chercher "GitHub Copilot" → Install → Redémarrer IntelliJ.
    
    **Étape 4 — Réauthentification**
    
    **Tools → GitHub Copilot → Login to GitHub** et compléter le flux OAuth.

---

## Procédure 4 — Configuration proxy/SSL {#procedure-4-configuration-proxy-ssl}

**Durée estimée : 15-30 minutes selon l'environnement réseau**

Cette procédure concerne les environnements d'entreprise avec proxy interceptant le trafic HTTPS.

### Symptômes typiques

- Erreur `SSL handshake failure` dans les logs IntelliJ
- Erreur `self-signed certificate` dans les logs VS Code
- `curl https://api.github.com` retourne une erreur de certificat mais pas un timeout

=== ":material-microsoft-visual-studio-code: VS Code"

    **Configuration du proxy**
    
    ```json
    // settings.json (utilisateur ou workspace)
    {
        "http.proxy": "http://proxy.company.com:8080",
        "http.proxyStrictSSL": false,
        "github.copilot.advanced": {
            "debug.useNodeFetcher": true
        }
    }
    ```
    
    !!! warning "http.proxyStrictSSL: false"
        Désactiver la vérification SSL est une solution temporaire acceptable sur un réseau d'entreprise contrôlé. Ne l'utilisez pas sur des réseaux publics ou personnels.
    
    **Proxy avec authentification**
    
    ```json
    {
        "http.proxy": "http://user:password@proxy.company.com:8080"
    }
    ```
    
    !!! danger "Mot de passe dans settings.json"
        Si `settings.json` est partagé via Settings Sync ou dans git, n'y stockez jamais un mot de passe en clair. Préférez la variable d'environnement `HTTPS_PROXY` dans votre profil shell.

=== ":simple-intellijidea: IntelliJ"

    **Étape 1 — Configurer le proxy dans l'IDE**
    
    **Settings → Appearance & Behavior → System Settings → HTTP Proxy**
    
    - Sélectionner "Manual proxy configuration"
    - Renseigner Host, Port, et les credentials si requis
    - Cliquer "Check connection" avec `https://api.github.com`
    
    **Étape 2 — Importer le certificat SSL de l'entreprise (si nécessaire)**
    
    Si votre proxy inspecte le trafic HTTPS ("man-in-the-middle"), il signe les connexions avec son propre certificat. IntelliJ utilisant la JVM, le certificat doit être importé dans le keystore JVM.
    
    ```powershell
    # Windows — récupérer le chemin du JDK utilisé par IntelliJ
    # Help → About → Runtime (ou via File → Project Structure)
    
    # Importer le certificat (certificat en format .cer ou .pem)
    $javaHome = "C:\Program Files\JetBrains\IntelliJIdea\jbr"
    $certFile = "C:\certs\company-proxy-cert.cer"
    $alias = "company-proxy"
    
    & "$javaHome\bin\keytool.exe" -import -alias $alias `
        -keystore "$javaHome\lib\security\cacerts" `
        -file $certFile -storepass changeit -noprompt
    ```
    
    Redémarrez IntelliJ après l'import.
    
    !!! tip "Obtenir le certificat de votre proxy"
        Demandez ce certificat à votre équipe sécurité/réseau. Il peut être exporté depuis un navigateur (cadenas → Certificat → Exporter) sur un domaine interne.

---

## Procédure 5 — Résolution de conflits d'extensions {#procedure-5-resolution-de-conflits-d-extensions}

**Durée estimée : 10-20 minutes**

Quand Copilot ne fonctionne pas correctement et qu'une autre extension semble interférer.

### Identifier le conflit — Approche bisect (VS Code)

Cette méthode est systématique et garantit d'identifier la bonne extension sans tâtonnement.

1. **Ouvrir le panneau Extensions** (++ctrl+shift+x++)
2. **Désactiver la moitié de vos extensions** (sauf Copilot)
3. Tester si le problème persiste
4. Si le problème disparaît → le conflit est dans la moitié désactivée
5. Réactiver la moitié désactivée, désactiver l'autre moitié → tester
6. Diviser par deux jusqu'à isoler l'extension problématique

**Extensions connues pour créer des conflits avec Copilot :**

| Extension | Type de conflit | Résolution |
|-----------|----------------|------------|
| Tabnine | Suggestions inline en double | Désactiver l'un des deux |
| Kite | Autocomplétion concurrente | Désactiver Kite |
| IntelliCode | Priorité de suggestions | Régler la priorité dans les paramètres |
| vim (vscodevim) | Raccourcis ++tab++ interceptés | Configurer Copilot dans le mode Normal |
| Extensions LSP personnalisées | Conflits avec le Language Server | Désactiver l'extension LSP tierce |

=== ":material-microsoft-visual-studio-code: VS Code"
    
    **Mode sans extensions (test rapide)**
    
    ```powershell
    # Lancer VS Code sans aucune extension pour tester
    code --disable-extensions
    ```
    
    Si Copilot fonctionne en mode sans extensions, le problème vient d'une extension tierce.
    
    **Désactiver une extension problématique identifiée**
    
    Dans le panneau Extensions → clic droit sur l'extension → **"Disable"** (workspace uniquement pour tester sans impact global).

=== ":simple-intellijidea: IntelliJ"
    
    **Test sans plugins tiers**
    
    **Settings → Plugins** : désactivez tous les plugins tiers (conservez uniquement les plugins JetBrains + GitHub Copilot). Redémarrez et testez.
    
    **Identifier via les logs**
    
    Dans `idea.log`, cherchez des traces d'incompatibilité :
    ```bash
    # Windows PowerShell
    Select-String -Path idea.log -Pattern "PluginException|incompatible|conflict"
    ```
    
    Les erreurs mentionnant un nom de plugin tiers indiquent généralement le coupable.

!!! info "Réactiver les extensions"
    Une fois le conflit résolu (extension désactivée ou mise à jour), réactivez le reste de vos extensions une par une pour confirmer qu'aucune autre ne crée de problème.

---

## Prochaines étapes

- [Cas d'Usage](../chapitre-9-cas-usage/index.md) — Configurations pratiques par technologie (Java, Python, Node.js…)
- [Appendices FAQ](../appendices/faq.md) — Réponses rapides aux questions fréquentes
