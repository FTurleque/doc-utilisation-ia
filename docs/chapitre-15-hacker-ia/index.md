# Hacker & IA — Menaces, défense et réponse

Ce chapitre traite des usages malveillants ou détournés de l'IA **uniquement sous l'angle défensif** : comprendre les menaces documentées, réduire l'exposition, détecter les incidents et organiser la réponse.

Claude Code étant l'agent principal du dépôt, une attention particulière est portée aux risques des agents de développement : instructions non fiables, MCP, permissions, secrets, supply chain et actions automatisées.

**Audit des sources et du chapitre : 4 octobre 2026.** Les références vérifiées comprennent les éditions OWASP LLM et agentique 2026, les publications ANSSI, la documentation de sécurité Claude Code et NIST SP 800-61 Rev. 3. Les recommandations et scénarios proposés ici sont à adapter au périmètre réel de l'organisation.

---

## Pages du chapitre

| Page | Description |
|---|---|
| [Panorama IA et hacking](page-principale.md) | Menaces documentées, limites de l'attribution et contrôles défensifs |
| [Sécuriser les agents IA](securite-agents.md) | Frontières de confiance, modes de permission, sandbox, MCP, mémoire et délégation |
| [Études de cas 2024-2026](etudes-de-cas-2024-2026.md) | Cas et tendances sourcés, avec distinction entre observation et extrapolation |
| [Playbook incident IA](playbook-incident-ia.md) | Détection, confinement, investigation, rotation des secrets et communication |
| [KPI & SOC pour menaces IA](kpi-soc-ia.md) | Indicateurs à adapter au contexte réel de l'organisation |
| [Exercices tabletop IA](exercices-tabletop-ia.md) | Exercices défensifs pour équipes sécurité, IT, métiers et direction |
| [Cas sectoriels](cas-sectoriels-ia.md) | Contraintes différentes selon secteur et données |
| [Matrice menaces → contrôles](matrice-controles-menaces.md) | Cartographie de contrôles et preuves attendues |
| [Checklist audit interne IA](checklist-audit-interne.md) | Revue périodique de gouvernance, accès et sécurité |
| [Tests de sécurité et preuves](tests-securite.md) | Tests de refus, tâches autorisées, cloisonnement, révocation et non-régression |
| [Modèles incident & post-mortem](modeles-fiches-incident.md) | Templates de documentation d'incident |
| [Plan 90 jours](plan-90-jours.md) | Plan de montée en maturité à adapter à l'organisation |
| [Comparaison IDE](comparaison.md) | Différences de surface d'attaque et de contrôle VS Code / JetBrains |

---

## Sources prioritaires

- [OWASP — LLM 2026](https://genai.owasp.org/resource/owasp-genai-llm-top-10-2026/) et [agents 2026](https://genai.owasp.org/resource/owasp-top-10-for-agentic-applications-for-2026/) — consultés le 2026-10-04.
- [ANSSI — synthèse de la menace IA, février 2026](https://cyber.gouv.fr/actualites/synthese-de-la-menace-sur-lia-generative-face-aux-attaques-informatiques/) — consulté le 2026-10-04.
- [NIST — réponse aux incidents, SP 800-61 Rev. 3](https://csrc.nist.gov/pubs/sp/800/61/r3/final) — consulté le 2026-10-04.
- [Claude Code — sécurité](https://code.claude.com/docs/en/security) — consulté le 2026-10-04.

Commencez par des sources primaires et des référentiels :

- [OWASP GenAI Security Project](https://genai.owasp.org/)
- [MITRE ATLAS](https://atlas.mitre.org/)
- [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)
- [CISA — AI](https://www.cisa.gov/ai)
- [ENISA Threat Landscape](https://www.enisa.europa.eu/topics/cyber-threats/threat-landscape)
- [ANSSI](https://cyber.gouv.fr/)
- [Anthropic Threat Intelligence](https://www.anthropic.com/threat-intelligence)

Le rapport Anthropic de septembre 2026 décrit des opérations malveillantes détectées et interrompues sur sa plateforme. Il est utile comme **source de cas réels**, mais Anthropic précise qu'il présente les activités les plus notables/novatrices identifiées, pas un échantillon représentatif de l'ensemble des usages malveillants de l'IA.

---

## Ce que ce chapitre ne doit pas faire

- transformer un cas médiatisé en probabilité universelle ;
- attribuer une attaque à un acteur sans source fiable ;
- présenter une démonstration offensive comme un tutoriel exploitable ;
- confondre capacités d'un modèle et preuve d'une compromission réelle ;
- donner un score de maturité ou de risque comme vérité objective sans méthodologie définie.

---

## Modèle de lecture défensif

Pour chaque cas :

```text
source
→ fait observé
→ niveau d'incertitude
→ actifs exposés
→ contrôles préventifs
→ détection
→ réponse
→ preuve que le contrôle fonctionne
```

Cette structure évite les récits sensationnalistes et produit des actions vérifiables.

---

## Risques spécifiques aux agents de code

Les agents modernes ajoutent des surfaces nouvelles :

- lecture de contenu non fiable ;
- exécution de commandes ;
- accès à des secrets du shell ;
- MCP et outils externes ;
- hooks/skills/plugins ;
- modification de plusieurs fichiers ;
- interaction avec Git, CI, cloud ou tickets.

Le contrôle central reste le **moindre privilège**, complété par validation indépendante, traçabilité et segmentation des accès.

---

## Prochaine étape

Poursuivez avec **[IA et hacking](page-principale.md)**, la page suivante dans le menu.
