# Études de cas IA et cyberattaques (2024-2026)

<span class="badge-expert">Expert</span> <span class="badge-intermediate">Intermédiaire</span>

Cette page regroupe des cas et tendances documentés entre 2024 et 2026 autour de l'usage de l'IA dans les cybermenaces. L'objectif est de transformer ces retours en décisions défensives applicables immédiatement.

---

## Méthode de lecture

- Un cas n'est utile que si tu en tires des contrôles concrets
- Les exemples ci-dessous sont orientés défense et réduction du risque
- Les sources sont indiquées explicitement pour permettre la vérification

!!! info "Périmètre"
    Certains cas sont des tendances consolidées (rapports annuels) plutôt qu'un incident unique. Le but est opérationnel: identifier ce qui se reproduit et comment s'en protéger.

---

## Cas 1 - Phishing hautement personnalisé par IA

### Ce qui est observé

Les campagnes de phishing exploitent l'IA pour produire rapidement des variantes linguistiques crédibles, adaptées au poste, au secteur et au contexte de la cible.

### Pourquoi c'est efficace

- Meilleure qualité rédactionnelle
- Personnalisation à grande échelle
- Réduction des signaux classiques de fraude (orthographe, ton incohérent)

### Défense recommandée

| Horizon | Action prioritaire |
|---|---|
| 7 jours | Exiger MFA phishing-resistant sur comptes critiques |
| 30 jours | Simulations ciblées par fonction (finance, RH, support, dev) |
| 90 jours | Corrélation SOC entre emails, identités et endpoints |

---

## Cas 2 - Fraude vocale/deepfake sur chaîne de validation

### Ce qui est observé

Les attaques combinent un appel vocal crédible et une demande urgente (virement, accès, changement de RIB, transfert de secret).

### Point faible exploité

La procédure humaine: urgence, hiérarchie, et validation monocanal.

### Défense recommandée

- Validation hors bande obligatoire (second canal connu)
- Règle "zéro exception" sur les paiements urgents
- Code phrase d'équipe pour opérations sensibles
- Journalisation des demandes atypiques avec revue hebdomadaire

!!! warning "Risque métier"
    Ce type d'attaque vise souvent la perte financière immédiate et la rupture de confiance interne.

---

## Cas 3 - Empoisonnement de contexte des assistants de code

### Ce qui est observé

Des instructions trompeuses sont introduites dans des fichiers de documentation, commentaires, prompts ou artefacts du dépôt pour influencer un agent IA.

### Effets possibles

- Suggestions non conformes aux politiques internes
- Exposition de secrets dans les sorties
- Modifications de code hors périmètre attendu

### Défense recommandée

| Contrôle | Mise en place pratique |
|---|---|
| Revue des fichiers d'instructions | Pull request obligatoire sur les fichiers de gouvernance IA |
| Permissions minimales | Interdire les actions terminales sensibles sans confirmation |
| Audit des actions agentiques | Conserver logs détaillés des opérations automatiques |
| Garde-fou pipeline | Bloquer merge si secret détecté ou dépendance non approuvée |

---

## Cas 4 - Supply chain accélérée par suggestions IA

### Ce qui est observé

Des dépendances suggérées automatiquement peuvent être obsolètes, peu maintenues ou malveillantes, puis passer en CI/CD si les garde-fous sont insuffisants.

### Défense recommandée

- Allowlist de packages par langage
- Validation SCA bloquante en CI
- Vérification mainteneur et provenance
- Réexamen humain des changements de dépendances à risque

---

## Cas 5 - Industrialisation de la reconnaissance ouverte (OSINT)

### Ce qui est observé

L'IA facilite le tri, la synthèse et la priorisation d'informations publiques pour construire des prétextes très crédibles.

### Défense recommandée

