# Copilot — archives : Outils

Extraits déplacés du parcours principal le **3 octobre 2026**. Les affirmations, exemples et dates de vérification sont ceux des pages d’origine ; ils ne constituent pas une nouvelle validation des fonctionnalités Copilot. Les passages comparatifs peuvent aussi citer Claude afin de conserver leur sens.


## Accueil { #page-chapitre-13-outils-economies-index }

Origine : [chapitre-13-outils-economies/index.md](../../chapitre-13-outils-economies/index.md).

<!-- Extrait original : chapitre-13-outils-economies/index.md:7 ; paragraphe -->

L'objectif n'est plus « économiser des crédits Copilot » à tout prix. Le bon principe est : **utiliser l'outil le plus fiable et le plus simple pour chaque étape**, puis réserver le raisonnement agentique aux problèmes qui en ont réellement besoin.

<!-- Extrait original : chapitre-13-outils-economies/index.md:140 ; exemple ou liste -->

- la compatibilité éventuelle avec Copilot ou d'autres agents.

<!-- Extrait original : chapitre-13-outils-economies/index.md:237 ; exemple ou liste -->

- GitHub Copilot dans ses chapitres dédiés.

<!-- Extrait original : chapitre-13-outils-economies/index.md:295 ; section dédiée -->

#### GitHub Copilot — référence conservée

Les outils de ce chapitre peuvent aussi compléter Copilot. Les anciennes formulations centrées sur « économiser les AI Credits Copilot » sont conservées uniquement dans les pages de facturation Copilot lorsque cela est pertinent ; le chapitre Outils est désormais indépendant du fournisseur principal.

---


## RTK AI { #page-chapitre-13-outils-economies-rtk }

Origine : [chapitre-13-outils-economies/rtk.md](../../chapitre-13-outils-economies/rtk.md).

<!-- Extrait original : chapitre-13-outils-economies/rtk.md:127 ; section dédiée -->

#### Claude Code, Copilot et autres agents

Claude Code est le parcours principal de cette documentation. RTK documente également des intégrations pour d'autres assistants, dont GitHub Copilot, Cursor, Gemini CLI ou Codex selon la version.

Les options d'initialisation propres à ces agents évoluent. Pour Copilot, conservez les configurations existantes du dépôt et utilisez uniquement l'option explicitement documentée par votre version de RTK ; ne laissez pas une commande d'initialisation écraser `.github/copilot-instructions.md` ou des hooks existants sans revue.

---


## IntelliJ { #page-chapitre-13-outils-economies-sonarqube }

Origine : [chapitre-13-outils-economies/sonarqube.md](../../chapitre-13-outils-economies/sonarqube.md).

<!-- Extrait original : chapitre-13-outils-economies/sonarqube.md:7 ; paragraphe -->

GitHub Copilot reste documenté comme client secondaire du SonarQube MCP Server ; il n'est plus le parcours principal de cette page.

<!-- Extrait original : chapitre-13-outils-economies/sonarqube.md:160 ; section dédiée -->

#### GitHub Copilot — référence conservée

Le serveur MCP SonarQube documente également GitHub Copilot CLI et le coding agent. Les configurations Copilot restent valides comme référence pour les équipes qui utilisent encore cet environnement.

Ne supposez toutefois pas qu'une configuration Claude `.mcp.json` et une configuration Copilot sont interchangeables : utilisez le format attendu par chaque client.

---


## VS Code { #page-chapitre-13-outils-economies-sonarqube-vscode }

Origine : [chapitre-13-outils-economies/sonarqube-vscode.md](../../chapitre-13-outils-economies/sonarqube-vscode.md).

<!-- Extrait original : chapitre-13-outils-economies/sonarqube-vscode.md:96 ; section dédiée -->

#### Copilot — référence conservée

GitHub Copilot peut toujours être utilisé à la place de Claude pour analyser une issue Sonar. Les pages Copilot restent disponibles dans la documentation, mais elles ne constituent plus le parcours par défaut.

---


## RTK + SonarQube { #page-chapitre-13-outils-economies-rtk-sonar }

Origine : [chapitre-13-outils-economies/rtk-sonar.md](../../chapitre-13-outils-economies/rtk-sonar.md).

