# RAG dans le Monde Réel : Secteurs + Architectures

<span class="badge-intermediate">Intermédiaire</span>

Exemples concrets, challenges réels, résultats ROI.

---

## 1. Gestion RH — (Carrière, Paie, Conformité) 👔

### Problème Business

Un logiciel RH pour agents de la fonction publique doit gérer :

- **Carrière** : arrêtés, avancement de grade, échelons
- **Paie** : calculs complexes avec régimes spécifiques, primes (13e mois, vacances, etc.)
- **Formation** : suivi des heures, certifications obligatoires
- **Conformité réglementaire** : décrets, circulaires, accord ministre, décision

**Challenges :**

- Base réglementaire massive et changeante (décrets, circulaires, décisions ministérielles)
- Erreurs de calcul = procédures CNIL, contentieux
- Agents/RH cherchent manuellement la "bonne règle" (20-30 min par cas)
- Maintenance coûteuse : chaque réforme = mise à jour code

### Solution RAG (Advanced + Agentic)

**Enterprise RAG** indexant toute la base réglementaire + jurisprudence. Agents autonomes pour vérifier conformité avant exécution.

### Architecture Réglementaire

```
BASE DOCUMENTAIRE
├─ Décrets (1000+)
├─ Circulaires DGAFP (500+)
├─ Accords/Protocoles ministériels (200+)
├─ Décisions CNIL/CDC (300+)
├─ Jurisprudence/Contentieux (100+)
└─ Guides applicatifs RH (50+)

      ↓ Chunking + Métadonnées (type_doc, date_validité, version)
      ↓ Embeddings haute qualité (text-embedding-3-large)
      ↓ Qdrant vectorstore (filtres: juridiction, date_entrée_vigueur)
      ↓
CALCUL PAIE AGENT (ex: "Avancement grade Y5→Y6, échelon 8")
      ↓ Agent recherche les 3 tâches:
        1) Décret définissant barème Y6
        2) Circulaire DGAFP sur conditions d'avancement
        3) Décision ministérielle si surplancher
      ↓ LLM vérifie conformité + calcule montants
      ↓ Agentic loop: Si doute → cherche jurisprudence similaire
      ↓ Reponse avec citations exactes (article X, date)
```

### Code Example (Agentic + Vérification)

```python
from langchain.agents import AgentType, initialize_agent
from langchain.tools import Tool
from langchain.vectorstores import Qdrant
from langchain_openai import ChatOpenAI
import json

# Base réglementaire indexée
documents_metadata = {
    "type": ["décret", "circulaire", "décision"],
    "date_validité_min": "2024-01-01",
    "jurisdiction": "fonction_publique_d_état"
}

vectorstore = Qdrant.from_documents(
    docs=regulation_docs,  # 2000+ docs
    embedding=embeddings,
    path="./regulation_db",
    collection_name="legislation_fp"
)

# Tools pour l'agent
tools = [
    Tool(
        name="SearchRegulation",
        func=lambda q: vectorstore.similarity_search(q, k=5),
        description="Recherche dans décrets, circulaires, décisions"
    ),
    Tool(
        name="CheckJurisprudence",
        func=lambda q: search_case_law(q),
        description="Vérifie jurisprudence (CJUE, tribunal admin, etc)"
    ),
    Tool(
        name="VerifyCompliance",
        func=check_compliance_rules,
        description="Vérifie conformité avant calcul"
    ),
    Tool(
        name="CalculateSalary",
        func=compute_salary_rag_verified,
        description="Calcule paie avec sources citées"
    )
]

# Agent RH autonome
agent = initialize_agent(
    tools,
    llm=ChatOpenAI(model="gpt-4", temperature=0),  # Stricte, pas de créativité
    agent=AgentType.STRUCTURED_CHAT_ZERO_SHOT_REACT_DESCRIPTION,
    verbose=True,
    max_iterations=5  # Limite recherches itératives
)

# Utilisation
agent_input = {
    "input": """
    Agent: Marc Dupont
    Action: Avancement Y5 → Y6, échelon 8 → 1
    Ancienneté: 3 ans Y5
    Prime ministérielle appliquée: Oui
    Situation: Surchef justifié?
    
    Calcule la paie avec vérification conformité OBLIGATOIRE.
    """
}

result = agent.run(agent_input)
print(result)
# Output:
# ✅ CONFORME
# Décret 2023-XX article 12: Avancement Y6 autorisé après 3 ans
# Circulaire DGAFP 2023-YY: Prime ministérielle applicable
# Jurisprudence: CJUE C-456/2023 confirme calcul
# SALAIRE: €3,245.67 (dont +€180 prime)
# Sources citées: [Décret, Circulaire, Avis CJUE]
```

### KPIs Before/After

| Métrique | Before | After | Delta |
|----------|--------|-------|-------|
| **Temps calcul paie/agent** | 30 min | 4 min | ↓ 86% |
| **Erreurs paie detectées** | 8/100 | <1/100 | ↓ 87% |
| **Audit conformité** | 2 semaines | 2 jours | ↓ 93% |
| **Réclamations CNIL** | 5/mois | ~0.5/mois | ↓ 90% |
| **Formation RH requise/règle** | 3h par agent | 0.5h | ↓ 83% |
| **Contentieux/erreur** | $50K/an | $3K/an | ↓ 94% |
| **Satisfaction RH** | 4/10 | 8.5/10 | ↑ +112% |

