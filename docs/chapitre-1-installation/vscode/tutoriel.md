# :material-microsoft-visual-studio-code: Tutoriel — Installer GitHub Copilot sur Visual Studio Code

<span class="badge-vscode">VS Code</span> <span class="badge-beginner">Débutant</span>

## Présentation

Ce tutoriel vous guide pas à pas pour installer et configurer GitHub Copilot sur Visual Studio Code. Durée estimée : **5 minutes**.

GitHub Copilot vous permet de :

- Recevoir des suggestions de code en temps réel
- Poser des questions en langage naturel via le chat
- Automatiser la génération de tests et de documentation
- Déboguer votre code plus rapidement

---

## Prérequis

Avant de commencer, vérifiez les prérequis :

- [ ] **Visual Studio Code 1.85+** (version en date de mars 2026 recommandée)
- [ ] **Compte GitHub actif** avec authentification
- [ ] **Accès à Copilot** (Free, Pro, ou via votre organisation)
- [ ] **Connexion internet** (authentification OAuth)

Vérifiez la version VS Code : *Help → About* ou ++ctrl+shift+p++ → tapez *"About"*

!!! warning "Version insuffisante ?"
    Si votre VS Code est antérieur à 1.85, mettez à jour via *Help → Check for Updates* ou téléchargez depuis [code.visualstudio.com](https://code.visualstudio.com).

---

## :material-folder-open: Étape 1 — Ouvrir le panneau Extensions

Ouvrez Visual Studio Code et accédez au **panneau Extensions** :

### :keyboard: Méthode 1 : Raccourci clavier

- **Windows/Linux** : ++ctrl+shift+x++
- **macOS** : ++cmd+shift+x++

### :material-mouse: Méthode 2 : Barre latérale gauche

1. Cliquez l'icône Extensions (quatre petits carrés)

<figure markdown>
  ![Panneau Extensions](../../assets/images/vscode/vscode-marketplace-01.png){ .reduced-screenshot }
  <figcaption markdown="span">:material-camera: Panneau Extensions</figcaption>
</figure>

### :material-menu: Méthode 3 : Menu

*View → Extensions*

!!! example "Vous verrez:"
    Une barre de recherche avec "Search Extensions in Marketplace" en haut du panneau.

---

## :material-download: Étape 2 — Installer GitHub Copilot

### :material-list-box: Étapes d'installation

1. Tapez **`GitHub Copilot`** dans la barre de recherche du panneau Extensions
2. Le premier résultat doit être l'extension officielle publiée par **GitHub** (avec un badge de vérification ✓)
3. Vérifiez l'identifiant exact : `GitHub.copilot`
4. Cliquez le bouton vert **Install**

<figure markdown>
  ![Bouton Install](../../assets/images/vscode/vscode-install-button-01.png){ .doc-screenshot }
  <figcaption markdown="span">:material-camera: Résultat de la recherche GitHub Copilot</figcaption>
</figure>

!!! danger "Sécurité — Vérification importante"
    Installez **UNIQUEMENT** l'extension publiée par `GitHub` (l'organisation autorisée). Plusieurs extensions imitatrices existent — ignorez-les. L'identifiant correct est `GitHub.copilot`, pas d'autres variantes.

**Après l'installation**, l'extension démarre. Vous verrez un message :

- *"GitHub Copilot installed successfully"* dans la palette de commandes
- Ou une notification pop-up vous demandant de vous connecter

---

## :material-chat: Étape 3 — Installer GitHub Copilot Chat (optionnel mais recommandé)

L'interface **chat** n'est pas incluse automatiquement. Installez-la pour utiliser :

- Chat conversationnel
- Slash commands (`/explain`, `/tests`, `/doc`)
- Contexte enrichi (`@workspace`, `@project`)

1. Tapez **`GitHub Copilot Chat`** dans les Extensions
2. Cliquez **Install** sur l'extension officielle de GitHub
3. L'extension installée, VS Code demande de recharger

!!! info "Installation groupée (VS Code 1.90+)"
    Les versions récentes de VS Code peuvent proposer une installation groupée : cliquez pour installer Copilot + Chat d'un coup.

---

## :material-github: Étape 4 — Authentification avec GitHub

Après installation, authentifiez-vous :

### :material-bell: Cas 1 : Notification automatique

1. Une pop-up apparaît en bas à droite : *"Sign in to use GitHub Copilot"*
2. Cliquez **"Sign in to GitHub"** ou **"Sign in with GitHub"**

### :material-pencil: Cas 2 : Authentification manuelle

- **Windows/Linux** : ++ctrl+shift+p++ → `GitHub Copilot: Sign In`
- **macOS** : ++cmd+shift+p++ → `GitHub Copilot: Sign In`

<figure markdown>
  ![Authentification GitHub](../../assets/images/vscode/vscode-auth-github-01.png){ .doc-screenshot }
  <figcaption markdown="span">:material-camera: Authentification GitHub</figcaption>
</figure>

### :material-web: Processus de connexion

1. VS Code ouvre votre navigateur sur GitHub
2. Si non connecté, connectez-vous avec vos identifiants GitHub
3. GitHub affiche une page d'autorisation : *"Visual Studio Code wants to access your account"*
4. Cliquez **Authorize Visual-Studio-Code**
5. VS Code affiche : *"GitHub Copilot authentication successful"*
6. Le navigateur vous redirige, VS Code recharge automatiquement

!!! tip "Connexion bloquée ?"
    - Vérifiez que l'authentification 2FA est activée sur votre compte GitHub
    - Certains réseaux d'entreprise bloquent OAuth → contactez votre IT
    - Essayez "*GitHub Copilot: Sign Out*" puis réessayez

