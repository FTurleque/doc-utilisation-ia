# OpenSpec Custom Schemas — workflows spécialisés

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span>

Le dépôt **`intent-driven-dev/openspec-schemas`** fournit des schémas personnalisés pour **OpenSpec**. Il ne remplace pas OpenSpec : il étend son moteur de workflow avec des variantes adaptées à différents styles de livraison.

!!! info "Vérifié le 1er octobre 2026"
    Pour la majorité des projets, les mainteneurs indiquent que le schéma intégré `spec-driven` d'OpenSpec suffit. Les schémas de ce dépôt deviennent intéressants lorsque le projet a besoin d'ADR durables, d'un workflow behaviour-driven, event-driven ou plus minimaliste.

---

## Schémas disponibles

Le README courant documente notamment :

| Schéma | Flux principal | Cas d'usage |
|---|---|---|
| `spec-driven` | `proposal → specs/design → tasks` | schéma standard OpenSpec |
| `behaviour-driven` | `proposal → (specs, design) → tasks` | exigences centrées sur comportements/scénarios |
| `spec-driven-with-adr` | `proposal → specs/design → adr → tasks` | workflow standard + décisions d'architecture durables |
| `intent-driven` | `proposal → (specs, design) → adr → tasks` | comportements + design + ADR |
| `event-driven` | `event-storming → event-modeling → specs → design → asyncapi → tasks` | systèmes event-driven / AsyncAPI |
| `minimalist` | `specs → tasks` | changements petits, bornés et à faible risque |

---

## Quand préférer le schéma standard

Commencez par **OpenSpec `spec-driven`** si :

- le projet n'a pas encore de discipline SDD ;
- le changement est classique ;
- l'équipe veut minimiser les conventions ;
- ADR, Gherkin ou AsyncAPI ne sont pas des besoins explicites.

Ajouter un schéma plus riche sans besoin concret augmente le nombre d'artefacts à maintenir.

---

## Intent-driven

`intent-driven` enrichit le workflow avec :

- specs orientées comportements ;
- design ;
- revue et persistance d'ADR ;
- tasks dérivées du changement.

C'est pertinent lorsque le **pourquoi**, les comportements attendus et les décisions techniques doivent rester durablement consultables.

---

## Event-driven

Pour une architecture événementielle, le schéma `event-driven` structure le travail autour de :

```text
event-storming
    ↓
event-modeling
    ↓
specs
    ↓
design
    ↓
AsyncAPI
    ↓
tasks
```

Dans cette documentation, il peut être combiné conceptuellement avec la page **Solace** pour la plateforme événementielle, mais les deux outils ne jouent pas le même rôle :

- le schéma OpenSpec structure la **spécification du changement** ;
- Solace fournit une **infrastructure event broker / event mesh**.

---

## Installer un schema

Le dépôt maintient un guide `AGENT_INSTALL.md` destiné à être lu par un coding agent. Les schémas sont copiés sous :

```text
openspec/schemas/<schema-name>/
```

OpenSpec fournit également des commandes de création/personnalisation :

```bash
openspec schema init <schema-name>
openspec schema fork <source> <new-schema-name>
openspec schema validate <schema-name>
openspec schema which <schema-name>
```

Utilisez la commande de validation avant de versionner un schéma modifié.

---

## Companion skills

Les schémas du dépôt peuvent déclarer des skills complémentaires via `skills.txt`. Le guide d'installation peut installer ces skills sous `.agents/skills/`.

Cela signifie qu'un schéma peut apporter deux dimensions :

1. la structure des artefacts OpenSpec ;
2. des procédures agentiques adaptées au workflow.

Vérifiez toujours le contenu des skills avant installation, notamment leurs permissions, commandes et dépendances.

Le répertoire `.agents/skills/` utilisé par ce guide n'est pas le répertoire natif des skills Claude Code. Pour les utiliser avec Claude, installez les skills relus sous `.claude/skills/<nom>/SKILL.md`, ou via un plugin compatible, puis vérifiez leur présence avec `/skills`. Ne supposez pas qu'un fichier placé sous `.agents/skills/` sera automatiquement découvert.

---

## Acceptation exécutable

Le dépôt précise que les scénarios behaviour-driven ne deviennent pas automatiquement des tests exécutables. L'exécution passe par un skill optionnel distinct (`spec-as-source`) et sa chaîne de tooling.

Ne présentez donc pas un fichier de spec comme « testé » simplement parce qu'il contient des scénarios GIVEN/WHEN/THEN.

---

## Choisir un schéma

```text
Besoin standard ?
  → spec-driven

Comportements métier centraux ?
  → behaviour-driven

Besoin d'ADR durables ?
  → intent-driven

Système événementiel / AsyncAPI ?
  → event-driven

Petit changement très borné ?
  → minimalist
```

La décision doit rester proportionnée au risque et à la longévité du changement.

---

## Sources

- [Guide d'installation des schémas — prérequis et companion skills](https://github.com/intent-driven-dev/openspec-schemas/blob/main/AGENT_INSTALL.md) — vérifié le 2026-10-03
- [Claude Code — emplacements des skills](https://code.claude.com/docs/en/skills) — vérifié le 2026-10-03

Sources consultées le **1er octobre 2026** :

- [OpenSpec Custom Schemas — dépôt officiel](https://github.com/intent-driven-dev/openspec-schemas)
- [OpenSpec Custom Schemas — guide de contribution](https://github.com/intent-driven-dev/openspec-schemas/blob/main/CONTRIBUTING.md)
- [OpenSpec — projet amont](https://github.com/Fission-AI/OpenSpec)

## Prochaine étape

Poursuivez avec **[Jupyter](jupyter.md)**, la page suivante dans le menu.
