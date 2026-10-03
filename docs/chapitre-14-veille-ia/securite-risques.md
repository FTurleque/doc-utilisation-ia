# Sécurité, risques & failles IA

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span>

La sécurité de Claude Code et des autres agents de développement ne se limite plus aux risques d'un chatbot. Un agent peut lire des fichiers, exécuter des commandes, appeler des MCP, modifier le dépôt et interagir avec des services externes. La veille doit donc couvrir **LLM + agent + outils + identité + supply chain**.

---

## Référence OWASP actuelle

Le **OWASP GenAI Security Project** est la référence principale de ce chapitre. En septembre 2026, le projet a annoncé :

- une nouvelle édition **Top 10 for LLM Applications 2026** ;
- un **Agent Control Standard** destiné aux systèmes agentiques ;
- des ressources dédiées à la sécurité des agents et des applications GenAI.

Ne figez pas ici une copie complète du Top 10 : utilisez la version officielle, car les catégories et recommandations évoluent.

- [OWASP GenAI Security Project](https://genai.owasp.org/)
- [Top 10 for LLM and GenAI](https://genai.owasp.org/initiative/owasp-top-10-for-llm-and-genai/)

---

## Menaces prioritaires pour un agent de code

| Risque | Exemple | Contrôle principal |
|---|---|---|
| Prompt injection indirecte | instruction malveillante dans README, issue, page Web ou réponse MCP | traiter le contenu externe comme non fiable ; limiter les outils |
| Permissions excessives | agent autorisé à écrire partout ou exécuter toute commande | moindre privilège, confirmation et sandbox |
| Exfiltration | secret lu puis envoyé à un service externe | réduire accès fichiers/réseau ; secrets hors contexte |
| Supply chain | package, skill, plugin ou MCP compromis | provenance, revue, version épinglée, permissions minimales |
| Sortie non vérifiée | code ou commande générée utilisée sans validation | tests, lint, analyse statique, revue du diff |
| Identité/credentials | token sur-privilégié disponible dans l'environnement | tokens courts, scope minimal, comptes dédiés |
| Context poisoning | document ou source RAG/MCP polluée | provenance, ACL, validation des sources |
| Consommation non bornée | boucle agentique ou outil trop bavard | limites, budgets, timeout, taille de sortie bornée |

---

## Dépôts tiers : considérer les instructions comme du code

Avant de laisser Claude Code travailler dans un dépôt cloné :

1. inspectez `CLAUDE.md`, `CLAUDE.local.md`, `AGENTS.md` et `.claude/` ;
2. inspectez `.mcp.json` et les serveurs qu'il déclare ;
3. inspectez hooks, scripts et skills ;
4. vérifiez les commandes de bootstrap (`postinstall`, scripts shell, Makefile, Gradle/Maven plugins, etc.) ;
5. n'accordez pas immédiatement des permissions larges.

Une instruction Markdown peut modifier le comportement d'un agent ; une skill ou un hook peut en plus déclencher du code.

---

## MCP : frontière de confiance explicite

Un serveur MCP peut exposer des données et des actions. Pour chaque serveur :

- qui l'exécute ?
- où tourne-t-il ?
- quels outils expose-t-il ?
- quels secrets reçoit-il ?
- peut-il écrire ou seulement lire ?
- quelles destinations réseau peut-il atteindre ?
- quelle quantité de contenu peut-il retourner ?

Pour un MCP local qui récupère des URL, protégez notamment contre **SSRF**, redirections vers réseaux privés, prompt injection provenant du Web et exfiltration via des outils réseau.

---

## Skills, plugins et hooks

Une skill tierce n'est pas « juste un prompt ». Elle peut contenir références et scripts. Un plugin ou hook peut exécuter des commandes.

Avant adoption :

```text
source connue
→ lire instructions
→ inspecter scripts
→ vérifier dépendances
→ épingler la révision si nécessaire
→ tester dans un environnement non sensible
→ déployer progressivement
```

Ne synchronisez pas automatiquement une source tierce non auditée vers tous les postes de l'équipe.

---

## Dépendances suggérées par un LLM

Ne vous fiez pas à un nom de package généré.

Vérifiez :

- existence sur le registre officiel ;
- propriétaire/mainteneur ;
- historique de versions ;
- dépôt source ;
- advisory de sécurité ;
- nécessité réelle d'ajouter la dépendance.

L'ancien conseil « regarder seulement le nombre de téléchargements » est insuffisant : un package populaire peut aussi être compromis et un package légitime de niche peut avoir peu de téléchargements.

---

## Secrets et données sensibles

Principe : **ne rendez pas un secret accessible à l'agent s'il n'en a pas besoin**.

- utilisez un secret manager ou des variables injectées au runtime ;
- évitez de stocker des tokens dans `.mcp.json`, `CLAUDE.md`, scripts d'exemple ou tickets ;
- préférez des identités temporaires et scopes minimaux ;
- évitez d'inclure `.env`, clés privées, dumps de production ou données personnelles dans le contexte ;
- nettoyez les logs avant partage.

Un backend local réduit certains transferts cloud mais ne protège pas automatiquement les fichiers, logs, MCP ou services réseau du poste.

---

## Validation du code généré


```text
modification IA
→ diff humainement lisible
→ tests ciblés
→ lint/typecheck
→ analyse statique / SAST si disponible
→ tests de sécurité pertinents
→ CI / Quality Gate
```

Pour une modification critique, exigez une preuve reproductible plutôt qu'une affirmation « c'est sécurisé ».

---

## Incident response agentique

Si un agent exécute une action inattendue :

1. arrêter la session / révoquer l'accès si nécessaire ;
2. préserver les logs utiles sans exposer de secrets ;
3. identifier outils, credentials et destinations utilisés ;
4. révoquer/faire tourner les tokens potentiellement exposés ;
5. inspecter le diff et les commandes exécutées ;
6. rechercher la source : instruction, MCP, skill, contenu externe, erreur utilisateur ou bug produit ;
7. ajouter un contrôle empêchant la répétition.

Le chapitre 15 fournit les playbooks et matrices opérationnelles correspondants.

---

## Références de veille

- [OWASP GenAI Security Project](https://genai.owasp.org/)
- [NIST AI Risk Management Framework](https://www.nist.gov/itl/ai-risk-management-framework)
- [MITRE ATLAS](https://atlas.mitre.org/)
- [Anthropic Research](https://www.anthropic.com/research)
- [Anthropic Newsroom](https://www.anthropic.com/news)
- [GitHub Security](https://github.blog/security/)
- [CNIL — Intelligence artificielle](https://www.cnil.fr/fr/intelligence-artificielle)

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-14-veille-ia.md#page-chapitre-14-veille-ia-securite-risques).

## Prochaine étape

Poursuivez avec **[Newsletters & Communautés](newsletters-communautes.md)**, la page suivante dans le menu.
