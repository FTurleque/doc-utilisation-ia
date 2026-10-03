# Cheat sheet — Commandes Claude Code

Fiche mémo vérifiée le **3 octobre 2026** : commandes de session `/`, commandes du terminal et options de lancement. La liste `/` suit le catalogue officiel à cette date ; les sous-commandes et options CLI ont aussi été contrôlées avec l'aide locale de **Claude Code 2.1.241**. La documentation en ligne peut décrire des fonctions plus récentes que votre installation.

**Votre disponibilité réelle** dépend de la version, du plan, du fournisseur, de la plateforme et des politiques de votre organisation. Tapez `/` ou `/help` dans votre session ; dans le terminal, utilisez `claude --help` et `claude <commande> --help`. Les skills, plugins et prompts MCP ajoutés par votre équipe rendent impossible une liste universelle de toutes les commandes personnalisées.

`<argument>` est obligatoire, `[argument]` facultatif. Les commandes `/` se saisissent au début d'un message Claude, les commandes `claude ...` dans votre terminal. Dans les tableaux, **S** désigne un skill fourni, **W** un workflow fourni ; les autres commandes sont intégrées au produit.

## Les commandes les plus utiles au quotidien

| Besoin | Commande |
|---|---|
| Préparer le projet | `/init`, `/memory` |
| Planifier une modification | `/plan <objectif>` |
| Comprendre le budget de contexte | `/context`, `/compact` |
| Choisir modèle et effort | `/model`, `/effort` |
| Contrôler les droits | `/permissions`, `/sandbox` |
| Relire les changements | `/diff`, `/code-review`, `/security-review` |
| Suivre un travail délégué | `/tasks`, `claude agents` |
| Démarrer une autre tâche | `/clear` |
| Reprendre ou revenir en arrière | `/resume`, `/rewind` |

## Catalogue des commandes de session

### Projet, configuration et contexte

| Commande | Fonction / précision |
|---|---|
| `/add-dir <chemin>` | Autoriser un répertoire supplémentaire ; ne charge pas toutes ses configurations |
| `/agents` | Aide à la gestion des définitions d'agents ; l'ancien éditeur interactif dépend de la version |
| `/auto-mode-setup` | Préparer la configuration du classificateur auto à revoir avant sauvegarde |
| `/autocompact [auto ou tokens]` | Régler le seuil de compaction automatique |
| `/cd <chemin>` | Changer le répertoire de travail de la session |
| `/clear [nom]` | Nouvelle conversation ; alias `/reset`, `/new` |
| `/compact [consignes]` | Résumer l'historique pour libérer du contexte |
| `/config [clé=valeur ...]` | Réglages ; alias `/settings` ; `/config --help` liste les clés |
| `/context [all]` | Occupation de la fenêtre et détails |
| `/hooks` | Consulter les hooks configurés |
| `/import [codex ou gemini ou cursor] [--dry-run] [--yes]` | Importer une configuration ; prévisualiser avec `--dry-run` |
| `/init` | Préparer les instructions du projet |
| `/keybindings` | Ouvrir la configuration clavier |
| `/mcp [reconnect ou enable ou disable] [serveur ou all]` | Connexions et authentification MCP |
| `/memory` | Instructions et mémoire automatique |
| `/output-style [style]` | Style de réponse |
| `/permissions` | Règles d'autorisation ; alias `/allowed-tools` |
| `/plugin [sous-commande]` | Menu ou opérations sur les plugins |
| `/reload-plugins [--force]` | Recharger ; `--force` peut être nécessaire si le cache de prompt change |
| `/reload-skills` | Redécouvrir skills et commandes modifiés |
| `/sandbox` | Configurer le sandbox sur les plateformes prises en charge |
| `/skill-doctor` | Coût en contexte et utilisation des skills |
| `/skills` | Lister et gérer la visibilité des skills |
| `/update-config [demande]` **S** | Faire modifier les settings correspondant à une demande |

### Conversation, modèle et usage

