# Claude Desktop — Chat, Claude Code et travail local

<span class="badge-beginner">Débutant</span> <span class="badge-intermediate">Intermédiaire</span>

**Claude Desktop** est l'application officielle Claude pour ordinateur. Elle ne remplace pas la CLI Claude Code ni les intégrations VS Code/JetBrains : elle constitue une **surface supplémentaire** qui réunit les usages Claude sur le poste de travail.

En septembre 2026, Anthropic présente l'application Desktop comme un point d'accès unifié à **Chat, Claude Code et aux capacités de travail local**.

!!! info "À ne pas confondre"
    - **Claude Desktop** : application de bureau Claude.
    - **Claude Code CLI** : agent de développement dans le terminal.
    - **Extension VS Code / plugin JetBrains** : intégrations IDE.

Ces surfaces peuvent coexister et partager le même compte Claude, mais elles n'ont pas exactement les mêmes capacités ni les mêmes contraintes.

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
2. inventorie les extensions de bureau autorisées ;
3. appliquez le moindre privilège aux connecteurs et MCP ;
4. ne mettez aucun secret dans les deep links ;
5. validez les politiques de mise à jour et de déploiement d'entreprise ;
6. documentez les différences de disponibilité entre macOS, Windows et Linux.

Les organisations gérées peuvent utiliser les mécanismes de déploiement entreprise documentés par Anthropic pour macOS et Windows.

---

## Sources officielles

Sources consultées le **28 septembre 2026** :

- [Claude — Télécharger les applications](https://claude.com/download)
- [Anthropic Help Center — Installer Claude Desktop](https://support.claude.com/fr/articles/10065433-installer-claude-desktop)
- [Anthropic Help Center — Ouvrir Claude Desktop avec un lien](https://support.claude.com/fr/articles/14729294-ouvrir-claude-desktop-avec-un-lien)
- [Anthropic Help Center — Quand utiliser les connecteurs de bureau et web](https://support.claude.com/fr/articles/11725091-quand-utiliser-les-connecteurs-de-bureau-et-web)

## Prochaine étape

Pour installer la CLI ou les intégrations IDE, revenez à **[Installer Claude Code](installation.md)**. Pour comprendre la configuration versionnée du dépôt, poursuivez avec **[Architecture `.claude/`](architecture-claude.md)**.
