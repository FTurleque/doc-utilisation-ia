# Installer Claude Code — CLI, Desktop, VS Code et JetBrains

<span class="badge-beginner">Débutant</span> <span class="badge-intellij">IntelliJ</span> <span class="badge-vscode">VS Code</span> <span class="badge-cli">CLI</span>

Cette page décrit les principaux points d'entrée actuels de **Claude Code** : CLI native, **Claude Desktop**, extension Visual Studio Code et plugin JetBrains. Elle couvre aussi l'authentification, les mises à jour et les diagnostics de base.

!!! info "Vérifié le 28 septembre 2026"
    Les commandes et prérequis ci-dessous ont été revérifiés dans la documentation officielle Claude Code et Claude Desktop.

---

## Quel point d'entrée choisir ?

| Besoin | Point d'entrée recommandé | CLI requise ? |
|---|---|:---:|
| Travailler principalement dans un terminal | **CLI Claude Code** | — |
| Utiliser Claude Code dans une application graphique unifiée avec Chat et outils locaux | **Claude Desktop** | Non pour l'application ; CLI utile pour les workflows terminal et le transfert de session |
| Travailler dans VS Code avec panneau graphique, diffs et `@mentions` | **Extension VS Code** | Non |
| Travailler dans IntelliJ / PyCharm / WebStorm avec intégration IDE | **Plugin JetBrains + CLI** | Oui |
| Automatiser dans un script ou une CI | **CLI en mode `-p`** | Oui |

!!! important "Desktop, VS Code et JetBrains ne fonctionnent pas de la même manière"
    **Claude Desktop** est l'application officielle de bureau et peut exécuter Claude Code directement. L'extension **VS Code** peut être installée et authentifiée directement dans l'éditeur : la CLI locale n'est pas un prérequis. Le plugin **JetBrains**, lui, lance la commande `claude` dans le terminal intégré et nécessite donc la CLI sur le `PATH`.

### Claude Desktop

Claude Desktop est disponible sur macOS et Windows, ainsi que sur Linux en bêta pour les distributions actuellement prises en charge. Il réunit Chat et Claude Code dans une application native, prend en charge des extensions de bureau pour des ressources locales et le schéma de deep link `claude://`.

Consultez la page dédiée **[Claude Desktop](claude-desktop.md)** pour l'installation, les extensions locales, les deep links, `/desktop` et les différences avec CLI/IDE.

---

## Prérequis de la CLI

Claude Code prend officiellement en charge notamment :

- macOS **13+** ;
- Windows **10 1809+** ou Windows Server 2019+ ;
- Ubuntu **20.04+**, Debian **10+**, Alpine Linux **3.19+** ;
- processeur x64 ou ARM64 ;
- au moins **4 Go de RAM** ;
- Bash, Zsh, PowerShell ou CMD ;
- une connexion Internet et un pays/région pris en charge par Anthropic.

Sur Windows natif, **Git for Windows est recommandé mais n'est plus obligatoire**. Sans Git Bash, Claude Code peut utiliser son outil PowerShell. WSL 2 reste pertinent pour les toolchains Linux et permet le sandboxing, contrairement à Windows natif.

### Compte nécessaire

Pour l'authentification directe Anthropic, Claude Code accepte :

- Claude **Pro** ou **Max** ;
- Claude **Team** ou **Enterprise** ;
- un compte **Claude Console** ;
- ou un fournisseur tiers configuré : Amazon Bedrock, Google Cloud Agent Platform / Vertex AI, Microsoft Foundry, etc.

!!! warning "Le plan Claude gratuit ne donne pas accès à Claude Code"
    L'accès local à Claude Code nécessite actuellement un compte payant compatible, un compte Console ou un fournisseur tiers configuré. Le chat Claude Desktop, lui, reste disponible sur le plan Free.

---

## 1. Installer la CLI

### macOS, Linux et WSL

L'installation native est la méthode recommandée :

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

