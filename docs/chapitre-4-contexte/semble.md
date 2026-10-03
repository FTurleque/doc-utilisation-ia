# Semble — recherche de code rapide pour agents

<span class="badge-intermediate">Intermédiaire</span>

**Semble** est un moteur de recherche de code conçu pour les agents. Il indexe un dépôt local ou distant puis renvoie uniquement les snippets les plus pertinents pour une requête en langage naturel ou une requête de code.

Sa place principale est **Contexte & Personnalisation** : son objectif est de réduire la quantité de code que l'agent doit lire avant de trouver la zone utile.

!!! info "Vérifié le 1er octobre 2026"
    Semble fonctionne localement sur CPU, sans clé API ni service externe obligatoire. Le projet propose une intégration Claude Code via MCP, instructions dans `CLAUDE.md`/`AGENTS.md` et subagent dédié.

---

## Comment Semble fonctionne

Semble découpe le code en chunks structurés avec **tree-sitter**, puis combine :

- des embeddings statiques spécialisés code ;
- une recherche lexicale **BM25** ;
- une fusion des scores ;
- des signaux adaptés au code : définitions, identifiants, cohérence de fichier et pénalités sur le bruit.

Le résultat est une liste de snippets avec fichiers et lignes, plutôt qu'une lecture complète des fichiers candidats.

```text
Question agent
    ↓
Index Semble
    ├── recherche sémantique
    ├── recherche lexicale
    └── reranking code-aware
    ↓
Snippets pertinents
    ↓
Claude Code
```

---

## Installation recommandée

Le projet recommande actuellement `uv` :

```bash
uv tool install semble
semble install
```

L'installateur détecte les agents présents et peut configurer :

- un **serveur MCP** ;
- des instructions pour `CLAUDE.md` / `AGENTS.md` ;
- un subagent `semble-search`.

Installation non interactive pour Claude Code :

```bash
semble install --agent claude --type mcp subagent --yes
```

Pour supprimer la configuration :

```bash
semble uninstall
```

---

## Utilisation CLI

Quelques usages courants :

```bash
# Chercher dans le dépôt courant
semble search "authentication flow" .

# Chercher dans un dépôt distant
semble search "save model to disk" https://github.com/MinishLab/model2vec

# Chercher plusieurs dépôts comme un seul corpus
semble search "invoice endpoint" ./service-a ./service-b

# Inclure documentation et configuration
semble search "deployment guide" . --content docs
semble search "feature flag" . --content all
```

Semble sait aussi rechercher du code similaire à une position connue avec `find-related`.

---

## Intégration MCP

Le serveur MCP expose principalement des opérations de recherche et de code similaire. L'index est construit à la demande, mis en cache et réévalué lorsque les fichiers changent.

Cette approche est utile lorsque Claude doit effectuer beaucoup de recherches répétées dans un gros dépôt mais n'a pas besoin des capacités de refactoring sémantique d'un IDE.

---

## Semble, Serena ou Graphify ?

| Outil | Force principale | Quand le choisir |
|---|---|---|
| **Semble** | retrieval rapide de snippets | retrouver où se trouve une logique sans lire beaucoup de fichiers |
| [Serena](serena.md) | symboles, références, édition/refactoring | naviguer et modifier précisément du code |
| [Graphify](graphify.md) | knowledge graph | comprendre les relations globales du dépôt |

Semble n'est pas une base vectorielle applicative comme Qdrant : il est spécialisé dans la **recherche de code pour agents**.

---

## Benchmarks : comment les lire

Le projet publie des benchmarks de vitesse, qualité de retrieval et économie de tokens. Ces chiffres sont utiles pour comprendre son objectif, mais ils restent des **mesures du projet sur son protocole de test**.

Pour votre dépôt, mesurez vous-même :

- recall sur des questions de code représentatives ;
- temps d'indexation et de recherche ;
- quantité de contexte réellement chargée ;
- taux de réponses qui pointent vers le bon fichier/symbole ;
- impact sur le temps total de résolution d'une tâche.

---

## Données locales et cache

Semble stocke ses index et statistiques dans le cache utilisateur de l'OS. Au premier usage, le modèle d'embedding est téléchargé depuis Hugging Face et mis en cache.

Le projet respecte `.gitignore` et permet d'ajouter un `.sembleignore` pour exclure ou inclure des fichiers spécifiques.

Pour un dépôt sensible :

1. vérifiez ce qui est indexé ;
2. excluez secrets, dumps et données inutiles ;
3. contrôlez l'emplacement du cache ;
4. supprimez les index avec `semble clear` lorsqu'ils ne doivent plus persister.

---

## Sources

Sources consultées le **1er octobre 2026** :

- [Semble — dépôt officiel](https://github.com/MinishLab/semble)
- [Semble — installation](https://github.com/MinishLab/semble/blob/main/docs/installation.md)
- [Semble — benchmarks](https://github.com/MinishLab/semble/tree/main/benchmarks)

## Prochaine étape

Poursuivez avec **[Serena — Code intelligence sémantique](serena.md)**, la page suivante dans le menu.
