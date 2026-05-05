# KPI & SOC pour menaces IA - Détection et pilotage

<span class="badge-expert">Expert</span> <span class="badge-intermediate">Intermédiaire</span>

Cette page propose un cadre de pilotage SOC orienté menaces liées à l'IA: indicateurs, objectifs, règles de détection et exemples de tableaux de bord.

---

## Pourquoi des KPI dédiés IA

Les incidents “assistés IA” se distinguent par leur vitesse, leur volume et leur personnalisation. Sans indicateurs dédiés, ils se noient dans le bruit opérationnel.

!!! info "But"
    Le but n'est pas de créer plus de métriques, mais d'avoir des métriques qui changent les décisions de triage, de confinement et de remédiation.

---

## KPI de base (minimum viable)

| KPI | Définition | Cible recommandée | Fréquence |
|---|---|---|---|
| MTTD IA | Temps moyen de détection d'un incident avec composante IA | Réduction continue trimestrielle | Hebdo + mensuel |
| MTTC IA | Temps moyen de confinement | < 60 min sur incidents majeurs | Hebdo + mensuel |
| Taux de phishing IA détecté | Campagnes IA détectées / campagnes IA reçues | > 90% à maturité | Mensuel |
| Taux de validation hors bande appliquée | Contrôles critiques validés hors canal initial | 100% finance/rh/it sensible | Mensuel |
| Taux de commits assistés IA avec revue humaine | Commits signalés IA revus par pair | 100% périmètre critique | Mensuel |
| Taux de secrets exposés dans artefacts IA | Secrets détectés dans prompts/sorties/logs | Tendre vers 0 | Hebdo |

---

## KPI avancés (maturité)

| KPI | Utilité opérationnelle | Seuil d'alerte |
|---|---|---|
| Taux d'incidents “urgents hiérarchiques” | Mesurer la pression social engineering | Hausse > 20% vs moyenne 3 mois |
| Dérive des permissions agents | Détecter élargissement de privilèges non maîtrisé | Toute permission critique non approuvée |
| Taux de dépendances non approuvées proposées | Mesurer risque supply chain IA | > 0 en branche protégée |
| FPR/FNR détection phishing IA | Évaluer qualité des règles SOC | FPR > 10% ou FNR estimé en hausse |
| Temps de corrélation multi-sources | Vitesse d'enquête SOC | > 30 min sur cas critique |

---

## Détections SOC recommandées

### Détection messagerie / identité

- Pic de messages hautement personnalisés vers fonctions sensibles
- Similarité forte de messages avec variations mineures
- Tentatives MFA anormales après campagne email

### Détection endpoint / dépôt

- Commandes ou modifications massives hors habitudes de l'équipe
- Écriture agentique sur fichiers de gouvernance sans validation
- Ajout soudain de dépendances non référencées

### Détection comportementale

- Demandes de validation urgente en dehors des canaux habituels
- Changement brutal de style d'interaction d'un compte interne
- Multiples tentatives de contournement d'une procédure de contrôle

---

## Exemples de tableaux de bord

### Dashboard 1 - Exécutif (CISO / Direction)

| Vue | Contenu |
|---|---|
| Résumé risque | Incidents IA ouverts/clos, gravité, impact métier |
| Vitesse de réponse | MTTD, MTTC, tendance 90 jours |
| Exposition | Fonctions les plus ciblées, canaux les plus utilisés |
| Décisions | Plan d'actions, écarts critiques, budget sécurité |

### Dashboard 2 - SOC Opérationnel

| Vue | Contenu |
|---|---|
| Alertes prioritaires | Top alertes IA par sévérité |
| Corrélations clés | Identité + mail + endpoint + SCM |
| Qualité détection | Faux positifs, couverture règles, lacunes |
| Réponse | Incidents en cours, état confinement, owner |

### Dashboard 3 - DevSecOps

| Vue | Contenu |
|---|---|
| Gouvernance agentique | Permissions, logs d'actions, exceptions |
| Supply chain | Dépendances proposées/refusées/approuvées |
| Qualité code généré | Vulnérabilités SAST/SCA issues de code IA |
| Conformité process | Revue humaine sur périmètre critique |

---

## Exemple de seuils pragmatiques

| Indicateur | Vert | Orange | Rouge |
|---|---|---|---|
| MTTD IA | < 20 min | 20-60 min | > 60 min |
| MTTC IA | < 45 min | 45-90 min | > 90 min |
| Taux validation hors bande | >= 98% | 95-97% | < 95% |
| Secrets exposés (hebdo) | 0 | 1 | >= 2 |
| Dépendances non approuvées en PR | 0 | 1 | >= 2 |

!!! warning "Attention"
    Les seuils doivent être adaptés à la taille de l'organisation, aux ressources SOC et au niveau de criticité métier.

---

## Mise en place en 30 jours

1. Semaine 1: définir 6 KPI de base et les propriétaires.
2. Semaine 2: brancher les sources de logs et normaliser les événements.
3. Semaine 3: construire dashboard SOC + dashboard exécutif.
4. Semaine 4: lancer revue de pilotage, ajuster seuils et runbooks.

---

## Sources et provenance

- [CISA AI](https://www.cisa.gov/ai)
- [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)
- [MITRE ATLAS](https://atlas.mitre.org/)
- [ENISA Threat Landscape](https://www.enisa.europa.eu/topics/cyber-threats/threat-landscape)
- [OWASP Top 10 for LLM Applications](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
- [ANSSI](https://www.ssi.gouv.fr/)

---

## Avant / Après la mise en place du pilotage SOC IA

| Critère | Sans KPI IA | Avec KPI IA |
|---|---|---|
| Visibilité incident | Incidents «IA» noyés dans le bruit opérationnel | MTTD et MTTC mesurés, incidents identifiés et tracés |
| Réponse phishing IA | Temps de triage long, actions manuelles | Règles de détection actives, confinement en < 60 min |
| Supply chain | Dépendances non approuvées non détectées | Alerte immédiate sur toute dépendance non référencée |
| Reporting direction | Bilan informel ou absent | Dashboard exécutif hebdo avec tendances 90 jours |
| Amélioration continue | Actions définies sans métriques | Revue trimestrielle des seuils et des règles SOC |

---

## Prochaine étape

**[Exercices tabletop IA (60/90/120 minutes)](exercices-tabletop-ia.md)** : entraîne tes équipes avec des scénarios réalistes et des critères d'évaluation mesurables.

Concepts clés couverts :

- **Indicateurs actionnables** — métriques qui pilotent les décisions
- **Seuils opérationnels** — déclenchement clair des escalades
- **Corrélation multi-sources** — enquête plus rapide et plus fiable
- **Pilotage continu** — amélioration trimestre après trimestre
