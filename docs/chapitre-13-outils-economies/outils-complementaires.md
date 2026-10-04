# Vue d'ensemble des outils complémentaires

<span class="badge-intermediate">Intermédiaire</span>

Claude Code est l'agent principal de cette documentation, mais il ne doit pas remplacer les outils plus déterministes ni empêcher un choix local ou spécialisé lorsque celui-ci est pertinent.

Cette page est le **catalogue transversal des outils de la documentation**. Les fiches d'installation, de fonctionnement et de configuration sont regroupées dans **Outils** ; les autres chapitres présentent brièvement leur intérêt pour le contexte, le RAG, les bonnes pratiques ou les coûts et renvoient ici. Les utilitaires employés dans les exemples sont également répertoriés ci-dessous.

---

## Outils de preuve, contexte et réduction du bruit

| Outil | Rôle | Page |
|---|---|---|
| SonarQube | Analyse statique, Quality Gates, MCP Sonar | [SonarQube](sonarqube.md) |
| RTK | Réduire certaines sorties CLI envoyées à l'agent | [RTK](rtk.md) |
| TOON | Représenter de façon compacte certaines données structurées | [TOON](toon.md) |
| Caveman | Réduire verbosité agent et certaines entrées/tool results | [Caveman](caveman.md) |
| MCP | Connecter Claude à des services/données dynamiques | [MCP](mcps/index.md) |
| OpenSkills | Installer/synchroniser des skills portables | [OpenSkills](openskills.md) |
| Semble | Recherche rapide de snippets de code pour agents | [Semble](semble.md) |
| Serena | Code intelligence sémantique : symboles, références, refactorings | [Serena](serena.md) |
| Graphify | Construire un knowledge graph d'un dépôt volumineux | [Graphify](graphify.md) |
| Tree-sitter | Analyser la structure syntaxique du code | [Tree-sitter](tree-sitter.md) |
| Docling | Parser/structurer des documents avant RAG | [Docling](docling.md) |
| Qdrant | Retrieval vectoriel/hybride pour les architectures RAG | [Qdrant](qdrant.md) |

Ces outils complètent Claude ; ils ne sont pas des modèles concurrents.

---

## Spec-driven development

| Outil | Rôle | Page |
|---|---|---|
| OpenSpec | Framework SDD avec proposal, specs, design et tasks versionnés | [OpenSpec](openspec.md) |
| OpenSpec Custom Schemas | Workflows spécialisés : intent-driven, event-driven, ADR, minimalist… | [OpenSpec Schemas](openspec-schemas.md) |

Le chapitre **Bonnes Pratiques** présente leur place dans le processus de livraison ; ces fiches du chapitre **Outils** expliquent leur installation et leur fonctionnement.

## Utilitaires de recherche et de données

