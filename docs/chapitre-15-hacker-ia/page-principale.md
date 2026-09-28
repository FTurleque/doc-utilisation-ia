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

## Priorisation locale

Ne classez pas « phishing IA = critique » ou « prompt injection = moyen » sans threat model.

Évaluez plutôt :

1. quels actifs sont accessibles ;
2. quelles permissions l'agent possède ;
3. quelles données sont sensibles ;
4. quelles sources externes peuvent influencer le workflow ;
5. quels contrôles de détection et récupération existent.

---

## Sources prioritaires

- [Anthropic Threat Intelligence](https://www.anthropic.com/threat-intelligence)
- [OWASP GenAI Security Project](https://genai.owasp.org/)
- [MITRE ATLAS](https://atlas.mitre.org/)
- [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)
- [CISA AI](https://www.cisa.gov/ai)
- [ENISA Threat Landscape](https://www.enisa.europa.eu/topics/cyber-threats/threat-landscape)
- [ANSSI](https://cyber.gouv.fr/)

## Prochaine étape

**[Études de cas 2024-2026](etudes-de-cas-2024-2026.md)** : relier des cas documentés à des contrôles défensifs vérifiables.