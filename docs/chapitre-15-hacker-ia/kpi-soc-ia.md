# KPI & SOC pour menaces IA — détection et pilotage

<span class="badge-expert">Expert</span> <span class="badge-intermediate">Intermédiaire</span>

Cette page propose des indicateurs pour piloter les incidents et contrôles liés aux agents IA. Les seuils doivent venir du **risk appetite**, des SLA internes et de la criticité des actifs ; ce dépôt ne fixe pas de valeurs universelles.

---

## Ce qu'un bon KPI doit permettre

Un indicateur utile répond à une décision : faut-il renforcer un contrôle, changer une permission, ajouter une détection, former une équipe ou revoir un fournisseur ?

Évitez les métriques décoratives telles que « nombre de prompts » si elles ne sont reliées ni à un risque ni à une action.

---

## Indicateurs opérationnels de base

| KPI | Définition | Décision associée |
|---|---|---|
| MTTD | Temps entre début estimé et détection | qualité de télémétrie/détection |
| MTTC | Temps entre détection et confinement | efficacité du runbook et des accès |
| Secrets exposés | Secrets confirmés dans prompts/logs/artefacts | rotation, prévention et secret management |
| Actions agentiques non approuvées | Commandes/outils hors politique | permissions, hooks, sandbox |
| Modifications sensibles sans revue | Changements critiques non relus | protection de branche/process |
| Dépendances non approuvées | Nouveaux packages/plugins/skills/MCP hors politique | supply chain |
| Incidents liés au contenu externe | Cas où une source non fiable a influencé l'agent | prompt injection/context trust |

---

## Indicateurs spécifiques à Claude Code / agents

Selon votre instrumentation, mesurez :

- part des projets avec `CLAUDE.md`/rules revus ;
- serveurs MCP autorisés vs découverts ;
- MCP avec secrets statiques ou scopes trop larges ;
- hooks/plugins/skills non épinglés ou non audités ;
- sessions où l'agent avait accès à des credentials de production ;
- actions nécessitant une confirmation manuelle ;
- taux de modifications agentiques qui passent les validations du dépôt du premier coup.

Ces données ne doivent pas devenir un outil de surveillance individuelle non nécessaire ; collectez ce qui sert réellement au risque et respectez les obligations privacy/HR applicables.

---

## Qualité de détection

Mesurez aussi la qualité du système de détection :

| Dimension | Question |
|---|---|
| Couverture | quels scénarios du threat model ont une détection ? |
| Faux positifs | combien d'alertes consomment du temps sans action ? |
| Faux négatifs | quels incidents ont été découverts par un autre canal ? |
| Délai | la télémétrie arrive-t-elle assez vite pour contenir ? |
| Contexte | l'alerte contient-elle identité, dépôt, outil et action ? |
| Actionnabilité | l'analyste sait-il quoi faire ensuite ? |

---

## Dashboard SOC recommandé

### Vue incidents

- incidents ouverts/clos par type ;
- actifs et données touchés ;
- MTTD/MTTC avec tendance ;
- causes racines récurrentes ;
- actions de remédiation en retard.

### Vue agentic security

- permissions critiques accordées ;
- MCP actifs et propriétaires ;
- exceptions de politique ;
- dépendances/skills/plugins non approuvés ;
- secrets détectés dans contexte/logs ;
- couverture des validations CI sur changements agentiques.

### Vue direction

Présentez :

- impact métier ;
- tendance et exposition ;
- décisions requises ;
- investissements/risques résiduels ;
- état des actions majeures.

Évitez de transformer des métriques techniques brutes en score unique opaque.

---

## Définir des seuils localement

Pour chaque KPI :

1. mesurer une baseline ;
2. définir la criticité métier ;
3. fixer un seuil d'escalade avec le propriétaire du risque ;
4. tester ce seuil sur des incidents/tabletops ;
5. le réviser après faux positifs/faux négatifs.

Exemple : une organisation peut exiger zéro secret de production dans un environnement agentique, tandis qu'un temps de confinement acceptable dépendra du type d'incident et de l'astreinte disponible.

