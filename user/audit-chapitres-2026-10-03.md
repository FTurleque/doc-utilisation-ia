# Audit des six chapitres — 3 octobre 2026

Périmètre : les **68 pages principales** inscrites au menu de Prompt Engineering, Machine Learning, Deep Learning, RAG, Coûts & Gouvernance et Outils. Les références historiques placées en Annexe sont exclues de cet audit de documentation actuelle.

La revue porte sur les explications, exemples, informations évolutives, structure des titres, références et progression. Les faits produits/bibliothèques ont été confrontés aux sources officielles ci-dessous. Les anciennes dates de consultation ne sont pas remplacées globalement : les nouvelles vérifications sont datées à proximité des modifications.

## Corrections principales

- Prompt Engineering : sorties structurées CLI et contraintes métier ; revue isolée versus fork ; vérification des tâches longues ; titres manquants.
- ML : séparation régression/classification ; datasets définis pour les exemples ; pipelines SVM/KNN et vectorisation sans fuite ; reproductibilité Docker ; erreurs historiques corrigées (AlexNet et prix Turing).
- Deep Learning : split de validation avant scaler ; Keras 3, sauvegarde/export, AMP moderne ; OpenVINO en inférence ; diffusion ; contraintes JAX ; titres et imports.
- RAG : dépendances et nouveaux formats Docling ; Query API Qdrant ; autorisation de toutes les branches ; pseudocode identifié et encodeur distinct.
- Coûts : prix et sièges revérifiés ; périmètre Enterprise ; /usage versus /status ; cache et coût des subagents ; chargement des règles ; conditions actuelles auto mode.
- Outils : configuration LM Studio, PowerShell et retour au backend habituel ; portée locale réelle ; RTK et télémétrie ; secrets Sonar ; OAuth Tavily/Firecrawl ; manifeste OpenSkills ; fin de vie Promtail ; limites GPU Kepler ; framework Python Solace déprécié ; surfaces Cline.
- L’affirmation d’acquisition Tabnine par Tricentis a été retirée : elle n’a pas été confirmée par une source primaire accessible pendant cet audit.

## Sources effectivement consultées

