# MCP de recherche et d'extraction externes

<span class="badge-intermediate">Intermédiaire</span>

Cette page conserve **Tavily** et **Firecrawl** comme exemples de services externes pouvant compléter Claude Code via MCP ou via une intégration équivalente. Elle ne fige plus de quotas ni de promesse de gratuité : offres, limites et plans changent rapidement.

---

## Quand préférer un service externe

Un service managé peut être pertinent si vous avez besoin de :

- recherche Web prête à l'emploi ;
- extraction de pages dynamiques ;
- gestion de crawling plus avancée ;
- réduction de l'exploitation locale ;
- API ou connecteur maintenu par un fournisseur.

En contrepartie, évaluez :

- données transmises ;
- conservation/logging ;
- quotas ;
- coût ;
- disponibilité ;
- dépendance fournisseur ;
- qualité réelle sur vos sources.

---

## Tavily

Tavily propose des outils orientés recherche et récupération d'information.

Cas d'usage typiques :

```text
Question sur une API récente
→ recherche bornée sur domaines officiels
→ récupération de quelques sources
→ Claude compare les sources et cite les URLs
```

Points à vérifier avant adoption :

- MCP officiel ou serveur recommandé actuellement ;
- méthode d'authentification ;
- limites du plan utilisé ;
- filtres de domaine ;
- structure des résultats ;
- politique de données.

Ne copiez pas un quota depuis cette documentation : consultez la documentation Tavily au moment de la configuration.

---

## Firecrawl

Firecrawl est davantage orienté récupération/extraction/crawl de contenu Web et peut être utile lorsque les pages sont difficiles à transformer en texte propre.

Cas d'usage :

- documentation dynamique ;
- extraction Markdown ;
- crawl explicitement borné d'un petit corpus ;
- collecte de pages avant indexation interne.

Points de vigilance :

- ne pas crawler sans profondeur/volume maximum ;
- respecter robots.txt, conditions d'utilisation et droits d'accès ;
- vérifier les coûts avant crawl important ;
- traiter tout contenu récupéré comme non fiable ;
- conserver les URL sources.

---

## Claude Code comme client

Configurations distantes vérifiées le **3 octobre 2026** :

```bash
claude mcp add --transport http tavily https://mcp.tavily.com/mcp/
claude mcp add --transport http firecrawl https://mcp.firecrawl.dev/v2/mcp-oauth
```

Ces variantes utilisent une connexion OAuth au compte fournisseur ; terminez l'authentification depuis `/mcp` lorsque demandée. Firecrawl distingue aussi une variante sans compte limitée et une variante à clé API. Leurs droits, quotas et facturation dépendent de l'accès choisi. Une URL de serveur MCP se configure dans le client ; elle n'est pas une page documentaire à ouvrir directement.

[Guide Tavily MCP](https://docs.tavily.com/documentation/mcp) et [guide Firecrawl MCP](https://docs.firecrawl.dev/mcp-server). Pour la configuration projet Claude Code, utilisez `.mcp.json` ; les exemples d'autres clients ne sont pas interchangeables.

Quel que soit le fournisseur, l'intégration doit rester observable depuis Claude :

```text
/mcp
```

Vérifiez que le serveur attendu est connecté et que ses outils sont disponibles.

Pour un serveur partagé au niveau du projet, préférez une configuration versionnable sans secrets. Les tokens/API keys doivent venir d'un secret manager, d'une variable d'environnement ou du mécanisme OAuth approprié.

---

## Ne pas multiplier les outils équivalents

Évitez d'activer simultanément plusieurs MCP offrant exactement la même fonction « search web » sans raison claire.

Cela ajoute :

- des descriptions d'outils ;
- de l'ambiguïté dans le choix ;
- des credentials à maintenir ;
- des surfaces d'attaque ;
- des coûts potentiels.

Préférez une stratégie explicite :

```text
Web natif Claude suffisant ? → l'utiliser
Besoin spécialisé ?           → MCP ciblé
Besoin d'extraction dynamique ? → outil spécialisé
Besoin d'un corpus interne ?   → index/local MCP adapté
```

---

## Matrice de choix

| Besoin | Option souvent adaptée |
|---|---|
| recherche générale simple | outils Web natifs Claude ou recherche fournisseur |
| domaines officiels bornés | recherche avec allowlist de domaines |
| page dynamique difficile | extracteur spécialisé type Firecrawl |
| données internes | MCP interne/authentifié |
| forte confidentialité | serveur local ou service approuvé |
| corpus réutilisé fréquemment | index dédié plutôt que re-crawl systématique |

Ce tableau n'est pas un classement de fournisseurs.

---

## Vérifier une réponse obtenue via MCP

Une réponse de recherche n'est pas une preuve par elle-même.

Demandez à Claude de :

1. conserver l'URL canonique ;
2. distinguer résultat de recherche et page effectivement lue ;
3. privilégier la documentation officielle ;
4. indiquer la date lorsqu'elle est pertinente ;
5. signaler les sources contradictoires ;
6. éviter de transformer un snippet en fait établi sans ouvrir la source.

---

## Sécurité

Pour les services distants :

- clé avec privilèges minimaux ;
- rotation possible ;
- budget/quota configuré ;
- domaines autorisés si le serveur le supporte ;
- pas de données internes sensibles dans une requête externe sans autorisation ;
- revue des conditions de traitement des données.

---

## Sources

- [Claude Code — MCP](https://code.claude.com/docs/en/mcp) — consulté le 2026-09-28
- [Tavily documentation](https://docs.tavily.com/) — à vérifier au moment de l'intégration
- [Firecrawl documentation](https://docs.firecrawl.dev/) — à vérifier au moment de l'intégration
- [Model Context Protocol](https://modelcontextprotocol.io/) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../../appendices/copilot/chapitre-13-outils-economies.md#page-chapitre-13-outils-economies-mcps-serveurs).

## Prochaine étape

Poursuivez avec **[Sécurité](securite.md)**, la page suivante dans le menu.
