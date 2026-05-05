# Checklist audit interne IA (trimestriel)

<span class="badge-expert">Expert</span> <span class="badge-intermediate">Intermédiaire</span>

Cette checklist aide à auditer de manière régulière la posture de sécurité liée aux usages IA dans les workflows dev, sécurité et métiers.

---

## Guide d'utilisation

- Fréquence recommandée: trimestrielle
- Périmètre: identité, messagerie, endpoints, dépôts, CI/CD, gouvernance IA
- Sortie attendue: plan d'écarts priorisé avec owners et échéances

---

## Grille d'audit (oui/non/partiel)

### 1. Gouvernance et politique

- [ ] Une politique IA formelle est publiée et connue
- [ ] Une règle "no secret in prompt" est appliquée
- [ ] Les rôles et responsabilités incident IA sont définis (RACI)
- [ ] Les exceptions sont tracées et approuvées

### 2. Contrôles identité et accès

- [ ] MFA phishing-resistant déployé pour comptes critiques
- [ ] Revue périodique des privilèges agents/outils
- [ ] Sessions et tokens à durée limitée
- [ ] Procédure de révocation rapide testée

### 3. Contrôles dev et supply chain

- [ ] Revue humaine obligatoire sur périmètre critique
- [ ] SAST/SCA bloquants actifs en CI
- [ ] Dépendances nouvelles soumises à validation
- [ ] Secrets scanning activé sur dépôts et pipelines

### 4. Détection et réponse SOC

- [ ] KPI SOC IA suivis mensuellement
- [ ] Règles de détection dédiées phishing/deepfake/agent
- [ ] Playbook incident IA testé au moins une fois
- [ ] Conservation des preuves et logs conforme

### 5. Formation et exercices

- [ ] Formation ciblée fonctions exposées (finance/RH/support)
- [ ] Exercices tabletop réalisés ce trimestre
- [ ] Debrief documenté et actions suivies
- [ ] Niveau de maturité réévalué périodiquement

### 6. Conformité et communication

- [ ] Procédure de notification réglementaire clarifiée
- [ ] Coordination juridique/comms testée
- [ ] Messages de crise préparés et validés
- [ ] Registre des incidents et post-mortems à jour

---

## Barème de maturité

| Score (items cochés) | Niveau | Interprétation |
|---|---|---|
| 0-8 | Initial | Contrôles fragmentés, risque élevé |
| 9-16 | Structuré | Base en place, écarts significatifs |
| 17-22 | Maîtrisé | Bon niveau, améliorer les délais |
| 23-24 | Avancé | Pilotage robuste et amélioration continue |

---

## Plan de remédiation (template)

```markdown
# Plan de remédiation audit IA - Trimestre QX YYYY

| Écart | Priorité | Action | Owner | Échéance | Preuve attendue |
|---|---|---|---|---|---|
| Exemple: pas de revue permissions agents | Haute | Mettre revue mensuelle + journal | SecOps | 2026-07-15 | Compte-rendu revue |
```

---

## Exemple de synthèse audit (1 page)

| Rubrique | Résultat |
|---|---|
| Score global | 16/24 |
| Niveau | Structuré |
| Principaux risques | Validation hors bande incomplète, logs agents incomplets |
| Décisions prises | Activation MFA forte, revue trimestrielle tabletop |
| Revue suivante | 2026-08-01 |

---

## Sources et provenance

- [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)
- [OWASP Top 10 for LLM Applications](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
- [ANSSI](https://www.ssi.gouv.fr/)
- [CISA AI](https://www.cisa.gov/ai)
- [ENISA Threat Landscape](https://www.enisa.europa.eu/topics/cyber-threats/threat-landscape)

---

## Prochaine étape

**[Modèles de fiches incident et post-mortem IA](modeles-fiches-incident.md)** : opérationnalise l'audit avec des gabarits de documentation standardisés.

Concepts clés couverts :

- **Audit récurrent** — cadence trimestrielle réaliste
- **Maturité mesurable** — score simple et comparable
- **Plan d'écarts** — actions concrètes et suivies
- **Traçabilité** — preuves exploitables en revue interne