Sur macOS ou Linux avec Homebrew :

```bash
brew install --cask claude-code
```

Le cask `claude-code` suit le canal **stable**. Le cask `claude-code@latest` suit les versions dès leur publication.

### Windows PowerShell

```powershell
irm https://claude.ai/install.ps1 | iex
```

Il n'est pas nécessaire d'ouvrir PowerShell en administrateur.

### Windows CMD

```cmd
curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd
```

### Windows avec WinGet

```powershell
winget install Anthropic.ClaudeCode
```

### npm — compatibilité historique

La méthode npm existe encore, mais ce n'est plus la méthode recommandée pour une nouvelle installation :

```bash
npm install -g @anthropic-ai/claude-code
```

Préférez l'installeur natif lorsque votre environnement le permet.

### Vérifier l'installation

```bash
claude --version
claude doctor
```

`claude doctor` réalise un diagnostic **en lecture seule** de l'installation et de la configuration : santé de l'installation, validation des settings et avertissements avec pistes de correction.

---

## 2. Authentification

Lancez Claude Code dans un terminal :

```bash
cd mon-projet
claude
```

Au premier démarrage, Claude Code ouvre normalement le navigateur pour l'authentification. Si le navigateur ne peut pas revenir vers le terminal — situation fréquente en WSL2, SSH ou conteneur — Claude Code permet de copier l'URL puis de coller le code de connexion dans le terminal.

### Abonnement Claude

Avec Pro, Max, Team ou Enterprise :

1. lancez `claude` ;
2. connectez-vous avec votre compte Claude ;
3. terminez l'autorisation dans le navigateur.

Dans une session interactive, `/login` permet de refaire l'authentification et `/logout` de la supprimer.

### Claude Console et clé API

Un compte Claude Console peut désormais être utilisé **avec ou sans création manuelle de clé API**, selon la configuration de l'organisation.

Pour utiliser explicitement une clé API :

```bash
# macOS / Linux
export ANTHROPIC_API_KEY="sk-ant-..."

# Windows PowerShell
$env:ANTHROPIC_API_KEY = "sk-ant-..."
```

Lorsqu'`ANTHROPIC_API_KEY` est présente, le mode interactif demande une confirmation avant de l'utiliser. En mode non interactif (`claude -p`), elle est utilisée lorsqu'elle est définie.

!!! danger "Ne versionnez jamais les credentials"
    Une clé API ou un jeton ne doit jamais apparaître dans `CLAUDE.md`, `.claude/settings.json`, un fichier Markdown ou un `.env` versionné. Utilisez un gestionnaire de secrets, les mécanismes d'authentification Claude ou des variables d'environnement injectées au runtime.

### Fournisseurs cloud

Claude Code peut être routé vers plusieurs plateformes. Par exemple :

```bash
# Amazon Bedrock
export CLAUDE_CODE_USE_BEDROCK=1

# Google Cloud Agent Platform / Vertex AI
export CLAUDE_CODE_USE_VERTEX=1

# Microsoft Foundry
export CLAUDE_CODE_USE_FOUNDRY=1
```

Les identifiants et variables complémentaires dépendent du fournisseur : suivez la page officielle correspondante plutôt que de copier des secrets dans le dépôt.

### Où Claude stocke-t-il la connexion ?

| OS | Stockage de la connexion Claude Code |
|---|---|
| macOS | Keychain chiffré ; fallback possible vers `~/.claude/.credentials.json` si le Keychain n'est pas accessible |
| Linux | `~/.claude/.credentials.json`, permissions `0600` |
| Windows | `%USERPROFILE%\.claude\.credentials.json`, protégé par les ACL du profil utilisateur |

Si `CLAUDE_CONFIG_DIR` est défini, Claude Code utilise ce répertoire à la place de `~/.claude` pour ses données de configuration et credentials concernés.

---

## 3. Premier lancement CLI

Lancez Claude à la racine du dépôt lorsque les instructions et réglages partagés se trouvent à cet endroit :

