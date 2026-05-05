# Matrice menaces IA -> contrôles (OWASP, NIST, ANSSI)

<span class="badge-expert">Expert</span> <span class="badge-intermediate">Intermédiaire</span>

Cette matrice relie les menaces IA les plus fréquentes à des contrôles concrets. Elle sert de base pour prioriser les actions et préparer un audit.

---

## Mode d'emploi

1. Identifie les menaces les plus probables dans ton contexte.
2. Vérifie les contrôles déjà en place.
3. Priorise les écarts selon impact et effort.
4. Attribue un owner et une échéance pour chaque écart.

---

## Matrice principale

| Menace | Contrôles techniques | Contrôles organisationnels | Référentiels utiles |
|---|---|---|---|
| Prompt injection | Filtrage entrée/sortie, sandbox, validation du contexte | Revue des instructions IA, politique de moindre privilège | OWASP LLM, NIST AI RMF |
| Exfiltration de données | DLP, content exclusions, chiffrement, secrets scanning | Politique "no secret in prompt", classification données | OWASP LLM, ANSSI |
| Phishing personnalisé IA | MFA phishing-resistant, protection email avancée | Validation hors bande, formation métiers exposés | CISA, ENISA |
| Deepfake voix/vidéo | Vérification identité multicanal, journalisation appels sensibles | Procédure anti-usurpation, script de crise | CISA, ANSSI |
| Supply chain via dépendances | SCA bloquante, allowlist, contrôle provenance | Processus d'approbation des dépendances | OWASP LLM, NIST |
| Agent de code sur-permissionné | Permissions minimales, confirmations obligatoires, logs d'actions | Gouvernance des agents et revue périodique | NIST AI RMF, ANSSI |
| Désinformation interne/externe | Monitoring de canaux, signatures officielles de communication | Process de validation communication de crise | ENISA, CISA |

---

## Exemple de priorisation (impact x effort)

| Contrôle | Impact réduction risque | Effort mise en place | Priorité |
|---|---|---|---|
| MFA phishing-resistant sur comptes critiques | Très élevé | Moyen | Immédiate |
| Revue obligatoire des fichiers d'instructions IA | Élevé | Faible | Immédiate |
| Dashboard KPI SOC dédié IA | Élevé | Moyen | Court terme |
| Programme tabletop trimestriel | Élevé | Moyen | Court terme |
| DLP avancé et segmentation complète | Très élevé | Élevé | Moyen terme |

---

## Modèle de registre de contrôles (copiable)

```markdown
# Registre contrôles IA

| Menace | Contrôle | Statut | Owner | Échéance | Preuve |
|---|---|---|---|---|---|
| Prompt injection | Revue fichiers instructions | En cours | SecOps | 2026-06-15 | Lien PR |
| Exfiltration | Policy no secret in prompt | Déployé | RSSI | 2026-05-20 | Note interne |
| Supply chain | SCA bloquante CI | Planifié | DevSecOps | 2026-07-01 | Pipeline config |
```

---

## Indicateurs de couverture de contrôles

| Indicateur | Calcul |
|---|---|
| Couverture technique | Contrôles techniques déployés / contrôles techniques prévus |
| Couverture organisationnelle | Contrôles organisationnels actifs / contrôles organisationnels prévus |
| Écarts critiques ouverts | Nombre de contrôles prioritaires non déployés |
| Délai moyen de fermeture d'écart | Somme délais / nombre d'écarts clos |

---

## Sources et provenance

- [OWASP Top 10 for LLM Applications](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
- [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)
- [ANSSI](https://www.ssi.gouv.fr/)
- [CISA AI](https://www.cisa.gov/ai)
- [ENISA Threat Landscape](https://www.enisa.europa.eu/topics/cyber-threats/threat-landscape)
- [MITRE ATLAS](https://atlas.mitre.org/)

---

## Avant / Après l'utilisation de la matrice

| Crit&egrave;re | Sans matrice | Avec matrice |
|---|---|---|
| Couverture des menaces | Contrôles ad hoc, lacunes non identifiées | Cartographie complète, écarts documentés avec owners |
| Priorisation | Décisions intuitives ou basées sur le dernier incident | Impact × effort évalué, priorités Immédiate/Court/Moyen terme |
| Traçabilité | Mesures informelles, non auditables | Registre de contrôles avec statut, preuve et échéance |
| Conformité | Difficile à démontrer aux auditeurs | Référencement OWASP/NIST/ANSSI explicite et vérifiable |

---

## Prochaine étape

**[Checklist audit interne IA](checklist-audit-interne.md)** : passe de la matrice de contrôles à une vérification trimestrielle exécutable.

Concepts clés couverts :

- **Lien menace-controle** — pilotage concret du risque
- **Priorisation effort/impact** — séquencement réaliste
- **Registre de preuves** — traçabilité d'audit
- **Mesure de couverture** — suivi objectif des progrès
