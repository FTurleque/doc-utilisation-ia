# Cookbook — recettes prêtes à l'emploi

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span> <span class="badge-cli">CLI</span>

Cette page rassemble des **commands, skills, agents et hooks prêts à copier** dans votre `.claude/`. Chaque recette est autonome : adaptez le front-matter (outils, modèle) et le corps à votre projet. Pour comprendre la structure, voir [Architecture `.claude/`](architecture-claude.md).

!!! tip "Mode d'emploi"
    1. Créez le fichier au chemin indiqué.
    2. Adaptez `description`, `allowed-tools`/`tools` et les chemins.
    3. Invoquez (`/<commande>`) ou laissez Claude auto-invoquer (skills/agents).

---

## Recettes Git & revue

### Command — Message de commit conventionnel

`.claude/commands/commit.md`

```markdown
---
description: "Rédige un message de commit Conventional Commits à partir des changements indexés"
allowed-tools: [bash]
---

## Changements indexés
!`git diff --cached`

## Tâche
Rédige UN message de commit au format Conventional Commits :
- type(scope): résumé impératif < 72 caractères
- corps optionnel expliquant le pourquoi
- footer `BREAKING CHANGE:` si rupture d'API

Retourne uniquement le message, prêt à coller.
```

### Command — Revue de PR

`.claude/commands/review-pr.md`

```markdown
---
description: "Revue du diff de la branche courante, risques priorisés"
allowed-tools: [bash, read, grep]
---

## Diff
!`git diff origin/main...HEAD`

## Tâche (raisonne étape par étape)
1. Liste les risques : sécurité, perf, régressions, lisibilité.
2. Classe-les High / Medium / Low avec le fichier et la ligne.
3. Propose un correctif concret par point High.
4. Termine par un verdict : APPROVE / REQUEST_CHANGES + 1 phrase.
```

---

## Recettes de test

### Command — Générer des tests dans le style du projet

`.claude/commands/generate-tests.md`

```markdown
---
description: "Génère des tests pour la cible en suivant le style existant"
allowed-tools: [read, grep]
---

## Cible
$ARGUMENTS

## Style de référence
Trouve un test voisin existant et imite-le EXACTEMENT :
- même framework et mêmes annotations
- même convention de nommage (`should_x_when_y`)
- mêmes utilitaires de mock / fixtures

## Sortie
Le fichier de test complet, imports inclus, sans commentaire superflu.
```

=== "Java (JUnit 5)"

    ```markdown
    Framework : JUnit 5 + Mockito + AssertJ.
    Nommage : `should_returnX_when_Y()`.
    Mock : `@Mock` + `@InjectMocks`. Assertions : `assertThat(...)`.
    ```

=== "TypeScript (Vitest)"

    ```markdown
    Framework : Vitest + Testing Library.
    Nommage : `it('returns X when Y', ...)`.
    Mock : `vi.fn()` / `vi.mock()`. Assertions : `expect(...).toBe(...)`.
    ```

=== "Python (pytest)"

    ```markdown
    Framework : pytest.
    Nommage : `test_returns_x_when_y`.
    Fixtures : `@pytest.fixture`. Paramétrage : `@pytest.mark.parametrize`.
    ```

---

## Recettes d'audit & sécurité

### Agent — Auditeur de sécurité OWASP

`.claude/agents/security-auditor.md`

```markdown
---
name: security-auditor
description: "Audite un endpoint/module selon OWASP Top 10 (injection, XSS, SSRF, IDOR, secrets)."
tools: [read, grep, bash]
model: claude-sonnet-4
color: red
---

Tu es un expert sécurité applicative certifié OWASP.
Pour chaque cible :
1. Entrées non validées (path, query, body, headers).
2. AuthN/AuthZ : IDOR/BOLA, contrôle au bon niveau.
3. Injections SQL/NoSQL, SSRF, désérialisation, secrets en dur.
4. Produis un JSON { globalRisk, findings:[{category,severity,remediation}] }.
Ne modifie aucun fichier ; tu produis un rapport.
```

### Command — Scan rapide de secrets

`.claude/commands/scan-secrets.md`

```markdown
---
description: "Recherche des secrets potentiels dans les fichiers suivis"
allowed-tools: [bash, grep]
---

!`git grep -nE "(sk-ant-|AKIA[0-9A-Z]{16}|BEGIN (RSA|EC|OPENSSH) PRIVATE KEY|password\s*=)" -- ':!*.md'`

## Tâche
Pour chaque correspondance : indique le risque, et propose la remédiation
(variable d'environnement, secret manager, rotation de la clé exposée).
```

