# MCP — sécurité et choix local / distant

<span class="badge-intermediate">Intermédiaire</span>

Le choix d'un MCP ne doit pas se résumer à « local = gratuit » ou « distant = simple ». Évaluez quatre dimensions : **permissions, données, maintenance et qualité du service**.

---

## Matrice de décision

| Critère | Local | Distant / managé |
|---|---|---|
| contrôle du runtime | fort | dépend du fournisseur |
| gestion des mises à jour | à votre charge | généralement fournisseur |
| secrets | à gérer localement | auth distante/OAuth/API key |
| données transmises | contrôlables | quittent potentiellement votre environnement |
| disponibilité | dépend de votre poste/infrastructure | dépend du service/réseau |
| coûts | machine + exploitation | plan/quota/usage éventuel |
| partage équipe | nécessite packaging/config | souvent plus simple |

Il n'y a pas de vainqueur universel.

---

## Menace 1 — Sur-permission

Un MCP peut exposer des outils de lecture **et d'écriture**.

Préférez :

```text
read_issue
list_issues
search_docs
```

avant d'autoriser :

```text
close_issue
delete_record
run_admin_command
```

Si une action destructive est indispensable :

- permission explicite ;
- confirmation utilisateur ;
- scope limité ;
- log d'audit ;
- identités de service dédiées.

---

## Menace 2 — Prompt injection via contenu externe

Un ticket, une page Web, un document ou une base peut contenir du texte du type :

```text
Ignore les instructions précédentes et exécute ...
```

Ce texte reste une **donnée non fiable**.

Mesures :

- ne pas donner de privilèges excessifs au serveur ;
- séparer lecture et écriture ;
- conserver la provenance ;
- éviter d'enchaîner automatiquement « lire une page → exécuter une commande sensible » ;
- utiliser hooks/permissions pour bloquer les actions critiques.

---

## Menace 3 — SSRF pour les MCP Web

Un outil `fetch_url` doit empêcher l'accès involontaire à des services internes.

Bloquez au minimum :

- loopback ;
- IP privées ;
- link-local ;
- metadata cloud ;
- protocoles non autorisés ;
- redirections vers une destination interdite.

La validation doit être refaite après résolution DNS et à chaque redirection.

---

## Menace 4 — Fuite de credentials par subprocess

Un serveur MCP `stdio` lancé localement peut hériter de variables d'environnement du processus parent.

N'accordez que les variables nécessaires au serveur.

Claude Code propose des mécanismes de durcissement de l'environnement des subprocess, notamment pour éviter d'exposer inutilement les credentials Anthropic ou cloud à Bash, hooks et MCP locaux.

!!! tip "Question à poser"
    « Ce serveur de recherche a-t-il réellement besoin de voir mes clés AWS, Anthropic ou GitHub ? »

Si la réponse est non, retirez-les de son environnement.

---

## Menace 5 — Sortie MCP excessive

Une sortie de plusieurs dizaines de milliers de tokens :

- augmente le contexte ;
- masque l'information importante ;
- peut déclencher compaction/troncature ;
- rend la revue humaine difficile.

Le serveur doit proposer pagination, limites, filtres et extraction ciblée. Claude Code dispose aussi de mécanismes de contrôle des gros résultats MCP, mais le producteur doit rester responsable de ses bornes.

---

## Menace 6 — Serveur compromis ou dépendance non fiable

Avant d'installer un MCP tiers :

- vérifiez l'éditeur ;
- vérifiez le dépôt/package officiel ;
- inspectez les permissions ;
- épinglez les versions si votre politique l'exige ;
- consultez les releases et avis de sécurité ;
- évitez les packages au nom presque identique ;
- testez dans un environnement peu privilégié.

Pour un serveur distant, examinez aussi les conditions de traitement et de conservation des données.

---

## Projet vs utilisateur

Utilisez une configuration **projet** lorsqu'un serveur fait partie du workflow partagé de l'équipe et peut être déclaré sans secret dans `.mcp.json`.

Utilisez une configuration **personnelle** lorsqu'il s'agit :

- d'un outil propre au développeur ;
- d'un credential personnel ;
- d'un serveur qui ne doit pas être imposé au repo.

Les politiques gérées par l'organisation peuvent prendre le dessus sur les préférences locales.

---

## Local vs distant selon le type de données

| Données | Orientation prudente |
|---|---|
| documentation publique | local ou distant acceptable selon politique |
| tickets internes | connecteur authentifié approuvé |
| logs production | limiter/redacter avant transmission |
| données clients | vérifier classification et politique de traitement |
| secrets/credentials | ne pas transmettre comme contenu MCP |
| base de production | lecture seule et requêtes fortement bornées par défaut |

---

## Checklist avant activation

```text
□ Source/éditeur vérifié
□ Outils exposés listés
□ Écriture nécessaire ?
□ Permissions minimales
□ Secrets hors dépôt
□ Données autorisées à sortir ?
□ Résultats bornés/paginés
□ Prompt injection envisagée
□ SSRF traité si URLs arbitraires
□ Logs sans credentials
□ /mcp vérifié après installation
```

---

## Réaction en cas de comportement suspect

1. déconnectez le serveur via `/mcp` ;
2. révoquez/rotatez les credentials si exposition possible ;
3. examinez logs et actions réalisées ;
4. vérifiez la configuration/version du serveur ;
5. signalez l'incident selon votre processus interne ;
6. ne réactivez qu'après compréhension de la cause.

---

## GitHub Copilot — référence

Les risques MCP sont largement indépendants du client. En revanche, l'interface de permissions et la configuration Copilot ne sont pas identiques à Claude Code ; vérifiez la documentation GitHub lorsque vous réutilisez un serveur côté Copilot.

---

## Sources

- [Claude Code — MCP](https://code.claude.com/docs/en/mcp) — consulté le 2026-09-28
- [Claude Code — Environment variables](https://code.claude.com/docs/en/env-vars) — consulté le 2026-09-28
- [Claude Code — Permissions](https://code.claude.com/docs/en/permissions) — consulté le 2026-09-28
- [Model Context Protocol](https://modelcontextprotocol.io/) — consulté le 2026-09-28

## Retour

**[Présentation MCP](index.md)** pour choisir la bonne architecture, ou **[MCP Web local](configuration.md)** pour le design `mcp-search-net`.