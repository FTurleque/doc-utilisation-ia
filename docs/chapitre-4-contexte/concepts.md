# Concepts fondamentaux du contexte agentique

<span class="badge-intermediate">Intermédiaire</span>

Le **contexte** est l'ensemble des informations disponibles pour l'agent au moment où il raisonne : instructions, historique de conversation, fichiers lus, résultats de commandes, sorties MCP, skills invoqués et synthèses de subagents.

Dans ce dépôt, les exemples sont désormais centrés sur **Claude Code**, tout en gardant les principes suffisamment génériques pour être utiles avec Copilot et d'autres agents.

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

## Contexte vs capacité

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

## Copilot — principes toujours valables

GitHub Copilot possède ses propres mécanismes de contexte et de personnalisation, conservés dans ce dépôt. Les principes restent les mêmes :

- contexte ciblé plutôt qu'exhaustif ;
- instructions courtes ;
- outils externes uniquement lorsqu'ils apportent une vraie information ;
- critères de réussite explicites ;
- vérification du résultat.

Pour les fichiers Copilot spécifiques, voir [Instructions projet et règles](guide-instructions.md) et les pages de référence `.github/`.

---

## Les 5 réflexes à retenir

1. **Borner la tâche** avant de demander une modification.
2. **Garder `CLAUDE.md` concis** et déplacer le reste vers rules/skills.
3. **Fournir les fichiers ou patterns utiles**, pas le dépôt entier.
4. **Donner une vérification exécutable**.
5. **Nettoyer ou isoler le contexte** avec `/clear`, compaction et subagents.

---

## Prochaine étape

**[Instructions projet et règles](guide-instructions.md)** : formaliser ce qui doit persister entre les sessions sans transformer le contexte permanent en encyclopédie.

---

## Sources

Sources officielles consultées le **28 septembre 2026** :

- [Claude Code — Best practices](https://code.claude.com/docs/en/best-practices)
- [Claude Code — Memory and project instructions](https://code.claude.com/docs/en/memory)
- [Claude Code — Skills](https://code.claude.com/docs/en/skills)
- [Claude Code — Subagents](https://code.claude.com/docs/en/sub-agents)
