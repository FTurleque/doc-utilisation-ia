# Cas sectoriels IA et cybersécurité

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span>

Chaque secteur présente des surfaces d'attaque différentes. Cette page propose des cas d'école concrets et des priorités défensives adaptées à plusieurs environnements métiers.

---

## Vue d'ensemble par secteur

| Secteur | Menace IA dominante | Impact principal | Priorité défensive |
|---|---|---|---|
| Banque/Finance | Fraude social engineering + deepfake | Perte financière directe | Validation hors bande et contrôle transactionnel |
| Santé | Phishing ciblé + fuite de données | Atteinte confidentialité et soins | Protection données patient + continuité |
| Industrie/OT | Ingénierie sociale + compromission IT/OT | Arrêt de production | Segmentation et procédures OT strictes |
| SaaS/Tech | Prompt poisoning + supply chain | Compromission produit/client | Gouvernance agentique et sécurité CI/CD |
| Secteur public | Désinformation + usurpation | Perte de confiance publique | Communication de crise et contrôle identité |

---

## Banque et finance

### Cas d'école

Un faux ordre de virement est déclenché via appel vocal crédible puis email de confirmation.

### Défenses prioritaires

- Double validation indépendante
- Seuils de transaction avec approbation multi-personnes
- Journalisation et revue quotidienne des exceptions
- Formation spécifique des équipes trésorerie

### KPI recommandé

- Taux de transactions urgentes bloquées pour vérification
- Temps moyen de validation hors bande

---

## Santé

### Cas d'école

Campagne de phishing ciblant des personnels administratifs pour accéder à des données sensibles.

### Défenses prioritaires

- Durcissement accès EHR et IAM
- Segmentation des accès selon rôle
- Simulation phishing orientée confidentialité patient
- Plan de continuité des opérations de soin

### KPI recommandé

- Taux d'incidents détectés avant accès aux dossiers sensibles
- Délai de confinement sur comptes soignants à privilège

---

## Industrie / OT

### Cas d'école

Ingénierie sociale contre équipes maintenance avec demandes de changement “urgent” de configuration.

### Défenses prioritaires

- Séparation IT/OT et bastion d'administration
- Processus de changement OT avec validation renforcée
- Monitoring des accès distants maintenance
- Exercices de crise intégrant arrêt/reprise d'activité

### KPI recommandé

- Nombre de changements OT refusés pour non-conformité
- Temps de détection d'anomalies sur accès maintenance

---

## SaaS / Tech

### Cas d'école

Empoisonnement de contexte des assistants de code puis proposition de dépendance risquée intégrée en CI.

### Défenses prioritaires

- Revue obligatoire des fichiers de gouvernance IA
- SAST/SCA + secrets scanning bloquants
- Permissions minimales des agents en environnement dev
- Signature/provenance des artefacts critiques

### KPI recommandé

- Taux de PR bloquées pour dépendance non approuvée
- Taux de revue humaine sur commits assistés IA critiques

---

## Secteur public

### Cas d'école

Campagne de désinformation ciblée combinant contenus générés et usurpation de communication officielle.

### Défenses prioritaires

- Chaîne de validation de la communication institutionnelle
- Procédure de démenti rapide multi-canal
- Renforcement de l'authentification des porte-parole
- Coordination cyber + communication de crise

### KPI recommandé

- Délai de détection d'un contenu usurpé
- Délai de diffusion du message correctif officiel

---

## Matrice de priorisation commune

| Niveau maturité | Priorité 1 | Priorité 2 | Priorité 3 |
|---|---|---|---|
| Début de programme | MFA fort + validation hors bande | Formation ciblée fonctions exposées | Journalisation consolidée |
| Intermédiaire | KPI SOC dédiés IA | Exercices tabletop trimestriels | Durcissement gouvernance agents |
| Avancé | Chasse proactive menaces IA | Tests red team dédiés IA | Pilotage risque par secteur |

---

## Sources et provenance

- [ENISA Threat Landscape](https://www.enisa.europa.eu/topics/cyber-threats/threat-landscape)
- [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)
- [CISA AI](https://www.cisa.gov/ai)
- [ANSSI](https://www.ssi.gouv.fr/)
- [MITRE ATLAS](https://atlas.mitre.org/)
- [OWASP Top 10 for LLM Applications](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
- [Europol Reports](https://www.europol.europa.eu/publications-events/main-reports)

---

## Prochaine étape

**[Matrice menaces IA -> contrôles](matrice-controles-menaces.md)** : relie les risques sectoriels à des contrôles concrets, mesurables et auditable.

Concepts clés couverts :

- **Risque sectoriel** — même menace, impact différent selon métier
- **Priorités défensives** — contrôles adaptés au contexte
- **KPI par secteur** — pilotage pertinent et actionnable
- **Maturité progressive** — route d'amélioration réaliste
