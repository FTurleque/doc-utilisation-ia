# Quand utiliser quel mode avec Claude Code ?

<span class="badge-intermediate">Intermédiaire</span>

Avec Claude Code, le bon choix n'est pas « quel bouton coûte le moins cher ? », mais **quel niveau d'autonomie et de contexte est nécessaire pour réussir la tâche sans rework**.

---

## Vue d'ensemble

| Approche | Autonomie | Contexte typique | À utiliser pour |
|---|---:|---|---|
| **Interaction directe** | Faible | question ciblée, fichier ou erreur précise | comprendre, expliquer, petite correction |
| **Plan** | Lecture / cadrage | plusieurs fichiers, contraintes, architecture | préparer un changement complexe avant écriture |
| **Agent principal** | Élevée | dépôt + outils | implémentation, debug multi-fichiers, migration |
| **Subagent** | Spécialisée | contexte isolé | exploration lourde, audit, recherche parallèle |
| **Skill / routine** | Réutilisable | procédure versionnée | workflow répétitif et stable |

---

## Interaction directe

Utilisez une interaction simple quand la tâche est locale et bien définie.

```text
Lis @src/auth/token.ts et le test associé.
Explique pourquoi le test `expired token` échoue.
Ne modifie rien.
```

C'est souvent préférable à une orchestration complète pour :

- une erreur de compilation ;
- une question d'API ;
- un petit refactoring ;
- un test manquant ;
- une explication de code.

---

## Plan

Le mode Plan est utile quand **le coût d'une mauvaise direction est supérieur au coût du cadrage**.

Utilisez-le avant :

- migration de dépendance ;
- refactoring multi-module ;
- changement de schéma ;
- nouvelle fonctionnalité transverse ;
- modification impliquant sécurité ou compatibilité.

Un bon plan doit identifier :

1. fichiers concernés ;
2. contraintes et invariants ;
3. ordre des modifications ;
4. risques ;
5. tests et critères de sortie.

!!! tip "Plan court"
    Ne demandez pas une dissertation. Le plan sert à réduire l'ambiguïté, pas à consommer le contexte avant l'implémentation.

---

## Agent principal

L'agent principal est adapté lorsque Claude doit combiner plusieurs actions :

```text
Explore → modifier → exécuter → observer → corriger → vérifier
```

Exemples :

- implémenter une feature sur plusieurs fichiers ;
- reproduire puis corriger un bug ;
- ajouter des tests et faire passer la suite ;
- adapter une configuration CI ;
- migrer une API avec vérification du build.

Le coût est justifié si l'agent dispose d'une **boucle de validation réelle**.

---

## Subagents

Un subagent est utile quand une sous-tâche génère beaucoup de contexte mais que le résultat final peut être résumé.

Bon cas :

- cartographier un gros module ;
- auditer les appels à une API dépréciée ;
- analyser séparément sécurité, tests et performance ;
- rechercher plusieurs hypothèses en parallèle.

Mauvais cas :

- lire deux fichiers ;
- corriger une typo ;
- créer une couche d'orchestration uniquement « parce que c'est agentique ».

L'objectif est d'**isoler le bruit**, pas de multiplier les agents.

---

## Skills et procédures récurrentes

Si vous répétez le même protocole, transformez-le en skill plutôt que de recopier un long prompt.

Exemples :

- revue de PR ;
- audit sécurité ;
- génération et validation de migration ;
- évaluation ML ;
- mise à jour documentaire.

Un skill est rentable quand il réduit les oublis et standardise les contrôles.

---

## Choisir avec quatre questions

```text
1. La tâche est-elle locale et claire ?
   → interaction directe

2. Une mauvaise direction toucherait-elle plusieurs fichiers ?
   → Plan

3. Faut-il modifier puis exécuter des validations ?
   → agent principal

4. Une sous-tâche volumineuse peut-elle être isolée et résumée ?
   → subagent
```

---

## Modèle et coût

Ne choisissez pas un modèle uniquement par habitude. La meilleure stratégie est :

- modèle plus léger pour tâches simples et déterministes ;
- modèle plus capable lorsque le raisonnement ou la coordination le justifie ;
- mesure sur vos tâches réelles plutôt qu'un classement générique.

Les modèles, disponibilités et politiques de routage évoluent ; consultez la documentation et les réglages du compte au moment du choix.

---

## Auto mode et permissions

Avec **Claude Code v2.1.283 ou ultérieur**, auto mode est le mode de départ intégré des sessions interactives terminal et VS Code sur tous les plans et fournisseurs, sous réserve de disponibilité et des réglages qui le remplacent. Les versions antérieures ont un périmètre différent : vérifiez `claude --version` et le mode affiché. Un modèle local derrière une API compatible n'est pas automatiquement pris en charge par le classificateur.

Auto mode fait analyser les actions par un classificateur distinct ; il ne constitue pas une sandbox. Les règles `ask` explicites peuvent encore provoquer une demande. L'organisation peut désactiver ce mode. Le réglage `permissions.defaultMode: "auto"` ne prend pas effet depuis les fichiers projet `.claude/settings.json` ou `.claude/settings.local.json` : utilisez la portée utilisateur/administrée appropriée ou `claude --permission-mode auto`.

[Modes et conditions officiels](https://code.claude.com/docs/en/permission-modes#eliminate-prompts-with-auto-mode), revérifiés le **3 octobre 2026**. Pour l'isolation des commandes, voir [Sandbox](../chapitre-4-contexte/sandbox.md).

---

## Sources

- [Claude Code — Best practices](https://code.claude.com/docs/en/best-practices) — consulté le 2026-09-28
- [Claude Code — Subagents](https://code.claude.com/docs/en/sub-agents) — consulté le 2026-09-28
- [Claude — Auto mode default in Claude Code](https://claude.com/blog/auto-mode-default-in-claude-code) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-12-couts-gouvernance.md#page-chapitre-12-couts-gouvernance-modes-quand-utiliser).

## Prochaine étape

Poursuivez avec **[Workflow recommandé](workflow-recommande.md)**, la page suivante dans le menu.
