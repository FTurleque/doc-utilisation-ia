# MCP Web gratuit et à quota

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-intellij">IntelliJ</span>

Cette page compare deux options rapides pour interroger le Web sans construire la V1 locale complète : **Tavily MCP** comme solution simple ou de secours, et **Firecrawl MCP** comme alternative plus puissante pour l’extraction. Les offres gratuites et les quotas peuvent évoluer ; quand une valeur est temporelle, elle doit être recontrôlée avant publication.

---

## Tavily MCP

Tavily est une option pratique quand tu veux aller vite et garder un serveur simple à exploiter.

### Positionnement

- Recherche orientée documentation et information.
- Filtrage possible par domaine.
- Réduction du temps de mise en route.
- Adapté aux requêtes ponctuelles et bornées.

### Avantages

- Démarrage rapide.
- Bonne solution de secours quand la V1 locale n’est pas disponible.
- Moins d’effort d’exploitation qu’un serveur local complet.
- Convenable pour une recherche ciblée dans la documentation officielle.

### Limites

- Dépendance au fournisseur.
- Quota gratuit susceptible d’évoluer.
- Tarifs et limites à contrôler au 2026-06-20 sur la documentation officielle.
- Pas d’accès garanti à tout le Web.
- Les réponses trop larges consomment plus de contexte.

### Confidentialité

- Les requêtes passent par un service externe.
- Les secrets ne doivent jamais être transmis dans les paramètres.
- Les résultats doivent être bornés avant injection dans Copilot.

### Réglages pour limiter la consommation

- Limiter les domaines.
- Restreindre la langue.
- Limiter le nombre de résultats.
- Utiliser des requêtes courtes et précises.
- Privilégier la récupération d’une URL connue après la recherche.

!!! warning "Ne pas promettre un gratuit éternel"
    Une offre gratuite peut changer de quota, de conditions ou de disponibilité. Documente toujours la date de contrôle si tu mentionnes un chiffre précis.

---

## Firecrawl MCP

Firecrawl est l’alternative la plus intéressante quand la page est dynamique, complexe ou difficile à extraire proprement.

### Positionnement

- Recherche web.
- Extraction avancée.
- Crawl contrôlé.
- Pages dynamiques ou riches en navigation.

### Avantages

- Plus adapté aux pages complexes.
- Bon pour les documents riches en structure ou en contenu rendu côté client.
- Pertinent si tu dois extraire plus qu’un simple extrait HTML.

### Limites

- Dépendance externe.
- Quota à vérifier selon l’offre.
- Risque d’exposer trop d’outils si la configuration est trop large.
- Risque de crawl trop large si les bornes sont faibles.
- Confidentialité à évaluer avant tout usage sur contenu sensible.

### Points de vigilance

- N’expose que les outils nécessaires.
- N’autorise pas un crawl libre sur des sites sensibles.
- Borne les domaines et les chemins.
- Préfère une extraction ciblée à un parcours exhaustif.

!!! tip "Cas d’usage typique"
    Firecrawl devient intéressant quand une page officielle charge une partie du contenu dynamiquement et qu’un simple `fetch_url` ne suffit plus.

---

## Recommandation

| Besoin | Outil recommandé | Pourquoi |
|---|---|---|
| Solution principale | MCP local | Maîtrise, filtrage fort, indépendance relative |
| Solution simple / secours | Tavily MCP | Mise en route rapide, usage ponctuel |
| Extraction plus complexe | Firecrawl MCP | Pages dynamiques, extraction avancée |

!!! note "Choix de principe"
    Pour ce dépôt, la solution locale reste la cible principale. Tavily sert de voie rapide et Firecrawl sert de voie plus puissante quand la structure des pages l’exige.

---

## Exemples

=== "IntelliJ IDEA"
    - Rechercher la documentation officielle JetBrains d’une API ou d’un plugin.
    - Lire ensuite l’URL exacte trouvée au lieu de lancer un crawl large.
    - N’envoyer à Copilot que le résultat borné utile à la décision.

=== "Documentation officielle"
    - Chercher `modelcontextprotocol.io` pour les concepts MCP.
    - Lire `docs.github.com` pour la prise en charge Copilot.
    - Extraire la section utile, pas la page entière.

---

## Sources

- [Documentation Tavily](https://docs.tavily.com/) (consulté le 2026-06-20)
- [Tavily Pricing](https://tavily.com/pricing) (consulté le 2026-06-20)
- [Documentation Firecrawl](https://docs.firecrawl.dev/) (consulté le 2026-06-20)
- [Firecrawl Pricing](https://firecrawl.dev/pricing) (consulté le 2026-06-20)
- [Model Context Protocol](https://modelcontextprotocol.io/) (consulté le 2026-06-20)
- [GitHub Copilot et MCP dans l'IDE](https://docs.github.com/en/copilot/how-tos/provide-context/use-mcp-in-your-ide/extend-copilot-chat-with-mcp) (consulté le 2026-06-20)

---

## Prochaine étape

**[Comparaison](./securite.md)** : trancher entre local, gratuit, V1 et V2 selon la maîtrise, la confidentialité et la charge de maintenance.

Concepts clés couverts :

- **Option gratuite** — utile pour démarrer ou dépanner
- **Tavily** — simple, borné, pratique pour la recherche ciblée
- **Firecrawl** — plus fort sur l’extraction et les pages dynamiques
- **Contexte** — limiter ce qui remonte dans Copilot

