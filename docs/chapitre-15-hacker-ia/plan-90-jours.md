# Plan 90 jours — feuille de route sécurité IA

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span>

Ce plan propose une séquence de travail sur environ trois mois. Les dates, responsables et priorités doivent être adaptés au threat model de l'organisation ; le but n'est pas de promettre qu'une posture « mature » est atteinte en 90 jours.

---

## Principes

- commencer par les accès, secrets et actifs critiques ;
- documenter l'existant avant d'ajouter des outils ;
- tester les contrôles, pas seulement les déclarer ;
- attribuer un owner et une preuve de clôture ;
- traiter un écart critique immédiatement, même s'il appartient à une phase ultérieure.

---

## Jours 1–30 — inventorier et réduire l'exposition

Actions possibles :

| Action | Preuve attendue |
|---|---|
| Inventorier agents, IDE, MCP, plugins, skills et backends | registre avec owner |
| Identifier les credentials accessibles aux agents | cartographie des scopes |
| Retirer les secrets des instructions et exemples | scan + diff |
| Vérifier MFA et comptes privilégiés | rapport IAM |
| Tester la révocation d'un token | exercice documenté |
| Mettre à jour le playbook incident | version approuvée |

---

## Jours 31–60 — industrialiser les contrôles

Selon le contexte :

- secret scanning ;
- SCA et advisories ;
- SAST / analyse statique ;
- Quality Gates ;
- logs agent/MCP nécessaires à l'investigation ;
- comptes de service/scopes dédiés ;
- contrôle réseau des MCP ;
- procédure d'approbation des dépendances/skills/plugins ;
- tableau de bord des écarts et actions.

Chaque contrôle doit avoir un test ou une preuve observable.

---

## Jours 61–90 — tester la réponse et la gouvernance

- exécuter un tabletop agentique ;
- tester rotation/révocation des credentials ;
- tester un scénario MCP compromis ;
- vérifier la capacité à reconstruire une chronologie ;
- revoir exceptions et permissions ;
- produire un bilan des écarts résiduels ;
- préparer la prochaine itération selon les risques réellement observés.

---

### Dev / Platform

- maintenir les instructions projet et outils versionnés ;
- réduire les permissions des agents ;
- intégrer les validations dans CI ;
- justifier et auditer les nouvelles dépendances/MCP/skills.

### SecOps / SOC

- vérifier la télémétrie utile ;
- relier identité, dépôt, endpoint, réseau et CI ;
- tester les runbooks ;
- suivre les actions de post-mortem.

### CISO / Direction

- clarifier le risk appetite ;
- arbitrer les exceptions ;
- financer les contrôles réellement prioritaires ;
- suivre l'impact métier plutôt qu'un score technique opaque.

### Métiers / fonctions sensibles

- utiliser les canaux officiels ;
- appliquer les validations hors bande ;
- signaler les demandes inhabituelles ;
- participer aux exercices adaptés à leur rôle.

---

## Template de suivi

```markdown
| Action | Risque lié | Owner | Échéance | Statut | Preuve |
|---|---|---|---|---|---|
| Réduire scopes MCP Sonar | accès excessif | Platform | 2026-10-15 | En cours | test read-only |
```

---

## Jalons de validation technique

| Période indicative | Critère de sortie |
|---|---|
| Jours 1–30 | Identités et périmètres connus ; au moins une révocation et un arrêt d'agent démontrés |
| Jours 31–60 | Contrôles de permission, sandbox/MCP et cloisonnement testés ; télémétrie vérifiée sans collecte excessive |
| Jours 61–90 | Exercice complet avec preuves, reprise validée et actions de non-régression attribuées |

Le [plan de tests](tests-securite.md) permet de choisir les scénarios applicables. Incluez mémoire persistante, RAG, sous-agents et processus associés dans l'inventaire. Fixez l'édition du référentiel de sécurité et déclenchez une réévaluation après modification d'outils, modèle, droits ou configuration.

Ces jalons sont une proposition d'organisation, pas un délai réglementaire ou une promesse de maturité. Le cadre [NIST SP 800-61 Rev. 3](https://csrc.nist.gov/pubs/sp/800/61/r3/final), consulté le **4 octobre 2026**, intègre la réponse aux incidents dans la gestion continue du risque.

## Comment juger le progrès

Ne concluez pas « maturité atteinte » parce que la checklist est terminée. Vérifiez :

- baisse des écarts critiques ;
- capacité à révoquer rapidement ;
- couverture des validations ;
- disponibilité des logs nécessaires ;
- résultats des tabletop ;
- fermeture effective des actions de post-mortem.

---

## Sources

- [NIST SP 800-61 Rev. 3](https://csrc.nist.gov/pubs/sp/800/61/r3/final) — consulté le 2026-10-04

- [OWASP GenAI Security Project](https://genai.owasp.org/)
- [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)
- [MITRE ATLAS](https://atlas.mitre.org/)
- [CISA AI](https://www.cisa.gov/ai)
- [ANSSI](https://cyber.gouv.fr/)
- [ENISA Threat Landscape](https://www.enisa.europa.eu/topics/cyber-threats/threat-landscape)

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-15-hacker-ia.md#page-chapitre-15-hacker-ia-plan-90-jours).

## Prochaine étape

Poursuivez avec **[Cybersécurité & IA — Comparaison](comparaison.md)**, la page suivante dans le menu.
