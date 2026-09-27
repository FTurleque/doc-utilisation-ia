# Hooks — Claude Code et référence Copilot

<span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span> <span class="badge-expert">Expert</span>

Les hooks Claude Code permettent d'exécuter automatiquement une commande, un appel HTTP, un outil MCP ou d'autres contrôles à différents événements du cycle de vie de l'agent.

Ils servent surtout à **automatiser** et à **faire respecter des garde-fous** : bloquer une commande dangereuse, lancer un contrôle après une édition, journaliser une action ou injecter un contexte ciblé.

---

## Hooks ≠ instructions

| Besoin | Bon mécanisme |
|---|---|
| « respecte cette convention de code » | `CLAUDE.md` ou `.claude/rules/` |
| « applique cette procédure quand elle est pertinente » | skill |
| « refuse techniquement cette action avant exécution » | permissions ou `PreToolUse` hook |
| « lance ce contrôle après une édition » | `PostToolUse` hook |
| « exécute un pre-commit Git » | hook Git, pas hook Claude |

Une phrase dans `CLAUDE.md` influence le modèle. Un hook `PreToolUse` peut, lui, intervenir dans le flux d'exécution.

---

## Où configurer les hooks Claude ?

Les hooks projet se déclarent normalement dans :

```text
.claude/settings.json
```

Les scripts peuvent vivre par exemple dans :

```text
.claude/hooks/
├─ block-dangerous-command.py
└─ check-style.sh
```

Exemple actuel de structure :

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash|PowerShell",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PROJECT_DIR}/.claude/hooks/check-command.py",
            "args": []
          }
        ]
      }
    ]
  }
}
```

!!! important "Structure imbriquée"
    Les versions actuelles utilisent une liste de matchers contenant elle-même une liste `hooks`. Plusieurs anciens exemples utilisent une structure plus plate : ne les copiez pas sans vérifier la référence actuelle.

---

## Événements importants

Claude Code possède aujourd'hui de nombreux événements. Les plus utiles pour démarrer sont :

| Événement | Moment | Exemple d'usage |
|---|---|---|
| `SessionStart` | début / reprise de session selon le contexte | charger une information externe |
| `UserPromptSubmit` | avant traitement d'un prompt utilisateur | audit ou contexte contrôlé |
| `PreToolUse` | avant exécution d'un outil | autoriser, demander ou bloquer |
| `PostToolUse` | après réussite d'un outil | lint, audit, journalisation |
| `PostToolUseFailure` | après échec d'un outil | diagnostic ciblé |
| `SubagentStart` / `SubagentStop` | cycle d'un subagent | suivi et agrégation |
| `PreCompact` / `PostCompact` | autour de la compaction | préserver / inspecter l'état |
| `Stop` | avant que Claude ne termine | imposer une vérification supplémentaire |
| `FileChanged` | fichier changé sur disque | contrôle après changement, quelle qu'en soit l'origine |

La liste évolue et comprend d'autres événements (modèle, worktree, configuration, permissions, etc.). Utilisez la référence officielle pour les cas avancés.

---

## `PreToolUse` — garde-fou avant action

`PreToolUse` s'exécute après que Claude a préparé les paramètres d'un outil, mais avant son exécution.

Exemple : cibler les commandes shell :

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash|PowerShell",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PROJECT_DIR}/.claude/hooks/validate-command.py"
          }
        ]
      }
    ]
  }
}
```

Le script reçoit un JSON sur `stdin`, notamment `tool_name` et `tool_input` pour cet événement.

### Bloquer avec un code de sortie

Pour la plupart des événements qui peuvent bloquer, **`exit 2`** signale le refus.

```bash
#!/usr/bin/env bash
input=$(cat)
command=$(jq -r '.tool_input.command // ""' <<<"$input")

if [[ "$command" == rm* ]]; then
  echo "Commande rm bloquée par la politique du projet" >&2
  exit 2
fi

exit 0
```

!!! danger "`exit 1` n'est pas un blocage fiable"
    Pour la plupart des hooks Claude Code, un code différent de `2` est traité comme une erreur non bloquante si aucune décision JSON valide ne dit le contraire. Si votre garde-fou repose sur un script shell, utilisez le contrat documenté de l'événement, pas la convention Unix « 1 = échec ».

---

## Permissions avant hooks

Pour une interdiction simple et statique, une règle de permission est souvent préférable :

```json
{
  "permissions": {
    "deny": [
      "Read(./.env)",
      "Bash(git push --force *)"
    ]
  }
}
```

Utilisez un hook lorsque la décision nécessite une logique dynamique : contenu de la commande, fichier ciblé, validation externe, politique métier, etc.