### Défis & Solutions

| Défi | Impact | Solution RAG |
|------|--------|-------------|
| **Base réglementaire massive** | Temps recherche | Métadonnées (type, date_validité) → filtrer avant recherche |
| **Règles qui changent** | Obsolescence | Versioning docs + date_entrée_vigueur + alertes |
| **Calculs complexes** | Erreurs côûteuses | Agentic loop vérify → cherche jurisprudence si doute |
| **Citation obligatoire** | Audit/CNIL | Chaque réponse = sources exactes (article, décret, date) |
| **Surplancher** | Cas rare/complexe | RAG trouve jurisprudence similaire + CJUE decisions |

---

## 2. Support Client / Help Desk 📞

### Problème Business

- 1000 tickets par jour
- Temps de réponse : 2 heures (agent cherche FAQ manuellement)
- 40% des tickets = redondants (même question)
- Satisfaction client : 6.2/10

### Solution RAG

**Naive RAG** indexant 5000 FAQ documents + knowledge base produits.

### Architecture Simple

```
FAQ Database (5K docs)
      ↓ Chunking (256 tokens)
      ↓ ChromaDB vectorstore
      ↓ Query: "Réinitialiser mot de passe?"
      ↓ Top-3 FAQs trovées
      ↓ ChatGPT formate réponse
      ↓ Agent envoie au ticket
```

### Code Example

```python
from langchain.chains import RetrievalQA
from langchain.chat_models import ChatOpenAI
from langchain.vectorstores import Chroma

# Load FAQ
faq_docs = load_faqs_from_database()  # 5K FAQs

# Setup RAG
vectorstore = Chroma.from_documents(faq_docs, embeddings)
qa_chain = RetrievalQA.from_chain_type(
    llm=ChatOpenAI(model="gpt-3.5-turbo", temperature=0),
    retriever=vectorstore.as_retriever(search_kwargs={"k": 3}),
    return_source_documents=True
)

# Agent workflow
ticket_text = "Customer: How to reset password?"
response = qa_chain({"query": ticket_text})
agent_sends = f"Agent Response: {response['result']}"
```

### KPIs Before/After

| Métrique | Before | After | Delta |
|----------|--------|-------|-------|
| **Response Time** | 2h | 35 min | ↓ 82% |
| **Ticket Backlog** | 200+ | <30 | ↓ 85% |
| **FAQ Tickets %** | 40% | 5% | ↓ 87% |
| **Agent Satisfaction** | 5/10 | 8/10 | ↑ +60% |
| **Customer CSAT** | 6.2 | 7.8 | ↑ +25% |
| **Cost/Ticket** | $15 | $3.50 | ↓ 77% |

---

## 3. Analyse Juridique & Conformité ⚖️

### Problème Business

- 10,000 contrats en PDF
- Recherche clause précise = 4 heures (avocats spécialisés)
- Erreurs = coûteuses (clauses manquées)
- Audit conformité = 2 semaines

### Solution RAG

**Advanced RAG** avec semantic chunking, metadata filtering, Cohere reranking.

### Architecture Avancée

```
PDF Contrats (10K)
      ↓ Extraction structurée (LlamaParse)
      ↓ Chunking sémantique par clause
      ↓ Add metadata: type_clause, jurisdiction, date
      ↓ Embedding: textembedding-3-large (3072D)
      ↓ Qdrant vectorstore (advanced filtering)
      ↓
Query: "Délai de paiement ?"
      ↓ Multi-query expansion (3 variations)
      ↓ Search x3 → Top-30 candidates
      ↓ Cohere rerank → Top-5
      ↓ GPT-4 fact-check + cite articles
      ↓ Verified response with exact references
```

### Code Example (Advanced)

```python
from qdrant_client import QdrantClient
from cohere import Client as CohereClient

def advanced_legal_rag(query: str):
    # 1. Multi-query expansion
    expanded = [
        "Délai paiement ?",
        "Payment term clause",
        "Conditions crédit?"
    ]
    
    # 2. Search all variants
    candidates = []
    for q in expanded:
        results = qdrant.search(
            collection_name="contracts",
            query_vector=embed_model.encode(q),
            limit=30,
            query_filter=Filter(must=[HasMetadata("jurisdiction", "FR")])
        )
        candidates.extend(results)
    
    # 3. Rerank with Cohere
    cohere = CohereClient(api_key="YOUR_KEY")
    reranked = cohere.rerank(
        model="rerank-english-v3.0",
        query=query,
        documents=[c.payload['text'] for c in candidates],
        top_n=5
    )
    
    # 4. LLM + fact-check
    top_5 = [candidates[r.index] for r in reranked.results]
    
    response = llm(f"""
    Based ONLY on these clauses: {query}
    
    Clauses: {format_clauses(top_5)}
    
    Cite exact article numbers.
    """, model="gpt-4")
    
    return response
```

### KPIs

