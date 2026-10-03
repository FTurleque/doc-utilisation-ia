# Plugins d'équipe — Claude Code

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span>

Un **plugin Claude Code** est un paquet de capacités réutilisables : skills, commandes, agents, hooks et intégrations. Il peut vivre dans un dépôt dédié **ou dans le dépôt de votre application**. Vous pouvez donc versionner avec l'application une partie de votre outillage IA et la charger comme plugin.

La limite importante : **un plugin ne distribue pas automatiquement tout `.claude/`**. Il possède sa propre arborescence et ses propres composants. Les instructions du projet, permissions, réglages locaux et secrets ont des emplacements et des règles distincts.

Fonctionnement et exemples revérifiés le **3 octobre 2026** auprès de la documentation officielle.

---

## Qu'est-ce qu'un plugin ?

| Élément | Rôle |
|---|---|
| `.claude-plugin/plugin.json` | Nom, version, description et configuration du paquet ; seul `name` est requis dans ce manifeste |
| `skills/<nom>/SKILL.md` | Procédure et ressources ; invocation `/<plugin>:<skill>` |
| `commands/*.md` | Ancien format de commandes ; préférer les skills pour les nouveaux workflows |
| `agents/*.md` | Subagents spécialisés réutilisables |
| `hooks/hooks.json` | Automatisations déclarées aux événements Claude Code |
| `.mcp.json` / `.lsp.json` | Serveurs MCP et configurations de serveurs de langage |
| `scripts/` | Scripts auxiliaires appelés par les composants ; ce dossier seul ne déclenche rien |

Les composants sont à la **racine du plugin**, à côté de `.claude-plugin/`, et non à l'intérieur de ce dossier de métadonnées. Le format général est décrit dans [la référence officielle](https://code.claude.com/docs/en/plugins-reference).

### Ce que vous pouvez mutualiser et ce qui reste au projet

| Configuration existante | Traitement adapté |
|---|---|
| `.claude/skills/` | Transformer les procédures partagées en `skills/` du plugin |
| `.claude/agents/` | Copier/adapter les spécialistes partageables dans `agents/` du plugin |
| `.claude/commands/` | Adapter en `commands/`, ou migrer vers des skills |
| Hooks configurés dans `.claude/settings.json` | Déclarer les hooks du paquet dans `hooks/hooks.json` et embarquer leurs scripts |
| `CLAUDE.md` et `.claude/rules/` | Conserver les instructions propres au dépôt ; une instruction réutilisable peut devenir une skill, avec un chargement différent |
| Permissions, modèle par défaut, policies dans `.claude/settings.json` | Conserver dans les settings projet/utilisateur ou la politique gérée appropriée |
| `.claude/settings.local.json`, clés API, credentials MCP | Configuration individuelle ; ne pas embarquer les secrets dans le plugin |

**Un `CLAUDE.md` placé à la racine du plugin n'est pas chargé comme contexte projet.** Une skill n'est pas équivalente à une règle toujours chargée : elle apporte ses instructions lorsqu'elle est invoquée. Pour un contrôle déterministe à un événement, examiner les hooks et garder les contrôles CI appropriés.

