# Agents de code alternatifs — Cline & Kilo Code

<span class="badge-intermediate">Intermédiaire</span>

Cette section documente deux **agents de code alternatifs** à Claude Code : **Cline** et **Kilo Code**.

L'objectif n'est pas de désigner un « gagnant ». Ces outils sont intéressants surtout lorsque vous avez besoin d'un runtime **multi-modèles**, d'une intégration IDE différente, de modèles locaux ou d'une autre politique de gouvernance.

---

## Pourquoi une section séparée

Cline et Kilo Code ne sont pas de simples backends LLM : ce sont des **agents de développement** avec leur propre boucle d'outils, règles, permissions et intégrations.

Ils doivent donc être comparés à Claude Code au niveau de :

- l'agent runtime ;
- le contexte projet ;
- les permissions ;
- MCP ;
- les modèles/providers ;
- IDE/CLI ;
- automatisation et CI ;
- sécurité et gouvernance.

---

## Vue d'ensemble

| Critère | Claude Code | Cline | Kilo Code |
|---|---|---|---|
| Orientation | écosystème Claude/Anthropic | runtime agent open source multi-provider | agent multi-provider et plateforme d'automatisation |
| CLI | ✅ | ✅ | ✅ |
| VS Code | ✅ | ✅ | ✅ |
| JetBrains | ✅ | disponible selon offre/surface actuelle | ✅ |
| MCP | ✅ | ✅ | ✅ |
| Modèles locaux | selon intégration/provider | ✅ via endpoints/providers compatibles | ✅ selon provider/configuration |
| Règles projet | `CLAUDE.md`, rules, skills | rules/skills Cline | custom rules/config Kilo |
| Position dans ce dépôt | parcours principal | alternative documentée | alternative documentée |

!!! note "Fonctionnalités évolutives"
    Les surfaces IDE, providers, prix et fonctions d'équipe changent rapidement. Vérifiez les pages officielles avant toute décision d'adoption.

---

## Quand tester Cline ou Kilo Code

Une expérimentation est pertinente si vous recherchez :

- liberté de choix du modèle ;
- utilisation d'un endpoint OpenAI-compatible ;
- modèles locaux avec Ollama/LM Studio ;
- workflow fortement centré IDE ;
- politique BYOK ;
- comparaison de plusieurs agent runtimes ;
- besoins d'automatisation spécifiques non couverts par votre workflow Claude actuel.

Ne migrez pas uniquement parce qu'un outil possède plus de boutons ou de providers. Mesurez sur un **même jeu de tâches** : qualité du patch, temps, nombre de retries, coût, sécurité et facilité de vérification.

---

## Comparaison expérimentale recommandée

```text
Même repository
+ même issue
+ mêmes tests
+ même modèle si possible
+ mêmes permissions

→ Claude Code
→ Cline
→ Kilo Code

Comparer :
- résultat fonctionnel
- diff
- tests
- temps total
- interventions humaines
- coût d'inférence
- erreurs d'outils
```

Cela compare le **harness agentique** plutôt que de confondre qualité du modèle et qualité de l'agent.

---

## Pages

- **[Cline](cline.md)** — Plan/Act, IDE, CLI, MCP, multi-provider et garde-fous ;
- **[Kilo Code](kilo-code.md)** — VS Code/JetBrains/CLI, modes, rules, MCP et configuration projet.

---

## Sources

Sources officielles consultées le **28 septembre 2026** :

- [Cline — site officiel](https://cline.bot/)
- [Cline — IDE](https://cline.bot/ide)
- [Kilo Code — documentation](https://kilo.ai/docs)
- [Kilo Code — MCP](https://kilo.ai/docs/automate/mcp/overview)