```bash
cd mon-projet
claude
```

Quelques commandes utiles :

| Commande | Usage |
|---|---|
| `/help` | Voir les commandes disponibles dans votre version |
| `/init` | Créer ou améliorer un `CLAUDE.md` à partir du dépôt |
| `/status` | Vérifier notamment la configuration et la méthode d'authentification active |
| `/config` | Modifier les préférences prises en charge |
| `/model` | Choisir le modèle pour la session |
| `/clear` | Démarrer avec un contexte de conversation vide |
| `/compact` | Compacter le contexte de la session |
| `/mcp` | Inspecter et gérer les connexions MCP |
| `/usage` | Consulter les informations d'usage disponibles |
| `/desktop` | Passer vers Claude Desktop lorsqu'il est pris en charge par la version installée |

!!! note "Les commandes évoluent rapidement"
    Utilisez `/help` dans votre version installée comme source opérationnelle. Cette documentation évite de figer une liste exhaustive de commandes slash.

### Mode non interactif

```bash
claude -p "Résume les changements de ce diff et propose un message de commit"
```

Le mode `-p` est adapté aux scripts et à la CI. Pour les automatisations sans navigateur, utilisez une méthode d'authentification explicitement prévue pour l'environnement d'exécution plutôt qu'un secret committé dans le dépôt.

---

## 4. Installer Claude Code dans VS Code

### Prérequis

La documentation officielle demande actuellement :

- **VS Code 1.94.0 ou supérieur** ;
- un abonnement Claude payant compatible ou un compte Claude Console ;
- ou la configuration d'un fournisseur tiers prise en charge.

La CLI n'est **pas obligatoire** pour utiliser l'extension VS Code.

### Installation

1. Ouvrez Extensions avec ++ctrl+shift+x++ sous Windows/Linux ou ++cmd+shift+x++ sous macOS.
2. Recherchez **Claude Code** publié par Anthropic.
3. Installez l'extension.
4. Si le panneau n'apparaît pas, rechargez la fenêtre avec **Developer: Reload Window** ou redémarrez VS Code.

Vous pouvez ensuite ouvrir Claude avec l'icône dédiée, l'Activity Bar ou la palette de commandes.

Au premier démarrage, le panneau affiche son propre écran de connexion et ouvre le navigateur. Si vous utilisez `ANTHROPIC_API_KEY`, lancez éventuellement VS Code depuis un terminal avec `code .` pour qu'il hérite des variables d'environnement du shell.

### Contexte et modifications

L'intégration VS Code peut notamment :

- voir la sélection courante ;
- référencer des fichiers et dossiers avec `@...` ;
- afficher des diffs ;
- travailler selon le mode de permissions choisi ;
- reprendre des sessions précédentes.

!!! tip "Copilot reste compatible avec ce dépôt"
    La documentation GitHub Copilot est conservée. Vous pouvez garder Copilot installé en parallèle, par exemple pour comparer les workflows ou conserver une complétion inline spécifique. Ce dépôt recommande toutefois Claude Code comme parcours principal.

---

## 5. Installer Claude Code dans JetBrains

Le plugin JetBrains fonctionne différemment de l'extension VS Code : **il ne contient pas sa propre copie de la CLI**.

### Installation

1. Installez d'abord la CLI Claude Code et vérifiez `claude --version`.
2. Dans IntelliJ IDEA, PyCharm, WebStorm ou un autre IDE pris en charge, ouvrez **Settings / Preferences → Plugins → Marketplace**.
3. Installez le plugin officiel **Claude Code**.
4. Redémarrez complètement l'IDE.
5. Lancez `claude` depuis le terminal intégré de l'IDE.

Le plugin prend notamment en charge :

- le lancement rapide de Claude Code ;
- l'affichage des diffs dans l'IDE ;
- le partage de la sélection ou de l'onglet actif ;
- les références de fichiers ;
- le partage des diagnostics IDE.

