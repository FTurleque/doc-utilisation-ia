# Études de cas IA et cyberattaques (2024-2026)

<span class="badge-expert">Expert</span> <span class="badge-intermediate">Intermédiaire</span>

Cette page regroupe des **tendances et cas documentés** afin d'en tirer des contrôles défensifs. Elle ne cherche pas à classer arbitrairement les menaces par probabilité : la fréquence réelle dépend du secteur, de l'exposition, des données et des adversaires de l'organisation.

---

## Méthode de lecture

Pour chaque cas, séparez :

1. le fait rapporté par la source ;
2. ce qui est inféré ou extrapolé ;
3. le contrôle défensif applicable ;
4. la preuve que ce contrôle fonctionne chez vous.

Un rapport fournisseur décrit ce qu'il observe sur sa propre plateforme. Il peut être très utile sans être représentatif de tout l'écosystème.

---

## Cas 1 — IA utilisée comme accélérateur d'opérations cyber

Le rapport **Anthropic Threat Intelligence — septembre 2026** décrit plusieurs opérations malveillantes détectées entre décembre 2025 et août 2026. Anthropic indique avoir observé des acteurs utilisant Claude pour accélérer des tâches d'ingénierie, d'analyse ou d'orchestration dans des campagnes cyber et de surveillance.

### Leçon défensive

Ne supposez plus qu'une opération techniquement sophistiquée implique nécessairement une grande équipe. Renforcez les contrôles sur :

- identités et clés API ;
- exécution de scripts inhabituels ;
- accès aux dépôts et environnements cloud ;
- création rapide d'outils internes non approuvés ;
- détection comportementale plutôt que seule attribution par « niveau de sophistication ».

---

## Cas 2 — Vol ou abus de credentials comme multiplicateur

Les rapports 2026 mettent en évidence l'usage de **clés API volées, comptes frauduleux ou services de proxy/revente** pour contourner des restrictions et industrialiser l'accès aux modèles.

### Contrôles

- secrets courts et rotatifs ;
- scopes minimaux ;
- alertes sur usage géographique ou volumétrique inhabituel ;
- révocation rapide ;
- séparation des comptes de développement, CI et production ;
- interdiction de partager des clés entre développeurs.

---

## Cas 3 — Prompt injection et empoisonnement de contexte des agents

Un dépôt, une page Web, une issue ou une sortie MCP peut contenir des instructions conçues pour détourner un agent.

### Surface typique

```text
contenu externe non fiable
→ agent le lit comme contexte
→ instruction malveillante influence un outil
→ accès fichier/réseau/commande trop permissif
→ action ou exfiltration
```

### Contrôles

- revue des fichiers d'instructions et skills ;
- `.mcp.json` audité ;
- moindre privilège ;
- outils réseau limités ;
- secrets inaccessibles par défaut ;
- validation humaine avant actions sensibles ;
- logs permettant de reconstruire la séquence.

---

## Cas 4 — Supply chain : package, skill, plugin ou MCP

L'IA peut accélérer l'ajout de dépendances, mais l'agent n'est pas une autorité sur leur provenance.

### Contrôles

- registre officiel ;
- provenance/mainteneur ;
- SCA et advisories ;
- versions épinglées lorsque nécessaire ;
- revue des scripts d'installation ;
- allowlist dans les environnements sensibles ;
- procédure distincte pour les skills/plugins/MCP tiers.

---

## Cas 5 — Fraude et ingénierie sociale assistées par IA

Les modèles peuvent améliorer la qualité linguistique, la personnalisation et la vitesse de génération de contenus frauduleux. Les deepfakes ajoutent un canal supplémentaire, mais le problème de fond reste souvent **une chaîne de validation humaine trop faible**.

### Contrôles

- MFA résistant au phishing pour comptes critiques ;
- validation hors bande pour paiements/changements sensibles ;
- procédures qui ne reposent pas uniquement sur voix/vidéo ;
- corrélation identité + messagerie + endpoint ;
- sensibilisation ciblée des fonctions exposées.

---

## Cas 6 — Données sensibles dans des services ou routeurs tiers

Les outils d'IA intermédiaires peuvent stocker ou relayer prompts, code et credentials. Un fournisseur de modèle n'est qu'un maillon de la chaîne.

### Questions à poser

```text
IDE / agent
→ proxy/router
→ modèle
→ MCP/outils
→ logs
→ analytics
→ stockage
```

Pour chaque maillon : qui voit quoi, pendant combien de temps, avec quelle base contractuelle et quel contrôle d'accès ?

---

## Prioriser sans faux score universel

Au lieu d'une matrice « probabilité élevée/moyenne » générique, mesurez votre exposition :

| Dimension | Question |
|---|---|
| Actifs | quels secrets, dépôts, données ou comptes sont accessibles ? |
| Capacité agent | lecture seule, écriture, shell, réseau, cloud ? |
| Source de contexte | dépôt interne, Web, tickets, emails, MCP ? |
| Identité | quel compte et quels scopes ? |
| Détection | peut-on reconstruire les actions ? |
| Récupération | peut-on révoquer, restaurer, revenir en arrière ? |

La priorité vient ensuite de votre threat model, pas d'un tableau générique du dépôt.

---

## Sources primaires recommandées

- [Anthropic — Threat Intelligence](https://www.anthropic.com/threat-intelligence) — rapport septembre 2026 et archives
- [OWASP GenAI Security Project](https://genai.owasp.org/) — Top 10 LLM/GenAI et sécurité agentique
- [MITRE ATLAS](https://atlas.mitre.org/) — tactiques/techniques adverses IA
- [ENISA Threat Landscape](https://www.enisa.europa.eu/topics/cyber-threats/threat-landscape)
- [CISA — AI](https://www.cisa.gov/ai)
- [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)
- [ANSSI](https://cyber.gouv.fr/)

Les articles fournisseurs et médias peuvent compléter le contexte, mais ne doivent pas remplacer ces sources lorsque vous affirmez qu'une menace a été observée ou qu'un contrôle est recommandé.

---

## Prochaine étape

**[Playbook incident IA](playbook-incident-ia.md)** : transformer ces scénarios en procédure de confinement, investigation, révocation et retour d'expérience.