!!! note "Références `@fichier`"
    `PreToolUse` ne s'exécute pas lorsqu'un fichier est ajouté directement au contexte via une référence `@...`, car aucun outil `Read` n'est nécessaire. Pour interdire certains chemins même dans ce cas, utilisez une règle de permission `Read(...)`.

---

## `PostToolUse` — contrôle après modification

Exemple : lancer un script de style après Write/Edit :

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PROJECT_DIR}/.claude/hooks/check-style.sh",
            "args": []
          }
        ]
      }
    ]
  }
}
```

`PostToolUse` arrive **après** l'action. Il est adapté à la vérification et au feedback, pas à l'empêchement de l'écriture déjà effectuée.

Pour un contrôle asynchrone :

```json
{
  "type": "command",
  "command": "${CLAUDE_PROJECT_DIR}/.claude/hooks/run-tests.sh",
  "async": true
}
```

Claude peut alors continuer pendant l'exécution ; le résultat est livré ultérieurement dans la conversation.

---

## Hooks Windows / PowerShell

Claude Code sait exécuter des hooks via PowerShell. Exemple :

```json
{
  "type": "command",
  "shell": "powershell",
  "command": "& \"$env:CLAUDE_PROJECT_DIR\\.claude\\hooks\\check.ps1\""
}
```

Pour une configuration multi-OS, privilégiez des scripts portables ou séparez proprement les implémentations plutôt que d'imbriquer de longues commandes spécifiques à un shell dans `settings.json`.

---

## Sécurité des hooks

Un hook de type `command` est **du code exécuté sur votre machine**.

Avant de versionner ou accepter un hook :

1. relisez le script ;
2. vérifiez ses chemins et variables ;
3. limitez ses permissions OS ;
4. évitez de logguer des secrets ;
5. testez le comportement de blocage ;
6. vérifiez qu'un timeout ou un script absent ne désactive pas silencieusement votre garde-fou.

!!! warning "Timeout PreToolUse"
    Un hook `command`, HTTP ou MCP qui atteint son timeout sur `PreToolUse` ne doit pas être considéré comme un mécanisme *fail-closed* universel : le tool call peut continuer dans le flux normal de permissions. Pour une politique critique, combinez permissions explicites et contrôles robustes.

---

## Hooks Git : mécanisme différent

Un fichier `.git/hooks/pre-commit` ou un outil comme pre-commit / Husky agit au niveau de Git et fonctionne indépendamment de Claude.

Exemple simple :

```bash
#!/usr/bin/env sh

if git diff --cached --name-only | grep -E '(^|/)\.env($|\.)' >/dev/null 2>&1; then
  echo "Fichier .env détecté dans le staging" >&2
  exit 1
fi

exit 0
```

Un **hook Git** doit continuer à être présenté comme un hook Git, même si Claude vous aide à l'écrire.

---

## GitHub Copilot — hooks conservés

Le dépôt conserve :

```text
.github/hooks/
```

pour les configurations Copilot existantes.

Les hooks Copilot et Claude ont des formats, événements et surfaces différents. GitHub documente actuellement les hooks Copilot notamment pour Copilot CLI et le cloud agent, avec d'autres surfaces signalées en preview ou non supportées selon la matrice produit.

Ne copiez donc pas un JSON `.github/hooks/*.json` dans `.claude/settings.json` en supposant une compatibilité directe.

---

## Migration Copilot → Claude

Pour chaque hook existant :

1. identifiez l'**intention** : blocage, validation, notification, formatage ;
2. vérifiez si une permission Claude suffit ;
3. sinon choisissez l'événement Claude équivalent ;
4. adaptez le format de l'entrée JSON et la décision de sortie ;
5. testez un cas autorisé **et** un cas bloqué ;
6. conservez le hook Copilot d'origine s'il sert encore aux utilisateurs Copilot.

---

## Prochaine étape

Voir **[Paramètres du dépôt](parametres-depot.md)** puis **[Hooks avancés Claude](../chapitre-3b-claude-code-migration-copilot/hooks-avances.md)**.

---

## Sources

Sources officielles consultées le **28 septembre 2026** :

- [Claude Code — Hooks reference](https://code.claude.com/docs/en/hooks)
- [Claude Code — Settings](https://code.claude.com/docs/en/settings)
- [GitHub Docs — About hooks for GitHub Copilot](https://docs.github.com/en/copilot/concepts/agents/hooks)
- [GitHub Docs — Copilot customization cheat sheet](https://docs.github.com/en/copilot/reference/customization-cheat-sheet)
