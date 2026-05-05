# Playbook incident IA - Détection, réponse, communication

<span class="badge-expert">Expert</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span>

Ce playbook fournit une procédure actionnable pour répondre à un incident impliquant l'IA: phishing assisté, deepfake, compromission via agent de code, fuite de données dans un workflow LLM.

---

## Objectif et conditions d'activation

Active ce playbook dès qu'un signal implique un usage probable de l'IA dans l'attaque ou un composant IA interne compromis.

### Déclencheurs typiques

- Demande urgente inhabituelle avec forte vraisemblance linguistique
- Variantes massives d'emails quasi identiques en peu de temps
- Activité agentique anormale dans les dépôts ou pipelines
- Indice de fuite de secrets via prompt, sortie ou artefact

!!! danger "Réflexe clé"
    En cas de doute, traite l'événement comme incident confirmé pendant la phase de triage initial. Le coût d'un faux positif est souvent inférieur au coût d'une fraude réussie.

---

## Rôles et responsabilités (RACI simplifié)

| Activité | Incident Manager | SOC/SecOps | IT Ops | Dev Lead | Juridique/Comms |
|---|---|---|---|---|---|
| Qualification incident | A | R | C | C | I |
| Containment technique | A | R | R | C | I |
| Analyse forensique | C | R | C | C | I |
| Décision de communication | A | C | I | I | R |
| Retour d'expérience | A | R | C | R | C |

Légende: R = Responsable, A = Autorité finale, C = Consulté, I = Informé.

---

## Chronologie opérationnelle

### T+0 à T+15 min - Qualification

- Ouvrir ticket majeur et horodatage initial
- Isoler la portée: identité, endpoint, messagerie, dépôt, SI critique
- Capturer les preuves volatiles disponibles sans altération
- Déterminer le niveau de sévérité initial

### T+15 à T+60 min - Confinement

- Révoquer sessions et tokens potentiellement compromis
- Forcer MFA reset sur comptes à risque
- Bloquer IOC/IOA identifiés (domaines, URL, hash, compte expéditeur)
- Geler temporairement actions agentiques non essentielles

### T+1h à T+4h - Investigation

- Corréler logs IAM, email gateway, EDR, SCM/CI
- Vérifier les exfiltrations probables et artefacts générés
- Évaluer impact métier et obligations réglementaires
- Préparer communication interne de crise

### T+4h à T+24h - Remédiation

- Corriger la cause racine (process, config, permission, formation)
- Restaurer les systèmes selon ordre de criticité
- Déployer règles de détection supplémentaires
- Revalider contrôles clés avant reprise complète

### T+24h à T+7j - Retour d'expérience

- Post-mortem sans blâme
- Plan d'actions avec responsables et échéances
- Mise à jour du playbook et des exercices tabletop
- Reporting direction avec indicateurs d'efficacité

---

## Runbooks ciblés par type d'incident

### A. Phishing/demande urgente assisté IA

- Vérifier identité de l'émetteur hors bande
- Bloquer campagne et purger boîtes cibles si nécessaire
- Réinitialiser les comptes impactés
- Informer les fonctions exposées (finance, RH, assistanat)

### B. Deepfake voix/vidéo

- Exiger authentification forte de la demande via canal secondaire
- Placer en quarantaine toute instruction financière liée
- Conserver enregistrement et métadonnées pour investigation
- Mettre à jour script de vérification des demandes sensibles

### C. Incident agent de code / prompt poisoning

- Désactiver temporairement l'agent ou restreindre ses permissions
- Auditer les modifications récentes et revert contrôlé si nécessaire
- Scanner secrets, dépendances et commandes exécutées
- Renforcer règles de revue sur fichiers d'instructions

### D. Fuite potentielle de données via IA

- Identifier périmètre des données concernées
- Couper les flux non essentiels vers services externes
- Activer procédure juridique/privacy selon réglementation
- Notifier parties prenantes selon obligations applicables

---

## Checklists prêtes à l'emploi

### Checklist triage

- [ ] Incident ID créé
- [ ] Périmètre initial défini
- [ ] Gravité initiale attribuée
- [ ] Preuves critiques sauvegardées
- [ ] RACI activé

