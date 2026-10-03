# Checklist audit interne IA

<span class="badge-expert">Expert</span> <span class="badge-intermediate">Intermédiaire</span>

Cette checklist aide à auditer la posture de sécurité des usages IA dans les workflows de développement, d'exploitation et métier. La cadence doit être adaptée au niveau de risque et aux changements de l'environnement ; « trimestriel » peut être un point de départ, pas une obligation universelle.

---

## Sortie attendue

L'audit doit produire :

- un périmètre clair ;
- des écarts documentés ;
- un owner par action ;
- une échéance ;
- une preuve attendue ;
- les exceptions explicitement acceptées.

Évitez un score global qui masque des écarts critiques.

---

## 1. Gouvernance

- [ ] Les outils/agents autorisés sont inventoriés.
- [ ] Les propriétaires de chaque outil, MCP, plugin et skill sont connus.
- [ ] Les règles d'usage de données/secrets sont documentées.
- [ ] Les exceptions de policy ont une date d'expiration et un owner.
- [ ] Les responsabilités d'incident sont définies.

## 2. Identité et permissions

- [ ] Les comptes critiques utilisent une MFA résistante au phishing lorsque possible.
- [ ] Les agents n'utilisent pas des credentials de production par défaut.
- [ ] Les tokens sont scoped au besoin et révocables rapidement.
- [ ] Les permissions agentiques sont revues après changement d'outil ou de workflow.
- [ ] Les actions sensibles nécessitent un contrôle adapté à leur criticité.

## 3. Claude Code / agents de développement

- [ ] `CLAUDE.md`, rules et autres instructions sont versionnés et revus.
- [ ] `.mcp.json` et les serveurs MCP sont audités.
- [ ] Les hooks/plugins/skills tiers ont une provenance vérifiée.
- [ ] Les commandes de validation du dépôt sont documentées.
- [ ] Les changements critiques passent par diff, tests et revue.
- [ ] Les contenus externes sont considérés comme non fiables par défaut.

## 4. Supply chain

- [ ] Les nouvelles dépendances sont revues selon leur criticité.
- [ ] SCA/advisories sont intégrés au workflow pertinent.
- [ ] Les lockfiles et sources de packages sont contrôlés.
- [ ] Les scripts d'installation des composants tiers sensibles sont inspectés.
- [ ] Les outils abandonnés/legacy sont identifiés et ont un plan de remplacement.

## 5. Secrets et données

- [ ] Les secrets ne sont pas stockés dans les instructions, tickets ou exemples.
- [ ] Les données sensibles accessibles aux agents sont minimisées.
- [ ] Les logs/transcriptions ont une politique de rétention adaptée.
- [ ] Une procédure de rotation des secrets est testée.
- [ ] Les services tiers de routage/proxy sont inclus dans la cartographie des données.

## 6. Détection et réponse

- [ ] Les événements nécessaires à l'investigation sont journalisés.
- [ ] Le playbook incident couvre agent, MCP, secret et supply chain.
- [ ] Les tokens/accès peuvent être révoqués rapidement.
- [ ] Un exercice récent a testé au moins un scénario agentique.
- [ ] Les actions des post-mortems sont suivies jusqu'à preuve de clôture.

## 7. Fournisseurs et conformité

- [ ] Les conditions de traitement des données sont comprises pour chaque fournisseur.
- [ ] Les besoins juridiques/privacy applicables sont documentés.
- [ ] Les décisions d'achat utilisent des tarifs et conditions actuels, pas des copies historiques.
- [ ] Les dépendances à un fournisseur peuvent être retirées ou migrées.

---

## Plan de remédiation

```markdown
| Écart | Risque local | Action | Owner | Échéance | Preuve attendue |
|---|---|---|---|---|---|
| MCP avec token large | Accès excessif à Sonar | créer token dédié read-only | Platform | 2026-10-15 | test d'accès + config |
```

---

## Évaluer la maturité sans faux barème

Plutôt qu'un score `18/24`, utilisez des états par domaine :

- **non maîtrisé** : contrôle absent ou non prouvé ;
- **partiel** : contrôle présent mais couverture incomplète ;
- **maîtrisé** : contrôle actif avec preuve ;
- **à réévaluer** : changement récent d'outil, menace ou fournisseur.

Un seul écart critique peut être plus important que vingt contrôles mineurs correctement cochés.

---

## Sources

- [OWASP GenAI Security Project](https://genai.owasp.org/)
- [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)
- [MITRE ATLAS](https://atlas.mitre.org/)
- [CISA — AI](https://www.cisa.gov/ai)
- [ANSSI](https://cyber.gouv.fr/)
- [ENISA Threat Landscape](https://www.enisa.europa.eu/topics/cyber-threats/threat-landscape)

## Prochaine étape

Poursuivez avec **[Modèles fiches incident & post-mortem](modeles-fiches-incident.md)**, la page suivante dans le menu.
