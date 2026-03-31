# ⚡ NIVEAU 1 — Premier RAG en 30 minutes

<span class="badge-beginner">Débutant</span>

**Prérequis :**

- Python 3.8+ installé
- Clé API OpenAI (ou compte Hugging Face)
- 30 minutes de libre

**Coûts :**

- ✅ **Gratuit** : Python, libraries, ChromaDB, sentence-transformers
- 💰 **Payant** : OpenAI API ($0.0005-0.03 par 1K tokens)

!!! warning "⚠️ Coûts OpenAI"
    Ce niveau utilise **ChatOpenAI (gpt-3.5-turbo)** qui est payant (~$0.0005 par requête).
    
    **Pour rester gratuit**, remplacez par **Ollama** (LLM local) ou **HuggingFace** (inférence gratuite).

**Objectif :** Construire un RAG minimal et fonctionnel qui indexe des documents et répond aux questions.

---

## 💡 Alternative 100% Gratuite

Si vous n'avez pas de budget (ou voulez tester en local), remplacez OpenAI par **Ollama** :

```bash
# Installer Ollama sur https://ollama.ai
# Puis télécharger un modèle léger
ollama pull mistral:7b-instruct
# Lancez le serveur local
ollama serve
```

```python
from langchain_ollama import OllamaLLM

# À la place de ChatOpenAI
llm = OllamaLLM(model="mistral:7b-instruct")

# Le reste du code fonctionne identiquement
qa_chain = RetrievalQA.from_chain_type(
    llm=llm,  # ← Utilise maintenant Ollama (local + gratuit)
    chain_type="stuff",
    retriever=vectorstore.as_retriever(search_kwargs={"k": 3})
)
```

**Avantages :** Aucun coût, données en local, vitesse acceptable  
**Inconvénient :** Qualité inférieure à GPT-4

---

## Avec Zéro Setup Complexe

**Installation**
```bash
# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install langchain langchain-openai langchain-community
```

**API Keys**
```bash
# Create .env file
echo "OPENAI_API_KEY=sk-..." > .env
```

---

## Étape 1 : Charger Documents (5 min)

=== "Texte Simple"
    ```python
    from langchain.schema import Document

    docs = [
        Document(page_content="Python est un langage de programmation."),
        Document(page_content="Python crée en 1989 par Guido van Rossum."),
        Document(page_content="Python permet OOP, functional, etc."),
    ]
    ```

=== "Depuis un PDF"
    ```python
    from langchain.document_loaders import PyPDFLoader

    loader = PyPDFLoader("./myfile.pdf")
    docs = loader.load()
    ```

=== "Dossier complet"
    ```python
    from langchain.document_loaders import DirectoryLoader

    loader = DirectoryLoader("./docs", glob="**/*.txt")
    docs = loader.load()
    ```

---

## Étape 2 : Embeddings (2 min)

**Gratuit (Recommandé débutants)**
```python
from langchain.embeddings import HuggingFaceEmbeddings

embeddings = HuggingFaceEmbeddings(model_name="all-MiniLM-L6-v2")
# 384D vectors, très rapide
```

---

## Étape 3 : Indexer (2 min)

```python
from langchain.vectorstores import Chroma
from langchain.text_splitters import CharacterTextSplitter

# Split
splitter = CharacterTextSplitter(chunk_size=256, chunk_overlap=50)
chunks = splitter.split_documents(docs)

# Index
vectorstore = Chroma.from_documents(
    documents=chunks,
    embedding=embeddings,
    persist_directory="./chroma_db"
)
```

---

## Étape 4 : LLM + Query (5 min)

```python
from langchain.chat_models import ChatOpenAI
from langchain.chains import RetrievalQA

llm = ChatOpenAI(model="gpt-3.5-turbo", temperature=0.3)

qa_chain = RetrievalQA.from_chain_type(
    llm=llm,
    chain_type="stuff",
    retriever=vectorstore.as_retriever(search_kwargs={"k": 3})
)

# Test
result = qa_chain.run("Quoi Python ?")
print(result)
# → "Selon la doc, Python est un langage de programmation..."
```

---

## ✅ RAG Fonctionne !

```python
# Complete NIVEAU 1 code

from langchain.schema import Document
from langchain.embeddings import HuggingFaceEmbeddings
from langchain.vectorstores import Chroma
from langchain.text_splitters import CharacterTextSplitter
from langchain.chat_models import ChatOpenAI
from langchain.chains import RetrievalQA

# 1. Data
docs = [
    Document(page_content="Python est un langage de programmation."),
    Document(page_content="Python crée en 1989."),
]

# 2. Embeddings
embeddings = HuggingFaceEmbeddings(model_name="all-MiniLM-L6-v2")

# 3. Chunking
splitter = CharacterTextSplitter(chunk_size=256, chunk_overlap=50)
chunks = splitter.split_documents(docs)

# 4. Vectorstore
vectorstore = Chroma.from_documents(documents=chunks, embedding=embeddings)

# 5. LLM
llm = ChatOpenAI(model="gpt-3.5-turbo", temperature=0.3)

# 6. RAG Chain
qa_chain = RetrievalQA.from_chain_type(
    llm=llm,
    chain_type="stuff",
    retriever=vectorstore.as_retriever(search_kwargs={"k": 3})
)

# 7. Ask
answer = qa_chain.run("Quoi Python ?")
print(answer)
```

---

## Prochaine étape

📖 Lire **[Niveau 2 — Avancé](niveau-2.md)** pour ajouter des techniques comme Hybrid Search et Query Expansion.