| Commande | Fonction / précision |
|---|---|
| `/advisor [modèle ou off]` | Consulter un second modèle ; accès dépendant du compte |
| `/branch [nom]` | Bifurquer la conversation et passer dans sa copie |
| `/btw [question]` | Question latérale hors historique principal |
| `/copy [N]` | Copier une réponse ou un bloc |
| `/effort [niveau ou auto ou status ou ultracode]` | Effort de raisonnement ; syntaxe et niveaux selon version/modèle |
| `/exit` | Quitter ; en session background attachée, détacher ; alias `/quit` |
| `/export [fichier]` | Exporter la conversation |
| `/fast [on ou off]` | Mode rapide, selon disponibilité |
| `/goal [condition ou clear]` | Objectif poursuivi entre les tours, ou annulation |
| `/help` | Aide et commandes disponibles |
| `/login`, `/logout` | Connexion et déconnexion |
| `/recap` | Résumé bref de la session |
| `/rename [nom]` | Nommer la session |
| `/resume [session]` | Reprendre ; alias `/continue` |
| `/rewind` | Point de contrôle, retour ou résumé ; alias `/checkpoint`, `/undo` |
| `/status` | Version, compte, modèle et état de session |
| `/usage` | Usage, coût et activité ; `/cost` est un alias, `/stats` ouvre l'onglet statistiques |

### Travail parallèle, revue et validation

| Commande | Fonction / précision |
|---|---|
| `/autofix-pr [consignes]` | Session cloud de correction de PR ; peut pousser des changements |
| `/background [consigne]` | Détacher la session actuelle ; alias `/bg` |
| `/batch <instruction>` **S** | Répartir une modification en unités/worktrees ; peut publier les changements |
| `/code-review [effort] [--fix] [--comment] [--max-findings n] [cible]` **S** | Revue ; `--fix` modifie, `--comment` publie ; alias `/review` |
| `/deep-research <question>` **W** | Recherche et rapport sourcé |
| `/diff` | Examiner le diff |
| `/fork [consigne]` | Copier vers une session background ; ancien comportement différent |
| `/list-agents` | Sessions et agents joignables ; alias `/peers` |
| `/loop [intervalle] [consigne]` **S** | Répéter une tâche pendant la session ; alias `/proactive` |
| `/plan [objectif]` | Mode plan |
| `/run` **S** | Lancer et piloter l'application du projet |
| `/run-skill-generator` **S** | Décrire le lancement/vérification du projet dans un skill |
| `/schedule [description]` | Routines cloud ; alias `/routines` |
| `/security-review` | Revue sécurité du diff de branche |
| `/simplify [cible]` **S** | Simplifier le code et appliquer les corrections |
| `/stop` | Arrêter la session background concernée ; conserve son travail |
| `/subtask <tâche>` | Subagent avec copie du contexte ; résultat renvoyé à cette conversation |
| `/tasks` | Tâches de la session ; alias `/bashes` |
| `/ultrareview [PR ou branche]` | Revue cloud ; invocation préférée `/code-review ultra` |
| `/verify` **S** | Vérifier le comportement en lançant et observant l'application |
| `/workflow-authoring` **S** | Référence pour écrire les workflows dynamiques |
| `/workflows` | Suivre, suspendre, reprendre ou sauvegarder les workflows |

