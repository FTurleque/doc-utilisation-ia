# OpenSpec — spec-driven development avec les agents

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span>

**OpenSpec** est un framework de **spec-driven development (SDD)** conçu pour les assistants de code. Son objectif est de faire converger humain et agent sur le **quoi** et le **pourquoi** avant l'implémentation, puis de matérialiser ce plan dans des artefacts versionnés.

Sa place principale dans cette documentation est **Bonnes Pratiques** : OpenSpec structure le workflow de développement, mais n'est ni un modèle, ni un moteur de recherche, ni un outil de contexte au sens strict.

!!! info "Vérifié le 1er octobre 2026"
    Le workflow courant d'OpenSpec est guidé par des artefacts. Le schéma par défaut `spec-driven` produit notamment `proposal`, `specs`, `design` et `tasks`, puis le changement peut être appliqué et archivé.

---

## Pourquoi l'utiliser avec Claude Code

Un agent peut produire rapidement du code incorrectement cadré si les exigences ne sont pas stabilisées. OpenSpec ajoute une couche explicite :

```text
Idée / besoin
    ↓
Exploration
    ↓
Proposal
    ↓
Specs + Design
    ↓
Tasks
    ↓
Implémentation
    ↓
Vérification
    ↓
Archive / mise à jour des specs
```

L'intérêt principal est la **traçabilité du changement** : les décisions et exigences restent dans Git plutôt que seulement dans l'historique de chat.

---

## Installation actuelle

OpenSpec nécessite actuellement Node.js **20.19.0 ou plus récent** selon le README officiel.

Installation npm :

```bash
npm install -g @fission-ai/openspec@latest
```

Initialisation dans un projet :

```bash
cd mon-projet
openspec init
```

OpenSpec configure les intégrations correspondant aux outils sélectionnés et génère les commandes adaptées au client.

---

## Workflow principal

Le workflow actuel met en avant :

```text
/opsx:explore
/opsx:propose
/opsx:apply
/opsx:archive
```

Le nom exact de l'invocation peut varier selon l'agent.

Le profil par défaut propose ce parcours compact. Pour les commandes étendues (`/opsx:new`, `/opsx:continue`, `/opsx:ff`, `/opsx:verify`, etc.), sélectionnez le profil adapté avec `openspec config profile`, puis régénérez les intégrations avec `openspec update`. L'absence d'une commande étendue peut donc venir du profil choisi plutôt que d'une installation cassée.

!!! note "CLI et commandes agent sont deux choses différentes"
    Certaines commandes s'exécutent dans le terminal (`openspec ...`), d'autres sont des commandes adressées à l'agent. Consultez la page officielle *How Commands Work* si un workflow ne réagit pas comme prévu.

---

## Artefacts du schéma `spec-driven`

Le schéma par défaut organise typiquement un changement ainsi :

```text
openspec/changes/<change>/
├── proposal.md
├── specs/
│   └── <capability>/spec.md
├── design.md
└── tasks.md
```

Le flux documenté est :

```text
proposal
   ├── specs
   └── design
        ↓
      tasks
        ↓
      apply
```

Le `design` peut être omis dans certains cas selon les conditions du workflow.

---

## OpenSpec et Claude Code

Dans un dépôt Claude-first :

- `CLAUDE.md` contient les conventions générales ;
- les rules/skills définissent les pratiques spécialisées ;
- OpenSpec porte les **artefacts du changement en cours** ;
- Claude Code peut explorer, rédiger, appliquer et vérifier en suivant ces artefacts.

Il ne faut pas recopier toutes les spécifications dans `CLAUDE.md`. Les deux mécanismes répondent à des besoins différents.

---

## OpenSpec vs simple plan de chat

| Plan dans le chat | OpenSpec |
|---|---|
| utile pour une tâche ponctuelle | utile pour une exigence qui doit survivre à la session |
| peu de structure imposée | artefacts versionnés et workflow explicite |
| historique parfois difficile à relire | changement consultable dans Git |
| faible coût de mise en place | plus de discipline et de fichiers |

Pour une correction triviale, OpenSpec peut être excessif. Pour une fonctionnalité multi-fichiers, un changement métier ou une décision d'architecture, la formalisation peut réduire le rework.

---

## Stores et travail multi-repo

OpenSpec documente également des **Stores** en bêta : les plans et specs peuvent vivre dans un dépôt dédié et être partagés entre plusieurs codebases.

Cette approche est intéressante lorsque :

- une fonctionnalité traverse plusieurs repos ;
- une équipe plateforme possède les exigences ;
- plusieurs agents doivent lire la même source de vérité ;
- le planning commence avant la création ou la modification des repos applicatifs.

Comme la fonctionnalité est en bêta, vérifiez la documentation officielle avant de l'adopter comme standard d'entreprise.

---

## Schémas personnalisés

Le workflow OpenSpec peut être personnalisé avec des schemas. Pour des variantes plus spécialisées — ADR, behaviour-driven, event-driven, minimalist — consultez la page **[OpenSpec Custom Schemas](openspec-schemas.md)**.

---

## Gouvernance et bonnes pratiques

1. utilisez OpenSpec pour les changements qui justifient réellement une spec ;
2. gardez les exigences testables et les scénarios concrets ;
3. relisez `proposal`, `specs`, `design` et `tasks` avant `apply` ;
4. exécutez les tests réels : un artifact validé n'est pas une preuve d'implémentation correcte ;
5. archivez les changements terminés pour maintenir la source de vérité ;
6. versionnez les changements OpenSpec dans la même PR que le code concerné lorsque cela correspond à votre gouvernance.

---

## Sources

- [OpenSpec — installation et profils de commandes actuels](https://github.com/Fission-AI/OpenSpec#quick-start) — vérifié le 2026-10-03

Sources consultées le **1er octobre 2026** :

- [OpenSpec — dépôt officiel](https://github.com/Fission-AI/OpenSpec)
- [OpenSpec — documentation](https://github.com/Fission-AI/OpenSpec/blob/main/docs/README.md)
- [OpenSpec — schéma `spec-driven`](https://github.com/Fission-AI/OpenSpec/tree/main/docs-lab/reference/schemas/spec-driven)

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-9-bonnes-pratiques.md#page-chapitre-9-bonnes-pratiques-openspec).

## Prochaine étape

Poursuivez avec **[OpenSpec Custom Schemas](openspec-schemas.md)**, la page suivante dans le menu.
