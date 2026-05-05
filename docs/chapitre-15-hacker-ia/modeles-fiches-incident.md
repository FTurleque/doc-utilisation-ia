# Modèles de fiches incident et post-mortem IA

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span>

Cette page fournit des modèles prêts à l'emploi pour documenter un incident lié à l'IA, structurer l'enquête et piloter les actions correctives.

---

## Comment utiliser ces modèles

- Copie le modèle dans ton outil de ticketing ou ton wiki interne
- Remplis les champs obligatoires pendant la crise, pas après
- Évite les récits vagues: privilégie faits, horodatages et décisions

!!! tip "Bon réflexe"
    Un modèle simple utilisé systématiquement vaut mieux qu'un modèle parfait utilisé une fois sur dix.

---

## Modèle 1 - Fiche d'incident (version courte)

```markdown
# Incident IA - Fiche courte

## Métadonnées
- Incident ID:
- Date/Heure détection:
- Détecté par:
- Gravité initiale: (Critique / Haute / Moyenne / Basse)
- Statut: (Ouvert / Confiné / En remédiation / Clos)

## Résumé
- Type d'incident: (phishing IA, deepfake, prompt poisoning, fuite données, autre)
- Systèmes impactés:
- Données potentiellement impactées:

## Actions immédiates (T+0 à T+60)
- [ ] Confinement initié
- [ ] Tokens/sessions révoqués
- [ ] IOC/IOA bloqués
- [ ] Communication interne envoyée

## Décisions clés
- Décision 1:
- Décision 2:

## Prochaines actions (24h)
- Action A - Owner - Échéance
- Action B - Owner - Échéance
```

---

## Modèle 2 - Fiche d'incident (version complète)

```markdown
# Incident IA - Fiche complète

## 1. Contexte
- ID incident:
- Date/Heure ouverture:
- Équipe coordinatrice:
- Niveau de sévérité:
- Canal de détection initial:

## 2. Chronologie horodatée
- HH:MM - Événement observé
- HH:MM - Action prise
- HH:MM - Décision management

## 3. Périmètre impact
- Identités impactées:
- Endpoints impactés:
- Dépôts/CI impactés:
- Applications métiers impactées:
- Impact client/externe:

## 4. Analyse technique
- Hypothèse d'attaque:
- Indicateurs collectés (IOC/IOA):
- Corrélations validées:
- Cause racine probable:

## 5. Confinement et remédiation
- Mesures de confinement:
- Correctifs appliqués:
- Contrôles ajoutés:

## 6. Conformité et communication
- Données personnelles impliquées (oui/non):
- Obligations de notification:
- Message interne:
- Message externe:

## 7. Clôture
- Critères de clôture atteints:
- Date de clôture:
- Risques résiduels:
```

---

## Modèle 3 - Post-mortem sans blâme

```markdown
# Post-mortem Incident IA

## Résumé exécutif
- Ce qui s'est passé:
- Impact métier:
- Durée:

## Ce qui a bien fonctionné
- Point fort 1
- Point fort 2

## Ce qui a échoué
- Lacune 1
- Lacune 2

## Causes racines
- Technique:
- Processus:
- Humain:
- Gouvernance:

## Plan d'actions 30/60/90 jours
- 30 jours:
- 60 jours:
- 90 jours:

## KPI de suivi
- MTTD:
- MTTC:
- Taux conformité revue humaine:

## Validation
- Sponsor direction:
- RSSI:
- Date revue:
```

---

## Exemple rempli (synthétique)

| Champ | Exemple |
|---|---|
| Type incident | Phishing personnalisé assisté IA |
| Point d'entrée | Email ciblé finance |
| Impact | Tentative de virement bloquée |
| Confinement | Révocation session + blocage domaine |
| Leçon clé | Validation hors bande non contournable |

---

## Erreurs courantes à éviter

- Écrire un récit subjectif sans preuves horodatées
- Oublier d'attribuer des owners et des échéances
- Clore l'incident sans mesurer les risques résiduels
- Négliger la coordination juridique/comms

---

## Sources et provenance

- [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)
- [CISA AI](https://www.cisa.gov/ai)
- [ANSSI](https://www.ssi.gouv.fr/)
- [ENISA Threat Landscape](https://www.enisa.europa.eu/topics/cyber-threats/threat-landscape)
- [OWASP Top 10 for LLM Applications](https://owasp.org/www-project-top-10-for-large-language-model-applications/)

---

## Prochaine étape

Consulte le **[Plan 90 jours — Passer à l'action](plan-90-jours.md)** pour transformer ces fiches en programme complet de remédiation avec quick wins, jalons et responsables par rôle.

Concepts clés couverts :

- **Documentation incident** — traçabilité claire et actionnable
- **Post-mortem structuré** — amélioration continue sans blâme
- **Responsabilités explicites** — owners et échéances non ambiguës
- **Capitalisation équipe** — transformer chaque incident en progrès
