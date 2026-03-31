# 🎯 NIVEAU 2 — RAG Production Avancé

<span class="badge-intermediate">Intermédiaire</span>

**Prérequis :**

- Avoir complété [Niveau 1](niveau-1.md)
- Comprendre les vecteurs et la recherche sémantique
- Vouloir optimiser la qualité et la performance

**Coûts :**

- ✅ **Gratuit** : Hybrid Search, BM25, ChromaDB, FAISS
- 💰 **Payant** : OpenAI API, Cohere Rerank ($0.02/1K requests)

!!! warning "💰 Coûts estimés par niveau"
    | Service | Coût/mois (100 requêtes) | Coût/mois (10K requêtes) |
    |---------|------------------------|------------------------|
    | OpenAI gpt-3.5-turbo | ~$1.50 | ~$150 |
    | Cohere Rerank | ~$0.02 | ~$2 |
    | Pinecone (pro) | $25 | $25 |
    | **Total Niveau 2** | ~$26.50 | ~$177 |
    
    ✅ **Alternative gratuite** : Query Expansion + BM25 (sans Cohere Rerank)

**Objectif :** Implémenter des techniques avancées (Hybrid Search, Query Expansion, Re-ranking) pour améliorer la pertinence des résultats.

---

## 📚 Fondamentaux — Vecteurs & Recherche Sémantique

### Qu'est-ce qu'un Vecteur ?

Un **vecteur** est une liste de nombres décimaux qui représente le sens d'un texte. Par exemple :

| Texte | Vecteur (simplifié) |
|-------|------------------|
| "Python est un langage de programmation" | `[0.23, -0.15, 0.89, 0.12, -0.34, ...]` |
| "Java est un langage de programmation" | `[0.24, -0.14, 0.91, 0.11, -0.33, ...]` |
| "Les chats sont mignons" | `[-0.67, 0.45, -0.12, 0.88, 0.02, ...]` |

**Observation :** Les deux phrases sur les langages ont des vecteurs très **proches** (0.23 vs 0.24, 0.89 vs 0.91), tandis que la phrase sur les chats est très **différente** (-0.67 vs 0.23).

### Comment on Crée un Vecteur ? — Embeddings

Un **embedding** est un modèle qui convertit du texte en vecteur. La magie se produit ici :

```python
from sentence_transformers import SentenceTransformer

# Charger un modèle d'embeddings
model = SentenceTransformer("all-MiniLM-L6-v2")

# Convertir du texte en vecteur
texte1 = "Comment configurer Python?"
vec1 = model.encode(texte1)
print(vec1)
# → array([ 0.0234,  -0.1567,   0.8932, ... ])  # 384 nombres

texte2 = "Comment installer Python?"
vec2 = model.encode(texte2)
print(vec2)
# → array([ 0.0231,  -0.1523,   0.8956, ... ])  # Très similaire à vec1

texte3 = "Quelle est la capitale de la France?"
vec3 = model.encode(texte3)
print(vec3)
# → array([-0.7234,   0.4156,  -0.1234, ... ])  # Très différent de vec1 et vec2
```

**Détail technique :**

- **all-MiniLM-L6-v2** crée des vecteurs de **384 dimensions**
- Chaque dimension capture un aspect du sens : "programmation", "python", "configuration", etc.
- Le modèle a été entraîné sur des milliards d'exemples pour capturer la sémantique

### Mesurer la Similarité — Distance Cosinus

Pour comparer deux vecteurs, on calcule la **distance cosinus** (entre 0 et 1) :

```python
import numpy as np
from numpy.linalg import norm

def cosine_similarity(v1, v2):
    """Mesure la similarité entre deux vecteurs (0=très différent, 1=identique)"""
    return np.dot(v1, v2) / (norm(v1) * norm(v2))

sim_12 = cosine_similarity(vec1, vec2)  # Compare "Configure Python" vs "Install Python"
print(f"Similarité: {sim_12:.3f}")
# → Similarité: 0.923  (TRÈS similaire)

sim_13 = cosine_similarity(vec1, vec3)  # Compare "Python" vs "Capitale de la France"
print(f"Similarité: {sim_13:.3f}")
# → Similarité: 0.142  (PAS similaire)
```