<!-- Extrait original : chapitre-13-outils-economies/rtk-sonar.md:125 ; section dédiée -->

#### Copilot — référence conservée

Le même packet peut être fourni à GitHub Copilot ou à un autre agent. La logique de réduction reste portable ; seul le client et son mécanisme de contexte changent.

---


## TOON { #page-chapitre-13-outils-economies-toon }

Origine : [chapitre-13-outils-economies/toon.md](../../chapitre-13-outils-economies/toon.md).

<!-- Extrait original : chapitre-13-outils-economies/toon.md:126 ; section dédiée -->

#### Copilot — référence conservée

TOON peut naturellement être utilisé avec GitHub Copilot ou d'autres agents. La logique est identique : compacter des données structurées **avant** de les injecter dans le contexte. La documentation principale utilise désormais Claude Code comme exemple, mais le format reste indépendant de l'agent.

---


## OpenSkills { #page-chapitre-13-outils-economies-openskills }

Origine : [chapitre-13-outils-economies/openskills.md](../../chapitre-13-outils-economies/openskills.md).

<!-- Extrait original : chapitre-13-outils-economies/openskills.md:98 ; exemple ou liste -->

- GitHub Copilot ;

<!-- Extrait original : chapitre-13-outils-economies/openskills.md:148 ; section dédiée -->

#### Copilot — référence conservée

OpenSkills peut servir de pont vers GitHub Copilot lorsqu'un environnement sait lire `AGENTS.md` ou lorsqu'une instruction Copilot lui demande explicitement de charger une skill. Ce comportement dépend davantage du client que dans Claude Code ; vérifiez donc la documentation Copilot actuelle au lieu de supposer une découverte automatique identique.

---


## Présentation et choix { #page-chapitre-13-outils-economies-mcps-index }

Origine : [chapitre-13-outils-economies/mcps/index.md](../../chapitre-13-outils-economies/mcps/index.md).

<!-- Extrait original : chapitre-13-outils-economies/mcps/index.md:148 ; section dédiée -->

#### GitHub Copilot — référence conservée

Copilot supporte également MCP dans certains environnements. Les mêmes serveurs peuvent parfois être réutilisables, mais la configuration, les permissions et les surfaces disponibles ne doivent pas être supposées identiques. Le parcours principal de ce chapitre utilise désormais Claude Code.

---


## MCP Web local { #page-chapitre-13-outils-economies-mcps-configuration }

Origine : [chapitre-13-outils-economies/mcps/configuration.md](../../chapitre-13-outils-economies/mcps/configuration.md).

<!-- Extrait original : chapitre-13-outils-economies/mcps/configuration.md:250 ; section dédiée -->

#### GitHub Copilot — compatibilité

La même architecture MCP peut être réutilisable avec Copilot si son client MCP supporte le transport et le contrat concernés. Ne supposez pas toutefois que scopes, permissions, auth ou UI sont identiques à Claude Code.

---


## MCP Web gratuit { #page-chapitre-13-outils-economies-mcps-serveurs }

Origine : [chapitre-13-outils-economies/mcps/serveurs.md](../../chapitre-13-outils-economies/mcps/serveurs.md).

<!-- Extrait original : chapitre-13-outils-economies/mcps/serveurs.md:158 ; section dédiée -->

#### Référence Copilot

Tavily, Firecrawl ou d'autres MCP peuvent aussi être utilisés avec GitHub Copilot lorsque l'environnement Copilot concerné supporte le serveur. La configuration doit être vérifiée séparément dans la documentation GitHub actuelle.

---


## Sécurité { #page-chapitre-13-outils-economies-mcps-securite }

Origine : [chapitre-13-outils-economies/mcps/securite.md](../../chapitre-13-outils-economies/mcps/securite.md).

<!-- Extrait original : chapitre-13-outils-economies/mcps/securite.md:192 ; section dédiée -->

#### GitHub Copilot — référence

Les risques MCP sont largement indépendants du client. En revanche, l'interface de permissions et la configuration Copilot ne sont pas identiques à Claude Code ; vérifiez la documentation GitHub lorsque vous réutilisez un serveur côté Copilot.

---

## Continue.dev (legacy) { #page-chapitre-13-outils-economies-continue-dev }

