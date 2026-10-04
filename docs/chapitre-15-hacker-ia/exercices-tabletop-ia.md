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

## Scénario 5 — Mémoire et cache RAG après révocation

Un document fictif est retiré des droits d'une identité de test. Une réponse générée ultérieurement semble encore contenir une information de ce document.

Injects : cache partagé, session longue, index dérivé non invalidé, consultation directe par identifiant. À vérifier : qui stoppe la diffusion, comment déterminer la copie concernée, quels caches invalider et comment prouver le cloisonnement à la reprise. Voir [Sécurité du RAG](../chapitre-7-rag/securite.md).

## Scénario 6 — Sous-agent, boucle et double action

Un sous-agent reçoit une tâche de lecture ; un service fictif enregistre pourtant une tentative d'écriture, puis plusieurs retries. Aucun système réel ne doit être touché pendant l'exercice.

À tester : limites du rôle, identité utilisée, décision d'autorisation, arrêt de toute l'équipe et des processus associés, idempotence et preuve que l'action n'a pas été répétée. Ne concluez pas au confinement uniquement parce que la conversation du parent est arrêtée.

## Scénario 7 — Reprise avec télémétrie incomplète

Après rotation d'un credential, les logs de l'agent restent silencieux mais un événement IAM signale un accès. L'équipe doit distinguer ancien secret non révoqué, jeton dérivé, autre identité et journal manquant.

Résultat attendu : reprise conditionnée par des preuves côté service, inventaire des processus et validation du responsable. Le [plan de tests techniques](tests-securite.md) complète le tabletop.

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

- [NIST SP 800-61 Rev. 3](https://csrc.nist.gov/pubs/sp/800/61/r3/final) — consulté le 2026-10-04

- [OWASP GenAI Security Project](https://genai.owasp.org/)
- [MITRE ATLAS](https://atlas.mitre.org/)
- [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)
- [CISA AI](https://www.cisa.gov/ai)
- [ANSSI](https://cyber.gouv.fr/)

## Prochaine étape

Poursuivez avec **[Cas sectoriels IA et cybersécurité](cas-sectoriels-ia.md)**, la page suivante dans le menu.
