# RAG — Mise en Œuvre pas à pas

<span class="badge-expert">Expert</span>

Ce guide construit un RAG local **fonctionnel et sans serveur externe** en 4 étapes concrètes. L'objectif : indexer des documents texte, puis interroger cet index pour enrichir automatiquement les prompts envoyés à un LLM.

**Installation des dépendances** (choisir une option) :

```bash
# Option A — ChromaDB : persistance sur disque, idéal pour prototyper
pip install sentence-transformers chromadb

# Option B — FAISS : ultra-rapide en mémoire, idéal pour la production
pip install sentence-transformers faiss-cpu
```

---

## Étape 1 — Découper les documents en chunks

Un LLM ne peut pas lire un document entier d'un coup : la **fenêtre de contexte est limitée** en tokens. Mais surtout, si on indexe des documents trop longs, la recherche vectorielle ramènera des passages trop généraux — et le LLM noiera la réponse cherchée dans du bruit.

La solution est le **chunking** : découper chaque document en petits blocs de taille fixe avec un **chevauchement** (*overlap*). L'overlap fonctionne comme une fenêtre coulissante : les derniers tokens du chunk N sont répétés au début du chunk N+1. Cela évite de couper une phrase ou un concept en plein milieu.

| Type de document | `chunk_size` recommandé | `overlap` recommandé |
|-----------------|------------------------|---------------------|
| Code source | 512 tokens (~380 mots) | 50 tokens |
| Documentation prose | 256–512 tokens | 30–50 tokens |
| Contrat / texte légal | 1024 tokens | 100 tokens |
| FAQ / Q&A courtes | 128–256 tokens | 20 tokens |

```python
def chunk_text(text: str, chunk_size: int = 512, overlap: int = 50) -> list[str]:
    """
    Découpe un texte en chunks de taille fixe avec chevauchement.

    Args:
        text: Le texte brut à découper (contenu d'un fichier, page de doc, etc.)
        chunk_size: Nombre de mots par chunk (approximatif — on travaille en mots, pas en tokens)
        overlap: Nombre de mots répétés entre deux chunks consécutifs

    Returns:
        Liste de chunks sous forme de chaînes de caractères
    """
    words = text.split()
    chunks = []
    start = 0

    while start < len(words):
        end = start + chunk_size
        chunk = " ".join(words[start:end])
        chunks.append(chunk)

        # Avancer en tenant compte du chevauchement
        # Si overlap=50, on revient 50 mots en arrière pour le prochain chunk
        start += chunk_size - overlap

    return chunks

# Exemple d'utilisation
with open("docs/guide-architecture.md", "r", encoding="utf-8") as f:
    contenu = f.read()

chunks = chunk_text(contenu, chunk_size=300, overlap=30)
print(f"{len(chunks)} chunks générés")
# → 47 chunks générés

print(chunks[0][:200])
# → "# Guide d'Architecture Ce document décrit les principes..."
print(chunks[1][:200])
# → "...les principes fondamentaux de notre stack. ## Composants Le service..."
# ↑ On voit que les 30 derniers mots du chunk 0 apparaissent au début du chunk 1
```

!!! warning "Stratégie de chunking en production"
    Pour du code source, évitez de découper au milieu d'une fonction. Préférez utiliser l'AST du langage (avec `tree-sitter` par exemple) pour couper aux frontières de classes ou de méthodes. Pour du Markdown, coupez aux titres (`##` / `###`) plutôt qu'au milieu d'un paragraphe.

---

## Étape 2 — Générer les embeddings

Un **embedding** est un vecteur de nombres décimaux qui encode la *signification sémantique* d'un texte. Deux phrases proches conceptuellement produisent des vecteurs proches dans l'espace vectoriel — même si elles ne partagent aucun mot en commun.

> "Comment redémarrer le service ?" et "Procédure de relance du processus" auront des vecteurs très proches, car leur sens est identique.

Le modèle `all-MiniLM-L6-v2` est un bon choix pour débuter : 80 MB, 384 dimensions par vecteur, open source, et performant pour les tâches de recherche sémantique en anglais et en français partiel.

