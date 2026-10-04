# Templates de configuration Claude Code

Collection de templates pour les instructions, rules, skills, agents et connexions **Claude Code**. Adaptez toujours les commandes, versions et conventions au dépôt réel.

---

## `CLAUDE.md` minimal { #template-claudemd }

```markdown
# Projet

## Structure
- `src/`: code applicatif
- `tests/`: tests

## Commandes
- Tests: `...`
- Lint: `...`
- Build: `...`

## Règles
- Préserver les API publiques sauf demande explicite.
- Exécuter les validations pertinentes avant de terminer.
- Ne pas ajouter de dépendance sans expliquer pourquoi.
- Ne jamais écrire de secret dans le dépôt.
```

Gardez ce fichier court. Déplacez les procédures longues vers rules/skills.

---

## Rule ciblée `.claude/rules/tests.md` { #template-rule }

```markdown
---
paths:
  - "tests/**"
  - "src/**/*.test.*"
  - "src/**/*.spec.*"
---

# Tests

- Réutiliser le framework et les conventions existantes.
- Couvrir d'abord le comportement modifié.
- Éviter les assertions qui ne testent pas réellement le résultat.
- Exécuter le test ciblé avant une suite plus large.
```

---

## Skill `.claude/skills/review-change/SKILL.md` { #template-skill }

```markdown
---
name: review-change
description: Revoit un changement local et vérifie les validations du dépôt avant de conclure.
---

1. Lire le diff.
2. Identifier les fichiers et comportements modifiés.
3. Rechercher bugs, régressions, sécurité et dépendances inattendues.
4. Exécuter les tests/lint/build pertinents.
5. Retourner les constats avec fichiers/lignes et résultats des commandes.
```

Une skill peut contenir `references/`, `scripts/` et `assets/` si nécessaire.

---

## Subagent `.claude/agents/security-review.md` { #template-agent }

```markdown
---
name: security-review
description: Recherche des risques de sécurité dans un changement sans modifier le code.
tools: Read, Grep, Glob
---

Analyse uniquement le périmètre demandé.
Recherche notamment : secrets, validation d'entrée, autorisation, injections,
dépendances et changements de configuration sensibles.
Retourne constat, preuve et fichier/ligne. Ne modifie rien.
```

Les outils réellement acceptés dépendent de la version Claude Code ; vérifiez la documentation avant de standardiser un front matter avancé.

---

## `.mcp.json` — squelette projet { #template-mcp }

```json
{
  "mcpServers": {
    "example": {
      "command": "example-mcp",
      "args": []
    }
  }
}
```

!!! warning "Secrets"
    Ne placez pas de token réel dans un fichier MCP versionné. Utilisez les mécanismes de secrets/variables supportés par le serveur et votre environnement.

Avant de partager un MCP dans le dépôt : documentez son owner, ses outils, ses permissions et ses destinations réseau.

---

## Hook : principe de sécurité { #template-hook }

N'ajoutez pas un hook seulement parce qu'il est possible de le faire. Un hook exécute du code autour du workflow agentique.

Checklist :

```text
[ ] script versionné
[ ] comportement documenté
[ ] aucun secret en dur
[ ] timeout raisonnable
[ ] sortie bornée
[ ] échec testé
[ ] revue sécurité si action sensible
```

Consultez le [guide Hooks](../chapitre-4-contexte/guide-hooks.md) pour le schéma courant.

---

## `AGENTS.md` portable { #template-agentsmd }

```markdown
# Instructions agents

## Repository
- Lire les conventions existantes avant modification.
- Ne pas changer l'architecture sans justification.

## Validation
- Tests: `...`
- Lint: `...`
- Build: `...`

## Sécurité
- Aucun secret dans les prompts ou commits.
- Toute nouvelle dépendance doit être justifiée.
```

Utilisez `AGENTS.md` pour les règles réellement portables. Gardez les capacités propres à Claude dans `.claude/`.

---

## Projet Machine Learning { #template-ml }

```markdown
# CLAUDE.md

## Commands
- Tests: `pytest -q`
- Lint: `ruff check .`
- Train baseline: `python -m src.train`
- Evaluate: `python -m src.evaluate`

## ML invariants
- Ne jamais ajuster le preprocessing sur le test final.
- Toute métrique doit préciser dataset/split.
- Conserver seed, config et artefacts nécessaires à la reproduction.
```

---

## Éviter les versions figées dans un template générique

N'écrivez pas par défaut :

```text
React 18
Spring Boot 3.2
Python 3.11
scikit-learn 1.4
```

sauf si ce sont réellement les versions du projet. Claude doit lire `package.json`, `pom.xml`, `pyproject.toml`, lockfiles et autres manifests avant de proposer une API dépendante d'une version.

---

## Checklist avant de copier un template

- [ ] commandes adaptées au dépôt ;
- [ ] versions lues depuis les manifests ;
- [ ] règles non contradictoires avec les docs existantes ;
- [ ] secrets absents ;
- [ ] outils tiers audités ;
- [ ] validation exécutable définie ;

## Voir aussi

- [Architecture Claude](../chapitre-3b-claude-code-migration-copilot/architecture-claude.md)
- [Instructions & Rules](../chapitre-4-contexte/guide-instructions.md)
- [Skills](../chapitre-4-contexte/guide-skills.md)
- [Agents](../chapitre-4-contexte/guide-agents.md)
- [MCP](../chapitre-13-outils-economies/mcps/index.md)

---

## Prochaine étape

Poursuivez avec **[Sandbox — Isolation des commandes](sandbox.md)**, la page suivante dans le menu.