Un **background agent**, une **agent team** et un **subagent** sont différents : voir [l'orchestration multi-agents](../chapitre-4-contexte/orchestration-multi-agents.md). Le fonctionnement d'une commande fournie comme skill est aussi influencé par le raisonnement du modèle : ce n'est pas une API déterministe de déploiement.

### Interfaces, intégrations et création

| Commande | Fonction / précision |
|---|---|
| `/artifact-capabilities` **S** | Capacités des artifacts disponibles |
| `/artifact-diagramming` **S** | Guide des diagrammes d'artifacts |
| `/artifacts` | Lister et ouvrir les artifacts accessibles |
| `/chrome` | Réglages de l'intégration Chrome |
| `/claude-api [sous-commande]` **S** | Références et workflows API Claude |
| `/claude-in-chrome [tâche]` **S** | Piloter Chrome avec l'intégration active |
| `/color [couleur ou default]` | Couleur de la session |
| `/dataviz [demande]` **S** | Guide de visualisation de données |
| `/design [brief]` **S** | Créer des maquettes Claude Design, selon accès |
| `/design-login` | Authentifier l'accès au design system |
| `/design-sync [indication]` **S** | Synchroniser un design system React vers Claude Design |
| `/desktop` | Continuer dans Desktop ; alias `/app` ; plateforme/abonnement requis |
| `/focus` | Vue focalisée, selon interface |
| `/ide` | Intégration IDE et statut |
| `/install-github-app` | Configurer l'app GitHub et éventuellement les workflows |
| `/install-slack-app` | Parcours d'installation Slack |
| `/mobile` | Accès à l'application mobile ; alias `/ios`, `/android` |
| `/model [modèle]` | Choix de modèle et réglage de l'effort selon modèle |
| `/plugin-authoring` | Référence d'écriture des mods, via plugin intégré ; version récente requise |
| `/powerup` | Tutoriels interactifs |
| `/radio` | Radio Claude FM |
| `/remote-control` | Accès distant à la session locale ; alias `/rc` |
| `/remote-env` | Environnement cloud par défaut |
| `/scroll-speed` | Vitesse de défilement, selon interface |
| `/setup-bedrock` | Assistant Bedrock, selon variables de fournisseur |
| `/setup-vertex` | Assistant fournisseur Google, selon variables de fournisseur |
| `/slides [brief]` **S** | Présentation Claude Slides, selon accès |
| `/statusline` | Configurer la ligne d'état |
| `/stickers` | Commande de stickers |
| `/team-onboarding` | Guide d'accueil d'équipe à partir de l'usage |
| `/teleport` | Rapatrier une session cloud ; alias `/tp` |
| `/terminal-setup` | Configurer le terminal et les raccourcis compatibles |
| `/theme` | Thème de l'interface |
| `/tui [default ou fullscreen]` | Choisir le rendu du terminal |
| `/voice [hold ou tap ou off]` | Dictée, selon compte |
| `/web-setup` | Connecter GitHub pour les sessions cloud |

### Diagnostic, compte et partage

| Commande | Fonction / précision |
|---|---|
| `/bug [rapport]` | Rapport avec choix du contenu et confirmation ; alias `/share` |
| `/debug [description]` **S** | Activer les logs et diagnostiquer |
| `/doctor [prompt-audit [chemin]]` **S** | Diagnostic et corrections proposées ; alias `/checkup` ; `prompt-audit` nécessite une version récente |
| `/feedback [rapport]` | Retour produit ou examen des brouillons de feedback |
| `/fewer-permission-prompts` **S** | Préparer une liste d'autorisations à partir des appels fréquents |
| `/heapdump` | Diagnostic mémoire caché ; le heap snapshot peut contenir credentials et conversation |
| `/insights` | Rapport d'usage des sessions locales |
| `/passes` | Invitations, selon éligibilité |
| `/privacy-settings` | Réglages de confidentialité, selon plan |
| `/rate-limit-options` | Options à la limite d'usage |
| `/release-notes` | Changelog |
| `/upgrade` | Page de changement d'offre |
| `/usage-credits` | Facturation ou demande de crédits à un administrateur ; ancien nom `/extra-usage` |

### Commandes retirées ou renommées

| Ancienne commande | Remplacement |
|---|---|
| `/pr-comments` | Demander à Claude de lire les commentaires de PR |
| `/ultraplan` | `/plan` |
| `/vim` | `/config` puis le mode d'édition |
| `/extra-usage` | `/usage-credits` |

### Commandes ajoutées par votre projet

`/<nom-skill>` invoque un skill disponible. Les plugins utilisent notamment `/<plugin>:<skill>`. Les prompts MCP exposés apparaissent dans le menu avec leur nom propre. `/skills`, `/plugin` et `/mcp` permettent d'inspecter les sources ; ne supposez pas qu'une commande personnalisée existe sur toutes les machines.

## Commandes du terminal

### Démarrage et sessions

```bash
claude
claude "Explique l'architecture du projet"
claude -p "Résume ce fichier"
claude --continue
claude --resume
claude --bg --worktree audit "Audite les tests sans modifier le code"
```

| Commande | Fonction |
|---|---|
| `claude agents` | Vue des sessions background ; `--json --all` pour les scripts |
| `claude attach <id>` | Ouvrir une session background |
| `claude logs <id>` | Sortie récente |
| `claude stop <id>` | Arrêter, sans supprimer |
| `claude rm <id>` | Supprimer la session ; vérifier le sort du worktree et de son contenu |
| `claude daemon status`, `logs`, `run`, `stop`, `uninstall` | Superviseur local ; aide et fonctions selon version |
| `claude doctor` | Diagnostic d'installation en lecture seule |
| `claude install [stable ou latest ou version]` | Installer une version native |
| `claude update` | Mettre à jour ; alias `upgrade` |
| `claude setup-token` | Préparer un token d'authentification durable |
| `claude gateway` | Passerelle entreprise ; options dans `--help` |
| `claude import [source]` | Import de configuration ; options dans `--help` |
| `claude ultrareview [cible]` | Revue multi-agents cloud |
| `claude purge [chemin]` | Depuis 2.1.288 : effacer l'état Claude du projet ; commencer par `--dry-run`. Avant 2.1.288 : `claude project purge [chemin]`. Opération destructive |
| `claude auto-mode config`, `defaults`, `critique`, `reset` | Configuration du classificateur ; `reset` modifie les settings utilisateur |

### Authentification, MCP et plugins

Chaque forme se préfixe par `claude` ; ajoutez `--help` pour les arguments et options exacts.

| Famille | Sous-commandes contrôlées dans l'aide locale |
|---|---|
| `auth` | `login`, `logout`, `status` |
| `mcp` | `add`, `add-json`, `add-from-claude-desktop`, `get`, `list`, `login`, `logout`, `remove`, `reset-project-choices`, `serve` |
| `plugin` (alias `plugins`) | `details`, `disable`, `enable`, `eval`, `init` (alias `new`), `install` (alias `i`), `list`, `prune` (alias `autoremove`), `tag`, `uninstall` (alias `remove`), `update`, `validate`, `marketplace` |
| `plugin marketplace` | `add`, `list`, `remove` (alias `rm`), `update` |
| Toutes les familles | `help [sous-commande]` ou `--help` |

Exemples :

```bash
claude auth status
claude mcp add --transport http mon-serveur https://mcp.example.com/mcp
claude plugin validate ./tools/mon-plugin
claude plugin install mon-plugin@mon-marketplace
```

L'URL `example.com` est un exemple à remplacer. Les commandes d'installation, connexion, suppression et publication modifient un état ou peuvent ouvrir un parcours externe : vérifiez la cible avant exécution.

## Options de lancement

Inventaire des options visibles dans `claude --help` de la version locale contrôlée. Les options expérimentales ou cachées documentées séparément peuvent s'ajouter ; par exemple `--teammate-mode` pour les teams. Vérifiez l'aide de votre version avant d'automatiser.

| Option | Fonction |
|---|---|
| `--add-dir` | Répertoires supplémentaires |
| `--agent`, `--agents` | Rôle principal ou définitions JSON |
| `--allowedTools`, `--allowed-tools` | Outils autorisés sans confirmation selon les règles applicables |
| `--disallowedTools`, `--disallowed-tools` | Outils interdits |
| `--tools` | Ensemble d'outils intégré disponible |
| `--permission-mode` | Mode de permissions |
| `--dangerously-skip-permissions` | Contournement des permissions ; ne crée pas de sandbox |
| `--allow-dangerously-skip-permissions` | Rend ce contournement sélectionnable sans l'activer par défaut |
| `--settings` | Fichier ou JSON de réglages |
| `--setting-sources` | Sources user/project/local chargées |
| `--model`, `--effort`, `--autocompact` | Modèle, effort et fenêtre de compaction |
| `--fallback-model` | Repli de modèle en mode print |
| `--betas` | En-têtes bêta, selon authentification |
| `--system-prompt`, `--append-system-prompt` | Remplacer ou compléter le prompt système |
| `--exclude-dynamic-system-prompt-sections` | Déplacer les sections liées à la machine du prompt système vers le premier message, pour le cache partagé |
| `--bg`, `--background` | Session détachée ; incompatible avec `-p` |
| `-c`, `--continue` | Conversation récente |
| `-r`, `--resume` | Reprise ou sélection de session |
| `--fork-session` | Nouvelle identité lors d'une reprise |
| `--from-pr` | Reprise liée à une PR |
| `-n`, `--name`, `--session-id` | Nom ou identifiant de session |
| `-w`, `--worktree`, `--tmux` | Worktree et session tmux associée |
| `-p`, `--print` | Réponse non interactive puis sortie |
| `--input-format`, `--output-format` | Formats texte/JSON/flux pris en charge |
| `--json-schema` | Sortie structurée |
| `--max-budget-usd` | Plafond API en mode print ; ce n'est pas un plafond global de compte |
| `--no-session-persistence` | Désactiver la sauvegarde en mode print |
| `--include-partial-messages` | Messages partiels dans un flux |
| `--include-hook-events` | Événements de hooks dans la sortie appropriée |
| `--forward-subagent-text` | Texte et raisonnement des subagents dans la sortie appropriée |
| `--replay-user-messages` | Réémettre l'entrée dans un flux JSON |
| `--prompt-suggestions` | Suggestions de prompt |
| `--brief` | Communication agent/utilisateur via l'outil prévu |
| `--mcp-config`, `--strict-mcp-config` | Configuration MCP explicite et restriction aux sources passées |
| `--plugin-dir`, `--plugin-url` | Plugins locaux/ZIP ou URL pour la session |
| `--disable-slash-commands` | Désactiver les skills |
| `--bare` | Mode minimal ; configuration et authentification spécifiques |
| `--safe-mode` | Diagnostic avec personnalisations désactivées ; politiques gérées conservées |
| `--chrome`, `--no-chrome`, `--ide` | Intégrations navigateur/IDE |
| `--cloud`, `--environment`, `--teleport` | Sessions et environnement cloud |
| `--remote-control`, `--remote-control-session-name-prefix` | Accès distant et préfixe de nom |
| `--file` | Ressources à télécharger au démarrage |
| `-d`, `--debug`, `--debug-file`, `--verbose` | Journaux et diagnostic |
| `--ax-screen-reader` | Rendu pour lecteur d'écran |
| `-h`, `--help`, `-v`, `--version` | Aide et version |

## Pièges rapides à éviter

- `/exit` dans une session background attachée **ne l'arrête pas** ; utilisez `/stop` ou `claude stop`.
- `/fork`, `/branch` et `/subtask` ont des destinations différentes : nouvelle session background, copie dans laquelle vous passez, ou résultat retourné à la session actuelle.
- `/compact` résume ; `/clear` démarre une nouvelle conversation.
- `--dangerously-skip-permissions` ne remplace pas un [sandbox](../chapitre-4-contexte/sandbox.md).
- `/autofix-pr`, `/batch` et les options de commentaire de revue peuvent écrire ou publier ; lisez leur portée avant lancement.
- Les commandes de mise à jour et de suppression ne sont pas des diagnostics en lecture seule.

---

## Prochaine étape

Poursuivez avec **[Contexte & Personnalisation — Accueil](../chapitre-4-contexte/index.md)**, la page suivante dans le menu.

## Sources

- [Claude Code — purge locale : renommage en 2.1.288 et aperçu `--dry-run`](https://code.claude.com/docs/en/claude-directory#clear-local-data) — contrôlé le 2026-10-03

- [Claude Code — Catalogue officiel des commandes](https://code.claude.com/docs/en/commands)
- [Claude Code — Référence CLI](https://code.claude.com/docs/en/cli-reference)
- [Claude Code — Agent view et commandes de sessions background](https://code.claude.com/docs/en/agent-view)
- [Claude Code — Agent teams expérimentales](https://code.claude.com/docs/en/agent-teams)
- Vérification locale : `claude --version`, `claude --help` et l'aide des familles CLI, le **3 octobre 2026**. Aucun lancement d'agent ou changement de configuration n'a été nécessaire pour cet inventaire.
