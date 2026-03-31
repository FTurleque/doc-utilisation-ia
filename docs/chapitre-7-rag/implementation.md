# RAG — Implémentation Complète (Débutant à Expert)

<span class="badge-beginner">Débutant</span>  <span class="badge-intermediate">Intermédiaire</span>  <span class="badge-expert">Expert</span>

Progressez à votre rythme : de **RAG minimal** (30 min, débutant) jusqu'à **RAG production-grade** (architecture avancée, scaling, monitoring). Tous les codes sont testables immédiatement.

!!! info "📌 Langage utilisé: PYTHON 🐍"
    **Tous les exemples de code de ce chapitre sont en Python** (3.8+)
    
    - **Frameworks**: LangChain, LlamaIndex (Python-first)
    - **Vector DBs**: ChromaDB, FAISS, Qdrant (tous supportent Python)
    - **Embeddings**: sentence-transformers, OpenAI API (Python)
    - **LLMs**: gpt-3.5, gpt-4, Claude (via Python)
    
    **Vous voulez un autre langage?** Voir en bas: [Équivalents Node.js / Java / Rust](#autres-langages)

---

## Choisissez Votre Niveau

| Page | Niveau | Durée | Coût au démarrage | Contenu |
|------|--------|-------|------------------|---------|
| **[Niveau 1](niveau-1.md)** | <span class="badge-beginner">Débutant</span> | 30 min | ✅ Gratuit* | Charger → Embeddings → Index → Query |
| **[Niveau 2](niveau-2.md)** | <span class="badge-intermediate">Intermédiaire</span> | 2-3h | 💰 ~$25-100 | Hybrid Search, Query Expansion, Re-ranking optionnel |
| **[Niveau 3](niveau-3.md)** | <span class="badge-expert">Expert</span> | 1 jour | 💰 $1,500+ | Chunking, FAISS, Agents, RAGAS, Langsmith |

*Niveau 1 : Gratuit avec Ollama (local), ou ~$0.50 avec OpenAI

!!! info "💰 Coûts Estimés en Production"
    
    | Niveau | 100 requêtes/mois | 10K requêtes/mois | 1M requêtes/mois |
    |--------|------------------|------------------|-----------------|
    | **1** | $0 (Ollama) | $1.50 | $150 |
    | **2** | $0.50 | $75 | $7,500 |
    | **3** | $10 | $250 | $2,000+ |
    
    **Levier d'économies :**
    - Utiliser **Ollama** au lieu de ChatOpenAI
    - Cacher les résultats (réduire requêtes API)
    - Ne pas utiliser Cohere Rerank au Niveau 2
    - Utiliser du **text-embedding-3-small** (50x moins cher que large)

---

## Démarche Recommandée

### 1️⃣ **Vous débutez ?** → Commencez par [Niveau 1](niveau-1.md)
- Objectif : Avoir un RAG fonctionnel en 30 minutes
- Code : 50 lignes de Python
- Budget : **Gratuit avec Ollama**

### 2️⃣ **Vous maîtrisez Niveau 1 ?** → Passez à [Niveau 2](niveau-2.md)
- Objectif : Améliorer la pertinence et la performance
- Techniques : Hybrid Search, Query Expansion, Re-ranking (optionnel)
- Budget : **Gratuit to $100/mois** selon les services actifs

### 3️⃣ **Vous construisez en production ?** → Consultez [Niveau 3](niveau-3.md)
- Objectif : RAG enterprise-grade avec monitoring
- Sujets : Chunking, Agents, Évaluation (RAGAS), Monitoring (Langsmith)
- Budget : **$1,500+ par mois** pour haute charge

---

## 🎯 Cas d'Usage Courants

### Vous avez un petit corpus (~1000 docs)?
→ [Niveau 1](niveau-1.md) + ChromaDB suffit

### Vous avez besoin de haute précision?
→ [Niveau 2](niveau-2.md) + Re-ranking Cohere

### Vous servez 1000s d'utilisateurs?
→ [Niveau 3](niveau-3.md) + FAISS + Agents

---

## Autres Langages

<span class="badge-intermediate">Intermédiaire</span>

Ce chapitre est centré sur **Python**, mais RAG est universel. Voici les équivalents pour d'autres écosystèmes.

### Node.js / TypeScript

```typescript
// Installation
// npm install @langchain/core @langchain/openai chromadb

import { OpenAIEmbeddings } from "@langchain/openai";
import { Chroma } from "@langchain/community/vectorstores/chroma";
import { RecursiveCharacterTextSplitter } from "langchain/text_splitter";

const embeddings = new OpenAIEmbeddings();
const vectorStore = new Chroma({ embeddings });

// Index
const splitter = new RecursiveCharacterTextSplitter({ chunkSize: 500 });
const docs = await splitter.splitText("...");
await vectorStore.addDocuments(docs);

// Query
const results = await vectorStore.similaritySearch("Quelle est...", 3);
```

**Frameworks recommandés :**
- [LangChain.js](https://js.langchain.com) — Équivalent JS de LangChain (production-ready)
- [LlamaIndex.ts](https://github.com/run-llama/LlamaIndexTS) — LlamaIndex pour TypeScript
- [Verba](https://github.com/weaviate/Verba) — RAG UI avec Weaviate backend

### Java

```java
// Dépendances: langchain4j, chromadb-java
import dev.langchain4j.memory.chat.MessageWindowChatMemory;
import dev.langchain4j.rag.content.retriever.ContentRetriever;
import dev.langchain4j.store.embedding.EmbeddingStore;
import dev.langchain4j.rag.DefaultRetrievalAugmentor;

// Embedding
EmbeddingStore<TextSegment> embeddingStore = new InMemoryEmbeddingStore<>();

// RAG Chain
RetrievalAugmentor ragAugmentor = DefaultRetrievalAugmentor.builder()
    .withContentRetriever(contentRetriever)
    .build();

// Chat avec RAG
AiMessage response = ai.chat(ragAugmentor, "Quelle est...").aiMessage();
```

**Frameworks recommandés :**
- [LangChain4j](https://github.com/langchain4j/langchain4j) — Java native, excellente doc
- [Spring AI](https://spring.io/projects/spring-ai) — Intégration Spring Boot native
- [Quarkus LangChain4j](https://docs.quarkus.io/langchain) — RAG serverless avec Quarkus

### Rust

```rust
// Cargo.toml: langchain-rust, qdrant-client, ollama-rs
use langchain_rust::chain::Chain;
use langchain_rust::llm::OpenAIConfig;
use qdrant_client::client::QdrantClient;

#[tokio::main]
async fn main() {
    let client = QdrantClient::from_url("http://localhost:6334").build()?;
    
    // Search
    let search_result = client.search_points(
        "documents".to_string(),
        vec![embedding],
        3,
    ).await?;
    
    // Chat
    let llm = OpenAIConfig::default().build()?;
    let response = llm.invoke(&context).await?;
    
    println!("{}", response);
}
```

**Frameworks recommandés :**

- [langchain-rust](https://github.com/Abraxas-365/langchain-rust) — Port en cours, jeune écosystème
- [Qdrant Rust SDK](https://qdrant.tech/documentation/quick-start/) — Vector DB native Rust
- [Ollama](https://ollama.ai) + local LLMs — RAG totalement offline + performant

### Comparaison d'Écosystèmes

| Langage | Maturité | Community | Perfs | Pour qui |
|---------|----------|-----------|-------|----------|
| **Python** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | Bonnes | Data scientists, prototypes rapides |
| **Node.js** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | APIs web, full-stack JS |
| **Java** | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | Enterprise, haute disponibilité |
| **Rust** | ⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐⭐⭐ | Performance critique, systèmes |

---

## Prochains chapitres

**[Bonnes Pratiques](../chapitre-9-bonnes-pratiques/index.md)** — Utilisation effective, productivité, sécurité et workflows IA au quotidien
**[Cas d'Usage par Technologie](../chapitre-10-cas-usage/index.md)** — Configurations et exemples concrets pour Java, Python, Node.js, React
