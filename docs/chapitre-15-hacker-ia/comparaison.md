# Comparaison — sécurité IA dans VS Code et JetBrains

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">JetBrains</span>

Le choix de l'IDE ne détermine pas à lui seul la sécurité d'un workflow agentique. Le risque dépend surtout des **permissions**, des extensions/plugins, des credentials disponibles, des MCP, des règles projet et des contrôles de validation.

Cette page compare donc les surfaces à auditer plutôt que de désigner un IDE « plus sûr ».

---

## Surfaces communes

Dans les deux environnements, vérifiez :

- plugins/extensions installés et leur provenance ;
- accès terminal/shell de l'agent ;
- credentials hérités du processus IDE ;
- fichiers d'instructions du dépôt ;
- serveurs MCP et leurs secrets ;
- hooks, skills et autres customisations ;
- permissions Git/GitHub/cloud ;
- capacité à relire le diff et exécuter les validations.

---

## Claude Code — différences opérationnelles

| Sujet | VS Code | JetBrains |
|---|---|---|
| Intégration Claude | Extension/interface Claude Code | Plugin/intégration JetBrains Claude Code |
| CLI standalone | Utile pour le terminal, pas nécessaire à toutes les fonctions du panneau | Requise par l'intégration JetBrains actuelle |
| Refactorings déterministes | Dépendent davantage du langage/extensions | Refactorings et analyses natives riches selon l'IDE/langage |
| Gestion extensions/plugins | Marketplace VS Code + policies éventuelles | Marketplace JetBrains + policies éventuelles |
| Keybindings/config | Settings/Keyboard Shortcuts | Settings/Keymap |
| Validation | tests, tâches, extensions, terminal | tests, inspections, debugger, build tools, terminal |

Ces différences influencent le workflow, pas un niveau de sécurité intrinsèque.

Les prérequis d'intégration ont été revérifiés le **4 octobre 2026** : l'extension VS Code embarque une CLI pour son panneau, tandis que le plugin JetBrains utilise la commande `claude` installée séparément. En développement distant, vérifiez aussi sur quel hôte s'exécutent plugin, commandes et credentials.

---

### Extensions/plugins

- limiter les composants aux besoins réels ;
- vérifier l'éditeur et le statut de maintenance ;
- contrôler les mises à jour dans les environnements sensibles ;
- supprimer les outils legacy inutilisés.

### Credentials

- ne pas lancer l'IDE avec des credentials de production permanents ;
- utiliser des identités dédiées/scopées ;
- préférer des tokens temporaires ;
- tester la révocation.

### Agent

- moindre privilège ;
- revue des commandes sensibles ;
- contexte externe considéré comme non fiable ;
- validation par tests/CI ;
- audit des fichiers d'instructions et `.mcp.json`.

---

## Outils déterministes avant agent

Pour une opération mécanique, utilisez la capacité native de l'IDE lorsqu'elle offre une transformation vérifiable :

```text
rename / find usages / extract / inspections / debugger / tests
→ puis agent si analyse ou coordination complexe nécessaire
```

Ce principe est particulièrement visible dans les IDE JetBrains, mais VS Code dispose également de capacités de refactoring via ses language servers et extensions.

---

## Même IDE, configurations de sécurité différentes

Dans la documentation actuelle, le mode **Auto** de Claude Code fait examiner certaines actions par un classificateur ; le mode **Manual** repose davantage sur les demandes d'autorisation. La surface, la version et les paramètres déterminent le mode initial. Vérifiez le mode réel et les politiques de l'organisation dans les deux IDE ; « extension installée » ne signifie pas « mêmes droits ».

La sandbox de commandes ne fonctionne pas sur Windows natif. Une intégration IDE, un terminal Windows et une session WSL2 peuvent donc exposer des frontières différentes. Comparez montages, credentials, réseau et couverture effective, pas uniquement le nom de l'IDE. Voir [Sécuriser les agents](securite-agents.md) et le [guide Sandbox](../chapitre-4-contexte/sandbox.md).

Ces points ont été vérifiés le **4 octobre 2026** dans les pages officielles [Security](https://code.claude.com/docs/en/security) et [Sandboxing](https://code.claude.com/docs/en/sandboxing).

## Workspace/dépôt non fiable

Lors de l'ouverture d'un dépôt externe :

1. inspecter les fichiers d'instructions ;
2. inspecter les configurations de tâches/scripts ;
3. vérifier `.mcp.json` et les serveurs déclarés ;
4. ne pas exécuter automatiquement les scripts d'installation ;
5. éviter de rendre immédiatement accessibles des secrets ;
6. utiliser les mécanismes de confiance/sandbox disponibles dans l'environnement.

Le risque vient du dépôt **et** de ce que l'agent peut faire avec son contenu.

---

## Décider sans classement arbitraire

Choisissez l'IDE selon :

- langage et qualité des outils natifs ;
- standard d'équipe ;
- capacité de gouvernance des plugins/extensions ;
- intégrations de sécurité ;
- besoin de refactoring/navigation ;
- capacité à reproduire les validations en CI.

Pour un projet critique, le contrôle des identités, secrets, permissions et pipelines importe davantage qu'un classement général VS Code vs IntelliJ.

---

## Sources

- [Claude Code — Security](https://code.claude.com/docs/en/security) — consulté le 2026-10-04
- [Claude Code — Sandboxing](https://code.claude.com/docs/en/sandboxing) — consulté le 2026-10-04

- [Claude Code — VS Code](https://code.claude.com/docs/en/vs-code)
- [Claude Code — JetBrains](https://code.claude.com/docs/en/jetbrains)
- [OWASP GenAI Security Project](https://genai.owasp.org/)
- [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)
- [MITRE ATLAS](https://atlas.mitre.org/)

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-15-hacker-ia.md#page-chapitre-15-hacker-ia-comparaison).

## Prochaine étape

Poursuivez avec **[FAQ Claude Code](../references-claude/faq.md)**, la page suivante dans le menu.
