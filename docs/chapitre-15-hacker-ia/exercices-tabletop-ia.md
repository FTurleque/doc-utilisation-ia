# Exercices tabletop IA

<span class="badge-expert">Expert</span> <span class="badge-intermediate">Intermédiaire</span>

Ces exercices servent à tester la coordination, les décisions et les contrôles d'une organisation face à des incidents impliquant agents IA, fraude, prompt injection ou fuite de données. La durée et le nombre d'injects doivent être adaptés à l'équipe ; aucun format 60/90/120 minutes n'est universel.

---

## Objectifs

Un bon tabletop doit vérifier :

- qui décide et avec quelles informations ;
- comment les accès sont révoqués ;
- quelles preuves sont conservées ;
- comment SOC, IT, Dev, juridique/privacy et métiers coopèrent ;
- quelles dépendances externes compliquent le confinement ;
- quelles actions concrètes sortent du debrief.

---

## Structure générique

```text
brief
→ signal initial
→ information nouvelle / ambiguïté
→ aggravation ou impact métier
→ décision de confinement
→ reprise / communication
→ debrief et actions
```

Le facilitateur adapte le rythme aux discussions, plutôt que de forcer un timing arbitraire.

---

## Scénario 1 — Prompt injection dans un dépôt

### Point de départ

Un développeur clone un dépôt tiers. Après ouverture par l'agent, des commandes inattendues sont exécutées et un serveur MCP inconnu apparaît dans la configuration projet.

### Injects possibles

- le dépôt contient un `CLAUDE.md` ou une skill inhabituelle ;
- un token de développement était présent dans l'environnement ;
- le diff montre une modification hors périmètre ;
- un appel réseau vers une destination inconnue est observé.

### Questions

- qui stoppe l'agent ?
- quels tokens sont révoqués ?
- quelles preuves sont préservées ?
- comment déterminer si une donnée a quitté le poste ?
- quels contrôles empêchent une répétition ?

---

## Scénario 2 — MCP compromis

### Point de départ

Un MCP utilisé pour la documentation commence à retourner des contenus inhabituels et tente d'accéder à des ressources internes non prévues.

### Injects

- changement récent de version ;
- secret statique présent dans sa configuration ;
- logs montrant une redirection vers une adresse privée ;
- plusieurs développeurs utilisent le même token.

### Résultats attendus

- désactivation du MCP ;
- rotation des secrets ;
- revue de provenance/version ;
- correction des règles réseau/SSRF ;
- migration vers comptes/scopes individuels ou dédiés.

---

## Scénario 3 — Fuite de données via assistant IA

Un collaborateur signale qu'un prompt envoyé à un service externe contenait des données client et potentiellement un secret.

À tester :

- qualification des données ;
- rotation du secret ;
- analyse des logs ;
- implication privacy/juridique ;
- relation avec le fournisseur ;
- communication interne/externe selon obligation applicable.

---

## Scénario 4 — Fraude assistée par IA

Une fonction finance reçoit une demande urgente via plusieurs canaux cohérents, dont un appel vocal ressemblant à un dirigeant.

Le tabletop doit vérifier que la procédure repose sur une **preuve d'identité indépendante**, pas sur la qualité apparente du média.

---

## Fiche d'observation

Au lieu d'une note `1-5`, documentez :

| Axe | Observation | Preuve | Action |
|---|---|---|---|
| Détection | Ce qui a déclenché l'incident | règle/log | amélioration éventuelle |
| Accès | Capacité à révoquer | test réalisé | owner |
| Preuves | Logs disponibles/manquants | emplacement | action instrumentation |
| Coordination | décision claire ou blocage | timeline | action process |
| Reprise | critères explicités | checklist | action |

Les observations qualitatives accompagnées de preuves sont souvent plus utiles qu'un score agrégé.

---

## Debrief

À la fin :

1. faits observés pendant l'exercice ;
2. décisions qui ont ralenti ou échoué ;
3. contrôles manquants ;
4. actions avec owner, échéance et preuve de clôture ;
5. date ou condition du prochain test.

---

## Sources

- [OWASP GenAI Security Project](https://genai.owasp.org/)
- [MITRE ATLAS](https://atlas.mitre.org/)
- [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)
- [CISA AI](https://www.cisa.gov/ai)
- [ANSSI](https://cyber.gouv.fr/)

## Prochaine étape

Poursuivez avec **[Cas sectoriels IA et cybersécurité](cas-sectoriels-ia.md)**, la page suivante dans le menu.