Origine : [chapitre-13-outils-economies/continue-dev.md](../../chapitre-13-outils-economies/continue-dev.md).

<!-- Extrait original : chapitre-13-outils-economies/continue-dev.md:91 ; section dédiée -->

#### Copilot — référence conservée

Certaines anciennes configurations associaient Continue au chat et Copilot à la complétion inline. Elles restent documentables pour les environnements existants, mais ne constituent plus le workflow recommandé du dépôt.

---


## Ollama { #page-chapitre-13-outils-economies-ollama }

Origine : [chapitre-13-outils-economies/ollama.md](../../chapitre-13-outils-economies/ollama.md).

<!-- Extrait original : chapitre-13-outils-economies/ollama.md:126 ; section dédiée -->

#### Copilot et autres clients

Ollama peut aussi alimenter d'autres clients compatibles OpenAI/Anthropic ou des plugins IDE. Ces usages restent possibles, mais le parcours principal de ce dépôt est désormais **Claude Code directement connecté à Ollama** lorsque l'objectif est local-first.

---


## Kilo Code { #page-chapitre-13-outils-economies-agents-code-kilo-code }

Origine : [chapitre-13-outils-economies/agents-code/kilo-code.md](../../chapitre-13-outils-economies/agents-code/kilo-code.md).

<!-- Extrait original : chapitre-13-outils-economies/agents-code/kilo-code.md:80 ; exemple ou liste -->

```text
AGENTS.md                 → conventions partagées
CLAUDE.md / .claude/      → Claude Code
.kilo/ ou kilo.jsonc      → Kilo Code
.github/                  → GitHub Copilot
```


## Windsurf (Codeium historique) { #page-chapitre-13-outils-economies-codeium-windsurf }

Origine : [chapitre-13-outils-economies/codeium-windsurf.md](../../chapitre-13-outils-economies/codeium-windsurf.md).

<!-- Extrait original : chapitre-13-outils-economies/codeium-windsurf.md:62 ; exemple ou liste -->

