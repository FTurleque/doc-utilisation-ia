# IA et hacking — usages offensifs, risques réels et protections

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span>

L'IA peut réduire le coût de certaines tâches d'attaque et accélérer des workflows qui nécessitaient auparavant davantage de temps ou de compétences spécialisées. Elle améliore aussi les capacités défensives. Cette page reste strictement orientée **prévention, détection et réponse**.

---

## Ce que les sources 2026 permettent d'affirmer

Les rapports de threat intelligence et référentiels récents documentent notamment :

- assistance à l'ingénierie de logiciels malveillants ou de surveillance ;
- automatisation et personnalisation de contenus frauduleux ;
- utilisation de clés API volées et de services de proxy/revente ;
- industrialisation de certaines tâches de recherche et d'analyse ;
- risques propres aux agents : prompt injection, permissions excessives, supply chain et outils externes.

Ces cas montrent des capacités réelles, mais ne donnent pas automatiquement une fréquence ou une probabilité universelle pour votre organisation.

---

## Menaces à modéliser

Il faut distinguer **IA utilisée comme moyen d'attaque**, **système IA pris pour cible** et **agent influencé dans un environnement autorisé**. Les contrôles se recoupent mais les preuves d'incident diffèrent. La [page sur la sécurité des agents](securite-agents.md) détaille ces frontières.

| Famille | Surface exposée | Contrôles défensifs |
|---|---|---|
| Ingénierie sociale assistée | messagerie, voix, vidéo, support | MFA résistante au phishing, validation hors bande, processus transactionnels |
| Agent de code compromis/influencé | dépôt, IDE, shell, CI | moindre privilège, revue diff, tests, logs, sandbox |
| Prompt injection indirecte | Web, tickets, README, MCP | frontières de confiance, outils minimaux, validation des sources |
| Supply chain | packages, plugins, skills, MCP | provenance, SCA, versions contrôlées, revue scripts |
| Exfiltration | secrets, données client, code | scopes minimaux, secret manager, DLP, restrictions réseau |
| Identité/credentials | API keys, tokens CI/cloud | rotation, scopes, comptes dédiés, détection d'usage inhabituel |

---

## Claude Code : surface spécifique

Un agent de développement peut combiner :

```text
instructions dépôt
+ fichiers du projet
+ shell
+ Git
+ MCP
+ hooks/plugins/skills
+ credentials disponibles
```

Cette combinaison rend la gouvernance des **permissions** plus importante que le simple choix du modèle.

Avant d'accorder une autonomie importante :

- auditer `CLAUDE.md`, `.claude/`, `AGENTS.md` et `.mcp.json` ;
- réduire les secrets présents dans l'environnement ;
- valider les hooks/plugins/skills ;
- garder les actions sensibles derrière un contrôle approprié ;
- s'assurer que tests/CI permettent de détecter les régressions.

---

## « IA hacker » et outils offensifs commerciaux

Un produit qui promet un pentest ou une exploitation « one-click » doit être évalué comme tout outil de sécurité sensible :

- identité de l'éditeur ;
- conditions légales d'usage ;
- données envoyées ;
- permissions demandées ;
- maintenance et advisories ;
- possibilité de l'exécuter dans une sandbox ;
- journalisation et contrôle humain.

N'utilisez pas un outil offensif sur une cible sans autorisation explicite.

---

## Signaux SOC utiles

Au lieu de chercher une « signature IA » peu fiable, surveillez les **comportements** :

- utilisation anormale de credentials ;
- commandes ou écritures hors périmètre habituel ;
- création soudaine de dépendances/outils ;
- sorties réseau nouvelles ;
- demandes transactionnelles contournant les procédures ;
- changements d'instructions, hooks, MCP ou policies sans revue.

L'objectif est de détecter une action risquée, pas de prouver qu'un texte ou un script a été généré par IA.

---

## Employer l'IA pour la défense

| Tâche | Contribution utile de l'assistant | Contrôle indépendant |
|---|---|---|
| Triage SOC | Synthétiser des événements et proposer des hypothèses | Journaux originaux et décision de l'analyste |
| Revue de code | Expliquer un diagnostic et proposer un correctif | [Analyse statique](../chapitre-13-outils-economies/outils-complementaires.md#validation-analyse-statique-et-migrations), tests et revue du diff |
| Incident | Préparer une chronologie et un compte rendu | Horodatages, sources et qualification des faits |
| Runbook | Préparer une action dans un périmètre borné | Autorisation, validation métier et retour arrière |

Les tickets, logs et alertes peuvent eux-mêmes contenir du texte contrôlé par un attaquant. Les transmettre à un assistant SOC ne les rend pas fiables. Réduisez les données envoyées et gardez les changements de droits, révocations, communications et opérations sensibles sous un contrôle approprié.

## Priorisation locale

Ne classez pas « phishing IA = critique » ou « prompt injection = moyen » sans threat model.

Évaluez plutôt :

1. quels actifs sont accessibles ;
2. quelles permissions l'agent possède ;
3. quelles données sont sensibles ;
4. quelles sources externes peuvent influencer le workflow ;
5. quels contrôles de détection et récupération existent.

---

## Mise à jour des référentiels — octobre 2026

Les guides OWASP **LLM 2026** et **agentique 2026** répondent à des périmètres distincts. Ne recopiez pas les identifiants ou rangs d'une édition 2025 comme s'ils étaient ceux de 2026. Fixez l'édition dans votre registre de contrôles et vérifiez le mapping lors d'une mise à jour.

La [synthèse ANSSI de février 2026](https://cyber.gouv.fr/actualites/synthese-de-la-menace-sur-lia-generative-face-aux-attaques-informatiques/) traite à la fois des usages offensifs et des attaques contre les systèmes IA. Ses constats doivent rester datés ; un rapport fournisseur décrivant une opération fortement automatisée ne prouve pas une autonomie complète de toutes les attaques.

Pour vos applications, vérifiez aussi mémoire persistante, séparation des tenants, traitement des sorties générées, abus de budget et retries. La [matrice des contrôles](matrice-controles-menaces.md) et les [tests défensifs](tests-securite.md) traduisent ces risques en preuves attendues.

## Références vérifiées le 4 octobre 2026

- [OWASP — LLM 2026](https://genai.owasp.org/resource/owasp-genai-llm-top-10-2026/)
- [OWASP — agents 2026](https://genai.owasp.org/resource/owasp-top-10-for-agentic-applications-for-2026/)
- [ANSSI / BSI — principes Zero Trust pour les systèmes LLM](https://cyber.gouv.fr/nous-connaitre/publications/publications-internationales/design-principles-for-llm-based-systems-with-zero-trust/)
- [Claude Code — Security](https://code.claude.com/docs/en/security)

### Autres repères

- [Anthropic Threat Intelligence](https://www.anthropic.com/threat-intelligence)
- [OWASP GenAI Security Project](https://genai.owasp.org/)
- [MITRE ATLAS](https://atlas.mitre.org/)
- [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)
- [CISA AI](https://www.cisa.gov/ai)
- [ENISA Threat Landscape](https://www.enisa.europa.eu/topics/cyber-threats/threat-landscape)
- [ANSSI](https://cyber.gouv.fr/)

## Prochaine étape

Poursuivez avec **[Sécuriser les agents IA](securite-agents.md)**, la page suivante dans le menu.
