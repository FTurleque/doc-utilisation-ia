# Sources officielles & changelogs

<span class="badge-beginner">Débutant</span>

Cette page rassemble les **sources primaires** à consulter avant de modifier une information périssable du dépôt. Claude Code est désormais la priorité documentaire ; GitHub Copilot reste suivi comme référence secondaire.

---

## Claude Code & Anthropic — priorité 1

| Ressource | Usage |
|---|---|
| [Claude Code documentation](https://code.claude.com/docs/) | Référence fonctionnelle principale |
| [Claude Code changelog](https://code.claude.com/docs/en/changelog) | Commandes, comportements et fonctionnalités récentes |
| [Anthropic Newsroom](https://www.anthropic.com/news) | Modèles, produit, annonces et sécurité |
| [Anthropic Research](https://www.anthropic.com/research) | Recherche, évaluations et sécurité |
| [Claude Platform docs](https://platform.claude.com/docs/) | API, modèles et plateforme développeur |
| [Claude pricing](https://claude.com/pricing) | Plans Claude ; à vérifier au moment d'une décision budgétaire |

!!! tip "Règle de maintenance"
    Pour une affirmation sur Claude Code, cherchez d'abord dans `code.claude.com`. Pour les modèles, plans ou annonces générales, utilisez Anthropic/Claude officiels.

---

## GitHub Copilot — référence conservée

| Ressource | Usage |
|---|---|
| [GitHub Copilot docs](https://docs.github.com/en/copilot) | Fonctionnalités et configuration |
| [GitHub Changelog](https://github.blog/changelog/) | Changements produit |
| [GitHub Copilot plans](https://docs.github.com/en/copilot/get-started/plans) | Plans et périmètres |
| [GitHub billing](https://docs.github.com/en/billing/concepts/product-billing/github-copilot-billing) | Facturation Copilot |
| [VS Code release notes](https://code.visualstudio.com/updates) | Intégrations VS Code/Copilot |

Ne recopiez pas durablement un tableau de prix ou de quotas : conservez la date de vérification et un lien canonique.

---

## Sécurité IA et systèmes agentiques

| Ressource | Usage |
|---|---|
| [OWASP GenAI Security Project](https://genai.owasp.org/) | Référence sécurité GenAI/agentique |
| [OWASP Top 10 for LLM and GenAI](https://genai.owasp.org/initiative/owasp-top-10-for-llm-and-genai/) | Risques LLM actuels |
| [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework) | Gestion des risques IA |
| [MITRE ATLAS](https://atlas.mitre.org/) | Tactiques et techniques d'attaque IA |
| [CNIL — IA](https://www.cnil.fr/fr/intelligence-artificielle) | Données personnelles et IA en France |

En septembre 2026, OWASP a annoncé le **Top 10 for LLM Applications 2026** et un **Agent Control Standard**. Les pages sécurité de ce dépôt doivent donc être relues avec une perspective agentique, pas uniquement « chatbot ». 

---

## Outils réellement utilisés par ce dépôt

Suivez les sources officielles plutôt qu'un agrégateur :

- [RTK](https://github.com/rtk-ai/rtk)
- [SonarQube MCP Server](https://github.com/SonarSource/sonarqube-mcp-server)
- [Ollama](https://docs.ollama.com/)
- [LM Studio](https://lmstudio.ai/docs/)
- [OpenSkills](https://github.com/numman-ali/openskills)
- [TOON](https://github.com/toon-format/toon)

Une page legacy doit être conservée si elle aide les utilisateurs existants, mais son statut de maintenance doit être explicite.

---

## Autres éditeurs à surveiller selon besoin

OpenAI, Google, Microsoft, JetBrains, AWS/Kiro, Windsurf/Cognition et Tabnine restent utiles lorsque leurs produits apparaissent dans une page du dépôt. Ils ne doivent pas occuper la veille principale si aucune décision documentaire n'en dépend.

---

## Sources communautaires : signal, pas preuve

Newsletters, Reddit, Discord, YouTube, blogs personnels et réseaux sociaux peuvent signaler :

- une régression ;
- un changement de prix ;
- une faille ;
- un nouveau workflow.

Avant de modifier la documentation, confirmez le point auprès d'une source primaire, d'un changelog, d'un dépôt officiel ou d'un avis de sécurité.

---

## Procédure de mise à jour documentaire

Pour toute information susceptible de changer :

1. retrouver la source officielle ;
2. vérifier la date de publication **et** la date effective du changement ;
3. distinguer GA, preview, beta, deprecated et legacy ;
4. éviter les modèles/prix figés si un lien officiel suffit ;
5. ajouter une date de consultation lorsque le contenu est temporel ;
6. vérifier les liens croisés et la navigation après modification.

---

## Les cinq flux les plus utiles pour ce dépôt

1. Claude Code changelog ;
2. Anthropic Newsroom ;
3. GitHub Changelog/Copilot docs ;
4. OWASP GenAI Security Project ;
5. releases/changelogs des outils réellement documentés.

## Prochaine étape

**[Sécurité, risques & failles](securite-risques.md)** pour transformer cette veille en contrôles opérationnels.