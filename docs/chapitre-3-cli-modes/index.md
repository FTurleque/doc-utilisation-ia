# GitHub Copilot — Modes CLI et agentiques (référence)

<span class="badge-intermediate">Intermédiaire</span>

Ce chapitre appartient désormais à la section **GitHub Copilot (référence)**. Il conserve les notes et workflows historiques liés aux modes Copilot afin de faciliter la comparaison, la migration et un éventuel retour vers Copilot.

!!! info "Pour Claude Code"
    Claude Code ne se structure pas autour des mêmes noms de modes. Pour le parcours principal, consultez :

    - [Installation et premier lancement](../chapitre-3b-claude-code-migration-copilot/installation.md)
    - [Prompt Engineering avec Claude Code](../chapitre-3b-claude-code-migration-copilot/prompt-engineering-claude.md)
    - [Architecture et paramétrage](../chapitre-3b-claude-code-migration-copilot/architecture-claude.md)

---

## Équivalences de besoin, pas de nom

| Besoin | Claude Code | Copilot historique / référence |
|---|---|---|
| discuter et explorer | session interactive Claude | Chat |
| explorer sans modifier | **plan mode** / permissions adaptées | modes de revue / chat selon surface |
| modifier plusieurs fichiers | agent Claude avec outils | agent/edit selon surface Copilot |
| automatiser sans interface | `claude -p` | Copilot CLI / agents selon environnement |
| réduire les confirmations | règles de permissions explicites | modes/autorisations Copilot selon surface |
| isoler une recherche | subagent | subagent/custom agent si disponible |

!!! warning "Ne transposez pas `Yolo` vers Claude"
    Les anciennes pages de ce chapitre utilisent parfois le terme **Yolo** pour une exécution très permissive. Dans la documentation Claude-first, décrivez plutôt le **niveau de permissions** réellement configuré. Évitez de recommander la suppression globale des garde-fous comme mode normal de travail.

---

## Pages conservées

| Page | Rôle |
|---|---|
| [Modes CLI — détail](page-principale.md) | référence historique Copilot, commandes et comportements à réauditer |
| [Comparaison des modes](comparaison.md) | comparaison Copilot VS Code / IntelliJ à conserver comme référence |

Ces longues pages ne sont pas supprimées. Elles seront réauditées lors du passage final sur les contenus Copilot spécifiques afin de ne pas écraser le travail existant sur la branche.

---

## Workflow Claude recommandé pour une tâche complexe

La documentation officielle Claude Code recommande plutôt :

1. **Explore** — comprendre le code sans modifier ;
2. **Plan** — proposer une séquence de changements ;
3. **Implement** — appliquer après validation du plan ;
4. **Verify** — exécuter tests/build/lint ou un autre contrôle mesurable.

Pour activer le plan mode au lancement :

```bash
claude --permission-mode plan
```

Pour les tâches simples et locales, passez directement à l'implémentation et à la vérification.

---

## Sources

Sources officielles consultées le **28 septembre 2026** :

- [Claude Code — Best practices](https://code.claude.com/docs/en/best-practices)
- [Claude Code — CLI reference](https://code.claude.com/docs/en/cli-reference)
- [GitHub Docs — GitHub Copilot](https://docs.github.com/en/copilot)
