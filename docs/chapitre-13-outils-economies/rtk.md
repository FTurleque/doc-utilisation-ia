# RTK — Rust Token Killer

<span class="badge-intermediate">Intermédiaire</span>

**RTK** ([rtk-ai.app](https://www.rtk-ai.app/) · [documentation](https://www.mintlify.com/rtk-ai/rtk/introduction) · [GitHub](https://github.com/rtk-ai/rtk)) est un outil **CLI open source écrit en Rust**. Il se place entre votre agent IA (Copilot, Cursor, Claude Code…) et le terminal, et **compresse les sorties de commandes de 60 à 90 %** avant qu'elles n'atteignent la fenêtre de contexte du modèle.

!!! warning "Ce n'est pas un plugin IDE"
    RTK ne s'installe pas dans IntelliJ ou VS Code. C'est un outil **ligne de commande** global. Il n'existe pas de plugin "RTK AI" dans le marketplace JetBrains ni dans celui de VS Code.

---

## Pourquoi RTK réduit les premium requests

Quand Copilot Agent ou Claude Code exécute une commande dans le terminal (ex. `npm test`, `git log`), la sortie brute est injectée dans la fenêtre de contexte du modèle. Ces sorties peuvent être **très volumineuses** :

```
Sans RTK :
  npm test  →  25 000 tokens de sortie brute  →  injectés dans le contexte

Avec RTK :
  rtk npm test  →  2 500 tokens filtrés  →  -90% de tokens consommés
```

Moins de tokens dans le contexte = **moins de premium requests consommées** par session d'agent, et des sessions qui durent **3× plus longtemps** avant d'atteindre la limite.

### Économies mesurées (exemples réels)

| Commande | Fréquence (30 min) | Sans RTK | Avec RTK | Gain |
|----------|-------------------|----------|----------|------|
| `git status` | 10× | 3 000 tokens | 600 tokens | -80% |
| `git log` | 5× | 2 500 tokens | 500 tokens | -80% |
| `npm test` | 5× | 25 000 tokens | 2 500 tokens | -90% |
| `ls / tree` | 10× | 2 000 tokens | 400 tokens | -80% |
| `grep / rg` | 8× | 16 000 tokens | 3 200 tokens | -80% |
| **Total session** | — | ~150 000 tokens | ~45 000 tokens | **-70%** |

---

## Comment ça fonctionne

RTK applique quatre stratégies selon la commande :

1. **Filtrage intelligent** — supprime les warnings répétitifs, le boilerplate, les barres de progression
2. **Regroupement** — agrège les fichiers par dossier, les erreurs par type
3. **Troncature** — conserve les N premières/dernières lignes pertinentes au lieu de 1 000
4. **Déduplication** — `Error: timeout (×347)` au lieu de 347 lignes identiques

```bash
# Exemple : git push brut (15 lignes, ~200 tokens)
$ git push
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 8 threads
Compressing objects: 100% (3/3), done.
...
To github.com:user/repo.git
   abc1234..def5678  main -> main

# Avec RTK (1 ligne, ~10 tokens — réduction de 95%)
$ rtk git push
ok ✓ main
```

---

## Installation

### Windows

Téléchargez le binaire pré-compilé depuis les [GitHub Releases](https://github.com/rtk-ai/rtk/releases) :

1. Rendez-vous sur [github.com/rtk-ai/rtk/releases](https://github.com/rtk-ai/rtk/releases)
2. Téléchargez `rtk-x86_64-pc-windows-msvc.zip` (ou la version `aarch64` pour ARM)
3. Créez un dossier dédié et ajoutez-le au PATH :

    Ouvrez un terminal **PowerShell** (pas cmd) : dans VS Code ++ctrl+grave++ ou dans le menu Démarrer → "Windows PowerShell". Puis exécutez ces commandes une par une :

    ```powershell
    # Créer le dossier
    New-Item -ItemType Directory -Path "C:\Tools" -Force

    # Extraire rtk.exe dedans (adapter le chemin du zip)
    Expand-Archive -Path "$env:USERPROFILE\Downloads\rtk-x86_64-pc-windows-msvc.zip" -DestinationPath "C:\Tools"

    # Ajouter C:\Tools au PATH de façon permanente (utilisateur courant)
    [Environment]::SetEnvironmentVariable(
        "PATH",
        [Environment]::GetEnvironmentVariable("PATH", "User") + ";C:\Tools",
        "User"
    )
    ```

    !!! info "Prendre en compte le PATH"
        Fermez et rouvrez votre terminal (ou VS Code / IntelliJ) pour que le nouveau PATH soit chargé.

4. Vérifiez l'installation :

```powershell
rtk --version
# rtk 0.34.3 (ou supérieur)

rtk gain
# Doit afficher les statistiques de tokens économisés
```

!!! warning "Résoudre un conflit de nom"
    Il existe deux projets nommés `rtk` sur crates.io. Vérifiez avec `rtk gain` : si la commande n'existe pas, vous avez le mauvais paquet. Utilisez toujours le binaire issu de [`rtk-ai/rtk`](https://github.com/rtk-ai/rtk/releases).

### macOS / Linux

```bash
# Via le script d'installation (recommandé)
curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh

# Via Homebrew (macOS et Linux)
brew install rtk
```

---

## Activation du hook automatique

Sans configuration supplémentaire, vous devez préfixer chaque commande avec `rtk`. Pour que **toutes les commandes soient automatiquement compressées** sans effort, lancez cette commande **dans votre terminal système** (PowerShell sous Windows, ou bash/zsh sur macOS/Linux) — **pas dans le chat IA** :

```powershell
rtk init --global
```

!!! info "Où lancer cette commande ?"
    - **VS Code** : terminal intégré (++ctrl+grave++) → PowerShell
    - **IntelliJ** : onglet Terminal en bas de l'IDE
    - **Windows** : menu Démarrer → "Windows PowerShell"

    Cette commande n'interagit pas avec une IA. Elle modifie la configuration de votre shell pour intercepter automatiquement les commandes CLI.

    Cette commande installe un **hook shell** (dans votre profil PowerShell, bash ou zsh). À partir de là, chaque commande `git status`, `npm test`, etc. que vous tapez dans un terminal passe automatiquement par RTK.

    !!! note "Hook shell vs hook agent"
        Le hook shell fonctionne dans **tout terminal interactif** (VS Code, IntelliJ, Windows Terminal…) car le shell charge votre profil au démarrage. En revanche, certains agents IA comme Claude Code ont leur propre mécanisme (`PreToolUse`) qui garantit l'interception même hors terminal interactif — ce n'est pas le cas de Copilot Agent dans IntelliJ.

### Utilisation explicite (sans hook)

Préfixez simplement `rtk` devant vos commandes habituelles :

```bash
rtk git status
rtk git log
rtk npm test
rtk cargo test
rtk grep "pattern" src/
rtk ls -la
```

### Avec le hook (automatique)

Après `rtk init --global`, continuez à écrire vos commandes normalement — RTK s'intercale automatiquement.

### Suivi des économies

```bash
rtk gain
```

```
📊 RTK Token Savings
════════════════════════════════════════
Total commands:    2,927
Input tokens:      11.6M
Output tokens:     1.4M
Tokens saved:      10.3M (89.2%)

By Command:
────────────────────────────────────────
Command               Count      Saved     Avg%
rtk find                324       6.8M    78.3%
rtk git status          215       1.4M    80.8%
rtk grep                227     786.7K    49.5%
rtk cargo test           16      50.1K    91.8%
```

---

## Commandes supportées

RTK optimise **50+ commandes** classiques du développement :

| Catégorie | Commandes |
|-----------|-----------|
| **Git** | `status`, `diff`, `log`, `push`, `pull`, `branch`, `stash` |
| **Tests** | `cargo test`, `npm test`, `pytest`, `go test`, `vitest`, `playwright` |
| **Packages** | `npm install`, `pnpm list`, `pip install`, `cargo build` |
| **Linters** | `eslint`, `ruff`, `tsc`, `mypy`, `cargo clippy` |
| **Containers** | `docker ps`, `docker logs`, `kubectl get pods` |
| **Fichiers** | `ls`, `tree`, `grep`, `cat`, `find` |
| **Divers** | `curl`, `gh pr list`, `next build`, `prisma migrate` |

La liste complète avec les détails de filtrage par commande est disponible dans la documentation officielle : **[mintlify.com/rtk-ai/rtk/commands/overview](https://www.mintlify.com/rtk-ai/rtk/commands/overview)**

---

## Compatibilité avec les agents IA

| Outil | Compatibilité | Notes |
|-------|--------------|-------|
| **Claude Code** | ✅ Natif | Hook `PreToolUse` intégré — compression automatique garantie |
| **GitHub Copilot Agent** (VS Code) | ✅ Via hook shell | Le terminal intégré charge le profil shell → RTK actif |
| **GitHub Copilot Agent** (IntelliJ) | ⚠️ Partiel | Voir note ci-dessous |
| **Cursor** | ✅ Via hook shell | Terminal intégré charge le profil shell |
| **Aider** | ✅ Via hook shell | Réduit la facture API de ~70% |
| **Gemini CLI** | ✅ Via hook shell | Libère du headroom sur le quota gratuit |

!!! warning "GitHub Copilot Agent dans IntelliJ"
    IntelliJ ne dispose pas d'un mécanisme de hook équivalent au `PreToolUse` de Claude Code.
    RTK fonctionne **quand vous tapez vous-même** des commandes dans le terminal intégré d'IntelliJ (car le shell charge votre profil au démarrage).
    En revanche, si Copilot Agent exécute des commandes via son propre moteur interne (sans passer par le shell interactif), le hook shell peut ne pas être déclenché.
    **Solution** : préfixez manuellement vos commandes avec `rtk` dans le terminal IntelliJ, ou utilisez RTK depuis un terminal externe en parallèle.

---

## Résumé

| Aspect | Détail |
|--------|--------|
| Type | Outil CLI (Rust, open source, MIT) |
| GitHub | [rtk-ai/rtk](https://github.com/rtk-ai/rtk) |
| Documentation | [mintlify.com/rtk-ai](https://www.mintlify.com/rtk-ai/rtk/introduction) |
| Installation | Binaire Windows · `brew install rtk` · script curl |
| Gratuit | Oui, entièrement |
| Économies mesurées | 60–90% de tokens par commande CLI |
| Plugin IDE | ❌ Aucun — fonctionne au niveau du terminal |

!!! success "Recommandation"
    Lancez `rtk init --global` une seule fois. Ensuite, chaque session Copilot Agent ou Claude Code consommera automatiquement 60 à 90 % de tokens en moins sur les sorties de commandes, sans rien changer à votre workflow.

---

## Prochaine étape

**[Outils Complémentaires](outils-complementaires.md)** : Continue.dev, Ollama, LM Studio, Codeium, Tabnine, Amazon Q et Supermaven — des alternatives gratuites ou locales pour couvrir les usages que RTK ne prend pas en charge.

Outils couverts :

- **Continue.dev** — assistant Chat open source, remplace Copilot Chat avec n'importe quel modèle
- **Ollama** — runner de modèles locaux, zéro coût, zéro connexion externe
- **Codeium / Supermaven** — autocomplétion gratuite sans limite de quota
- **Tabnine** — option enterprise avec modèle local et garantie de confidentialité