| Outil | Usage avec Claude Code | Repère |
|---|---|---|
| Git | Historique, différences et revue des modifications | [Workflow de validation](../chapitre-9-bonnes-pratiques/workflows-ia.md) |
| ripgrep (`rg`) | Recherche textuelle ciblée dans les fichiers | [Exemples de CLI](index.md#cli-deterministes) |
| `jq` | Sélection de champs dans une sortie JSON | [Exemples de CLI](index.md#cli-deterministes) |
| `yq` | Sélection de champs dans une configuration YAML | [Exemples de CLI](index.md#cli-deterministes) |
| `tree` | Vue limitée de l'arborescence | [Exemples de CLI](index.md#cli-deterministes) |

Ces commandes préparent des preuves ciblées. Fixez la variante et la version des utilitaires dans la configuration du projet : deux commandes portant le même nom peuvent avoir des options différentes.

## Validation, analyse statique et migrations

| Outil ou famille | Rôle dans le workflow | Guide ou documentation officielle |
|---|---|---|
| SonarQube | Analyse statique et Quality Gates | [IntelliJ](sonarqube.md), [VS Code](sonarqube-vscode.md), [RTK + Sonar](rtk-sonar.md) |
| Semgrep | Recherche et analyse du code par règles | [Documentation Semgrep](https://semgrep.dev/docs/) |
| Qodana | Inspections du code et rapports de qualité | [Documentation Qodana](https://www.jetbrains.com/help/qodana/) |
| SpotBugs | Analyse statique du bytecode Java | [Documentation SpotBugs](https://spotbugs.readthedocs.io/) |
| PMD | Analyse du code par règles | [Documentation PMD](https://docs.pmd-code.org/latest/) |
| Checkstyle | Contrôle des conventions de code Java | [Documentation Checkstyle](https://checkstyle.org/) |
| OpenRewrite | Migrations automatisées à partir de recettes | [Documentation OpenRewrite](https://docs.openrewrite.org/) |
| pytest | Exécution des tests Python | [Documentation pytest](https://docs.pytest.org/) |
| Ruff | Lint et formatage Python | [Documentation Ruff](https://docs.astral.sh/ruff/) |
| Compilateurs, type checkers, Maven, Gradle, npm | Build, types et checks définis par le projet | [Workflow de validation](../chapitre-9-bonnes-pratiques/workflows-ia.md) |

Ces outils fournissent les diagnostics que Claude analyse et les checks qui valident ses modifications. Leur configuration dépend du langage et du dépôt ; utilisez les commandes verrouillées par le projet.

## Data, notebooks et frameworks ML

| Outil ou famille | Place dans le travail | Guide dans Outils |
|---|---|---|
| Jupyter / JupyterLab | Exploration et notebooks reproductibles | [Jupyter avec Claude Code](jupyter.md) |
| scikit-learn | ML classique et pipelines de preprocessing | [Comparaison des frameworks ML](frameworks-ml.md#scikit-learn) |
| TensorFlow | Deep learning et écosystème associé | [Comparaison des frameworks ML](frameworks-ml.md#tensorflow) |
| PyTorch | Deep learning et export des modèles | [Comparaison des frameworks ML](frameworks-ml.md#pytorch) |
| Keras | API haut niveau et choix du backend | [Comparaison des frameworks ML](frameworks-ml.md#keras-3) |
| JAX | Backend à considérer selon les opérations et la cible | [Frameworks Deep Learning](frameworks-deep-learning.md) |
| NumPy, pandas, Matplotlib | Calcul, préparation des données et visualisation | [Jupyter](jupyter.md), [frameworks ML](frameworks-ml.md) |

Pour une méthode de préparation des données et d'évaluation, suivez les chapitres [Machine Learning](../chapitre-6-machine-learning/index.md) et [Deep Learning](../chapitre-8-deep-learning/index.md). Ils renvoient aux fiches d'outils pour les contraintes propres aux frameworks.

---

## Code intelligence : choisir selon le problème

```text
Recherche de snippets ciblés       → Semble
Symboles / références / refactor   → Serena
Relations globales / knowledge map → Graphify
Recherche exacte simple            → IDE / rg
```

Ne déployez pas les trois par défaut. Mesurez d'abord où les outils natifs de Claude Code ou de l'IDE deviennent insuffisants.

---

## Ingestion et retrieval RAG

```text
Documents hétérogènes
      ↓
Docling — parsing / OCR / structure / chunks
      ↓
Embeddings
      ↓
Qdrant — index / filtres / retrieval hybride
      ↓
LLM / agent
```

Docling et Qdrant sont complémentaires : le premier prépare le corpus, le second sert de moteur d'index/retrieval.

---

## Observabilité & GreenOps

| Outil | Positionnement | Page |
|---|---|---|
| Grafana | Dashboards, Explore, alerting et corrélation multi-source | [Grafana](observabilite/grafana.md) |
| Loki | Centralisation et interrogation des logs | [Loki](observabilite/loki.md) |
| Kepler | Métriques d'énergie Kubernetes exportées vers Prometheus | [Kepler](observabilite/kepler.md) |
| Prometheus | Collecte et interrogation des métriques | [Architecture d'observabilité](observabilite/index.md) |

Voir la **[vue d'ensemble Observabilité & GreenOps](observabilite/index.md)**.

---

## Architecture event-driven

| Outil | Positionnement | Page |
|---|---|---|
| Solace | Event Broker/Event Mesh et déclenchement de workflows agentiques | [Solace](solace.md) |

Solace ne remplace pas MCP : l'event mesh transporte des événements, tandis que MCP expose des outils et ressources à un agent.

Un workflow **OpenSpec event-driven** peut documenter la conception d'un système événementiel ; il ne remplace pas non plus l'infrastructure Solace.

---

## Backends locaux

| Outil | Positionnement | Page |
|---|---|---|
| Ollama | CLI/API locale et cloud, compatibilité Anthropic pour Claude Code | [Ollama](ollama.md) |
| LM Studio | GUI + serveur local, API Anthropic compatible Claude Code | [LM Studio](lm-studio.md) |

Les deux permettent maintenant de garder **Claude Code comme interface agentique** tout en changeant le modèle servi lorsque la compatibilité du backend le permet.

---

## Agents de code alternatifs

| Produit | Pourquoi l'évaluer | Page |
|---|---|---|
| Cline | Agent open source multi-provider, IDE + CLI, Plan/Act et MCP | [Cline](agents-code/cline.md) |
| Kilo Code | Agent multi-provider avec VS Code, JetBrains, CLI, rules et MCP | [Kilo Code](agents-code/kilo-code.md) |

Ces deux outils disposent d'une **[section spéciale](agents-code/index.md)** pour les comparer à Claude Code sans les mélanger avec les simples assistants ou backends de modèles.

---

## Autres assistants ou environnements alternatifs

| Produit | Statut / raison de l'évaluer | Page |
|---|---|---|
| Windsurf | IDE agentique actuel, issu de Codeium, désormais chez Cognition | [Windsurf](codeium-windsurf.md) |
| Tabnine | Gouvernance et options de déploiement entreprise | [Tabnine](tabnine.md) |
| Amazon Q / Kiro | Spécialisation AWS, migration en cours vers Kiro | [Amazon Q](amazon-q-developer.md) |

---

## Références legacy

| Produit | Pourquoi la page reste |
|---|---|
| [Continue](continue-dev.md) | Installations existantes et historique des stacks locales ; maintenance active arrêtée |
| [Supermaven](supermaven.md) | Utilisateurs existants ; sunset annoncé |

Ne créez pas une nouvelle stack d'équipe autour d'une page legacy uniquement parce qu'elle existe encore dans la documentation.

---

## Comment composer la stack

Commencez par le problème, pas par l'outil :

```text
Besoin de corriger mécaniquement ?  → IDE / linter / Sonar
Besoin de retrouver du code vite ?  → Semble
Besoin de symboles/refactorings ?    → Serena
Besoin de cartographier un repo ?   → Graphify
Besoin d'ingérer des documents ?    → Docling
Besoin de retrieval RAG ?           → Qdrant ou store adapté
Besoin de formaliser un changement ?→ OpenSpec si la complexité le justifie
Besoin de preuves dynamiques ?      → tests / MCP / API officielle
Besoin de logs centralisés ?        → Loki
Besoin de dashboards / alerting ?   → Grafana
Besoin de mesurer l'énergie K8s ?   → Kepler + Prometheus + Grafana
Besoin d'event-driven temps réel ?  → Solace ou infrastructure adaptée
Besoin de réduire du bruit CLI ?    → RTK
Besoin de réduire verbosité/tool results ? → Caveman, après mesure
Besoin de procédures réutilisables ?→ skills
Besoin de modèle local ?            → Ollama ou LM Studio
Besoin d'un agent multi-provider ?  → Cline ou Kilo Code
```

---

## Règle de cohabitation IDE

Évitez d'activer plusieurs moteurs de complétion inline concurrents. Un agent principal et un moteur inline clairement choisis réduisent les conflits de raccourcis, de suggestions et de contexte.

Si plusieurs agents coexistent, centralisez les conventions communes dans une source partagée (`AGENTS.md`, commandes de build/test, documentation projet) plutôt que de copier les mêmes règles dans chaque format.

---

## Validation avant standardisation équipe

Pour chaque outil ajouté :

- définir ce qu'il remplace ou complète ;
- vérifier sa maintenance actuelle ;
- documenter données envoyées et secrets requis ;
- mesurer le bénéfice sur des tâches réelles ;
- prévoir la désinstallation/migration ;
- instrumenter le système lorsque le résultat doit être observé ;
- ne pas dupliquer les mêmes règles dans cinq formats propriétaires.

---

## Pour aller plus loin

- [Contexte & code intelligence](../chapitre-4-contexte/index.md)
- [RAG](../chapitre-7-rag/index.md)
- [OpenSpec](openspec.md)
- [Coûts & Gouvernance](../chapitre-12-couts-gouvernance/index.md)
- [Comparaison des outils](comparaison.md)
- [Agents de code alternatifs](agents-code/index.md)
- [Observabilité & GreenOps](observabilite/index.md)
- [Solace](solace.md)
- [Recommandations par contexte](recommandations-taille-type-application.md)

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-13-outils-economies.md#page-chapitre-13-outils-economies-outils-complementaires).

## Prochaine étape

Poursuivez avec **[Recommandations par application](recommandations-taille-type-application.md)**, la page suivante dans le menu.