```python
from sentence_transformers import SentenceTransformer
import numpy as np

# Charger le modèle une seule fois (mise en cache automatique après le premier téléchargement)
model = SentenceTransformer("all-MiniLM-L6-v2")

# Encoder tous les chunks — retourne un tableau NumPy de shape (N, 384)
# N = nombre de chunks, 384 = dimensions du vecteur par chunk
embeddings = model.encode(chunks, show_progress_bar=True)

print(f"Shape des embeddings : {embeddings.shape}")
# → Shape des embeddings : (47, 384)
# Chaque chunk est représenté par un vecteur de 384 nombres

# La similarité entre deux chunks se mesure avec la distance cosinus :
# cos(A, B) proche de 1.0 → très similaires sémantiquement
# cos(A, B) proche de 0.0 → sans rapport
from numpy.linalg import norm

def cosine_similarity(v1: np.ndarray, v2: np.ndarray) -> float:
    return float(np.dot(v1, v2) / (norm(v1) * norm(v2)))

# Exemple : mesurer la proximité entre deux chunks
sim = cosine_similarity(embeddings[0], embeddings[1])
print(f"Similarité chunks 0 et 1 : {sim:.3f}")
# → Similarité chunks 0 et 1 : 0.712  (très proches, même section du document)
```

---

## Étape 3 — Stocker les embeddings dans une base vectorielle

Une base vectorielle est optimisée pour un type de recherche qu'une base SQL ne sait pas faire efficacement : trouver les **k vecteurs les plus proches** d'un vecteur requête dans un espace à 384 dimensions (recherche approximative du plus proche voisin, ou ANN). C'est cette recherche qui permet de retrouver les passages pertinents en quelques millisecondes, même sur des milliers de documents.

=== "ChromaDB"

    ChromaDB stocke les embeddings **sur disque** et offre une API simple. Idéal pour prototyper ou pour des projets où la persistance entre deux sessions est importante.

    ```python
    import chromadb
    from chromadb.config import Settings

    # Créer ou charger une collection persistante sur disque
    client = chromadb.PersistentClient(path="./chroma_storage")
    collection = client.get_or_create_collection(
        name="documentation",
        # ChromaDB peut calculer les embeddings lui-même si on ne les fournit pas,
        # mais ici on fournit les nôtres (all-MiniLM-L6-v2) pour contrôler le modèle
        metadata={"hnsw:space": "cosine"}  # distance cosinus pour la recherche
    )

    # Indexer les chunks avec leurs embeddings et leurs métadonnées
    collection.add(
        ids=[f"chunk_{i}" for i in range(len(chunks))],
        documents=chunks,                           # texte brut (pour l'affichage)
        embeddings=embeddings.tolist(),             # vecteurs (pour la recherche)
        metadatas=[{"source": "guide-architecture.md", "chunk_index": i}
                   for i in range(len(chunks))]    # métadonnées (pour citer la source)
    )

    print(f"Collection indexée : {collection.count()} chunks")
    # → Collection indexée : 47 chunks

    # Rechercher les 3 chunks les plus pertinents pour une question
    results = collection.query(
        query_embeddings=[model.encode("Comment redémarrer le service ?").tolist()],
        n_results=3,
        include=["documents", "distances", "metadatas"]
    )
    # results["documents"][0] → liste des 3 chunks les plus proches
    # results["distances"][0] → leurs scores de similarité
    # results["metadatas"][0] → leurs sources
    ```

=== "FAISS"

    FAISS (Facebook AI Similarity Search) est une bibliothèque ultra-performante qui stocke les vecteurs **en mémoire RAM**. Idéal pour la production à haute charge ou quand la latence est critique.

    ```python
    import faiss
    import numpy as np
    import pickle

    # FAISS travaille en float32 — normaliser pour la distance cosinus
    embeddings_f32 = embeddings.astype(np.float32)
    faiss.normalize_L2(embeddings_f32)  # normalisation L2 → produit scalaire = cosinus

    # Créer un index plat (recherche exacte) — pour des corpus > 100k docs, utiliser IndexIVFFlat
    dimension = embeddings_f32.shape[1]  # 384
    index = faiss.IndexFlatIP(dimension)  # IP = Inner Product (= cosinus après normalisation)
    index.add(embeddings_f32)

    print(f"Index FAISS : {index.ntotal} vecteurs indexés")
    # → Index FAISS : 47 vecteurs indexés

    # Persistance manuelle (FAISS n'est pas persistant nativement)
    faiss.write_index(index, "faiss_storage.index")
    with open("chunks.pkl", "wb") as f:
        pickle.dump(chunks, f)  # stocker les textes séparément

    # Recherche des 3 chunks les plus proches
    query_vec = model.encode(["Comment redémarrer le service ?"]).astype(np.float32)
    faiss.normalize_L2(query_vec)
    distances, indices = index.search(query_vec, k=3)
    # distances[0] → scores cosinus (entre 0 et 1)
    # indices[0]   → positions dans la liste chunks[]
    ```

