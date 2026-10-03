# Claude Desktop — Chat, Claude Code et travail local

<span class="badge-beginner">Débutant</span> <span class="badge-intermediate">Intermédiaire</span>

**Claude Desktop** est l'application officielle Claude pour ordinateur. Elle ne remplace pas la CLI Claude Code ni les intégrations VS Code/JetBrains : elle constitue une **surface supplémentaire** qui réunit les usages Claude sur le poste de travail.

En septembre 2026, Anthropic présente l'application Desktop comme un point d'accès unifié à **Chat, Claude Code et aux capacités de travail local**.

!!! info "À ne pas confondre"
    - **Claude Desktop** : application de bureau Claude.
    - **Claude Code CLI** : agent de développement dans le terminal.
    - **Extension VS Code / plugin JetBrains** : intégrations IDE.

Ces surfaces peuvent coexister et partager le même compte Claude, mais elles n'ont pas exactement les mêmes capacités ni les mêmes contraintes.

## Différences concrètes entre Chat, Cowork, Code, CLI et IDE

Desktop est le contenant ; **Chat, Cowork et Code sont des usages distincts**. Une conversation Chat avec un fichier joint ne devient pas automatiquement une session Claude Code sur le dépôt.

| Surface | Ce que vous faites | Contrainte à connaître |
|---|---|---|
| **Desktop — Chat** | Poser des questions, analyser des pièces jointes, utiliser les connecteurs disponibles | Donner du code dans le chat ne donne pas automatiquement accès au dépôt, aux tests ou à son terminal |
| **Desktop — Cowork** | Déléguer du travail sur des documents et fichiers, selon les dossiers et outils autorisés | Vérifier séparément sa disponibilité, ses permissions et les politiques de l'organisation ; les réglages Code ne décrivent pas à eux seuls Cowork |
| **Desktop — Code** | Lire/modifier un dépôt, lancer ses commandes, voir les diffs, prévisualiser une application et gérer plusieurs sessions | Choisir l'environnement d'exécution : local, cloud, SSH ou WSL. Les fonctionnalités disponibles diffèrent selon cet environnement |
| **Claude Code CLI** | Faire le même travail agentique depuis un terminal ; automatiser avec `claude -p` et des scripts | Les dépendances, credentials et fichiers doivent exister dans l'environnement du terminal ; l'interface graphique de revue Desktop n'est pas fournie par la CLI |
| **VS Code** | Travailler avec le contexte de l'éditeur et examiner les modifications dans l'IDE | Sous-ensemble de commandes slash, pas de raccourci Bash `!` ; l'extension n'ajoute pas `claude` au PATH : installer aussi la CLI pour les commandes du terminal |
| **JetBrains** | Utiliser Claude Code dans le terminal de l'IDE avec son intégration éditeur | La CLI doit être installée ; gérer les plugins Claude depuis ce terminal lorsque l'IDE n'offre pas le navigateur de plugins |

### Limites de Code dans Desktop

Au **3 octobre 2026**, la documentation distingue notamment :

- **Automatisation** : utiliser la CLI pour `--print`/`-p`, les scripts et la CI. Les tâches planifiées Desktop sont un autre mécanisme.
- **Agent teams** : disponibles dans la CLI, pas dans Desktop ; les subagents et les workflows dans une session répondent à un autre besoin.
- **Plugins** : utilisables en sessions locales et SSH ; le navigateur de plugins n'est pas disponible en cloud, les plugins installés sur le poste n'y sont pas transférés, et les sessions WSL Desktop ne les prennent pas en charge actuellement.
- **Contexte éditeur** : les mentions de fichiers et certaines interfaces de connecteurs dépendent de l'environnement ; ne pas supposer que tout ce qui fonctionne localement fonctionne en cloud/WSL.
- **Contrôle d'applications** : computer use est une preview sur macOS/Windows pour Pro/Max, indisponible sur Team/Enterprise et Linux à cette date ; ce n'est pas une capacité générale incluse avec tous les sièges Code.
- **Providers** : Desktop utilise Anthropic par défaut. Une gateway ou un provider tiers demande le parcours de configuration prévu, pas simplement une connexion au même compte.