- Réduire l'exposition d'informations sensibles publiques (site, réseaux, offres d'emploi)
- Politique claire de communication externe sur l'infra et les rôles critiques
- Sensibilisation des fonctions exposées (dirigeants, assistanat, finance, support)

---

## Exemples opérationnels par équipe

=== "Équipe Dev"
    - Signaler toute suggestion de dépendance inconnue avant installation
    - Bloquer les merges sans SAST/SCA et secrets scanning
    - Exiger revue humaine pour les changements générés en masse

=== "Équipe SecOps / SOC"
    - Créer des règles de détection pour vagues de phishing personnalisées
    - Surveiller les écritures anormales d'agents dans les dépôts
    - Corréler alertes identité + messagerie + endpoint

---

## Matrice impact x probabilité (priorisation)

| Menace | Probabilité | Impact | Priorité |
|---|---|---|---|
| Phishing personnalisé IA | Élevée | Élevé | Critique |
| Deepfake vocal pour fraude | Moyenne à élevée | Élevé | Critique |
| Empoisonnement de contexte agent | Moyenne | Élevé | Haute |
| Supply chain via dépendance suggérée | Moyenne | Élevé | Haute |
| Désinformation interne ciblée | Moyenne | Moyen à élevé | Moyenne |

---

## Avant / Après la mise en place des protections

| Menace | Avant protection | Après protection |
|---|---|---|
| Phishing IA | Messages personnalisés passés inaperçus, taux de clic non mesuré | Formation ciblée + détection messagerie, réduction visible du taux de compromission |
| Deepfake vocal | Virement approuvé sur demande orale urgent | Procédure de confirmation multi-canal, zéro validation sur canal unique |
| Empoisonnement de contexte | Fichier d'instructions modifié non détecté | Revue periódique obligatoire des fichiers `.github/`, alertes sur modifications |
| Supply chain | Dépendance malveillante intégrée à la base de code | SCA bloquante active, aucun merge sans validation provenance |
| OSINT amplifié | Exposition des données publiques non identifiée | Audit surface d'exposition, minimisation des données publiées |

---

## Sources et provenance

| Domaine | Source |
|---|---|
| Risques LLM applicatifs | [OWASP Top 10 for LLM Applications](https://owasp.org/www-project-top-10-for-large-language-model-applications/) |
| Techniques adverses IA | [MITRE ATLAS](https://atlas.mitre.org/) |
| Tendances de menaces en Europe | [ENISA Threat Landscape](https://www.enisa.europa.eu/topics/cyber-threats/threat-landscape) |
| Recommandations cyber et IA | [CISA AI](https://www.cisa.gov/ai) |
| Gouvernance risque IA | [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework) |
| Cybercriminalité organisée | [Europol Reports](https://www.europol.europa.eu/publications-events/main-reports) |
| Sécurité code et agents | [GitHub Security Blog - Secure Code Game](https://github.blog/security/hack-the-ai-agent-build-agentic-ai-security-skills-with-the-github-secure-code-game/) |
| Vulgarisation sectorielle complémentaire | [Google Cloud Q&A CISO](https://cloud.google.com/transform/truths-about-ai-hacking-every-ciso-needs-to-know-qa?hl=en), [OPSWAT](https://french.opswat.com/blog/ai-hacking-how-hackers-use-artificial-intelligence-in-cyberattacks) |

!!! tip "Comment exploiter ces sources"
    Utilise les référentiels (OWASP, NIST, MITRE, CISA, ENISA) pour définir tes contrôles, puis utilise les articles sectoriels pour sensibiliser les équipes non techniques.

---

## Prochaine étape

**[Playbook incident IA](playbook-incident-ia.md)** : passe d'une analyse de menaces à un plan d'action concret utilisable en situation de crise.

Concepts clés couverts :

- **Priorisation par risque** — concentrer les efforts sur les menaces à impact élevé
- **Contrôles défensifs mesurables** — actions concrètes à 7, 30 et 90 jours
- **Détection corrélée** — identité, messagerie, endpoint et dépôt
- **Gouvernance des agents IA** — permissions, revue et auditabilité