---

### :material-check: Vérification rapide

1. Regardez la **barre de statut en bas à droite** de VS Code
2. Vous devez voir l'icône Copilot (ressemble à un éclair ou logo Copilot)
3. **Vert** ou sans point rouge = actif ✅

<figure markdown>
  ![Icône Copilot](../../assets/images/vscode/vscode-status-bar-icon.png){ .reduced-screenshot }
  <figcaption markdown="span">:material-camera: Icône Copilot active dans la barre de statut</figcaption>
</figure>

### :material-play: Test rapide du fonctionnement

1. Créez un nouveau fichier : *File → New File*
2. Tapez un langage : `// TypeScript` ou `# Python`
3. Appuyez ++enter++ et tapez : `function hello` (ou autre début)
4. Attendez 1-2 secondes → Copilot affiche une suggestion grise
5. Appuyez ++tab++ pour accepter, ou ++escape++ pour rejeter

!!! example "Exemple: vous tapez"
    ```
    function hello
    ```
    
    Copilot suggère (en gris) :
    ```
    function hello(name: string): string {
      return `Hello, ${name}!`;
    }
    ```
    
    Appuyer ++tab++ accepte la suggestion entière. ++alt+right++ accepte mot par mot.

---

## :material-chat: Votre première interaction avec Copilot Chat

### :material-chat-outline: Ouvrir Copilot Chat

- **Windows/Linux** : ++ctrl+alt+i++
- **macOS** : ++cmd+alt+i++

### :material-lightbulb: Première question

1. Le panneau **Chat** s'ouvre à droite

<figure markdown>
  ![Panneau Copilot Chat](../../assets/images/vscode/vscode-chat-sidebar-01.png){ .doc-screenshot }
  <figcaption markdown="span">:material-camera: Panneau Copilot Chat ouvert dans VS Code</figcaption>
</figure>

2. Tapez une question simple :
   ```
   Explique-moi comment utiliser Map en JavaScript
   ```
3. Copilot répond avec explication + exemples de code

### :keyboard: Raccourcis Chat disponibles

- **Ouvrir Chat** : ++ctrl+alt+i++
- **Inline Chat (dans l'éditeur)** : ++ctrl+i++ — modifier du code sélectionné
- **Quick Chat (fenêtre flottante)** : ++ctrl+shift+i++

---

## Prochaines étapes

Vous avez installé Copilot ! Explor ensuite :

### 1. **Découvrir les raccourcis** (5 min)

→ [Guide Référence — Raccourcis complets](reference.md)

Apprenez :

- Accepter suggestions (++tab++, ++alt+right++)
- Naviguer entre suggestions (++alt+bracket-left/right++)
- Déclencher manuellement (++alt+backslash++)

### 2. **Personnaliser vos préférences** (10 min)

→ [Paramétrage avancé](../../chapitre-2-parametrage/vscode-parametrage.md)

Configurez :

- Auto-suggestions (mode manuel vs auto)
- Langages autorisés
- Raccourcis clavier personnalisés

### 3. **Apprendre les best practices** (15 min)

→ [Utilisation Effective](../../chapitre-8-bonnes-pratiques/utilisation-effective.md)

Maîtrisez :

- Quand utiliser suggestions inline vs chat
- Prompt engineering basique
- Validation du code suggéré
- Sécurité et bonnes pratiques

### 4. **Explorer les agents et personnalisation** (20+ min)

→ [Contexte & Personnalisation](../../chapitre-3-contexte/vscode-contexte.md)

Avancé :

- Custom instructions (`.github/copilot-instructions.md`)
- Agents autonomes
- Copilot Edits (modification multi-fichiers)

---

## Foire aux questions

**Q : Comment désactiver temporairement Copilot ?**

A : Cliquez l'icône Copilot dans la barre de statut (bas VS Code) → *"Disable Globally"* ou *"Disable for [Langage]"*

**Q : Copilot ne suggère rien. Qu'est-ce qui ne va pas ?**

A : Vérifiez :

- [ ] Extension GitHub Copilot installée (`GitHub.copilot`)
- [ ] Vous êtes authentifié (icône Copilot visible en bas)
- [ ] Les suggestions auto sont activées (settings)
- [ ] Vous êtes connecté à Internet

**Q : Je vois une erreur d'authentification. Que faire ?**

A :

1. Ouvrez palette de commandes ++ctrl+shift+p++
2. Tapez `GitHub Copilot: Sign Out`
3. Attendez 10 secondes
4. Tapez `GitHub Copilot: Sign In` et reconnectez-vous

**Q : Copilot suggère du code dangereux / mauvaise qualité ?**

A : C'est normal — **vous êtes responsable** de vérifier chaque suggestion. Lisez la section [Best Practices](../../chapitre-8-bonnes-pratiques/utilisation-effective.md) pour apprendre à valider.

---

## Prochaine étape

**[Guide Référence — GitHub Copilot sur VS Code](reference.md)** : documentation complète avec tous les raccourcis, paramétrages avancés, MCP, et fonctionnalités de Copilot sur VS Code.

Concepts clés couverts :

- **Raccourcis clavier complets** — accepter suggestions, naviguer, chat, inline chat
- **Paramétrages avancés** — modèles, tokens, MCP, authentification
- **Model Context Protocol (MCP)** — enrichir Copilot avec des serveurs externes (Context7, GitHub, Playwright, etc.)
- **Extensions recommandées** — GitHub Copilot Chat, GitLens, Error Lens, et autres