### Checklist containment

- [ ] Sessions/tokens compromis révoqués
- [ ] IOC/IOA bloqués
- [ ] Permissions agents restreintes
- [ ] Pipeline durci temporairement
- [ ] Communication interne de vigilance envoyée

### Checklist remédiation

- [ ] Cause racine validée
- [ ] Correctifs appliqués
- [ ] Détection améliorée
- [ ] Contrôles re-testés
- [ ] Post-mortem planifié

---

## Exemples de messages de communication

### Message interne court (alerte immédiate)

```markdown
Incident sécurité en cours - vigilance renforcée

Un incident impliquant des contenus potentiellement générés par IA est en cours d'analyse.
N'exécutez aucune demande urgente (paiement, accès, secret) sans validation hors bande.
Signalez immédiatement tout message ou appel suspect au SOC.
```

### Message de consigne équipes techniques

```markdown
Mesures temporaires de sécurité

- Revue humaine obligatoire sur toute modification sensible.
- Installation de nouvelles dépendances suspendue sans validation SecOps.
- Actions agentiques à privilège élevé temporairement désactivées.
```

---

## Adaptation par IDE

=== "IntelliJ IDEA"
    - Vérifier les plugins actifs et désactiver temporairement ceux non essentiels
    - Renforcer les quality gates côté CI pour tout commit assisté IA
    - Forcer revue pair sur changements multi-fichiers sensibles

=== "Visual Studio Code"
    - Réviser les permissions des extensions et agents connectés
    - Restreindre les actions terminales automatiques
    - Centraliser les paramètres sécurité dans le workspace d'équipe

---

## KPI de pilotage post-incident

| Indicateur | Cible |
|---|---|
| Temps de détection (MTTD) | Réduction continue trimestre sur trimestre |
| Temps de confinement (MTTC) | < 60 min sur incidents majeurs |
| Taux d'incidents liés à validation monocanal | Tendre vers 0 |
| Taux de faux positifs critiques | Maîtrisé et documenté |
| Taux de conformité des revues humaines | 100% sur périmètre critique |

---

## Cadre légal minimal (UE/FR) à vérifier en incident

| Sujet | Question opérationnelle |
|---|---|
| Données personnelles | Des données personnelles ont-elles été exposées dans prompts, logs ou artefacts ? |
| Notification | Une notification à l'autorité compétente est-elle requise selon la nature de l'incident ? |
| Traçabilité | Les décisions, horodatages et actions sont-ils correctement journalisés ? |
| Tiers externes | Un fournisseur IA externe est-il impliqué contractuellement dans la chaîne d'incident ? |
| Communication | Le message externe est-il aligné entre technique, juridique et direction ? |

!!! warning "Bon réflexe"
    En cas d'incident impliquant des données sensibles, engage rapidement les fonctions juridique, conformité et protection des données en parallèle du SOC.

---

## Sources et provenance

- [CISA AI](https://www.cisa.gov/ai)
- [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)
- [OWASP Top 10 for LLM Applications](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
- [MITRE ATLAS](https://atlas.mitre.org/)
- [ANSSI](https://www.ssi.gouv.fr/)
- [ENISA Threat Landscape](https://www.enisa.europa.eu/topics/cyber-threats/threat-landscape)
- [GitHub Security Blog - Secure Code Game](https://github.blog/security/hack-the-ai-agent-build-agentic-ai-security-skills-with-the-github-secure-code-game/)

!!! info "Positionnement"
    Ce playbook est un gabarit de réponse défensive. Adapte-le à tes obligations légales, à ton secteur et à ton organisation interne (astreinte, RSSI, DPO, communication de crise).

---

## Prochaine étape

**[KPI & SOC pour menaces IA](kpi-soc-ia.md)** : transforme la réponse incident en pilotage mesurable et amélioration continue.

Concepts clés couverts :

- **RACI incident** — qui décide, qui exécute, qui valide
- **Confinement rapide** — réduire l'impact dans la première heure
- **Remédiation durable** — corriger causes racines et pas seulement les symptômes
- **Mesure de performance** — piloter l'amélioration avec des KPI concrets
