# Cas sectoriels IA et cybersécurité

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span>

Les mêmes techniques peuvent produire des impacts très différents selon le secteur. Cette page aide à **adapter le threat model** ; elle ne désigne pas une « menace dominante » universelle pour chaque industrie.

---

## Questions communes

Avant toute priorisation sectorielle :

1. quelles données sont sensibles ?
2. quels comptes ou systèmes peuvent provoquer un impact majeur ?
3. quels agents IA ont accès à ces actifs ?
4. quelles actions nécessitent une validation humaine indépendante ?
5. quels journaux permettent de reconstruire un incident ?
6. quelles obligations métier/réglementaires s'appliquent ?

---

## Finance

Scénarios à tester :

- fraude au paiement ou changement de coordonnées ;
- compromission de comptes à privilèges ;
- fuite de données client ou transactionnelles ;
- agent de code ayant accès à des credentials d'environnement financier.

Contrôles typiques : validation hors bande, séparation des rôles, MFA résistante au phishing, limites transactionnelles, revue des accès et journalisation.

---

## Santé

Points de vigilance :

- données de santé ;
- disponibilité des systèmes de soin ;
- comptes partagés/terminaux cliniques ;
- fournisseurs et intégrations multiples ;
- agents utilisés sur des données ou configurations sensibles.

La priorité doit rester la confidentialité **et** la continuité des soins ; un contrôle de sécurité qui bloque un workflow clinique critique doit être évalué avec les équipes métier.

---

## Industrie / OT

Principes :

- séparer IT/OT ;
- ne pas donner à un agent généraliste un accès direct non borné aux systèmes de contrôle ;
- utiliser bastions, procédures de changement et validation humaine ;
- tester les scénarios de reprise ;
- surveiller les accès distants fournisseurs/maintenance.

---

## SaaS / Tech

Surfaces particulièrement pertinentes :

- dépôts source ;
- CI/CD ;
- secrets cloud ;
- packages et registries ;
- `.mcp.json`, skills, plugins et hooks ;
- agents avec droits Git/GitHub/cloud.

Contrôles : branch protection, secret scanning, SCA, review, Quality Gates, credentials courts/scopés, registre des MCP et outils autorisés.

---

## Secteur public

Selon l'organisme :

- usurpation de communication officielle ;
- campagnes de désinformation ;
- données sensibles/citoyens ;
- systèmes critiques ;
- contraintes de souveraineté/hébergement ;
- comptes à forte visibilité publique.

Les procédures de communication de crise et d'authentification des messages officiels doivent être testées avant incident.

---

## Mesurer ce qui importe au secteur

Ne copiez pas un KPI générique. Exemples de mesures possibles :

| Secteur | Mesure utile potentielle |
|---|---|
| Finance | exceptions transactionnelles et validations hors bande |
| Santé | accès anormaux aux données sensibles + continuité de service |
| OT | changements non autorisés et accès distants |
| SaaS | secrets/dépendances/MCP non approuvés en CI |
| Public | délai de détection et correction d'une usurpation officielle |

Les seuils viennent des objectifs de risque et SLA internes.

---

## Sources

- [OWASP GenAI Security Project](https://genai.owasp.org/)
- [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)
- [MITRE ATLAS](https://atlas.mitre.org/)
- [CISA AI](https://www.cisa.gov/ai)
- [ENISA Threat Landscape](https://www.enisa.europa.eu/topics/cyber-threats/threat-landscape)
- [ANSSI](https://cyber.gouv.fr/)

## Prochaine étape

Poursuivez avec **[Matrice menaces IA -> contrôles](matrice-controles-menaces.md)**, la page suivante dans le menu.
