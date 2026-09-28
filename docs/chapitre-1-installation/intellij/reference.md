# GitHub Copilot sur JetBrains — référence

<span class="badge-intellij">IntelliJ IDEA</span> <span class="badge-intermediate">Intermédiaire</span>

Cette page est une **référence Copilot conservée** pour IntelliJ IDEA et les IDE JetBrains compatibles. Claude Code reste le parcours principal du dépôt.

---

## Compatibilité et versions

GitHub renvoie désormais vers le **JetBrains Marketplace** pour la compatibilité exacte entre version du plugin Copilot et version de l'IDE. Ne figez pas une version IntelliJ universelle dans vos procédures internes.

Pratique recommandée :

1. utiliser une version stable de l'IDE encore supportée ;
2. vérifier la compatibilité de la version du plugin Copilot dans le Marketplace ;
3. utiliser le canal Stable sauf besoin explicite de preview ;
4. consulter la Copilot feature matrix pour connaître l'état réel des fonctions.

---

## Fichier de configuration du plugin

GitHub documente `github-copilot.xml` pour certains réglages, notamment l'activation par langage.

| OS | Emplacement courant documenté |
|---|---|
| Windows | `%APPDATA%\JetBrains\<product><version>\options\github-copilot.xml` |
| macOS | `~/Library/Application Support/JetBrains/<product><version>/options/github-copilot.xml` |
| Linux | `~/.config/JetBrains/<product><version>/options/github-copilot.xml` |

!!! note "Préférer l'interface quand possible"
    Le fichier interne peut évoluer. Pour les réglages ordinaires, utilisez d'abord **Settings → Tools → GitHub Copilot** et ne modifiez le XML directement que pour un besoin documenté.

---

## Activation par langage

La documentation GitHub permet d'activer ou désactiver Copilot par langage via :

**Settings → Tools → GitHub Copilot → Completions**

Le même réglage peut être représenté dans `github-copilot.xml` via `languageAllowList`.

Utilisez cette possibilité pour limiter Copilot dans des formats sensibles, mais ne la confondez pas avec un mécanisme DLP ou une garantie qu'aucune donnée sensible ne sera accessible à un autre outil.

---

## Matrice de fonctionnalités JetBrains

Dans les versions JetBrains Copilot 2026 actuellement listées par GitHub :

| Fonction | État général actuel |
|---|---|
| Code completion | Supporté |
| Chat | Supporté |
| Agent mode | Supporté |
| Edit mode | Supporté |
| MCP | Supporté |
| Checkpoints | Supporté |
| Code review | Supporté |
| Workspace indexing | Supporté |
| Custom instructions | Preview |
| Custom agents | Preview |
| Prompt files | Preview |
| Agent skills | Preview sur les versions récentes |
| Next edit suggestions | Preview |
| BYOK / Vision | Preview selon version |

La **feature matrix GitHub** reste la source de vérité : ces états peuvent changer sans modification de cette page.

---

## Raccourcis clavier

Les raccourcis varient selon :

- l'IDE JetBrains ;
- le système d'exploitation ;
- le keymap ;
- IdeaVim ou d'autres plugins ;
- la version du plugin Copilot.

Au lieu de maintenir une table exhaustive fragile :

1. ouvrez **Settings → Keymap** ;
2. recherchez `GitHub Copilot` ou `Copilot` ;
3. vérifiez ou remappez les actions réellement disponibles.

`Tab` et `Escape` restent couramment associés à l'acceptation/rejet des suggestions inline, mais vérifiez votre keymap avant de documenter un raccourci d'équipe.

---

## Personnalisation

JetBrains prend désormais en charge davantage de mécanismes Copilot qu'auparavant. Plusieurs sont encore en preview.

Conservez une séparation nette :

- Copilot : fichiers et réglages attendus par GitHub ;
- Claude Code : `CLAUDE.md`, `.claude/rules/`, `.claude/skills/`, `.claude/agents/`, hooks Claude ;
- commun : conventions métier et commandes de build/test qui peuvent vivre dans une documentation partagée.

---

## MCP

Le support MCP est indiqué comme disponible dans les versions JetBrains récentes de Copilot.

Avant d'ajouter un serveur :

- vérifiez l'éditeur ;
- minimisez les permissions ;
- gardez les secrets hors Git ;
- vérifiez les outils exposés ;
- testez sur un dépôt non critique ;
- conservez une procédure de désactivation rapide.

---

## Diagnostic

En cas de dysfonctionnement :

1. vérifiez la compatibilité IDE/plugin ;
2. vérifiez le compte connecté ;
3. mettez le plugin à jour ;
4. vérifiez **Settings → Tools → GitHub Copilot** ;
5. ouvrez le dossier de logs via **Help → Show Log in Explorer/Finder/Files Manager** ;
6. recherchez les entrées Copilot dans `idea.log` ;
7. contrôlez les politiques d'organisation et GitHub Status.

---

## Sources

- [GitHub Docs — Installing the GitHub Copilot extension](https://docs.github.com/en/copilot/how-tos/set-up/install-copilot-extension) — consulté le 2026-09-28
- [GitHub Docs — Configuring GitHub Copilot in your environment](https://docs.github.com/en/copilot/how-tos/configure-personal-settings/configure-in-ide) — consulté le 2026-09-28
- [GitHub Docs — Copilot feature matrix](https://docs.github.com/en/copilot/reference/copilot-feature-matrix) — consulté le 2026-09-28

## Parcours principal

Pour Claude Code : **[Installation Claude Code](../../chapitre-3b-claude-code-migration-copilot/installation.md)**.