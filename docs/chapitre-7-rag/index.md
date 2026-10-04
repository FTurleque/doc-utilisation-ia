# RAG — Retrieval-Augmented Generation

<span class="badge-beginner">Débutant</span> <span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span>

Le **RAG** (*Retrieval-Augmented Generation*) consiste à récupérer des informations externes pertinentes puis à les fournir au modèle au moment de répondre. C'est une technique utile lorsque la réponse doit s'appuyer sur des documents privés, volumineux ou fréquemment mis à jour.

!!! important "RAG ≠ tout mécanisme de contexte"
    Un IDE qui fournit des fichiers ouverts ou un agent qui lit un dépôt utilise du **contexte** et des outils de recherche, mais ce n'est pas automatiquement une architecture RAG au sens strict. Le RAG implique généralement une étape explicite de **retrieval** sur un corpus avant génération.

---

## Où Claude Code se place

Claude Code peut participer à deux niveaux différents :

1. **développer et tester** votre système RAG (ingestion, indexation, retrieval, évaluation, API) ;
2. **consommer des sources externes** via MCP ou des outils pour charger du contexte juste à temps.

Anthropic décrit justement cette évolution vers le **just-in-time context** : plutôt que d'injecter un maximum de données à l'avance, l'agent conserve des références légères puis charge les informations utiles au moment où il en a besoin.

---

## Roadmap d'apprentissage

```mermaid
graph LR
    A["Concepts"] --> I["Ingestion\nDocling"]
    I --> B["Niveau 1\nretrieval simple"]
    B --> C["Niveau 2\nqualité retrieval"]
    C --> D["Niveau 3\nproduction"]
    D --> E["Agentic retrieval\n& multi-source"]
```