Ces contraintes sont détaillées dans la [comparaison officielle Desktop/CLI](https://code.claude.com/docs/en/desktop#feature-comparison).

### Ce qui se partage, et ce qui se configure séparément

Les sessions **Code locales** Desktop et CLI réutilisent notamment les instructions `CLAUDE.md`, les settings, skills et hooks du projet. Les plugins installés sur un ordinateur sont partagés entre les surfaces Code compatibles de cet ordinateur. Cela ne synchronise pas toutes les installations entre ordinateurs.

Pour MCP, Desktop peut charger `claude_desktop_config.json` dans Chat et dans Code local. La CLI autonome ne lit pas directement ce fichier : utiliser l'import documenté ou une configuration MCP Claude Code. Un serveur visible dans Chat n'est donc pas une preuve qu'il est disponible dans votre terminal. Voir [la configuration partagée et les différences MCP](https://code.claude.com/docs/en/desktop#shared-configuration).

**Exemple** : pour faire corriger une API et exécuter ses tests, ouvrir **Code** sur le dépôt ou utiliser la CLI/IDE. Pour expliquer un PDF joint, **Chat** suffit. Pour traiter une série de documents dans un dossier autorisé, examiner le parcours **Cowork**.

---

## Disponibilité

Claude Desktop est actuellement proposé sur :

| Système | État |
|---|---|
| macOS | Disponible |
| Windows x64 / arm64 | Disponible |
| Linux | Bêta sur Ubuntu et Debian pris en charge |

Les exigences système et canaux d'installation évoluent : utilisez toujours la page officielle de téléchargement pour la version courante.

### Plans

Le **chat** Desktop est disponible sur tous les plans Claude. L'accès à **Claude Code dans Desktop** dépend d'un plan compatible Claude Code, actuellement Pro, Max, Team ou Enterprise.

---

## Installation

### macOS et Windows

Téléchargez l'application depuis la page officielle :

- <https://claude.com/download>

Installez-la ensuite comme une application native puis connectez-vous avec le même compte Claude que celui utilisé dans vos autres surfaces.

### Linux

Claude Desktop pour Linux est actuellement en bêta. Anthropic documente une installation via son dépôt `apt` sur Ubuntu et Debian pris en charge.

Préférez la procédure officielle à une copie figée de commandes dans vos scripts d'entreprise : clé de signature, repository et exigences de distribution peuvent évoluer.

---

## Claude Code dans l'application Desktop

Claude Code peut s'exécuter directement dans Claude Desktop. Cette surface est utile pour :

- lancer ou reprendre une tâche de code dans une interface graphique ;
- examiner les changements locaux ;
- surveiller l'état de pull requests ;
- travailler avec des serveurs Web en cours d'exécution ;
- transférer certaines sessions entre CLI et Desktop.

La CLI reste préférable lorsque vous avez besoin d'un workflow terminal explicite, de scripts ou d'automatisation CI.

### Passer de la CLI à Desktop

Dans une session Claude Code CLI compatible, la commande :

```text
/desktop
```

permet d'ouvrir ou de poursuivre le travail dans l'application Desktop.

!!! note "Vérifiez `/help`"
    Les commandes slash évoluent rapidement. Si `/desktop` n'est pas disponible dans votre version, vérifiez `/help` et mettez Claude Code à jour avant de conclure à un problème de configuration.

---

## Deep links `claude://`

Claude Desktop enregistre le schéma d'URL `claude://`. Il peut être utilisé depuis un navigateur, un script ou une autre application pour ouvrir directement une surface Claude.

Exemples documentés par Anthropic :

```text
claude://claude.ai/new
claude://code/new
```

Il est également possible de préremplir une tâche et de fournir un dossier à une nouvelle session Code via les paramètres documentés du deep link.

### Bon usage

Les deep links conviennent pour :

- un bouton « Ouvrir dans Claude Code » dans un outil interne ;
- une documentation de développeur qui renvoie vers une tâche locale ;
- un launcher ou une palette de commandes d'entreprise.

Ne placez jamais de secret, token ou donnée sensible dans un paramètre d'URL : ces valeurs peuvent être journalisées par le système ou l'application appelante.

---

## Extensions de bureau et connecteurs

Claude distingue deux familles :

| Besoin | Mécanisme |
|---|---|
| Service cloud accessible partout | Connecteur distant |
| Ressource ou application locale | Extension de bureau |

Les **extensions de bureau** peuvent connecter Claude à des ressources locales comme des fichiers, applications ou services exécutés sur la machine. Elles sont pertinentes lorsque la ressource n'est pas disponible comme service distant.

Un plugin peut également regrouper des intégrations MCP locales ou distantes selon son architecture.

!!! warning "Accès local = surface de risque"
    Une extension locale peut avoir accès au système de fichiers, à localhost ou à des applications du poste. Appliquez les mêmes principes que pour MCP : moindre privilège, provenance connue, secrets séparés et validation des actions sensibles.

---

## Desktop, CLI ou IDE ?

| Besoin | Surface la plus naturelle |
|---|---|
| Script / CI / automatisation | CLI Claude Code |
| Développement terminal-first | CLI Claude Code |
| Développement avec contexte éditeur | VS Code ou JetBrains |
| Interface graphique Claude unifiée | Claude Desktop |
| Travailler avec applications/fichiers locaux via extensions | Claude Desktop |
| Déclencher une tâche Code depuis une autre application | Deep link `claude://code/...` |

Ce tableau ne signifie pas qu'une surface exclut les autres. Un même développeur peut utiliser Desktop pour certaines tâches, CLI pour les opérations reproductibles et l'IDE pour l'édition interactive.

---

## Sécurité et gouvernance

Pour un déploiement d'équipe :

1. distinguez les politiques **Claude Desktop** de celles de la CLI et de l'IDE ;
2. inventoriez les extensions de bureau autorisées ;
3. appliquez le moindre privilège aux connecteurs et MCP ;
4. ne mettez aucun secret dans les deep links ;
5. validez les politiques de mise à jour et de déploiement d'entreprise ;
6. documentez les différences de disponibilité entre macOS, Windows et Linux.

Les organisations gérées peuvent utiliser les mécanismes de déploiement entreprise documentés par Anthropic pour macOS et Windows.

---

## Sources officielles

Sources consultées le **28 septembre 2026** :

Comparaison des surfaces et contraintes revérifiée le **3 octobre 2026** :

- [Claude Code — Desktop, comparaison CLI et configuration](https://code.claude.com/docs/en/desktop)
- [Claude Code — Installation des plugins selon la surface](https://code.claude.com/docs/en/plugins/install)
- [Claude Code — VS Code, différences avec la CLI](https://code.claude.com/docs/en/vs-code)
- [Claude Code — JetBrains et prérequis CLI](https://code.claude.com/docs/en/jetbrains)

- [Claude — Télécharger les applications](https://claude.com/download)
- [Anthropic Help Center — Installer Claude Desktop](https://support.claude.com/fr/articles/10065433-installer-claude-desktop)
- [Anthropic Help Center — Ouvrir Claude Desktop avec un lien](https://support.claude.com/fr/articles/14729294-ouvrir-claude-desktop-avec-un-lien)
- [Anthropic Help Center — Quand utiliser les connecteurs de bureau et web](https://support.claude.com/fr/articles/11725091-quand-utiliser-les-connecteurs-de-bureau-et-web)

## Prochaine étape

Poursuivez avec **[Architecture et paramétrage Claude Code](architecture-claude.md)**, la page suivante dans le menu.
