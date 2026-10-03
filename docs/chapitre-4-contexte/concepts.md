# Concepts fondamentaux du contexte agentique

<span class="badge-intermediate">Intermédiaire</span>

Le **contexte** est l'ensemble des informations disponibles pour l'agent au moment où il raisonne : instructions, historique de conversation, fichiers lus, résultats de commandes, sorties MCP, skills invoqués et synthèses de subagents.


---

## La fenêtre de contexte est un budget

Une session n'a pas une mémoire infinie. Chaque élément chargé consomme une partie de la fenêtre :

```text
Instructions persistantes
+ conversation
+ fichiers lus
+ sorties d'outils
+ résultats MCP
+ skills invoqués
+ synthèses de subagents
= contexte de travail
```

La bonne question n'est donc pas « comment tout donner à l'agent ? », mais :

> **Quelle information est nécessaire maintenant pour réussir la tâche ?**

Claude Code recommande de gérer ce contexte activement. Une fenêtre remplie d'informations sans rapport peut réduire la qualité des décisions.

---

## Contexte permanent vs contexte à la demande

**Permanent signifie conservé sur disque et chargé automatiquement dans les sessions concernées.** Cela ne signifie pas que le modèle mémorise définitivement votre dépôt. **À la demande signifie chargé seulement lorsqu'une tâche le nécessite** : une lecture, l'invocation d'un skill ou un appel d'outil apporte alors son contenu dans la conversation.

Il faut distinguer trois choses : le fichier existe, Claude sait qu'il existe, et son contenu est effectivement dans la fenêtre de contexte. Un manuel présent dans le dépôt n'est pas automatiquement lu. Une courte description de skill peut être disponible pour permettre sa sélection, sans que toute sa procédure soit déjà chargée.

### Le socle automatique

Le `CLAUDE.md` du projet contient les informations nécessaires presque toujours : commandes de test, conventions essentielles et architecture générale. Les instructions applicables du répertoire de travail et de ses parents sont chargées au démarrage. Les règles `.claude/rules/` **sans `paths`** font également partie du socle automatique : séparer un long document en plusieurs fichiers sans condition ne réduit donc pas son coût en contexte.

Un import `@docs/conventions.md` dans `CLAUDE.md` charge aussi ce document avec les instructions. À l'inverse, écrire « consultez `docs/conventions.md` si vous modifiez l'API » donne une consigne de lecture, sans importer immédiatement tout le document.

Ce socle doit rester court : il occupe une partie du budget même pour une petite correction. Réservez-lui ce qui doit guider toutes les tâches, pas les détails de chaque domaine.

### Le contexte conditionnel

Une règle avec `paths` constitue un niveau intermédiaire : elle est conservée dans le dépôt, mais chargée lorsque Claude utilise Read, Write ou Edit sur un chemin correspondant. Par exemple, `.claude/rules/api.md` :

```markdown
---
paths:
  - "src/api/**/*.ts"
---

# Conventions API

- Valider les entrées avant d'appeler le service.
- Ajouter un test pour chaque nouvelle réponse d'erreur.
```

Cette règle n'a pas besoin d'encombrer une session consacrée aux styles CSS. Les `CLAUDE.md` de sous-répertoires peuvent aussi être chargés lors de la lecture de fichiers de leur périmètre. **Conditionnel ne signifie pas temporaire au sens d'une suppression immédiate** : une fois chargé, le contenu participe au contexte de travail de la session.

### Le contexte à la demande

Pour une procédure occasionnelle, utilisez un skill, par exemple `.claude/skills/release/SKILL.md`. Sa description aide Claude à décider quand l'utiliser ; son corps est chargé lors de l'invocation par vous ou par Claude, selon sa configuration. Les fichiers annexes du skill doivent ensuite être lus lorsqu'ils sont utiles : installer un skill ne charge pas automatiquement tous ses exemples.

De même, les fichiers sources, logs et résultats MCP entrent dans le contexte lorsqu'ils sont consultés. Un subagent peut isoler une exploration volumineuse : la conversation principale reçoit sa synthèse, plutôt que chacune de ses lectures.

### Exemple : corriger une route puis préparer une release

1. Au démarrage, Claude reçoit le socle `CLAUDE.md` : comment tester et quelles conventions communes respecter.
2. En lisant `src/api/users.ts`, il reçoit la règle API ciblée et le contenu de ce fichier.
3. Il lit les tests concernés et les résultats de leur exécution. Les autres services restent hors du contexte tant qu'ils ne sont pas consultés.
4. Lors d'une release, vous invoquez le skill dédié : sa procédure est alors chargée. Elle n'avait pas besoin d'être présente pendant la correction de route.

Le gain vient du **moment où l'information est chargée**, pas seulement de son emplacement dans l'arborescence.

| Information | Mécanisme Claude recommandé |
|---|---|
| conventions et commandes utiles presque toujours | `CLAUDE.md` |
| règle liée à certains fichiers | `.claude/rules/` avec `paths` |
| procédure ou expertise occasionnelle | skill |
| fichier nécessaire à la tâche actuelle | lecture/référence ciblée |
| recherche qui exige beaucoup de lectures | subagent |
| données d'un système externe | MCP si réellement nécessaire |

!!! tip "Ne mettez pas tout dans CLAUDE.md"
    Claude Code recommande un `CLAUDE.md` concis, idéalement sous environ 200 lignes. Une procédure longue ou locale doit généralement devenir une rule ciblée ou un skill.

### Que reste-t-il après une nouvelle session ?