| Page | Niveau | Contenu |
|---|---|---|
| [Concepts & architectures](concepts.md) | Tous | Retrieval, embeddings, chunking, reranking, agentic retrieval |
| [Sécurité — ACL & prompt injection](securite.md) | Tous | Droits d'accès, confidentialité, ingestion, caches, révocation et tests |
| [Docling](../chapitre-13-outils-economies/docling.md) | Intermédiaire | Ingestion PDF/DOCX/PPTX/etc., OCR, structure, exports et chunks |
| [Qdrant](../chapitre-13-outils-economies/qdrant.md) | Intermédiaire | Moteur vectoriel, payloads, filtres et hybrid search |
| [Implémentation](implementation.md) | Tous | Progression du prototype à la production |
| [Niveau 1](niveau-1.md) | Débutant | Pipeline minimal et observable |
| [Niveau 2](niveau-2.md) | Intermédiaire | Retrieval hybride, reranking, qualité |
| [Niveau 3](niveau-3.md) | Expert | Production, sécurité, monitoring |
| [Cas d'usage par secteur](cas-usage-secteurs.md) | Intermédiaire | Exemples métier et contraintes |
| [Optimisation avancée](optimisation-avancee.md) | Expert | Évaluation, tuning et diagnostic |

---

## Pipeline RAG minimal

```mermaid
graph TD
    DOCS["Documents"] --> ING["Ingestion / parsing\nex. Docling"]
    ING --> CHUNK["Découpage"]
    CHUNK --> IDX["Index / store\nex. Qdrant"]
    Q["Question"] --> RET["Retrieval"]
    IDX --> RET
    RET --> CTX["Passages pertinents"]
    Q --> AUG["Prompt / contexte augmenté"]
    CTX --> AUG
    AUG --> LLM["LLM"]
    LLM --> ANS["Réponse + sources"]
```

Le pipeline est simple à dessiner mais difficile à rendre fiable. Les erreurs peuvent venir de l'ingestion, du chunking, de l'indexation, du retrieval, du reranking, du prompt ou du modèle.

---

## Ingestion documentaire : Docling

Avant les embeddings et le vector store, il faut transformer les sources en un corpus exploitable.

**[Docling](../chapitre-13-outils-economies/docling.md)** est un exemple d'outil spécialisé dans cette étape :

- PDF avec structure de page, ordre de lecture, tableaux, formules et OCR ;
- DOCX, PPTX, XLSX, HTML, EPUB, images, audio et autres formats ;
- représentation structurée `DoclingDocument` ;
- exports Markdown/JSON/texte et sortie de chunks ;
- exécution locale, bibliothèque Python, service API et serveur MCP.

Docling n'est pas obligatoire : choisissez un parseur selon vos formats et contraintes. Le point important est de **mesurer la qualité de l'ingestion avant de juger le retrieval**.

---

## Embeddings, similarité et moteur vectoriel

Une approche courante consiste à représenter textes et requêtes sous forme de vecteurs puis à rechercher les passages proches.

La similarité cosinus est fréquente, mais **un score élevé n'est pas une preuve de pertinence métier**. Un retrieval doit être évalué sur un jeu de questions représentatif.

**[Qdrant](../chapitre-13-outils-economies/qdrant.md)** fournit un exemple concret de moteur vectoriel adapté à ce rôle, avec filtres sur payload, recherche dense/sparse et requêtes hybrides. Il n'est pas obligatoire : choisissez le store qui correspond à vos contraintes et à vos evals.

Métriques utiles côté retrieval :

- Recall@k ;
- Precision@k ;
- MRR / nDCG selon le problème ;
- taux de réponse avec source correcte ;
- couverture des documents critiques.

---

## Ne pas figer les fournisseurs et tarifs

Les anciennes versions de cette page associaient des niveaux à des modèles précis, des prix mensuels de vector DB et des tarifs de tokens. Ces informations vieillissent trop vite.

Conservez plutôt une matrice de décision :

| Composant | Questions à poser |
|---|---|
| Parsing / ingestion | formats, structure, OCR, tableaux, local/cloud, confidentialité |
| Embeddings | langue, domaine, dimension, coût, hébergement, confidentialité |
| Store | volume, filtres metadata, latence, sauvegarde, coût opérationnel |
| Reranker | gain mesuré, latence ajoutée, coût par requête |
| LLM | qualité sur votre eval, contexte, outils, coût réel du trafic |
| Framework | abstraction utile ou complexité inutile ? |

Les prix doivent être vérifiés sur les pages officielles des fournisseurs au moment d'une décision d'achat, pas recopiés ici comme constantes.

---

## Baseline avant architecture « avancée »

Commencez par :

1. un corpus propre et une ingestion vérifiée ;
2. un chunking simple ;
3. un retrieval observable ;
4. des citations ;
5. un petit jeu d'évaluation réel.

N'ajoutez query expansion, reranking, hybrid search, graph retrieval ou orchestration agentique **que si les evals montrent un problème qu'ils résolvent**.

Cette approche suit le principe Anthropic : privilégier des patterns simples et composables avant d'ajouter de la complexité agentique.

---

## Évaluer ingestion, retrieval et génération séparément

Si la réponse est mauvaise, demandez d'abord :

- le document a-t-il été correctement parsé ?
- sa structure, ses tableaux ou son OCR sont-ils corrects ?
- le bon document était-il indexé ?
- a-t-il été chunké correctement ?
- le bon passage était-il dans le top-k ?
- le reranker l'a-t-il conservé ?
- le modèle a-t-il utilisé la source ?

Ne changez pas simultanément parseur, embeddings, chunk size, prompt et modèle : vous perdrez la capacité d'expliquer l'amélioration.

---

## Agentic retrieval et MCP

Un agent peut décider **quand** chercher, **quelle source** interroger et **s'il faut rechercher à nouveau**. C'est différent d'un pipeline RAG fixe.

Claude Code peut accéder à des systèmes externes via MCP. Pour un projet RAG, cela permet par exemple de connecter :

- un service Docling pour traiter un document ;
- une base documentaire ;
- un moteur de recherche interne ;
- une base SQL ;
- un outil d'observabilité ;
- un système de tickets.

MCP fournit l'accès aux outils et données ; les **skills** peuvent documenter comment les utiliser correctement.

---

## Sécurité

Le guide **[Sécurité du RAG](securite.md)** explique les ACL (listes de contrôle d'accès) et présente les frontières du système avec des diagrammes UML. La sécurité se conçoit dès le prototype, pas seulement lors du passage au niveau 3.

Le retrieval fait entrer du contenu externe dans le contexte du modèle. Considérez ce contenu comme **non fiable** :

- contrôlez les droits d'accès avant ingestion et retrieval ;
- ne faites pas remonter de document qu'un utilisateur n'a pas le droit de voir ;
- conservez la provenance ;
- séparez données et instructions ;
- testez les prompt injections présentes dans les documents ;
- limitez les outils d'écriture lorsque seule la lecture est nécessaire.

---

## Workflow Claude pour développer un RAG

```text
1. Cartographie le pipeline RAG actuel sans modifier le code.
2. Identifie où sont ingestion, chunking, indexation, retrieval, reranking et génération.
3. Trouve les evals existantes.
4. Exécute la baseline et enregistre ses métriques.
5. Propose UNE modification avec hypothèse mesurable.
6. Implémente-la.
7. Réexécute exactement les mêmes evals.
8. Compare coût, latence et qualité avant/après.
```

Pour les analyses volumineuses, déléguez l'exploration à un subagent afin de garder la conversation principale concentrée sur la décision.

---

## Sources

- [Anthropic — Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) — consulté le 2026-09-28
- [Anthropic — Building effective agents](https://www.anthropic.com/engineering/building-effective-agents) — consulté le 2026-09-28
- [Claude Code — MCP](https://code.claude.com/docs/en/mcp) — consulté le 2026-09-28
- [Claude Code — fonctionnalités et extensions](https://code.claude.com/docs/en/features-overview) — consulté le 2026-09-28
- [Docling — dépôt officiel](https://github.com/docling-project/docling) — consulté le 2026-10-01
- [Qdrant — documentation](https://qdrant.tech/documentation/) — consulté le 2026-09-28

## Prochaine étape

Poursuivez avec **[Concepts & Architectures](concepts.md)**, la page suivante dans le menu.