**Interprétation :**

- 🔴 0.0-0.3 : Sens complètement différent
- 🟡 0.3-0.7 : Sens partiellement lié
- 🟢 0.7-1.0 : Sens très similaire (bonne correspondance)

### Recherche Sémantique en RAG

C'est le **cœur du RAG**. Au lieu de chercher des mots-clés, on cherche le **sens** :

```python
# L'utilisateur pose une question
question = "Comment je peux configurer l'API?"
question_vec = model.encode(question)

# On compare avec TOUS les chunks indexés
chunks = [
    "Pour configurer l'API, allez dans settings.json",          # ← Pertinent
    "L'API supporte les requêtes REST et WebSocket",            # ← Partiellement pertinent
    "Les meilleures recettes de pizza italienne",               # ← Non pertinent
]

for chunk in chunks:
    chunk_vec = model.encode(chunk)
    score = cosine_similarity(question_vec, chunk_vec)
    print(f"Score: {score:.3f} | {chunk[:50]}...")

# Output:
# Score: 0.876 | Pour configurer l'API, allez dans settings.json...
# Score: 0.542 | L'API supporte les requêtes REST et WebSocket...
# Score: 0.091 | Les meilleures recettes de pizza italienne...
```

**Contrairement à la recherche par mots-clés :**

| Approche | Requête | Résultat |
|----------|---------|----------|
| **Mots-clés (BM25)** | "configurer l'API" | ❌ Trouve "configuration API" mais pas "mettre en place le service" |
| **Sémantique (Vecteurs)** | "configurer l'API" | ✅ Trouve "Pour mettre en place votre service API, suivez ces étapes" |

### Pourquoi ça Marche Mieux que BM25

**BM25 (mots-clés)** :
```
Cherche: "configurer API"
Trouve:  "configurer API" ← EXACT
Ignore:  "mettre en place votre service" ← PAS de mots-clés
```

**Vecteurs (sémantique)** :
```
Sens recherché: "comment mettre en place un service API"
Trouve:         "Pour configurer l'API..." ← Même SENS
                  "Mettre en place le service..." ← Même SENS
```

!!! tip "Quand utiliser les vecteurs (Niveau 2)"
    ✅ **Utilisez les vecteurs** quand :
    - La paraphrase compte (même sens, mots différents)
    - Les questions sont formulées librement
    - Vous avez un contexte documentaire riche
    
    ❌ **Les vecteurs échouent** quand :
    - Vous cherchez des termes techniques très spécifiques
    - Les mots-clés exacts sont importants
    - La documentation contient beaucoup d'acronymes
    
    **Solution : Hybrid Search** (combinez BM25 + vecteurs) → voir section suivante

---

## Techniques Avancées

### Hybrid Search (BM25 + Dense)

Combine la recherche par mots-clés (BM25) et la recherche sémantique (dense vectors). Utile quand les deux approches sont complémentaires.

```python
from langchain.retrievers import BM25Retriever, EnsembleRetriever

bm25 = BM25Retriever.from_documents(chunks)
dense = vectorstore.as_retriever(search_kwargs={"k": 5})

ensemble = EnsembleRetriever(
    retrievers=[bm25, dense],
    weights=[0.3, 0.7]  # 30% BM25, 70% semantic
)

# Récupère les meilleurs de CHAQUE méthode
best_docs = ensemble.get_relevant_documents("Comment configurer?")
```

**Quand l'utiliser :**

- Les documents contiennent des termes techniques spécifiques
- Les mots-clés comptent autant que l'intention sémantique
- Vous avez du contexte domaine-spécifique

---

### Query Expansion

Génère automatiquement des variantes de la question de l'utilisateur pour augmenter la couverture de recherche.

