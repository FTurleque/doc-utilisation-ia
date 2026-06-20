# Présentation et choix

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-intellij">IntelliJ</span>

Ce guide présente les MCP utilisés dans ce chapitre comme un **cadre de filtrage du contexte**. L’objectif n’est pas d’envoyer plus d’informations à Copilot, mais de n’en transmettre que ce qui est utile, officiel et borné.

---

## Ce qu’est MCP

MCP, pour **Model Context Protocol**, standardise la manière dont un client IA dialogue avec des serveurs externes. Dans ce dépôt, le client principal est **GitHub Copilot**, utilisé depuis **IntelliJ IDEA**.

| Terme | Rôle | Exemple dans ce chapitre |
|---|---|---|
| Client | Application qui appelle les serveurs MCP | GitHub Copilot dans l'IDE |
| Serveur | Processus qui expose des outils et des ressources | `mcp-search-net`, Tavily MCP, Firecrawl MCP |
| *Tool* (outil) | Action appelable par le client | `search_web`, `fetch_url` |
| *Resource* (ressource) | Donnée publiée sans action spéciale | Registre YAML, cache, index documentaire |
| Transport | Canal de communication | `stdio`, HTTP |

!!! tip "Règle de base"
    Un MCP utile **réduit** le bruit, il ne doit pas l’augmenter. Si le serveur renvoie trop de texte, tu dépenses plus de contexte et tu gagnes moins de précision.

### Recherche Web, récupération d’URL, extraction et crawl

| Fonction | Ce qu’elle fait | Ce qu’elle ne doit pas faire |
|---|---|---|
| Recherche Web | Trouver des sources candidates à partir de mots-clés | Remplacer la lecture ciblée d’une page connue |
| Récupération d’URL | Lire une page déjà identifiée | Explorer tout un site |
| Extraction | Garder seulement les sections utiles | Renvoyer la page entière si ce n’est pas nécessaire |
| Crawl | Parcourir plusieurs liens à partir d’une page | Remonter tout Internet ou suivre des liens sans borne |

Séparer `search_web` et `fetch_url` aide à garder des permissions claires : la recherche découvre, la récupération lit, l’extraction compacte, le crawl reste hors V1.

!!! warning "Contexte et coût"
    Un MCP trop bavard peut augmenter la taille du contexte injecté dans Copilot et, par effet domino, la consommation de crédits ou de requêtes. Borne toujours les résultats et les outils exposés.

---

## Familles de solutions

| Famille | Positionnement | Avantage principal | Limite principale |
|---|---|---|---|
| MCP local autohébergé | Contrôle fort, lecture seule, données bornées | Maîtrise et confidentialité | Installation et maintenance locales |
| MCP distant gratuit avec quota | Démarrage rapide | Simplicité d’usage | Quota évolutif, dépendance fournisseur |
| MCP commercial | Offre complète et service managé | Moins d’exploitation locale | Coût, verrouillage possible, quotas |
| MCP documentaire local avancé | Index dédié à la documentation | Recherche locale rapide | Risque d’obsolescence du corpus |

### Choix validés pour ce chapitre

| Choix | Statut | Pourquoi |
|---|---|---|
| V1 locale | Validée comme cible documentaire | Façade TypeScript + SearXNG + Crawl4AI + SQLite |
| V2 documentaire | Validée comme évolution | Index local, catalogue et recherche multi-document |
| Tavily MCP | Solution gratuite principale | Démarrage simple avec quota à vérifier |
| Firecrawl MCP | Alternative recommandée | Plus adapté aux pages dynamiques et à l’extraction |
| Environnement principal | Validé | IntelliJ IDEA + GitHub Copilot |

!!! note "V1, V2 et environnement"
    La V1 décrit une architecture cible documentée, pas un logiciel livré dans ce dépôt. La V2 ajoute un index documentaire local plus riche. L’IDE principal reste IntelliJ IDEA, mais les principes restent portables.

---

## Limites à garder en tête

- Authentification requise sur certains services distants.
- Paywalls et contenus réservés qui ne doivent pas être contournés.
- CAPTCHA et blocages anti-bot.
- Respect de `robots.txt` et des conditions d’utilisation.
- Pages dynamiques, non indexées ou supprimées.
- Restrictions légales, contractuelles ou internes.
- Dépendance aux moteurs externes.
- Blocages possibles de SearXNG selon la source ou le réseau.

!!! danger "Ne pas promettre l’accès à tout le Web"
    Aucun MCP ne garantit un accès universel à tout Internet. Les sources visibles dépendent des moteurs, des limites réseau, des règles du site et des droits d’accès.

---

## Sécurité

| Risque | Mesure attendue |
|---|---|
| SSRF | Bloquer localhost, les réseaux privés et les adresses link-local |
| Prompt injection provenant des pages | Considérer tout contenu externe comme non fiable |
| Secrets | Ne jamais exposer de secret dans les paramètres ou les exemples |
| Sur-exposition d’outils | N’activer que les outils utiles à la tâche |
| Contexte trop large | Limiter les résultats, les sections et les domaines |

### Principes directeurs

- Lecture seule par défaut.
- Pas de LLM interne dans la V1.
- Peu d’outils, bien cadrés.
- Sorties compactes, hiérarchisées et filtrées.
- Vérifications de sécurité avant toute redirection ou récupération.

---

## Navigation

| Page | Rôle |
|---|---|
| [MCP Web local](./configuration.md) | Architecture V1 et contrat des outils |
| [MCP Web gratuit et à quota](./serveurs.md) | Tavily et Firecrawl comme solutions simples ou de secours |
| [Comparaison](./securite.md) | Arbitrage local / gratuit / V1 / V2 |

---

## Sources

- [Model Context Protocol](https://modelcontextprotocol.io/) (consulté le 2026-06-20)
- [MCP Specification](https://spec.modelcontextprotocol.io/) (consulté le 2026-06-20)
- [GitHub Copilot documentation](https://docs.github.com/copilot) (consulté le 2026-06-20)
- [GitHub Copilot et MCP dans l'IDE](https://docs.github.com/en/copilot/how-tos/provide-context/use-mcp-in-your-ide/extend-copilot-chat-with-mcp) (consulté le 2026-06-20)
- [Documentation SearXNG](https://docs.searxng.org/) (consulté le 2026-06-20)
- [Documentation Crawl4AI](https://docs.crawl4ai.com/) (consulté le 2026-06-20)
- [Documentation Tavily](https://docs.tavily.com/) (consulté le 2026-06-20)
- [Documentation Firecrawl](https://docs.firecrawl.dev/) (consulté le 2026-06-20)
- [Docker Compose](https://docs.docker.com/compose/) (consulté le 2026-06-20)
- [Node.js releases](https://nodejs.org/en/about/releases/) (consulté le 2026-06-20)
- [TypeScript documentation](https://www.typescriptlang.org/docs/) — consulté le 2026-06-20

---

## Prochaine étape

**[MCP Web local](./configuration.md)** : cadrer l’architecture V1, les outils exposés et les règles de sécurité avant d’ouvrir la moindre intégration réseau.

Concepts clés couverts :

- **Client / serveur** — distinguer le client IA du serveur MCP
- **Filtrage** — réduire le contexte avant de l’envoyer à Copilot
- **Transport** — choisir `stdio` ou HTTP selon le cas d’usage
- **Sources officielles** — privilégier les domaines validés et bornés



