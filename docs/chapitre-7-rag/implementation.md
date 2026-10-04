# RAG — Implémentation progressive

<span class="badge-beginner">Débutant</span> <span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span>

Cette section propose une progression du **prototype observable** au système de production. Les anciennes estimations de coûts et versions de modèles ont été retirées : elles vieillissent trop vite et donnent une fausse impression de précision.

Le principe est désormais : **baseline → evals → diagnostic → amélioration ciblée**.

---

## Choisir votre niveau

| Page | Niveau | Objectif |
|---|---|---|
| [Niveau 1](niveau-1.md) | Débutant | Construire un retrieval simple, observable et sourcé |
| [Niveau 2](niveau-2.md) | Intermédiaire | Améliorer la qualité avec hybrid search, filtres et reranking |
| [Niveau 3](niveau-3.md) | Expert | Production : sécurité, evals, monitoring et orchestration |

Ne montez pas de niveau simplement parce qu'une technique est plus moderne. Montez lorsque vos mesures montrent une limite du niveau précédent.

---

## Niveau 0 — définir les evals avant le framework

Avant d'installer LangChain, LlamaIndex ou n'importe quelle abstraction, créez un petit jeu de questions représentatives :

```json
[
  {
    "question": "Comment réinitialiser un token expiré ?",
    "expected_sources": ["auth/token-reset.md"],
    "expected_facts": ["endpoint /token/refresh", "refresh token required"]
  }
]
```

Même 20 à 50 cas bien choisis valent mieux qu'une architecture complexe sans référence de qualité.

---

## Niveau 1 — pipeline minimal

Architecture :

```text
documents
  → chunking
  → index
question
  → retrieve top-k
  → context + question
  → LLM
  → answer + sources
```

Objectifs :

- pouvoir inspecter les résultats du retrieval ;
- conserver les IDs/URLs des sources ;
- mesurer Recall@k ;
- éviter de cacher la logique derrière trop d'abstractions.

### Pseudo-code Python volontairement générique

```python
documents = load_documents("docs/")
chunks = chunk_documents(documents)
index = build_index(chunks)

results = index.search(question, k=5)
answer = generate_answer(
    question=question,
    context=results,
    require_citations=True,
)
```

Le but de ce niveau est de comprendre où chaque erreur apparaît, pas de sélectionner « le meilleur vector DB ».

---

## Niveau 2 — améliorer un problème mesuré

Ajoutez une seule technique à la fois :

### Hybrid search

Utile lorsque votre corpus mélange sémantique et identifiants exacts : noms de classes, codes erreur, références produit.

### Metadata filtering

Utile pour restreindre par :

- tenant ;
- produit/version ;
- langue ;
- type de document ;
- période ;
- niveau d'autorisation.

### Reranking

Utile si le bon résultat est souvent récupéré mais classé trop bas.

### Query rewriting

Utile si les questions réelles sont courtes, ambiguës ou contiennent du vocabulaire métier différent du corpus.

Après chaque ajout, réexécutez le même jeu d'evals.

---

## Niveau 3 — production