---

## Recettes de refactoring & migration

### Command — Plan de refactoring sûr

`.claude/commands/plan-refactor.md`

```markdown
---
description: "Plan de refactoring réversible, sans écrire de code"
allowed-tools: [read, grep, bash]
---

## Cible
$ARGUMENTS

## Procédure
1. Trouve tous les appelants de la cible.
2. Liste les tests qui la couvrent (et les trous de couverture).
3. Découpe en étapes réversibles (1 commit = 1 étape).
4. Pour chaque étape : risque, fichiers, test de non-régression.
5. NE PRODUIS PAS de code tant que le plan n'est pas validé.
```

### Skill — Migration SQL vers Flyway

`.claude/skills/migration-flyway/SKILL.md`

```markdown
---
name: migration-flyway
description: "Règles de migration de schéma SQL vers Flyway : nommage des versions, scripts idempotents, rollback."
---

# Migrations Flyway

- Fichiers : `V<timestamp>__description.sql` (versionnés, jamais modifiés après merge).
- Scripts idempotents quand possible (`CREATE TABLE IF NOT EXISTS`).
- Pas de DML destructif sans sauvegarde et fenêtre de maintenance.
- Toujours fournir un script de rollback documenté.
```

---

## Recettes de productivité

### Command — Expliquer un fichier complexe

`.claude/commands/explain.md`

```markdown
---
description: "Explique un fichier : rôle, flux, points d'attention"
allowed-tools: [read]
---

## Cible
@$ARGUMENTS

## Sortie
1. Résumé en 2 phrases du rôle du fichier.
2. Diagramme Mermaid du flux principal.
3. 3 points d'attention (pièges, dette, couplage).
```

### Hook — Lint automatique après édition

`.claude/hooks/post-tool-use.sh` + `.claude/settings.json`

```bash
#!/usr/bin/env bash
# Lance le formateur après chaque écriture, sans bloquer.
if command -v npx >/dev/null 2>&1; then
  npx --no-install prettier --write "$CLAUDE_FILE_PATHS" 2>/dev/null
fi
exit 0
```

```json
{
  "hooks": {
    "PostToolUse": [
      { "matcher": "Edit|Write", "command": ".claude/hooks/post-tool-use.sh" }
    ]
  }
}
```

---

## Tableau récapitulatif des recettes

| Recette | Type | Emplacement |
|---------|------|-------------|
| Message de commit | Command | `commands/commit.md` |
| Revue de PR | Command | `commands/review-pr.md` |
| Génération de tests | Command | `commands/generate-tests.md` |
| Auditeur OWASP | Agent | `agents/security-auditor.md` |
| Scan de secrets | Command | `commands/scan-secrets.md` |
| Plan de refactoring | Command | `commands/plan-refactor.md` |
| Migration Flyway | Skill | `skills/migration-flyway/SKILL.md` |
| Expliquer un fichier | Command | `commands/explain.md` |
| Lint post-édition | Hook | `hooks/post-tool-use.sh` |

!!! success "Construisez votre bibliothèque interne"
    Ces recettes sont des points de départ. Versionnez celles qui marchent dans votre dépôt, puis mutualisez-les entre projets via un [plugin d'équipe](plugins-equipe.md).

---

## Prochaine étape

**[Hooks avancés](hooks-avances.md)** : transformer ces recettes en automatisations garanties — formatage, garde-fous de sécurité et tests déclenchés automatiquement autour des actions de Claude.

Concepts clés couverts :

- **Cycle de vie complet** — `SessionStart`, `PreToolUse`, `PostToolUse`, `Stop`, `PreCompact`
- **Exemples prêts à l'emploi** — formatage multi-langage, blocage de commandes dangereuses, tests impactés
- **Configuration d'équipe** — assembler plusieurs hooks dans `settings.json`
- **Débogage** — tester un hook en isolation et diagnostiquer

---

## Sources

- [Anthropic — Common workflows](https://docs.anthropic.com/en/docs/claude-code/common-workflows) - consulté le 2026-06-20
- [Anthropic — Slash commands & custom commands](https://docs.anthropic.com/en/docs/claude-code/slash-commands) - consulté le 2026-06-20
- [Anthropic — Subagents](https://docs.anthropic.com/en/docs/claude-code/sub-agents) - consulté le 2026-06-20
- [Anthropic — Hooks reference](https://docs.anthropic.com/en/docs/claude-code/hooks) - consulté le 2026-06-20


