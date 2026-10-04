# GitHub Copilot — Paramétrage IntelliJ vs VS Code (référence)

<span class="badge-intellij">IntelliJ</span> <span class="badge-vscode">VS Code</span>

Cette page conserve une comparaison des surfaces **GitHub Copilot**. Pour la configuration principale de ce dépôt, utilisez désormais [Architecture et paramétrage Claude Code](../chapitre-3b-claude-code-migration-copilot/architecture-claude.md).

---

## Matrice actuelle des personnalisations

La documentation GitHub distingue clairement les capacités selon la surface. Au 28 septembre 2026 :

| Fonction Copilot | VS Code | JetBrains |
|---|:---:|:---:|
| Custom instructions | ✓ | Preview |
| Prompt files | ✓ | Preview |
| Custom agents | ✓ | Preview |
| Subagents | ✓ | Preview |
| Agent skills | ✓ | Preview |
| Hooks | Preview | ✗ |
| MCP servers | ✓ | ✓ |

**Légende :** ✓ supporté · Preview fonctionnalité en préversion · ✗ non pris en charge dans la matrice officielle actuelle.

!!! warning "Cette matrice est volatile"
    Vérifiez toujours la [Copilot customization cheat sheet](https://docs.github.com/en/copilot/reference/customization-cheat-sheet) avant d'écrire une procédure ou une politique multi-IDE.

---

## Instructions et skills

### Instructions

Les instructions de dépôt restent pertinentes pour Copilot, mais leur support détaillé varie selon la surface. Les fichiers `.github/` historiques du dépôt sont donc conservés.

### Skills

GitHub Copilot accepte aujourd'hui des skills projet dans plusieurs emplacements :

```text
.github/skills/<skill>/SKILL.md
.claude/skills/<skill>/SKILL.md
.agents/skills/<skill>/SKILL.md
```

Cette compatibilité ouvre une stratégie intéressante pendant la migration : un skill réellement générique peut vivre sous `.claude/skills/` et être utilisé par Claude Code tout en restant exploitable par certaines surfaces Copilot.

!!! note "Ne présumez pas d'une compatibilité universelle"
    Toutes les surfaces Copilot n'exposent pas les skills au même niveau. La documentation GitHub actuelle les prend notamment en charge dans le cloud agent, code review, Copilot CLI, l'app Copilot et agent mode dans VS Code.

---

## Agents et subagents

Les custom agents Copilot sont pleinement documentés sur plusieurs surfaces, mais restent en **public preview dans JetBrains**. Les fichiers d'agents de ce dépôt restent donc conservés sous `.github/agents/` comme référence Copilot.

Pour le parcours Claude-first, les agents spécialisés sont documentés sous `.claude/agents/*.md` dans [Architecture et paramétrage Claude Code](../chapitre-3b-claude-code-migration-copilot/architecture-claude.md).

---

## Hooks

Les hooks Copilot ne sont pas un mécanisme homogène dans tous les IDE.

GitHub documente les hooks pour :

- Copilot CLI ;
- Copilot cloud agent ;
- certaines autres surfaces signalées en preview dans la matrice de personnalisation.

Les hooks de dépôt Copilot sont stockés sous `.github/hooks/*.json` pour les surfaces concernées. Ils sont **conservés** dans ce dépôt, mais ils ne doivent pas être présentés comme une fonction JetBrains équivalente aux hooks Claude Code.

---

## MCP

MCP est supporté dans VS Code et JetBrains côté Copilot. Le protocole est aussi central dans Claude Code.

Lorsqu'un serveur MCP n'est pas lié à une fonctionnalité propre à Copilot, documentez d'abord le serveur et ses risques de façon générique, puis ajoutez les différences de configuration par client.

---

## Stratégie du dépôt

| Situation | Emplacement privilégié |
|---|---|
| Configuration Claude Code principale | `CLAUDE.md`, `.claude/`, `.mcp.json` |
| Référence Copilot historique | `.github/copilot-instructions.md`, `.github/instructions/`, `.github/agents/`, `.github/prompts/`, `.github/hooks/` |
| Skill réellement partagé | `.claude/skills/` lorsque la compatibilité des surfaces utilisées est confirmée |
| Procédure spécifique VS Code Copilot | Pages Copilot VS Code |
| Procédure spécifique JetBrains Copilot | Pages Copilot JetBrains |

---

## Prochaine étape

Poursuivez avec **[Modes CLI — Accueil](../chapitre-3-cli-modes/index.md)**, la page suivante dans le menu.

## Sources

Sources officielles consultées le **28 septembre 2026** :

- [GitHub Docs — Copilot customization cheat sheet](https://docs.github.com/en/copilot/reference/customization-cheat-sheet)
- [GitHub Docs — Adding agent skills](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/customize-cloud-agent/add-skills)
- [GitHub Docs — Custom agents configuration](https://docs.github.com/en/copilot/reference/custom-agents-configuration)
- [GitHub Docs — About hooks for GitHub Copilot](https://docs.github.com/en/copilot/concepts/agents/hooks)
- [Claude Code — `.claude` directory](https://code.claude.com/docs/en/claude-directory)