!!! tip "ChromaDB ou FAISS ?"
    | Critère | ChromaDB | FAISS |
    |---------|----------|-------|
    | Persistance | Automatique sur disque | Manuelle (sérialisation) |
    | Scalabilité | Milliers de docs | Millions de docs |
    | Setup | 3 lignes | Quelques étapes de plus |
    | Filtres sur métadonnées | Natif | Non (nécessite post-filtrage) |
    | Cas d'usage idéal | Prototype, projet local | Production haute charge |

---

## Étape 4 — Interroger le RAG et augmenter le prompt

Le flux complet : la question de l'utilisateur est convertie en vecteur → les top-k chunks les plus proches sont récupérés → ils sont injectés comme contexte dans le prompt → le LLM répond en se basant uniquement sur ce contexte.

```python
def query_rag(question: str, collection, model, top_k: int = 3) -> str:
    """
    Interroge le RAG : récupère les chunks pertinents et construit le prompt augmenté.

    Args:
        question: La question posée par l'utilisateur
        collection: La collection ChromaDB (ou l'index FAISS + liste de chunks)
        model: Le modèle SentenceTransformer pour vectoriser la question
        top_k: Nombre de chunks à récupérer (3 est une bonne valeur de départ)

    Returns:
        Le prompt augmenté, prêt à être envoyé à un LLM
    """
    # 1. Convertir la question en vecteur avec le MÊME modèle que lors de l'indexation
    #    (utiliser un modèle différent produirait des vecteurs incompatibles)
    question_vec = model.encode(question).tolist()

    # 2. Rechercher les chunks les plus pertinents
    results = collection.query(
        query_embeddings=[question_vec],
        n_results=top_k,
        include=["documents", "metadatas", "distances"]
    )

    # 3. Assembler le contexte avec les sources pour permettre la traçabilité
    passages = []
    for doc, meta, dist in zip(
        results["documents"][0],
        results["metadatas"][0],
        results["distances"][0]
    ):
        source = meta.get("source", "inconnu")
        score = 1 - dist  # ChromaDB retourne une distance, on la convertit en similarité
        passages.append(f"[Source : {source} | Pertinence : {score:.0%}]\n{doc}")

    context = "\n\n---\n\n".join(passages)

    # 4. Construire le prompt augmenté — instructions défensives explicites
    prompt = f"""Tu es un assistant technique. Réponds à la question en te basant UNIQUEMENT
sur les passages de documentation fournis ci-dessous. Si la réponse ne se trouve pas
dans ces passages, réponds "Je ne trouve pas cette information dans la documentation fournie."
Ne complète pas avec des connaissances extérieures.

=== DOCUMENTATION PERTINENTE ===
{context}
=== FIN DE LA DOCUMENTATION ===

Question : {question}

Réponse (en citant les sources entre crochets) :"""

    return prompt

# Exemple d'utilisation
prompt_augmente = query_rag(
    question="Comment configurer le timeout de connexion ?",
    collection=collection,
    model=model,
    top_k=3
)

# Envoyer au LLM de votre choix (OpenAI, Anthropic, Ollama, etc.)
# reponse = openai_client.chat.completions.create(
#     model="gpt-4o",
#     messages=[{"role": "user", "content": prompt_augmente}]
# )
print(prompt_augmente)
```

!!! warning "Le piège du top-k trop élevé"
    Augmenter `top_k` au-delà de 5 dégrade souvent la qualité des réponses. Avec trop de contexte, le LLM a du mal à identifier les passages vraiment pertinents (**phénomène de dilution**). Commencez avec `top_k=3`, et si la précision est insuffisante, préférez un **re-ranking** (classer les résultats avec un modèle cross-encoder) plutôt qu'augmenter top_k.

---

## Exemple complet fonctionnel

Le code ci-dessous assemble toutes les étapes dans une classe réutilisable. Copiez-le tel quel pour démarrer votre propre RAG.

```python
from sentence_transformers import SentenceTransformer
import chromadb
from pathlib import Path


class DocumentRAG:
    """
    RAG minimal et fonctionnel basé sur sentence-transformers + ChromaDB.
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
    - **Mettre à jour l'index** : quand vos documents changent, re-indexer les fichiers modifiés (supprimer les anciens chunks par `collection.delete(where={"source": fichier})` avant de ré-indexer).

---

## Prochains chapitres

- **[Bonnes Pratiques](../chapitre-9-bonnes-pratiques/index.md)** — Utilisation effective, productivité, sécurité et workflows IA au quotidien
- **[Cas d'Usage par Technologie](../chapitre-10-cas-usage/index.md)** — Configurations et exemples concrets pour Java, Python, Node.js, React