```python
from langchain.chains import LLMChain
from langchain.prompts import PromptTemplate

expand_prompt = PromptTemplate(
    input_variables=["QUESTION"],
    template="""Générer 3 variantes de cette question:
    {QUESTION}
    
    Sortie (une par ligne):"""
)

chain = LLMChain(llm=llm, prompt=expand_prompt)
variants = chain.run(QUESTION="Python?").split("\n")

# Chercher sur chaque variante
all_docs = []
for variant in variants:
    docs = vectorstore.similarity_search(variant, k=5)
    all_docs.extend(docs)

# Fusionner et dédupliquer
unique = {doc.metadata['id']: doc for doc in all_docs}.values()
```

**Quand l'utiliser :**

- Les questions sont souvent mal formulées ou vagues
- Vous avez besoin d'une couverture maximale
- Les tokens supplémentaires ne sont pas une limite

---

### Re-ranking avec Cohere

<span class="badge-intermediate">Optionnel & 💰 Payant</span>

Refine les résultats en les classant avec un modèle cross-encoder spécialisé. Cette étape améliore la précision mais **ajoute un coût** (~$0.0001/requête).

```python
import cohere

co = cohere.Client(api_key="...")

# Récupérer 20 candidats
candidates = vectorstore.similarity_search("Python?", k=20)

# Re-rank à top-3
reranked = co.rerank(
    query="Python?",
    documents=[d.page_content for d in candidates],
    model="rerank-english-v3.0",
    top_n=3
)

# Top-3 final
top_docs = [candidates[r["index"]] for r in reranked]
```

**Quand l'utiliser :**

- ✅ Vous avez besoin d'une précision maximale (e.g. FAQ juridique)
- ✅ Votre budget le permet
- ✅ La latence n'est pas critique

**Alternative gratuite :**

- Garder top-k=3 directement (sans re-ranking)
- Améliorer à la place la récupération (Hybrid Search + Query Expansion)

!!! tip "Budget-friendly"
    Pour rester gratuit au Niveau 2, utilisez seulement **Hybrid Search + Query Expansion** sans Cohere Rerank.

**Quand l'utiliser :**

- La précision est critique (support client, recherche juridique)
- Vous avez un budget pour les appels API externes
- La latence ajoutée est acceptable (~500ms)

---

## Code Exemple : Classe RAG Avancée

```python
from sentence_transformers import SentenceTransformer
import chromadb
from pathlib import Path


class DocumentRAG:
    """
    RAG minimaliste et fonctionnel basé sur sentence-transformers + ChromaDB.
    Indexe des fichiers texte ou Markdown et répond aux questions en s'appuyant
    sur leur contenu.
    """

    def __init__(
        self,
        storage_path: str = "./rag_storage",
        model_name: str = "all-MiniLM-L6-v2",
        chunk_size: int = 300,
        overlap: int = 30,
    ):
        self.model = SentenceTransformer(model_name)
        self.chunk_size = chunk_size
        self.overlap = overlap

        client = chromadb.PersistentClient(path=storage_path)
        self.collection = client.get_or_create_collection(
            name="documents",
            metadata={"hnsw:space": "cosine"}
        )

    def _chunk(self, text: str) -> list[str]:
        words = text.split()
        chunks, start = [], 0
        while start < len(words):
            chunks.append(" ".join(words[start:start + self.chunk_size]))
            start += self.chunk_size - self.overlap
        return chunks

    def index_file(self, filepath: str) -> int:
        """Indexe un fichier et retourne le nombre de chunks créés."""
        text = Path(filepath).read_text(encoding="utf-8")
        chunks = self._chunk(text)
        embeddings = self.model.encode(chunks).tolist()

        # Préfixer les IDs avec le nom de fichier pour éviter les collisions
        base_id = Path(filepath).stem
        self.collection.add(
            ids=[f"{base_id}_chunk_{i}" for i in range(len(chunks))],
            documents=chunks,
            embeddings=embeddings,
            metadatas=[{"source": filepath, "chunk_index": i} for i in range(len(chunks))]
        )
        return len(chunks)

    def ask(self, question: str, top_k: int = 3) -> str:
        """Retourne le prompt augmenté prêt à être envoyé à un LLM."""
        question_vec = self.model.encode(question).tolist()
        results = self.collection.query(
            query_embeddings=[question_vec],
            n_results=top_k,
            include=["documents", "metadatas"]
        )

        passages = [
            f"[Source : {meta['source']}]\n{doc}"
            for doc, meta in zip(results["documents"][0], results["metadatas"][0])
        ]
        context = "\n\n---\n\n".join(passages)

        return (
            f"Réponds uniquement à partir de la documentation suivante.\n\n"
            f"{context}\n\n"
            f"Question : {question}"
        )


# ── Utilisation ──────────────────────────────────────────────────────────────
rag = DocumentRAG(storage_path="./mon_rag")

# Indexer plusieurs fichiers
for fichier in ["docs/guide-api.md", "docs/architecture.md", "docs/faq.md"]:
    n = rag.index_file(fichier)
    print(f"  {fichier} → {n} chunks indexés")

# Poser une question
prompt = rag.ask("Quelle est la limite de requêtes par minute sur l'API ?")

# Envoyer à votre LLM (exemple avec OpenAI)
# from openai import OpenAI
# client = OpenAI()
# response = client.chat.completions.create(
#     model="gpt-4o-mini",
#     messages=[{"role": "user", "content": prompt}]
# )
# print(response.choices[0].message.content)
```