La **[sécurité du RAG](securite.md)** détaille les ACL (listes de contrôle d'accès), les refus par défaut et les tests à prévoir dès qu'un prototype utilise des documents privés.

Un système de production doit couvrir plus que le retrieval :

| Axe | Exigences |
|---|---|
| Sécurité | ACL avant retrieval, secrets protégés, prompt injection testée |
| Observabilité | requête, documents récupérés, scores, latence, erreurs |
| Evals | dataset versionné, régression automatique |
| Fraîcheur | stratégie de réindexation et suppression |
| Résilience | timeout, fallback, dépendances externes |
| Coût | tokens, appels retrieval/reranking, cache mesuré |
| Gouvernance | provenance et politique de rétention |

---

## Workflow Claude Code pour implémenter

Claude Code peut inspecter le dépôt, modifier les composants et exécuter les evals.

```text
Cartographie ce projet RAG.
Ne modifie rien pour l'instant.
Identifie :
- ingestion ;
- chunking ;
- embeddings/index ;
- retrieval ;
- reranking ;
- prompt/génération ;
- evals ;
- observabilité.

Ensuite exécute la baseline existante et donne les métriques.
```

Puis :

```text
Les evals montrent que le bon document est présent dans top-20 mais rarement top-5.
Propose une seule expérience pour améliorer le ranking.
Définis le critère de succès avant de coder.
```

Cette façon de travailler évite que Claude « améliore » plusieurs composants en même temps sans pouvoir attribuer le gain.

---

## Skill d'évaluation RAG

`.claude/skills/evaluate-rag/SKILL.md` :

```markdown
---
name: evaluate-rag
description: Exécute et diagnostique les évaluations du pipeline RAG sans changer plusieurs variables à la fois.
---

1. Lire la configuration du pipeline et du dataset d'eval.
2. Exécuter la baseline.
3. Séparer erreurs de retrieval et erreurs de génération.
4. Classer les échecs par cause.
5. Comparer au run précédent à protocole identique.
6. Produire qualité, latence et coût observés.
```

---

## Subagents utiles

Pour un gros corpus, déléguez séparément :

- audit du chunking ;
- analyse des requêtes qui échouent ;
- sécurité / ACL ;
- prompt injection ;
- performance et latence.

Chaque subagent doit retourner une synthèse avec preuves et exemples, pas tout son corpus d'analyse.

---

## Agentic retrieval

Passez à un agent seulement lorsque la question nécessite réellement plusieurs recherches ou outils dynamiques.

Exemples pertinents :

- comparer documentation, ticket et code ;
- chercher une source, analyser le résultat puis reformuler ;
- sélectionner entre plusieurs bases selon la question.

Pour un FAQ simple, une boucle agentique peut uniquement ajouter coût, latence et surfaces de sécurité.

---

## MCP

Claude Code peut utiliser MCP pour accéder à des sources externes. `.mcp.json` peut décrire des serveurs partagés par le projet.

Pattern :

```text
MCP = connexion et outils
Skill = procédure métier pour bien utiliser ces outils
Subagent = contexte isolé pour une recherche lourde
Hook = automatisation sur événement
```

Ce sont des briques différentes ; ne les utilisez pas comme synonymes de RAG.

---

## Autres langages

Le RAG n'est pas lié à Python. TypeScript, Java, Rust, Go et d'autres écosystèmes disposent de clients de bases vectorielles, SDK LLM et frameworks de retrieval.

Choisissez selon :

- stack existante ;
- maturité des bibliothèques nécessaires ;
- observabilité ;
- contraintes de déploiement ;
- expertise de l'équipe.

Ne migrez pas un service Java stable vers Python uniquement pour utiliser une librairie RAG populaire si votre besoin peut être couvert avec les composants de la stack existante.

---

## Coûts : comment les documenter correctement

Ne stockez pas ici de prix unitaires supposés durables. Pour une décision réelle :

1. relevez les tarifs officiels actuels ;
2. mesurez votre distribution de tokens et de requêtes ;
3. incluez retrieval, embeddings, reranking, LLM, stockage et observabilité ;
4. simulez votre trafic ;
5. ajoutez une marge pour retries et pics.

Versionnez le tableur ou script d'estimation dans le projet si le coût est une contrainte d'architecture.

---

## Sources

- [Anthropic — Building effective agents](https://www.anthropic.com/engineering/building-effective-agents) — consulté le 2026-09-28
- [Anthropic — Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) — consulté le 2026-09-28
- [Claude Code — MCP](https://code.claude.com/docs/en/mcp) — consulté le 2026-09-28

## Prochaine étape

Poursuivez avec **[Niveau 1 (Débutant)](niveau-1.md)**, la page suivante dans le menu.
