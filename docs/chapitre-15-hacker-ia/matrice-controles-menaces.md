# Matrice menaces IA → contrôles

<span class="badge-expert">Expert</span> <span class="badge-intermediate">Intermédiaire</span>

Cette matrice relie les menaces GenAI/agentiques à des contrôles concrets. Elle ne fournit pas de classement universel : la priorité dépend des actifs, permissions, données et adversaires propres à l'organisation.

---

## Mode d'emploi

1. Identifier les actifs et workflows IA réellement utilisés.
2. Décrire les capacités de chaque agent : lecture, écriture, shell, réseau, MCP, cloud.
3. Associer les menaces pertinentes.
4. Vérifier les contrôles existants et leurs preuves.
5. Prioriser les écarts selon le risque métier local.

---

## Matrice principale

| Menace | Contrôles techniques | Contrôles organisationnels | Preuve attendue |
|---|---|---|---|
| Prompt injection / contexte non fiable | isolation des outils, allowlist réseau, sandbox, validation des entrées externes | politique de confiance des sources | test d'injection, logs d'outil |
| Exfiltration de secrets | scopes minimaux, secret manager, DLP/secrets scanning, blocage fichiers sensibles | règle d'accès aux données et rotation | test de révocation, scan CI |
| MCP compromis ou trop permissif | outils minimaux, SSRF protections, scopes réseau, auth dédiée | registre des MCP et owner | config versionnée, revue de permissions |
| Skill/plugin/hook compromis | version épinglée, revue scripts, sandbox | sources approuvées | hash/version + revue |
| Agent sur-permissionné | confirmations, sandbox, comptes dédiés, permissions minimales | revue périodique des accès | export de policy / test de refus |
| Supply chain | SCA, lockfiles, provenance, allowlist | procédure d'approbation | rapport SCA / PR approuvée |
| Sortie LLM non vérifiée | tests, lint, SAST, Quality Gate | règle de revue humaine selon criticité | CI verte + review |
| Fraude/deepfake | MFA résistant au phishing, contrôles transactionnels | validation hors bande | exercice/tabletop |
| Consommation non bornée | timeout, quotas, taille de sortie, budgets | règles d'escalade | alertes et logs |
| Données RAG/context empoisonnées | provenance, ACL, validation corpus | owner des sources | audit des sources et accès |

---

## Contrôles supplémentaires pour les applications agentiques

| Surface | Contrôle à appliquer | Test de preuve |
|---|---|---|
| Mémoire persistante | Écriture bornée, provenance, validation avant promotion en instruction | Une note externe ne peut pas accorder de droits |
| Délégation et messages inter-agents | Identité, rôle, ressources et outils bornés | Le sous-agent ne dépasse pas les droits du rôle |
| Autorisation multi-tenant | Décision côté service sur chaque ressource et cache | Une identité A ne reçoit aucun document B |
| Sortie générée | Schéma, paramètres typés et contrôle d'exécution | Une réponse libre ne devient pas une commande |
| Retries et actions métier | Budget, timeout, limite d'essais et idempotence | Une erreur ne produit pas de boucle ou de double action |
| Configuration de sécurité | Paramètres administrés et trace des changements | Une configuration du dépôt ne retire pas la politique imposée |
| Reprise après incident | Copies et caches traités, secrets invalidés, tests avant activation | L'ancien token échoue et la tâche autorisée réussit |

Le [plan de tests](tests-securite.md) distingue refus vérifié, exécution interdite et résultat inconclusif. Un simple refus textuel n'est pas une preuve technique.

## Référentiels utiles

Les éditions [OWASP LLM 2026](https://genai.owasp.org/resource/owasp-genai-llm-top-10-2026/) et [agentique 2026](https://genai.owasp.org/resource/owasp-top-10-for-agentic-applications-for-2026/) ont été vérifiées le **4 octobre 2026**. Fixez l'édition et le périmètre du mapping ; les lignes de cette matrice sont des catégories pratiques du dépôt, pas les identifiants officiels de ces listes.

- **OWASP GenAI Security Project** : risques LLM et agentiques ;
- **NIST AI RMF** : gouvernance et gestion du risque ;
- **MITRE ATLAS** : tactiques et techniques adverses ;
- **CISA / ANSSI / ENISA** : contrôles cyber, identité, supply chain et incident response.

Le mapping exact vers un contrôle réglementaire ou normatif doit être validé dans le référentiel applicable à votre organisation.

---

## Registre de contrôles

```markdown
| Menace | Contrôle | Statut | Owner | Échéance | Preuve |
|---|---|---|---|---|---|
| MCP sur-permissionné | réduire scopes réseau | En cours | Platform | 2026-10-15 | config + test |
| Secret accessible à l'agent | déplacer dans secret manager | Planifié | DevSecOps | 2026-10-30 | test CI |
```

La colonne **Preuve** est essentielle : un contrôle déclaré sans preuve vérifiable est difficile à auditer.

---

## Indicateurs de couverture

Mesurez ce qui correspond au périmètre réel :

- contrôles critiques avec preuve valide ;
- écarts ouverts sur actifs critiques ;
- exceptions de policy expirées/non revues ;
- MCP/plugins/skills sans owner ;
- credentials de production accessibles aux environnements agentiques ;
- actions de post-mortem non clôturées.

Évitez de transformer ces indicateurs en score unique opaque.

---

## Sources

- [OWASP — LLM 2026](https://genai.owasp.org/resource/owasp-genai-llm-top-10-2026/) — consulté le 2026-10-04
- [OWASP — agents 2026](https://genai.owasp.org/resource/owasp-top-10-for-agentic-applications-for-2026/) — consulté le 2026-10-04
- [Claude Code — Security](https://code.claude.com/docs/en/security) — consulté le 2026-10-04

- [OWASP GenAI Security Project](https://genai.owasp.org/)
- [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)
- [MITRE ATLAS](https://atlas.mitre.org/)
- [CISA — AI](https://www.cisa.gov/ai)
- [ANSSI](https://cyber.gouv.fr/)
- [ENISA Threat Landscape](https://www.enisa.europa.eu/topics/cyber-threats/threat-landscape)

## Prochaine étape

Poursuivez avec **[Checklist audit interne IA](checklist-audit-interne.md)**, la page suivante dans le menu.