Si `claude` est installé dans un emplacement que l'IDE ne trouve pas, configurez le chemin complet dans le réglage **Claude command** du plugin.

Depuis un terminal externe, vous pouvez également démarrer Claude puis utiliser `/ide` pour vous connecter à une instance JetBrains en cours d'exécution.

---

## 6. Windows : natif ou WSL ?

| Mode | Sandboxing Claude Code | Usage recommandé |
|---|:---:|---|
| Windows natif | Non | Projets et outils Windows natifs |
| WSL 2 | Oui | Toolchains Linux ou besoin de sandboxing |
| WSL 1 | Non | Solution de compatibilité lorsque WSL 2 n'est pas disponible |

Avec Git for Windows installé, Claude Code peut utiliser Git Bash pour son outil Bash. Sans Git for Windows, les versions actuelles peuvent utiliser PowerShell sur Windows natif.

---

## 7. Mises à jour

| Installation | Mise à jour |
|---|---|
| Installeur natif Claude Code | Mise à jour automatique en arrière-plan ; `claude update` permet de forcer une vérification |
| Homebrew | `brew upgrade claude-code` ou `brew upgrade claude-code@latest` |
| WinGet | `winget upgrade Anthropic.ClaudeCode` |
| npm | Mise à jour via npm |
| Claude Desktop Linux via `apt` | Mise à jour via les mises à jour normales du gestionnaire de paquets |

!!! warning "WinGet n'est pas l'installeur natif auto-updaté"
    Une installation WinGet nécessite par défaut une mise à jour via WinGet. Ne la classez pas avec l'installeur natif lorsqu'il s'agit de politique de mise à jour.

Claude Code permet également de choisir un canal de mise à jour (`latest` ou `stable`) pour les installations concernées.

---

## 8. Dépannage rapide

| Symptôme | Vérification |
|---|---|
| `claude` introuvable | Ouvrir un nouveau terminal, contrôler le `PATH`, puis lancer `claude doctor` |
| Le plugin JetBrains ne démarre pas | Vérifier que la CLI est installée et que le plugin connaît le chemin de `claude` |
| L'extension VS Code ne s'affiche pas | **Developer: Reload Window** ou redémarrage de VS Code |
| Une clé API n'est pas utilisée dans VS Code | Lancer `code .` depuis un shell qui contient la variable, ou utiliser la connexion Claude |
| Claude Desktop n'ouvre pas une session Code | Vérifier le plan compatible, la version Desktop et la disponibilité de Claude Code sur la plateforme |
| Connexion expirée | Vérifier `/status`, puis refaire `/login` |
| Settings invalides | `claude doctor` et `/status` signalent les erreurs de configuration |

---

## Prochaine étape

Si vous souhaitez une interface graphique unifiée, passez à **[Claude Desktop](claude-desktop.md)**. Pour structurer ensuite la configuration versionnée du projet, poursuivez avec **[Architecture et paramétrage Claude Code](architecture-claude.md)**.

---

## Sources

Sources officielles consultées le **28 septembre 2026** :

- [Claude — Télécharger Claude Desktop](https://claude.com/download)
- [Anthropic Help Center — Installer Claude Desktop](https://support.claude.com/fr/articles/10065433-installer-claude-desktop)
- [Anthropic Help Center — Ouvrir Claude Desktop avec un lien](https://support.claude.com/fr/articles/14729294-ouvrir-claude-desktop-avec-un-lien)
- [Claude Code — Advanced setup](https://code.claude.com/docs/en/setup)
- [Claude Code — Authentication](https://code.claude.com/docs/en/authentication)
- [Claude Code — VS Code](https://code.claude.com/docs/en/vs-code)
- [Claude Code — JetBrains IDEs](https://code.claude.com/docs/en/jetbrains)
- [Claude Code — CLI reference](https://code.claude.com/docs/en/cli-reference)
- [Claude Code — Settings](https://code.claude.com/docs/en/settings)