---

## Corrélations utiles

Les incidents agentiques deviennent plus lisibles lorsque vous corrélez :

```text
identité
+ dépôt / branche / commit
+ poste ou runner
+ commandes/outils
+ MCP
+ réseau
+ secret manager
+ CI/CD
```

L'objectif est de reconstruire une séquence d'actions, pas d'inférer l'intention du modèle.

---

## Instrumenter Claude Code sans créer une nouvelle fuite

La documentation [Monitoring usage](https://code.claude.com/docs/en/monitoring-usage), consultée le **4 octobre 2026**, distingue l'export OpenTelemetry configuré par l'organisation des services de télémétrie opérationnelle Anthropic. L'export vers votre backend est optionnel et doit être explicitement configuré.

Le contenu des prompts et les arguments d'outils ne sont pas systématiquement journalisés. Activer `OTEL_LOG_USER_PROMPTS`, `OTEL_LOG_TOOL_DETAILS`, `OTEL_LOG_TOOL_CONTENT` ou les traces détaillées peut exposer prompts, chemins, commandes, résultats ou données sensibles selon les options et la version. Vérifiez chaque signal et masquez les valeurs avant stockage. Ne supposez pas que l'absence de détails dans un événement signifie qu'ils sont absents des spans de trace.

La journalisation complète n'est pas nécessaire à chaque décision SOC. Préférez des identifiants corrélables, horodatages, catégories d'actions, ressources, décisions et résultats ; limitez la collecte de contenu aux investigations autorisées. Protégez collector, destination d'export, accès et rétention. Le guide [Observabilité](../chapitre-13-outils-economies/observabilite/index.md) regroupe les outils correspondants.

| Règle de détection proposée | Corrélation attendue | Action analyste |
|---|---|---|
| Changement d'instructions puis action sensible | Configuration effective + session + outil + événement du service cible | Examiner le changement et la portée réelle |
| Credential révoqué puis nouvelle utilisation | Identité/token référencé + journal IAM + résultat d'accès | Confirmer l'invalidation ou un jeton dérivé |
| Serveur MCP modifié puis nouvelle destination | Inventaire/version + DNS/proxy + session | Isoler si la destination est hors politique |
| Lecture de donnée protégée puis transfert externe | Décision d'accès + journal réseau + destination | Vérifier quelles données ont effectivement quitté le système |
| Répétition d'une action après erreur | Identifiant d'opération + retries + résultat métier | Stopper la boucle et contrôler les doublons |

Ces règles sont des propositions locales, pas des détections intégrées garanties. Complétez les événements agentiques avec les journaux du système et du service cible.

### Mesurer la couverture et l'incertitude

Documentez numérateur, dénominateur, fenêtre de mesure et données manquantes. Par exemple, la couverture de tests est « scénarios applicables avec preuve récente / scénarios applicables », pas « alertes produites / prompts envoyés ». Pour MTTD, gardez la distinction entre début confirmé, début estimé et début inconnu ; une moyenne seule peut masquer des incidents longs.

## Revue périodique

À chaque revue :

- quelles alertes ont été utiles ?
- quels incidents ont échappé aux règles ?
- quelles permissions se sont élargies ?
- quels nouveaux MCP/plugins/skills sont apparus ?
- quelles actions de post-mortem restent ouvertes ?
- les métriques changent-elles réellement une décision ?

Supprimez un KPI qui ne pilote rien.

---

## Sources

- [Claude Code — Monitoring usage](https://code.claude.com/docs/en/monitoring-usage) — consulté le 2026-10-04

- [OWASP GenAI Security Project](https://genai.owasp.org/)
- [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)
- [MITRE ATLAS](https://atlas.mitre.org/)
- [CISA — AI](https://www.cisa.gov/ai)
- [ENISA Threat Landscape](https://www.enisa.europa.eu/topics/cyber-threats/threat-landscape)

## Prochaine étape

Poursuivez avec **[Exercices tabletop IA](exercices-tabletop-ia.md)**, la page suivante dans le menu.