- [Windsurf — comparaison Copilot](https://windsurf.com/compare/windsurf-vs-github-copilot) — consulté le 2026-09-28


## Tabnine { #page-chapitre-13-outils-economies-tabnine }

Origine : [chapitre-13-outils-economies/tabnine.md](../../chapitre-13-outils-economies/tabnine.md).

<!-- Extrait original : chapitre-13-outils-economies/tabnine.md:35 ; paragraphe -->

Tabnine propose désormais une plateforme agentique ; une comparaison 2026 limitée à « autocomplete vs Copilot » est donc incomplète.


## Supermaven (historique) { #page-chapitre-13-outils-economies-supermaven }

Origine : [chapitre-13-outils-economies/supermaven.md](../../chapitre-13-outils-economies/supermaven.md).

<!-- Extrait original : chapitre-13-outils-economies/supermaven.md:49 ; paragraphe -->

Si vous cherchez une plateforme agentique complète, comparez Claude Code, Windsurf, Tabnine, Kiro, GitHub Copilot ou d'autres solutions actuelles selon vos contraintes réelles ; ne considérez pas Supermaven comme une option active équivalente.


## Comparaison des Outils { #page-chapitre-13-outils-economies-comparaison }

Origine : [chapitre-13-outils-economies/comparaison.md](../../chapitre-13-outils-economies/comparaison.md).

<!-- Extrait original : chapitre-13-outils-economies/comparaison.md:11 ; tableau comparatif -->

| Catégorie | Exemples | Rôle |
|---|---|---|
| Agent / environnement | Claude Code, Cline, Kilo Code, Windsurf, GitHub Copilot, Kiro | Lire/modifier le dépôt et orchestrer des tâches |
| Backend de modèle | Claude, Ollama, LM Studio | Fournir le modèle/inférence |
| Outil de preuve ou contexte | SonarQube, RTK, MCP, skills, Graphify | Produire des signaux, réduire le bruit ou structurer le contexte |
| Observabilité | Grafana, Loki | Visualiser, explorer, alerter et analyser les logs |
| GreenOps | Kepler | Mesurer l'énergie de workloads Kubernetes |
| Infrastructure event-driven | Solace | Distribuer les événements et relier producteurs/consommateurs |

<!-- Extrait original : chapitre-13-outils-economies/comparaison.md:39 ; paragraphe -->

GitHub Copilot reste documenté comme environnement de référence secondaire. Cline et Kilo Code disposent désormais d'une section dédiée comme agents alternatifs multi-provider.

<!-- Extrait original : chapitre-13-outils-economies/comparaison.md:45 ; tableau comparatif -->

| Contrainte | Piste à évaluer | Vérification indispensable |
|---|---|---|
| Agent principal Claude-first | Claude Code | permissions, coût réel, qualité sur le repo |
| Agent multi-provider | Cline ou Kilo Code | même modèle/test pour isoler l'effet du harness |
| Inférence locale | Ollama ou LM Studio derrière un agent compatible | RAM/VRAM, tool calling, contexte, sécurité réseau |
| Analyse statique / qualité | SonarQube for IDE + CI/MCP | règles, Quality Gate, tests |
| Sorties terminal trop verbeuses | RTK | mesurer avec `rtk gain` |
| Données structurées répétitives | TOON, après benchmark local | tokens + fidélité du round-trip |
| Cartographie relationnelle d'un gros dépôt | Graphify | fraîcheur du graphe, relations inférées, hooks installés |
| Skills multi-agents | OpenSkills | audit de la source et des scripts |
| Logs centralisés | Loki | labels, cardinalité, rétention, redaction |
| Dashboards / alerting multi-source | Grafana | qualité des data sources, permissions, provisioning |
| Mesure énergétique Kubernetes | Kepler + Prometheus + Grafana | version Kepler, matériel, protocole comparable |
| Event-driven multi-systèmes | Solace si l'architecture le justifie | topics, ACL, schémas, idempotence, observabilité |
| IDE agentique dédié | Windsurf | gouvernance, migration IDE, coûts actuels |
| Gouvernance/déploiement privé poussés | Tabnine | engagements contractuels et architecture cible |
| Stack AWS | Kiro / Amazon Q pendant la transition | échéance Q IDE, permissions AWS |
| Copilot déjà déployé | GitHub Copilot | AI Credits, politiques org, modèles disponibles |


## Vue d'ensemble des outils { #page-chapitre-13-outils-economies-outils-complementaires }

Origine : [chapitre-13-outils-economies/outils-complementaires.md](../../chapitre-13-outils-economies/outils-complementaires.md).

<!-- Extrait original : chapitre-13-outils-economies/outils-complementaires.md:121 ; tableau comparatif -->

| Produit | Statut / raison de l'évaluer | Page |
|---|---|---|
| Windsurf | IDE agentique actuel, issu de Codeium, désormais chez Cognition | [Windsurf](../../chapitre-13-outils-economies/codeium-windsurf.md) |
| Tabnine | Gouvernance et options de déploiement entreprise | [Tabnine](../../chapitre-13-outils-economies/tabnine.md) |
| Amazon Q / Kiro | Spécialisation AWS, migration en cours vers Kiro | [Amazon Q](../../chapitre-13-outils-economies/amazon-q-developer.md) |
| GitHub Copilot | Référence conservée pour compatibilité et éventuel retour | Chapitres Copilot |


## Recommandations par application { #page-chapitre-13-outils-economies-recommandations-taille-type-application }

Origine : [chapitre-13-outils-economies/recommandations-taille-type-application.md](../../chapitre-13-outils-economies/recommandations-taille-type-application.md).

<!-- Extrait original : chapitre-13-outils-economies/recommandations-taille-type-application.md:17 ; paragraphe -->

Le parcours par défaut du dépôt reste **Claude Code**, avec GitHub Copilot conservé comme référence.

<!-- Extrait original : chapitre-13-outils-economies/recommandations-taille-type-application.md:158 ; section dédiée -->

#### Quand conserver Copilot

Les pages Copilot restent utiles si :

- l'organisation le fournit déjà ;
- la complétion inline y apporte de la valeur ;
- des workflows `.github/` sont déjà industrialisés ;
- le prix ou l'offre redevient favorable ;
- certains développeurs utilisent encore cet environnement.

Le but de la migration est de rendre Claude principal, pas de casser volontairement les workflows Copilot existants.

---

---

## Prochaine étape

Poursuivez avec **[Veille IA](chapitre-14-veille-ia.md)**, la page suivante dans le menu.