| Sujet | Référence primaire |
|---|---|
| Claude : méthodes et vérification | [Best practices](https://code.claude.com/docs/en/best-practices) |
| Claude : JSON/schema | [Mode programmatique](https://code.claude.com/docs/en/headless) |
| Claude : règles et contexte | [Memory](https://code.claude.com/docs/en/memory) |
| Claude : coût et limites | [Costs](https://code.claude.com/docs/en/costs), [Pricing](https://claude.com/pricing), [Team](https://support.claude.com/en/articles/9266767-what-is-the-team-plan), [Pro](https://support.claude.com/en/articles/8325606-what-is-the-pro-plan), [Max](https://support.claude.com/en/articles/11049741-what-is-the-max-plan) |
| Claude : permissions et délégation | [Permission modes](https://code.claude.com/docs/en/permission-modes), [Subagents](https://code.claude.com/docs/en/sub-agents), [MCP](https://code.claude.com/docs/en/mcp) |
| scikit-learn | [Common pitfalls](https://scikit-learn.org/stable/common_pitfalls.html) |
| Keras | [Keras 3](https://keras.io/keras_3/), [Migration](https://keras.io/guides/migrating_to_keras_3/), [Export](https://keras.io/api/models/model_saving_apis/export/) |
| PyTorch | [ONNX 2.14](https://docs.pytorch.org/docs/2.14/onnx.html), [AMP 2.14](https://docs.pytorch.org/docs/2.14/amp.html) |
| JAX | [Sharp bits](https://docs.jax.dev/en/latest/notebooks/Common_Gotchas_in_JAX.html) |
| Diffusion | [Diffusers](https://huggingface.co/docs/diffusers/en/index) |
| AlexNet | [Publication NeurIPS 2012](https://papers.neurips.cc/paper_files/paper/2012/file/c399862d3b9d6b76c8436e924a68c45b-Paper.pdf) |
| Docling | [Formats](https://docling-project.github.io/docling/usage/supported_formats/), [CLI](https://docling-project.github.io/docling/reference/cli/) |
| Qdrant | [Hybrid queries](https://qdrant.tech/documentation/search/hybrid-queries/) |
| Backends | [Ollama Anthropic](https://docs.ollama.com/api/anthropic-compatibility), [LM Studio Claude Code](https://lmstudio.ai/docs/integrations/claude-code) |
| Compression | [RTK](https://github.com/rtk-ai/rtk), [TOON spec](https://github.com/toon-format/spec/blob/main/SPEC.md), [Caveman](https://github.com/JuliusBrussee/caveman) |
| Skills et Sonar | [OpenSkills](https://github.com/numman-ali/openskills), [Sonar MCP](https://github.com/SonarSource/sonarqube-mcp-server) |
| MCP Web | [Tavily](https://docs.tavily.com/documentation/mcp), [Firecrawl](https://docs.firecrawl.dev/mcp-server) |
| Observabilité | [Promtail EOL](https://grafana.com/docs/loki/latest/send-data/promtail/), [Kepler](https://github.com/sustainable-computing-io/kepler) |
| Agent Mesh | [Dépôt Python déprécié](https://github.com/SolaceLabs/solace-agent-mesh) |
| Agents alternatifs | [Cline](https://github.com/cline/cline), [Kilo](https://github.com/Kilo-Org/kilocode), [Kilo MCP](https://kilo.ai/docs/automate/mcp/using-in-kilo-code) |
| Maintenance et transitions | [Continue README](https://github.com/continuedev/continue), [Supermaven sunset](https://supermaven.com/blog/sunsetting-supermaven), [Amazon Q IDE EOS](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/q-developer-ide-end-of-support.html), [Windsurf/Cognition](https://cognition.com/blog/windsurf) |

## Inventaire de revue

38 pages corrigées ou enrichies ; les autres pages conservent leurs explications et recommandations stables.

| Page | Résultat |
|---|---|
| [chapitre-5-prompt-engineering/index.md](../docs/chapitre-5-prompt-engineering/index.md) | Corrigée / enrichie |
| [chapitre-5-prompt-engineering/fondamentaux.md](../docs/chapitre-5-prompt-engineering/fondamentaux.md) | Corrigée / enrichie |
| [chapitre-5-prompt-engineering/techniques-intermediaires.md](../docs/chapitre-5-prompt-engineering/techniques-intermediaires.md) | Corrigée / enrichie |
| [chapitre-5-prompt-engineering/techniques-avancees.md](../docs/chapitre-5-prompt-engineering/techniques-avancees.md) | Corrigée / enrichie |
| [chapitre-6-machine-learning/index.md](../docs/chapitre-6-machine-learning/index.md) | Contenu conservé après revue |
| [chapitre-6-machine-learning/concepts-fondamentaux.md](../docs/chapitre-6-machine-learning/concepts-fondamentaux.md) | Corrigée / enrichie |
| [chapitre-6-machine-learning/algorithmes-courants.md](../docs/chapitre-6-machine-learning/algorithmes-courants.md) | Corrigée / enrichie |
| [chapitre-6-machine-learning/claude-workflow-ml.md](../docs/chapitre-6-machine-learning/claude-workflow-ml.md) | Contenu conservé après revue |
| [chapitre-6-machine-learning/python-data-science.md](../docs/chapitre-6-machine-learning/python-data-science.md) | Contenu conservé après revue |
| [chapitre-6-machine-learning/notebooks-jupyter.md](../docs/chapitre-6-machine-learning/notebooks-jupyter.md) | Contenu conservé après revue |
| [chapitre-6-machine-learning/mlops-deploiement.md](../docs/chapitre-6-machine-learning/mlops-deploiement.md) | Corrigée / enrichie |
| [chapitre-6-machine-learning/comparaison-ecosystemes-ml.md](../docs/chapitre-6-machine-learning/comparaison-ecosystemes-ml.md) | Contenu conservé après revue |
| [chapitre-6-machine-learning/comparaison-outils.md](../docs/chapitre-6-machine-learning/comparaison-outils.md) | Corrigée / enrichie |
| [chapitre-8-deep-learning/index.md](../docs/chapitre-8-deep-learning/index.md) | Contenu conservé après revue |
| [chapitre-8-deep-learning/fondations-mathematiques.md](../docs/chapitre-8-deep-learning/fondations-mathematiques.md) | Corrigée / enrichie |
| [chapitre-8-deep-learning/reseaux-neurones.md](../docs/chapitre-8-deep-learning/reseaux-neurones.md) | Corrigée / enrichie |
| [chapitre-8-deep-learning/architectures-deep-learning.md](../docs/chapitre-8-deep-learning/architectures-deep-learning.md) | Corrigée / enrichie |
| [chapitre-8-deep-learning/concevoir-entrainer.md](../docs/chapitre-8-deep-learning/concevoir-entrainer.md) | Corrigée / enrichie |
| [chapitre-8-deep-learning/optimisation-performance.md](../docs/chapitre-8-deep-learning/optimisation-performance.md) | Corrigée / enrichie |
| [chapitre-8-deep-learning/comparaison.md](../docs/chapitre-8-deep-learning/comparaison.md) | Corrigée / enrichie |
| [chapitre-7-rag/index.md](../docs/chapitre-7-rag/index.md) | Contenu conservé après revue |
| [chapitre-7-rag/concepts.md](../docs/chapitre-7-rag/concepts.md) | Contenu conservé après revue |
| [chapitre-7-rag/docling.md](../docs/chapitre-7-rag/docling.md) | Corrigée / enrichie |
| [chapitre-7-rag/qdrant.md](../docs/chapitre-7-rag/qdrant.md) | Corrigée / enrichie |
| [chapitre-7-rag/implementation.md](../docs/chapitre-7-rag/implementation.md) | Contenu conservé après revue |
| [chapitre-7-rag/niveau-1.md](../docs/chapitre-7-rag/niveau-1.md) | Corrigée / enrichie |
| [chapitre-7-rag/niveau-2.md](../docs/chapitre-7-rag/niveau-2.md) | Corrigée / enrichie |
| [chapitre-7-rag/niveau-3.md](../docs/chapitre-7-rag/niveau-3.md) | Contenu conservé après revue |
| [chapitre-7-rag/cas-usage-secteurs.md](../docs/chapitre-7-rag/cas-usage-secteurs.md) | Contenu conservé après revue |
| [chapitre-7-rag/optimisation-avancee.md](../docs/chapitre-7-rag/optimisation-avancee.md) | Contenu conservé après revue |
| [chapitre-12-couts-gouvernance/index.md](../docs/chapitre-12-couts-gouvernance/index.md) | Corrigée / enrichie |
| [chapitre-12-couts-gouvernance/patterns-allers-retours.md](../docs/chapitre-12-couts-gouvernance/patterns-allers-retours.md) | Contenu conservé après revue |
| [chapitre-12-couts-gouvernance/abonnements.md](../docs/chapitre-12-couts-gouvernance/abonnements.md) | Corrigée / enrichie |
| [chapitre-12-couts-gouvernance/leviers-economie.md](../docs/chapitre-12-couts-gouvernance/leviers-economie.md) | Corrigée / enrichie |
| [chapitre-12-couts-gouvernance/caveman.md](../docs/chapitre-12-couts-gouvernance/caveman.md) | Corrigée / enrichie |
| [chapitre-12-couts-gouvernance/modes-quand-utiliser.md](../docs/chapitre-12-couts-gouvernance/modes-quand-utiliser.md) | Corrigée / enrichie |
| [chapitre-12-couts-gouvernance/workflow-recommande.md](../docs/chapitre-12-couts-gouvernance/workflow-recommande.md) | Contenu conservé après revue |
| [chapitre-13-outils-economies/index.md](../docs/chapitre-13-outils-economies/index.md) | Corrigée / enrichie |
| [chapitre-13-outils-economies/rtk.md](../docs/chapitre-13-outils-economies/rtk.md) | Corrigée / enrichie |
| [chapitre-13-outils-economies/sonarqube.md](../docs/chapitre-13-outils-economies/sonarqube.md) | Corrigée / enrichie |
| [chapitre-13-outils-economies/sonarqube-vscode.md](../docs/chapitre-13-outils-economies/sonarqube-vscode.md) | Contenu conservé après revue |
| [chapitre-13-outils-economies/rtk-sonar.md](../docs/chapitre-13-outils-economies/rtk-sonar.md) | Contenu conservé après revue |
| [chapitre-13-outils-economies/toon.md](../docs/chapitre-13-outils-economies/toon.md) | Contenu conservé après revue |
| [chapitre-13-outils-economies/openskills.md](../docs/chapitre-13-outils-economies/openskills.md) | Corrigée / enrichie |
| [chapitre-13-outils-economies/mcps/index.md](../docs/chapitre-13-outils-economies/mcps/index.md) | Contenu conservé après revue |
| [chapitre-13-outils-economies/mcps/configuration.md](../docs/chapitre-13-outils-economies/mcps/configuration.md) | Corrigée / enrichie |
| [chapitre-13-outils-economies/mcps/serveurs.md](../docs/chapitre-13-outils-economies/mcps/serveurs.md) | Corrigée / enrichie |
| [chapitre-13-outils-economies/mcps/securite.md](../docs/chapitre-13-outils-economies/mcps/securite.md) | Contenu conservé après revue |
| [chapitre-13-outils-economies/observabilite/index.md](../docs/chapitre-13-outils-economies/observabilite/index.md) | Contenu conservé après revue |
| [chapitre-13-outils-economies/observabilite/grafana.md](../docs/chapitre-13-outils-economies/observabilite/grafana.md) | Contenu conservé après revue |
| [chapitre-13-outils-economies/observabilite/loki.md](../docs/chapitre-13-outils-economies/observabilite/loki.md) | Corrigée / enrichie |
| [chapitre-13-outils-economies/observabilite/kepler.md](../docs/chapitre-13-outils-economies/observabilite/kepler.md) | Corrigée / enrichie |
| [chapitre-13-outils-economies/solace.md](../docs/chapitre-13-outils-economies/solace.md) | Corrigée / enrichie |
| [chapitre-13-outils-economies/continue-dev.md](../docs/chapitre-13-outils-economies/continue-dev.md) | Contenu conservé après revue |
| [chapitre-13-outils-economies/ollama.md](../docs/chapitre-13-outils-economies/ollama.md) | Corrigée / enrichie |
| [chapitre-13-outils-economies/lm-studio.md](../docs/chapitre-13-outils-economies/lm-studio.md) | Corrigée / enrichie |
| [chapitre-13-outils-economies/stack-prete-15-min-vscode.md](../docs/chapitre-13-outils-economies/stack-prete-15-min-vscode.md) | Corrigée / enrichie |
| [chapitre-13-outils-economies/stack-prete-15-min-intellij.md](../docs/chapitre-13-outils-economies/stack-prete-15-min-intellij.md) | Corrigée / enrichie |
| [chapitre-13-outils-economies/agents-code/index.md](../docs/chapitre-13-outils-economies/agents-code/index.md) | Contenu conservé après revue |
| [chapitre-13-outils-economies/agents-code/cline.md](../docs/chapitre-13-outils-economies/agents-code/cline.md) | Corrigée / enrichie |
| [chapitre-13-outils-economies/agents-code/kilo-code.md](../docs/chapitre-13-outils-economies/agents-code/kilo-code.md) | Contenu conservé après revue |
| [chapitre-13-outils-economies/codeium-windsurf.md](../docs/chapitre-13-outils-economies/codeium-windsurf.md) | Contenu conservé après revue |
| [chapitre-13-outils-economies/tabnine.md](../docs/chapitre-13-outils-economies/tabnine.md) | Corrigée / enrichie |
| [chapitre-13-outils-economies/amazon-q-developer.md](../docs/chapitre-13-outils-economies/amazon-q-developer.md) | Contenu conservé après revue |
| [chapitre-13-outils-economies/supermaven.md](../docs/chapitre-13-outils-economies/supermaven.md) | Contenu conservé après revue |
| [chapitre-13-outils-economies/comparaison.md](../docs/chapitre-13-outils-economies/comparaison.md) | Contenu conservé après revue |
| [chapitre-13-outils-economies/outils-complementaires.md](../docs/chapitre-13-outils-economies/outils-complementaires.md) | Contenu conservé après revue |
| [chapitre-13-outils-economies/recommandations-taille-type-application.md](../docs/chapitre-13-outils-economies/recommandations-taille-type-application.md) | Contenu conservé après revue |

## Validation

- Build MkDocs strict et validation des liens internes, progression et périmètre Annexe exécutés sur le site final.
- Les 35 snippets Python des 68 pages passent la compilation syntaxique ; les blocs JSON sont décodables.
- Aucun entraînement GPU, service cloud payant, installation de plugin ou déploiement externe n’a été exécuté. La compatibilité des APIs a été vérifiée dans les sources ; les exemples dépendants de données/services restent à exécuter dans l’environnement verrouillé du projet.
- Certains fetchs HTML ont échoué ; les variantes Markdown, README officiels ou lecture Web officielle ont été utilisées quand disponibles. La nouvelle documentation commerciale Solace n’a pas pu être extraite : ses anciennes APIs ne sont donc pas déclarées compatibles avec le nouveau produit.