!!! info "Limites à connaître avant de passer en production"
    - **La qualité du chunking est déterminante** : un mauvais découpage produit de mauvais résultats, même avec un excellent LLM. Commencer par auditer visuellement vos premiers chunks.
    - **Les hallucinations ne disparaissent pas** : si le chunk pertinent n'est pas retrouvé (mauvais embedding, question trop vague), le LLM répondra quand même — d'où l'instruction "réponds que tu ne sais pas si l'info n'est pas dans le contexte".
    - **Mettre à jour l'index** : quand vos documents changent, re-indexer les fichiers modifiés.

---

## Ressources & Outils

### Frameworks Comparaison

| Framework | Courbe | Community | Pour qui |
|-----------|--------|-----------|----------|
| **LangChain** | Moyen | ⭐⭐⭐⭐⭐ 50K+ | Production + integrations |
| **LlamaIndex** | Facile | ⭐⭐⭐⭐ 30K+ | Query engine focused |
| **Haystack** | Difficile | ⭐⭐⭐ 10K+ | ML engineers |

### Vector Databases

| Solution | Coût | Latency | Use Case |
|----------|------|---------|----------|
| **ChromaDB** | $0 | 5ms | Prototype |
| **Qdrant** | $18/mo | 50ms | Startup |
| **Pinecone** | $25/mo | 100ms | Production |
| **Weaviate** | $0 (self) | 50ms | Enterprise |
| **Milvus** | $0 (self) | 20ms | High-perf |

### Embedding Models Benchmark

| Modèle | Dim | Speed | Quality | Coût |
|--------|-----|-------|---------|------|
| **all-MiniLM-L6-v2** | 384 | ⚡⚡⚡ | ⭐⭐⭐⭐ | $0 |
| **all-mpnet-base-v2** | 768 | ⚡⚡ | ⭐⭐⭐⭐⭐ | $0 |
| **text-embedding-3-small** | 512 | ⚡ | ⭐⭐⭐⭐⭐ | $0.02/M |
| **text-embedding-3-large** | 3072 | 🐌 | ⭐⭐⭐⭐⭐ (98.6) | $0.13/M |

### Cloud RAG Services

```python
# AWS Bedrock
import boto3

client = boto3.client('bedrock-runtime')
response = client.invoke_model(
    modelId='anthropic.claude-3-sonnet',
    body=json.dumps({"prompt": "..."})
)

# Azure Cognitive Search
from azure.search.documents import SearchClient

client = SearchClient(endpoint="...", index_name="docs", credential=...)
results = client.search(search_text="...", vector_queries=[...])

# Google Vertex AI Search
from google.cloud import discoveryengine

client = discoveryengine.SearchServiceClient()
response = client.search(discoveryengine.SearchRequest(...))
```

---

## Prochaine étape

📖 Lire **[Niveau 3 — Expert](niveau-3.md)** pour Enterprise RAG, Agents, et Monitoring en production.

