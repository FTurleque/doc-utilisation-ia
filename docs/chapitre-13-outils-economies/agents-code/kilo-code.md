# Kilo Code — agent multi-provider, IDE et CLI

<span class="badge-intermediate">Intermédiaire</span>

**Kilo Code** est un agent de développement proposant des intégrations IDE, une CLI, des règles personnalisées et MCP. Sa documentation actuelle couvre notamment VS Code, JetBrains et la ligne de commande.

Dans ce dépôt, Kilo Code est documenté comme **alternative à tester**, pas comme remplacement automatique de Claude Code.

---

## Surfaces principales

La documentation officielle Kilo Code présente actuellement :

- extension VS Code ;
- extension JetBrains ;
- CLI ;
- modes et règles personnalisées ;
- automatisations et intégrations ;
- MCP ;
- accès à plusieurs modèles/providers via l'écosystème Kilo.

Installation documentée pour VS Code :

```bash
code --install-extension kilocode.kilo-code
```

Installation CLI documentée actuellement :

```bash
npm install -g @kilocode/cli
```

Vérifiez la documentation courante avant de figer une version dans un environnement d'entreprise.

---

## Configuration projet

Kilo distingue configuration globale et configuration projet.

Pour MCP, la documentation actuelle indique notamment :

```text
~/.config/kilo/kilo.jsonc    # global
kilo.jsonc                   # projet
.kilo/kilo.jsonc             # alternative projet
```

La configuration projet prend le pas sur la configuration globale pour les éléments concernés.

Cette séparation est utile pour versionner uniquement ce qui doit être partagé par l'équipe.

---

## MCP

Kilo Code supporte MCP pour connecter des outils et services externes.

La documentation Kilo permet de gérer les serveurs MCP depuis l'interface ou via la configuration, avec des politiques de permission permettant de :

- autoriser ;
- demander confirmation ;
- refuser certains outils.

Ce modèle est important pour les serveurs capables d'écrire dans des systèmes externes.

!!! tip "Commencez en lecture seule"
    Pour un nouveau MCP, commencez avec les opérations de lecture, vérifiez les sorties et ajoutez les capacités d'écriture seulement lorsqu'un besoin réel est établi.

---

## Rules et modes

Kilo propose des **custom rules** et des modes permettant d'adapter le comportement de l'agent à un projet ou une tâche.

Pour un dépôt multi-agents :


Évitez de dupliquer les mêmes règles longues dans quatre formats. Les fichiers spécifiques doivent surtout décrire les différences de runtime.

---

## Multi-provider

Kilo Code met en avant une couche d'accès à plusieurs modèles et providers.

Cela peut être utile pour :

- comparer des modèles sur un même agent ;
- adapter le modèle au coût/latence ;
- utiliser BYOK selon l'offre et la configuration ;
- expérimenter différents endpoints.

Mais la liberté de modèle augmente aussi la surface de gouvernance : chaque provider peut avoir une politique de données, une région et un modèle de facturation différents.

---

## Kilo Code + Graphify

Graphify documente une intégration Kilo Code spécifique qui peut installer :

- un skill Graphify ;
- une commande `/graphify` ;
- des indications dans `AGENTS.md` ;
- une configuration/plugin Kilo pour rappeler l'utilisation du graphe.

Cela peut être intéressant pour les dépôts volumineux, mais relisez toujours les fichiers générés avant de les versionner.

Voir **[Graphify](../../chapitre-4-contexte/graphify.md)**.

---

## Kilo Code vs Claude Code

| Sujet | Claude Code | Kilo Code |
|---|---|---|
| Orientation | Claude/Anthropic | multi-provider |
| CLI | ✅ | ✅ |
| VS Code | ✅ | ✅ |
| JetBrains | ✅ | ✅ |
| MCP | ✅ | ✅ |
| Rules projet | `.claude/rules/` | custom rules/config Kilo |
| Skills | natifs Claude | mécanismes Kilo + intégrations |
| Position dans ce dépôt | principal | alternative |

Les deux peuvent coexister si les conventions partagées restent centralisées.

---

## Sécurité et gouvernance

Avant d'activer Kilo en équipe, vérifiez :

- providers autorisés ;
- stockage des clés ;
- permissions MCP ;
- règles d'auto-approval ;
- accès terminal/fichiers ;
- configuration projet versionnée ;
- plugins et intégrations ;
- journalisation ;
- données envoyées à chaque provider.

Le fait qu'un outil supporte de nombreux modèles ne signifie pas qu'ils sont tous acceptables dans votre contexte réglementaire ou contractuel.

---

## Quand Kilo Code est intéressant

- vous voulez un agent utilisable dans VS Code, JetBrains et CLI ;
- vous voulez comparer plusieurs providers ;
- MCP est central dans votre workflow ;
- vous avez besoin de règles/modes personnalisés ;
- vous cherchez une alternative agentique tout en conservant une forte intégration IDE.

---

## Sources

Sources officielles consultées le **28 septembre 2026** :

- [Kilo Code — Documentation](https://kilo.ai/docs)
- [Kilo Code — MCP Overview](https://kilo.ai/docs/automate/mcp/overview)
- [Kilo Code — Using MCP](https://kilo.ai/docs/automate/mcp/using-in-kilo-code)

---

## Référence en annexe

[Copilot — archive de ce chapitre](../../appendices/copilot/chapitre-13-outils-economies.md#page-chapitre-13-outils-economies-agents-code-kilo-code).

## Prochaine étape

Poursuivez avec **[Windsurf (Codeium historique)](../codeium-windsurf.md)**, la page suivante dans le menu.
