# Modèles de fiches incident et post-mortem IA

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span>

Ces modèles servent à documenter un incident impliquant un agent IA, un MCP, une fuite de données, une fraude assistée par IA ou un composant GenAI. Privilégiez les **faits horodatés, sources de preuve et décisions** plutôt qu'un récit reconstruit après coup.

---

## Fiche incident courte

```markdown
# Incident IA

## Métadonnées
- Incident ID:
- Détection:
- Owner:
- Statut:
- Sévérité selon la politique interne:

## Faits observés
- Signal initial:
- Systèmes/comptes concernés:
- Données potentiellement concernées:
- Sources de preuve:

## Composants IA
- Agent/client:
- Modèle/backend si pertinent:
- MCP actifs:
- Plugins/skills/hooks:
- Credentials accessibles:

## Confinement
- Accès révoqués:
- Agent/MCP désactivé:
- Systèmes isolés:
- Déploiements/écritures suspendus:

## Prochaines actions
| Action | Owner | Échéance | Preuve attendue |
|---|---|---|---|
```

---

## Fiche d'investigation complète

```markdown
# Investigation incident IA

## 1. Périmètre
- Identités:
- Endpoints/runners:
- Dépôts/branches/commits:
- CI/CD:
- Services cloud:
- Données:

## 2. Chronologie
| Heure | Fait observé | Source | Action prise |
|---|---|---|---|

## 3. Chaîne agentique
- Source du contexte:
- Instructions chargées:
- Outils appelés:
- Commandes exécutées:
- Fichiers lus/écrits:
- Destinations réseau:
- Credentials utilisés:

## 4. Hypothèses
| Hypothèse | Éléments pour | Éléments contre | Statut |
|---|---|---|---|

## 5. Confinement/remédiation
- Tokens rotatés:
- Permissions réduites:
- Composants retirés/mis à jour:
- Contrôles ajoutés:

## 6. Données & conformité
- Données personnelles/sensibles:
- Fournisseurs impliqués:
- Obligations à évaluer:
- Décisions juridique/privacy:

## 7. Clôture
- Critères de clôture:
- Risques résiduels:
- Preuves de validation:
```

---

## Post-mortem sans blâme

```markdown
# Post-mortem incident IA

## Résumé
- Ce qui s'est passé:
- Impact:
- Durée / période:

## Chronologie confirmée
...

## Cause racine et facteurs contributifs
- Technique:
- Processus:
- Gouvernance:
- Fournisseur/outil:

## Contrôles
### Ont fonctionné
- ...

### Ont échoué ou manqué
- ...

## Actions
| Action | Owner | Échéance | Preuve de clôture |
|---|---|---|---|

## Risque résiduel
- ...
```

Évitez de forcer un plan « 30/60/90 » si l'action critique doit être traitée immédiatement ou si une action structurelle nécessite davantage de temps.

---

## Erreurs à éviter

- recopier la réponse du modèle comme preuve ;
- supprimer les logs avant capture ;
- conclure à une exfiltration sans preuve réseau/forensique ;
- conclure à l'absence d'exfiltration uniquement parce que l'agent ne la mentionne pas ;
- fermer l'incident sans owner ni preuve de remédiation ;
- stocker de nouveaux secrets dans le ticket d'incident.

---

## Sources

- [OWASP GenAI Security Project](https://genai.owasp.org/)
- [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)
- [MITRE ATLAS](https://atlas.mitre.org/)
- [CISA AI](https://www.cisa.gov/ai)
- [ANSSI](https://cyber.gouv.fr/)

## Prochaine étape

Utilisez le [plan 90 jours](plan-90-jours.md) comme feuille de route adaptable, puis réévaluez les contrôles à partir des preuves collectées.