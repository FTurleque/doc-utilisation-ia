# FAQ Claude Code — Questions fréquentes

## Claude Code

??? question "Claude Code est-il le parcours principal de cette documentation ?"
    Oui. Les pages du parcours principal utilisent **Claude Code**. Les références d'un autre assistant sont regroupées dans [l'annexe](../appendices/index.md).

??? question "Claude Code fonctionne-t-il dans VS Code et JetBrains ?"
    Oui. Claude Code possède une intégration VS Code et une intégration JetBrains. Vérifiez la documentation officielle pour les prérequis exacts : l'intégration JetBrains s'appuie sur la CLI Claude Code, tandis que l'expérience VS Code dispose également de sa propre surface intégrée.

??? question "Quelle configuration projet faut-il commencer par ?"
    Gardez le socle petit :

    ```text
    CLAUDE.md
    .claude/
      rules/
      skills/
    ```

    Ajoutez agents, hooks, plugins et MCP uniquement lorsqu'un besoin concret le justifie.

??? question "À quoi servent `CLAUDE.md` et `AGENTS.md` ?"
    `CLAUDE.md` est le mécanisme principal d'instructions projet Claude Code. `AGENTS.md` peut servir de convention portable/multi-agent et est également pris en charge dans les versions récentes de Claude Code. Évitez de dupliquer de longues règles contradictoires dans les deux fichiers.

??? question "Quand utiliser une rule, une skill, un subagent ou MCP ?"
    | Besoin | Mécanisme |
    |---|---|
    | Invariant court du dépôt | `CLAUDE.md` |
    | Règle ciblée par fichiers/contexte | `.claude/rules/` |
    | Procédure réutilisable | `.claude/skills/` |
    | Travail isolé / recherche indépendante | subagent |
    | Service ou donnée externe dynamique | MCP |

??? question "Comment diagnostiquer Claude Code ?"
    Commencez par les mécanismes intégrés : `/doctor`, `claude doctor`, `/status`, `/context` et `/mcp` selon le symptôme. Utilisez `--safe-mode` lorsqu'il faut isoler plugins, hooks ou MCP.

??? question "Puis-je utiliser un modèle local avec Claude Code ?"
    Oui, certains backends comme **Ollama** et **LM Studio** exposent une compatibilité Anthropic permettant de connecter Claude Code à un modèle local. Cela ne transforme pas ce modèle en Claude : tool calling, contexte, qualité et sécurité doivent être benchmarkés séparément.

---

## Coûts et données

??? question "Faut-il un abonnement pour Claude Code ?"
    Claude Code peut être utilisé via les offres Claude compatibles ou via des configurations API/cloud prises en charge. Les plans, limites et mécanismes d'usage évoluent : vérifiez [Claude pricing](https://claude.com/pricing) et la documentation Claude Code avant une décision budgétaire.

??? question "Mon code est-il envoyé dans le cloud ?"
    Cela dépend du backend et de la configuration. Avec un backend Anthropic/cloud, le contenu nécessaire à la requête est traité par le service distant. Avec un backend local compatible, l'inférence peut rester locale, mais d'autres composants (MCP, plugins, télémétrie, logs, services externes) peuvent toujours communiquer avec le réseau.

    Pour un projet sensible, cartographiez toute la chaîne de données au lieu de vous fier au seul mot « local ».

??? question "Peut-on donner des secrets à Claude pour qu'il configure un service ?"
    Évitez de placer des secrets dans les prompts, instructions ou fichiers versionnés. Préférez variables d'environnement, secret managers et identités temporaires/scopées. L'agent ne doit voir que les credentials strictement nécessaires.

---

## Contexte et qualité

??? question "Claude Code lit-il tout le dépôt automatiquement ?"
    Non. Un agent travaille avec un budget de contexte et utilise recherche, lecture de fichiers, outils et parfois subagents pour charger l'information utile. Un dépôt bien structuré et des instructions concises sont plus efficaces qu'une tentative d'injecter tout le workspace.

??? question "Comment améliorer la qualité des résultats ?"
    Donnez :

    1. l'objectif ;
    2. les contraintes ;
    3. les fichiers ou zones pertinentes ;
    4. les commandes de validation ;
    5. le critère de fin.

    Demandez ensuite à Claude d'exécuter les tests/linters/build pertinents et de relire le diff.

??? question "Faut-il demander à Claude de “raisonner étape par étape” ?"
    Ne présentez pas cette formule comme une recette magique. Pour le développement logiciel, il est plus robuste de demander un plan, une décomposition, des critères de vérification et des preuves exécutées.

---

## Sécurité

??? question "Un agent peut-il être influencé par un fichier malveillant ?"
    Oui. Un dépôt, une page Web, une issue ou une sortie MCP peut contenir des instructions non fiables. Inspectez les fichiers d'instructions, skills, hooks, plugins et `.mcp.json` avant d'accorder des permissions larges à un dépôt tiers.

??? question "Le code généré est-il sûr s'il compile ?"
    Non. Compilation et sécurité sont deux contrôles différents. Utilisez tests, lint/typecheck, SAST/SCA, revue du diff et Quality Gates selon le projet.

??? question "Comment vérifier une dépendance suggérée par l'IA ?"
    Vérifiez le registre officiel, la provenance, le mainteneur, le dépôt source, les advisories et la nécessité de l'ajout. Ne vous fiez ni au nom généré ni uniquement au nombre de téléchargements.

---

## Prochaine étape

Poursuivez avec **[Raccourcis & commandes Claude](raccourcis-commandes.md)**, la page suivante dans le menu.