Les fichiers versionnés restent disponibles sur disque et les instructions automatiques applicables sont rechargées. Les fichiers lus et les résultats d'outils d'une ancienne conversation ne deviennent pas pour autant des instructions permanentes. `/clear` remet à zéro l'historique de conversation ; `/compact` le résume, avec une possible perte de détails. Consignez donc une décision durable dans un fichier approprié et relisez les preuves nécessaires à une nouvelle tâche.

La mémoire automatique de Claude Code est un mécanisme distinct : elle conserve certains apprentissages entre sessions, mais ne remplace ni les instructions d'équipe versionnées ni une vérification de l'état réel du code. Utilisez `/memory` et `/context` pour inspecter les instructions et l'occupation du contexte.

Ces règles de chargement ont été vérifiées dans la [documentation officielle sur la mémoire](https://code.claude.com/docs/en/memory) le **3 octobre 2026**. Le chargement progressif des procédures est décrit dans la [documentation des skills](https://code.claude.com/docs/en/skills).

---

## Un bon contexte est spécifique

Prompt vague :

```text
Corrige le service utilisateur.
```

Contexte utile :

```text
Dans src/users/UserService.ts, corrige le cas où un utilisateur désactivé
peut encore renouveler son token.

Lis d'abord src/auth/TokenService.ts et le test UserService.test.ts.
Ne change pas l'API publique.
Ajoute un test de non-régression puis exécute la suite ciblée.
```

Le second exemple indique :

- la **cible** ;
- le **scénario** ;
- les fichiers de référence ;
- une contrainte de compatibilité ;
- une preuve de réussite.

---

## Le contexte ne remplace pas la vérification

Un agent peut produire une solution plausible avec un contexte excellent et malgré tout se tromper.

Donnez-lui un signal qu'il peut vérifier :

- tests ;
- build ;
- linter ;
- validation de schéma ;
- comparaison à une fixture ;
- capture d'écran ou contrôle fonctionnel.

La documentation Claude Code insiste sur ce point : un test ou un build ferme la boucle de travail et évite que l'utilisateur soit le seul détecteur d'erreurs.

---

## Explorer sans polluer la conversation principale

Une recherche large peut charger des dizaines de fichiers. Claude Code recommande d'utiliser des **subagents** pour les investigations volumineuses.

```text
Utilise un subagent pour cartographier le flux de paiement.
Retourne seulement :
- fichiers clés ;
- appels externes ;
- invariants ;
- risques de la modification demandée.
```

Le subagent conserve son exploration dans un contexte séparé et remonte une synthèse.

---

## Gérer une session longue

| Problème | Action Claude Code |
|---|---|
| nouvelle tâche sans rapport | `/clear` |
| contexte proche de la limite | auto-compaction ou `/compact` |
| besoin de revenir à un état antérieur | `/rewind` ou ++esc+esc++ |
| question annexe à ne pas garder dans l'historique | `/btw` si disponible |
| multiples corrections qui échouent | `/clear`, puis nouveau prompt intégrant les apprentissages |

Claude Code compresse automatiquement l'historique lorsqu'il approche des limites de contexte. `/compact <instructions>` permet de guider explicitement cette synthèse.

---

## Instructions et règles ne sont pas des barrières de sécurité

`CLAUDE.md`, `AGENTS.md` et `.claude/rules/` sont du **contexte**. Ils guident le modèle, mais ne garantissent pas techniquement qu'une action sera impossible.

Pour faire respecter une interdiction :

- `permissions.deny` ;
- politiques gérées ;
- sandboxing lorsque disponible ;
- hook `PreToolUse` pour une décision dynamique.

```json
{
  "permissions": {
    "deny": [
      "Read(./.env)",
      "Read(./secrets/**)"
    ]
  }
}
```

---

### Contexte

Ce que l'agent doit savoir **pour cette situation** : état du dépôt, contraintes, fichiers, décisions.

### Capacité

Ce que l'agent sait **faire de façon réutilisable** : auditer une documentation, migrer un composant, préparer une release, analyser une PR.

Dans Claude Code, une capacité répétable se prête souvent bien à un **skill** ou à un **subagent**.

---

## Pourquoi les sorties d'outils comptent

Les commandes terminal, recherches, logs et résultats MCP peuvent consommer beaucoup de contexte.

Pour limiter le bruit :

1. ciblez les commandes ;
2. filtrez les résultats volumineux ;
3. ne demandez pas l'exploration exhaustive par défaut ;
4. utilisez un subagent pour les recherches larges ;
5. nettoyez la session entre tâches indépendantes.

Des outils comme RTK, documentés dans le chapitre Outils, peuvent aussi compresser certaines sorties CLI avant qu'elles n'occupent la fenêtre de contexte.

---

## Les 5 réflexes à retenir

1. **Borner la tâche** avant de demander une modification.
2. **Garder `CLAUDE.md` concis** et déplacer le reste vers rules/skills.
3. **Fournir les fichiers ou patterns utiles**, pas le dépôt entier.
4. **Donner une vérification exécutable**.
5. **Nettoyer ou isoler le contexte** avec `/clear`, compaction et subagents.

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-4-contexte.md#page-chapitre-4-contexte-concepts).

## Prochaine étape

Poursuivez avec **[Semble — Recherche de code](semble.md)**, la page suivante dans le menu.

## Sources

Sources officielles consultées le **28 septembre 2026** :

- [Claude Code — Best practices](https://code.claude.com/docs/en/best-practices)
- [Claude Code — Memory and project instructions](https://code.claude.com/docs/en/memory)
- [Claude Code — Skills](https://code.claude.com/docs/en/skills)
- [Claude Code — Subagents](https://code.claude.com/docs/en/sub-agents)