Le `settings.json` du plugin ne remplace pas celui du projet : la documentation actuelle n'y applique que les defaults `agent` et `subagentStatusLine`. On ne peut donc pas y déposer arbitrairement toute la configuration `.claude/settings.json` en supposant qu'elle sera appliquée. Voir [les composants et limites](https://code.claude.com/docs/en/plugins/components).

---

## Installer dans un projet : stockage, activation et version sont trois choses

Un plugin peut être **hébergé** dans le dépôt d'application sans être **chargé** par Claude. Réciproquement, un plugin externe peut être **activé pour le projet** sans que ses sources soient copiées dans ce dépôt.

| Question | Réponse |
|---|---|
| Où sont ses sources ? | Dans le dépôt du plugin, un sous-dossier d'application ou le catalogue local |
| Où est enregistrée son activation ? | Dans les settings correspondant à la portée choisie |
| Où sont les fichiers installés ? | Généralement dans le cache utilisateur Claude ; un catalogue local à source relative peut charger directement ses fichiers |
| Qu'est-ce qui est versionné avec l'application ? | Les sources si elles y sont hébergées, et/ou les settings partagés d'activation ; pas le cache utilisateur |

Installer un plugin ne crée pas des dossiers `.claude/skills/`, `.claude/agents/` et `.claude/commands/` contenant des copies « héritées ». Les composants sont chargés depuis le plugin. Le préfixe du plugin évite notamment de confondre `/review` local et `/application-ia:review` fourni par le paquet.

### Portées d'installation

| Portée | Effet | Fichier d'activation |
|---|---|---|
| `user` | Pour cet utilisateur dans ses projets sur ce poste ; portée par défaut | `~/.claude/settings.json` |
| `project` | Activation partagée pour le dépôt | `.claude/settings.json`, versionnable |
| `local` | Pour cet utilisateur dans ce dépôt uniquement | `.claude/settings.local.json`, local |

**Activation partagée ne signifie pas installation sur toutes les machines.** Pour une source externe, chaque collaborateur doit disposer du marketplace et installer le plugin. La documentation précise une exception pour les sources relatives de catalogue, qui peuvent charger directement depuis le catalogue disponible. Utilisez un onboarding explicite et vérifiable plutôt que supposer qu'un clone suffit dans tous les cas. Voir [les portées](https://code.claude.com/docs/en/plugins/install#choose-an-install-scope) et [le chargement](https://code.claude.com/docs/en/plugins/loading).

---

## Comment créer un plugin

### Exemple : versionner le plugin dans le dépôt d'application

Cette organisation garde les instructions spécifiques au projet et ses capacités empaquetées dans le **même dépôt Git** :

```text
mon-application/
├── src/
├── tests/
├── CLAUDE.md                         # commandes et invariants du projet
├── .claude/
│   ├── rules/                        # règles spécifiques au code
│   └── settings.json                 # activation / permissions du projet
├── .claude-plugin/
│   └── marketplace.json              # catalogue facultatif du dépôt
└── tools/
    └── application-ia/               # racine du plugin
        ├── .claude-plugin/
        │   └── plugin.json
        ├── skills/
        │   └── review/
        │       └── SKILL.md
        └── agents/
            └── reviewer.md
```

### Manifeste minimal

Dans `tools/application-ia/.claude-plugin/plugin.json` :

```json
{
  "name": "application-ia",
  "version": "1.0.0",
  "description": "Revue et conventions de mon application",
  "author": { "name": "Équipe application" }
}
```

Les emplacements standards `skills/` et `agents/` sont découverts sans ajouter des chemins au manifeste. Utilisez un objet pour `author`, pas une chaîne de caractères.

### Ajouter une skill réutilisable

Dans `tools/application-ia/skills/review/SKILL.md` :

```markdown
---
name: review
description: Relire le diff de l'application avec les conventions de l'équipe.
disable-model-invocation: true
---

Lis CLAUDE.md et le diff Git courant.
Identifie les régressions, contrôles d'accès manquants et tests nécessaires.
Ne modifie aucun fichier.
Rends une liste de constats avec chemin, ligne, scénario et preuve.
Distingue ce qui a été vérifié de ce qui reste une hypothèse.
```

L'utilisateur lance cette skill avec `/application-ia:review`. Ici, `disable-model-invocation: true` réserve son invocation à l'utilisateur ; sans ce choix, la description peut aussi aider Claude à décider de la charger.

### Ajouter un agent réutilisable

Dans `tools/application-ia/agents/reviewer.md` :

```markdown
---
name: reviewer
description: Examiner les changements de l'application en lecture seule.
tools: Read, Glob, Grep
model: sonnet
---

Examine les fichiers désignés dans la mission.
Retourne des constats reproductibles avec chemins et lignes.
Ne présente pas une absence de preuve comme une absence de défaut.
```

La skill décrit une procédure ; l'agent permet au principal de déléguer une analyse avec son propre contexte. Ils peuvent coexister sans être tous les deux nécessaires pour chaque revue.

### Tester les sources du dépôt sans marketplace

Depuis la racine de `mon-application/` :

```bash
claude plugin validate ./tools/application-ia
claude --plugin-dir ./tools/application-ia
```

Dans la session ouverte :

```text
/application-ia:review
```

`--plugin-dir` charge ce dossier pour **la session**, sans installer le plugin durablement. C'est pratique pour développer, suivre le commit de l'application et tester les modifications locales. Un dossier simplement présent dans `tools/` n'est pas chargé automatiquement.

---

## Distribuer un plugin via marketplace

Un marketplace est un catalogue : **`.claude-plugin/marketplace.json` à la racine du catalogue**. Il peut être dans le dépôt d'application de l'exemple, dans un dépôt partagé ou dans un répertoire local.

### Catalogue dans le même dépôt

Dans `mon-application/.claude-plugin/marketplace.json` :

```json
{
  "name": "application-marketplace",
  "description": "Catalogue de l'outillage IA de l'application",
  "owner": { "name": "Équipe application" },
  "plugins": [
    {
      "name": "application-ia",
      "source": "./tools/application-ia",
      "description": "Outillage IA versionné avec l'application"
    }
  ]
}
```

`source` est relatif à la **racine du catalogue**, donc ici à `mon-application/`, et non au dossier `.claude-plugin/`. Le nom de l'entrée et celui du manifeste doivent correspondre.

Depuis la racine de l'application :

```bash
claude plugin validate .
claude plugin marketplace add .
claude plugin install application-ia@application-marketplace --scope project
claude plugin list
claude plugin details application-ia
```

L'installation en portée `project` enregistre notamment ceci dans `.claude/settings.json` ; conserver les autres réglages existants :

```json
{
  "enabledPlugins": {
    "application-ia@application-marketplace": true
  }
}
```

Versionnez le catalogue, le plugin et les settings partagés. Dans l'onboarding, demandez aux collègues d'enregistrer le catalogue de **leur propre clone** puis de vérifier le chargement. Un chemin enregistré sur votre ordinateur ne désigne pas leur clone.

### Plugin dans un autre dépôt ou un monorepo

Le catalogue peut référencer un dépôt dédié avec une source `github`, ou un sous-dossier avec `git-subdir` :

```json
{
  "name": "application-ia",
  "source": {
    "source": "git-subdir",
    "url": "mon-org/mon-application",
    "path": "tools/application-ia",
    "ref": "v1.0.0"
  }
}
```

Cet objet est une **entrée** de l'array `plugins` du catalogue. Le tag est un exemple : il doit réellement exister. Pour une reproductibilité plus forte, utiliser le commit `sha` pris en charge par la source. L'accès au dépôt privé et les dépendances des scripts doivent aussi être préparés sur chaque poste. Voir [les sources de marketplace](https://code.claude.com/docs/en/plugin-marketplaces#choose-a-plugin-source).

---

## Hooks et MCP : empaqueter les composants, prévoir leur environnement

Un plugin peut contenir `hooks/hooks.json` et ses scripts. Dans les commandes des hooks, utiliser `${CLAUDE_PLUGIN_ROOT}` pour désigner les fichiers du plugin ; ne pas supposer qu'ils vivent dans le `.claude/` du projet. La configuration du hook doit correspondre à l'événement et au format d'entrée réels : un script qui lit `sys.argv[1]` ne devient pas un hook fonctionnel uniquement parce qu'il est déposé dans `hooks/`.

Pour MCP, fournir la définition dans `.mcp.json` ou le composant prévu. Préparer séparément les credentials et runtimes nécessaires. Installer le plugin n'installe pas automatiquement toutes les dépendances système et ne donne pas les autorisations de connexion de chacun.

Les hooks peuvent exécuter du code sur le poste : relire les scripts et tester leurs effets. Une vérification proposée par une skill reste une instruction au modèle ; un contrôle CI est une preuve indépendante pour les validations obligatoires.

---

## Gouvernance et maintenance du plugin

### Versionner n'est pas mettre tout le monde à jour automatiquement

Un commit ou un tag publié ne force pas tous les postes et projets à charger instantanément la nouvelle version. Pour les installations distantes, gérer la version du manifeste, la source du catalogue, les mises à jour et le rechargement. Si la version reste identique, une référence Git qui bouge peut laisser les utilisateurs sur la copie en cache.

Un catalogue **local**, avec source relative, lit les fichiers directement : les changements sont pris en compte au démarrage suivant ou après `/reload-plugins`, sans étape de téléchargement. C'est différent d'une installation depuis un catalogue cloné à distance.

Pour publier une nouvelle version :

1. revoir les skills, agents et scripts, puis tester une installation propre ;
2. augmenter `version` si elle est définie dans le manifeste et publier le commit/tag ;
3. mettre à jour la référence du catalogue lorsqu'elle est épinglée ;
4. actualiser le catalogue et le plugin sur les postes concernés ;
5. recharger ou redémarrer les sessions selon l'indication de Claude Code ;
6. contrôler la version et les composants réellement chargés avec `claude plugin list` et `claude plugin details`.

Le catalogue peut être actualisé avec `claude plugin marketplace update application-marketplace` ; le navigateur `/plugin`, onglet des plugins installés, permet de gérer la mise à jour du plugin. Documenter un retour à la version précédente avant de distribuer un hook qui change le comportement de l'équipe. Voir [la maintenance et les versions](https://code.claude.com/docs/en/plugins/host-marketplace).

### Quand créer un plugin ?

| Situation | Organisation adaptée |
|---|---|
| Un seul dépôt, quelques instructions propres à son code | `CLAUDE.md`, rules et `.claude/` versionnés peuvent suffire |
| Un paquet cohérent à tester ou distribuer avec l'application | Plugin dans `tools/` et chargement explicite |
| Plusieurs applications partagent les mêmes capacités | Plugin commun et catalogue partagé |
| Besoin de permissions ou de politiques obligatoires | Settings/politiques gérées et validations indépendantes ; le plugin ne remplace pas la gouvernance |

Choisissez selon les responsabilités et la fréquence de changement, sans seuil arbitraire de nombre de projets.

### Pièges à éviter

- Copier tout `.claude/` dans un plugin en supposant que les mêmes chemins sont reconnus.
- Mettre `CLAUDE.md` dans le paquet et croire qu'il sera toujours chargé.
- Confondre présence des sources, activation dans les settings et installation sur chaque poste.
- Modifier une copie en cache au lieu des sources versionnées.
- Ignorer les chemins, exécutables et credentials nécessaires aux hooks/MCP.
- Promettre que toutes les surfaces supportent les mêmes plugins : les contraintes Desktop cloud/WSL sont précisées dans [Claude Desktop](claude-desktop.md).
- Publier un changement de hook sans revue, tests de comportement et possibilité de retour arrière.

## Sources

Sources consultées le **3 octobre 2026** :

- [Claude Code — Référence et manifeste des plugins](https://code.claude.com/docs/en/plugins-reference)
- [Claude Code — Composants et instructions de plugin](https://code.claude.com/docs/en/plugins/components)
- [Claude Code — Installation et portées](https://code.claude.com/docs/en/plugins/install)
- [Claude Code — Chargement, activation et cache](https://code.claude.com/docs/en/plugins/loading)
- [Claude Code — Création d'un marketplace et sources](https://code.claude.com/docs/en/plugin-marketplaces)
- [Claude Code — Hébergement, versions et maintenance](https://code.claude.com/docs/en/plugins/host-marketplace)

## Prochaine étape

Poursuivez avec **[Cheat sheet — Commandes Claude Code](commandes-claude.md)**, la page suivante dans le menu.