| Métrique | Before | After | Delta |
|----------|--------|-------|-------|
| **Search Time** | 4h | 5 min | ↓ 98% |
| **Accuracy** | 92% | 99.5% | ↑ +7.5% |
| **Compliance Errors** | 3/year | 0/year | ✅ Zéro |

---

## 4. R&D / Recherche Scientifique 🔬

### Problème

- 100,000 papers sur arXiv
- Chercheur passe 5h avant de coder
- Duplication : découvrir tard prior work

### Solution

**Agentic RAG** with multi-source tools (Papers + Patents + Repos).

### Exemple d'Agent

```python
from langchain.agents import initialize_agent, Tool, AgentType

def search_arxiv(query: str) -> str:
    # Search arXiv papers
    pass

tools = [
    Tool(
        name="Search_ArXiv_Papers",
        func=search_arxiv,
        description="Search SOTA research papers"
    ),
]

agent = initialize_agent(
    tools,
    ChatOpenAI(model="gpt-4"),
    agent=AgentType.OPENAI_FUNCTIONS
)

response = agent.run("""
Find 5 techniques for neural network compression.
For each: methodology, metrics, use cases.
Focus on 2024-2025 papers.
""")
```

### Results

- ✅ 5h recherche → 15 min
- ✅ 50+ sources synthétisées
- ✅ Prior work dépistée automatiquement

---

## 5. Santé / Protocoles Cliniques 🏥

### Requirement: ZÉRO ERREURS

Médecine = zéro tolérance à hallucinations.

### Solution

Hybrid search + Fact-Check GATE + Audit trail.

```python
def medical_rag_with_review(condition: str):
    """RAG for clinical protocols — DOCTOR REVIEW REQUIRED"""
    
    # Retrieve
    docs = vectorstore.similarity_search(condition, k=5)
    
    # Generate
    response = llm(f"Protocol for {condition}: {docs}")
    
    # GATE: Medical professional MUST approve
    print("⚠️  DOCTOR REVIEW REQUIRED:")
    print(f"Recommended: {response}")
    
    approval = input("Approve? (yes/no): ")
    
    if approval != "yes":
        log_rejection(condition, response)
        return None
    
    # Audit trail
    log_audit(user=get_user(), protocol=response, approved=True)
    return response
```

### Key Features

- ✅ Human review gate
- ✅ Source documentation
- ✅ HIPAA compliance
- ✅ Zero hallucinations

---

## 6. Commerce / E-Commerce 🛍️

### Multimodal RAG (Text + Images)

```python
from sentence_transformers import SentenceTransformer

model = SentenceTransformer('clip-ViT-L-14')

for product in products:
    text_emb = model.encode(product['description'])
    image_emb = model.encode(Image.open(product['image']))
    
    combined = (text_emb + image_emb) / 2
    
    vectorstore.add(id=product['id'], vector=combined)
```

### Results

- ✅ Unified descriptions
- ✅ +15% conversion rate
- ✅ -20% returns

---

## 7. HR / Politiques Internes 👥

### Simple Naive RAG

```python
handbook = open("employee_handbook.md").read()
sections = handbook.split("## ")

vectorstore.add(
    ids=[f"sec_{i}" for i in range(len(sections))],
    documents=sections
)

# Chatbot
while True:
    q = input("HR Question: ")
    results = vectorstore.query(q, top_k=2)
    print(f"Answer: {results[0]}")
```

### Results

- ✅ -50% HR email volume
- ✅ Onboarding 2 weeks → 3 days
- Free

---

## Tableau Résumé

| Secteur | Architecture | Vectorstore | LLM | Reranking | Coût |
|---------|---|---|---|---|---|
| **Fonction Publique** | Agentic | Qdrant | GPT-4 | ✅ Cohere | High |
| **Support** | Naive | ChromaDB | 3.5 | ❌ | Low |
| **Juridique** | Advanced | Qdrant | GPT-4 | ✅ Cohere | High |
| **R&D** | Agentic | FAISS | GPT-4 | ❌ | Medium |
| **Santé** | Hybrid+Gate | Postgres | GPT-4 | ❌ | High |
| **Commerce** | Multimodal | Pinecone | 3.5 | ❌ | Medium |
| **HR** | Naive | ChromaDB | 3.5 | ❌ | Low |

### Sources

- **Zendesk Customer Service Benchmarks 2024**: Support AI ROI
- **Gartner Legal AI Report**: Contract analysis trends
- **FDA Guidance on AI in Healthcare**: Clinical protocols
- **McKinsey E-Commerce Study**: Conversion rate optimization
- **HR Tech Magazine**: Employee handbook digitalization

---

## Prochaine Étape

Vos cas d'usage identifiés ? Passez à l'optimisation :

### 🚀 [Optimisation Avancée](optimisation-avancee.md)

Après MVP : coûts, latence, qualité, monitoring.

- **RAGAS evaluation** : évaluer précision RAG automatiquement
- **Caching** : réduire appels LLM (-60% coûts)
- **Token optimization** : réduire taille contexte
- **Security/Compliance** : audit trail, données sensibles
- **Production checklist** : 7 points validation avant deploy
