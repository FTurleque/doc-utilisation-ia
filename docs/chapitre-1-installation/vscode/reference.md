# GitHub Copilot sur VS Code — référence

<span class="badge-vscode">VS Code</span> <span class="badge-intermediate">Intermédiaire</span>

Cette page est une **référence Copilot conservée**. Le parcours principal du dépôt est Claude Code ; utilisez cette page lorsque VS Code + GitHub Copilot reste votre environnement.

---

## Source de vérité

GitHub recommande d'utiliser la **dernière version stable de VS Code et de Copilot**. Les fonctionnalités évoluent suffisamment vite pour qu'une matrice figée dans ce dépôt devienne rapidement fausse.

Consultez en priorité :

- la **Copilot feature matrix** ;
- la documentation VS Code Copilot ;
- les release notes VS Code ;
- les politiques de votre organisation GitHub.

---

## Configuration VS Code

Les paramètres utilisateur VS Code sont généralement stockés dans :

| OS | Dossier utilisateur VS Code |
|---|---|
| Windows | `%APPDATA%\Code\User\` |
| macOS | `~/Library/Application Support/Code/User/` |
| Linux | `~/.config/Code/User/` |

Le fichier principal est `settings.json`. Les paramètres de workspace vivent dans `.vscode/settings.json` et peuvent surcharger les réglages utilisateur.

!!! warning "Ne mettez pas de secrets dans le workspace"
    Un fichier `.vscode/settings.json` peut être versionné. N'y placez jamais de token ou secret.

---

## Fonctions prises en charge

La matrice GitHub courante pour la dernière version de VS Code indique la prise en charge de nombreuses capacités, notamment :

| Fonction | État général actuel |
|---|---|
| Code completion | Supporté |
| Chat | Supporté |
| Agent mode | Supporté |
| Edit mode | Supporté |
| MCP | Supporté |
| Custom instructions | Supporté |
| Custom agents | Supporté |
| Prompt files | Supporté |
| Agent skills | Supporté sur les versions récentes |
| Workspace indexing | Supporté |
| BYOK / Vision | Peut rester en preview |

La disponibilité exacte dépend toujours de la version, du plan, des politiques d'organisation et parfois du canal preview.

---

## Raccourcis clavier

Ne considérez pas les raccourcis de cette documentation comme une API stable. Ils peuvent varier avec :

- le système d'exploitation ;
- le keymap ;
- les extensions ;
- les changements VS Code/Copilot.

Pour connaître la valeur réelle :

1. ouvrez **Keyboard Shortcuts** (`Ctrl+K Ctrl+S` sur Windows/Linux par défaut) ;
2. recherchez `Copilot`, `Chat` ou `inlineSuggest` ;
3. utilisez les commandes affichées par votre version.

Les actions de base restent généralement : accepter/rejeter une suggestion inline, ouvrir le chat, lancer une action agentique et arrêter une génération.

---

## Instructions, agents, prompt files et skills

Copilot peut utiliser plusieurs mécanismes de personnalisation dans VS Code. Leur syntaxe et leur portée ne sont pas identiques à Claude Code.

Dans ce dépôt :

- `.github/copilot-instructions.md` reste conservé pour Copilot ;
- les pages `applyTo` et prompt files restent des références Copilot ;
- les skills/agents Copilot sont documentés séparément des `.claude/skills/` et `.claude/agents/`.

Évitez de dupliquer une même règle dans plusieurs fichiers si une source commune peut être référencée.

---

## MCP

VS Code Copilot prend en charge MCP. Traitez chaque serveur MCP comme un composant ayant accès à des données ou actions :

- permissions minimales ;
- secrets hors dépôt ;
- outils limités au besoin ;
- validation des sorties ;
- audit des serveurs tiers avant installation.

Voir aussi **[MCP](../../chapitre-13-outils-economies/mcps/index.md)**.

---

## Diagnostic

En cas de problème :

1. mettez VS Code et Copilot à jour ;
2. vérifiez le compte GitHub actif ;
3. vérifiez les politiques d'organisation ;
4. testez sans extensions conflictuelles ;
5. consultez **View → Output** et sélectionnez les canaux Copilot disponibles ;
6. contrôlez GitHub Status si le problème semble distant.

Voir **[Troubleshooting](../../chapitre-11-troubleshooting/index.md)**.

---

## Sécurité

- relire le diff avant acceptation ;
- ne pas transmettre de secrets ;
- contrôler les permissions agentiques ;
- vérifier les packages proposés ;
- exécuter tests, lint, typecheck et scans habituels ;
- ne pas considérer une réponse Copilot comme preuve de correction.

---

## Prochaine étape

Poursuivez avec **[Installation — Comparaison](../comparaison.md)**, la page suivante dans le menu.

## Sources

- [GitHub Docs — Copilot feature matrix](https://docs.github.com/en/copilot/reference/copilot-feature-matrix) — consulté le 2026-09-28
- [GitHub Docs — Installing the GitHub Copilot extension](https://docs.github.com/en/copilot/how-tos/set-up/install-copilot-extension) — consulté le 2026-09-28
- [GitHub Docs — Configuring GitHub Copilot in your environment](https://docs.github.com/en/copilot/how-tos/configure-personal-settings/configure-in-ide) — consulté le 2026-09-28

## Parcours principal

Pour Claude Code : **[Installation Claude Code](../../chapitre-3b-claude-code-migration-copilot/installation.md)**.
