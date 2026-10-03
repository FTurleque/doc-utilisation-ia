# Docling — ingestion documentaire pour RAG

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span>

**Docling** est un projet open source de traitement documentaire. Il convertit de nombreux formats — notamment PDF, DOCX, PPTX, XLSX, HTML, EPUB, images, audio et plusieurs formats structurés — vers une représentation unifiée exploitable par des pipelines IA.

Sa place principale dans cette documentation est le chapitre **RAG**, car il intervient en amont du retrieval : extraction, compréhension de mise en page, OCR, sérialisation et préparation des chunks avant indexation.

!!! info "Vérifié le 1er octobre 2026"
    Docling est hébergé sous LF AI & Data. Le projet fournit une CLI, une API Python, des exports structurés, du chunking pour RAG, un serveur MCP et un mode service via `docling-serve`.

---

## Où Docling intervient dans un pipeline RAG

```text
PDF / DOCX / PPTX / XLSX / HTML / images / audio
                ↓
              Docling
                ↓
      DoclingDocument structuré
                ↓
       Markdown / JSON / chunks
                ↓
 embeddings / indexation / Qdrant
                ↓
             retrieval
                ↓
                LLM
```

Docling ne remplace pas le moteur de retrieval ni la base vectorielle. Il prépare un **corpus plus propre et plus structuré**.

---

## Capacités utiles au RAG

Le projet documente notamment :

- compréhension avancée des PDF : layout, ordre de lecture, tableaux, code, formules et classification d'images ;
- OCR pour PDF scannés et images ;
- conversion vers un modèle unifié `DoclingDocument` ;
- exports Markdown, HTML, JSON, texte, DocTags, DocLang et autres formats ;
- sortie **chunks JSONL** avec chunking hiérarchique ou hybride ;
- exécution locale possible pour les données sensibles ;
- intégrations LangChain, LlamaIndex, Haystack, CrewAI et autres outils IA ;
- serveur MCP et serveur API optionnels.

---

## Installation et CLI

Installation Python :

```bash
pip install docling
```

Le README officiel indique actuellement **Python 3.10+**.

Conversion simple :

```bash
docling rapport.pdf
```

La sortie par défaut est du Markdown. Pour produire des chunks :

```bash
docling convert rapport.pdf --to chunks
```

La CLI permet également de choisir le type de chunking et la limite de tokens par chunk.

!!! note "CLI évolutive"
    Les options sont générées à partir de l'application CLI. Vérifiez `docling --help` ou la référence officielle avant d'automatiser des flags sensibles aux versions.

---

### Formats, dépendances et exécution locale

Le support d’un format n’implique pas que toute dépendance soit incluse dans l’installation de base. Les formats Office binaires DOC/XLS/PPT et RTF requièrent LibreOffice ; l’audio requiert l’extra `asr`, et la vidéo requiert aussi `ffmpeg`. Les formats Apple Pages/Keynote utilisent l’extra `format-iwork`. Les exports incluent désormais aussi DocLang archive (`dclx`) et LaTeX. Vérifiez la version et les extras dans le lockfile.

Une conversion locale peut télécharger des modèles au premier usage ; préparez leurs artefacts pour un environnement hors réseau. L’activation d’un moteur OCR/VLM distant change le périmètre de confidentialité. Conservez IDs, pages, titres et métadonnées de provenance avec les chunks. [Formats officiels Docling](https://docling-project.github.io/docling/usage/supported_formats/), revérifiés le 3 octobre 2026.

## Utilisation Python

```python
from docling.document_converter import DocumentConverter

converter = DocumentConverter()
result = converter.convert("rapport.pdf")
doc = result.document

markdown = doc.export_to_markdown()
```

Le `DoclingDocument` permet de conserver une représentation structurée plutôt que de réduire immédiatement un document complexe à du texte brut.

---

## Docling + Qdrant

Une combinaison courante est :

```text
Docling
  ↓ extraction / structure / chunks
Embeddings
  ↓
Qdrant
  ↓ hybrid/vector retrieval
LLM
```

- **Docling** traite et structure les documents ;
- **Qdrant** stocke et recherche les représentations indexées ;
- le modèle ou l'agent génère la réponse à partir des passages récupérés.

Voir **[Qdrant — Vector DB & Hybrid Search](qdrant.md)** pour la partie index/retrieval.

---

## Local, service ou MCP ?

| Mode | Usage |
|---|---|
| CLI locale | conversions ponctuelles et batch simples |
| bibliothèque Python | pipeline RAG applicatif |
| `docling-serve` | service partagé / architecture distribuée |
| MCP | permettre à un agent de convertir ou comprendre des documents à la demande |

Pour des données sensibles ou réglementées, l'exécution locale peut être préférable si elle respecte votre politique de sécurité.

---

## Qualité d'ingestion : points à mesurer

Avant d'indexer un corpus, vérifiez :

- ordre de lecture correct ;
- tableaux correctement reconstruits ;
- titres et sections préservés ;
- OCR suffisamment fiable ;
- images/formules traitées selon le besoin métier ;
- chunks cohérents et pas uniquement uniformes en taille ;
- provenance conservée jusqu'au passage final.

Un retrieval performant ne peut pas compenser une ingestion qui a perdu la structure ou les données importantes.

---

## Sécurité

Les documents ingérés sont des **entrées non fiables** :

- n'exécutez pas le contenu extrait comme une instruction ;
- analysez les fichiers provenant de sources externes ;
- contrôlez les droits avant indexation ;
- supprimez ou masquez les secrets et données personnelles inutiles ;
- conservez la provenance et les métadonnées d'accès ;
- testez les prompt injections présentes dans les documents.

---

## Sources

Sources consultées le **1er octobre 2026** :

- [Docling — dépôt officiel](https://github.com/docling-project/docling)
- [Docling — documentation](https://docling-project.github.io/docling/)
- [Docling — formats supportés](https://docling-project.github.io/docling/usage/supported_formats/)
- [Docling — référence CLI](https://docling-project.github.io/docling/reference/cli/)

## Prochaine étape

Poursuivez avec **[Qdrant — Vector DB & Hybrid Search](qdrant.md)**, la page suivante dans le menu.
