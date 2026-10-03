# Niveau 2 — Améliorer le retrieval avec des mesures

<span class="badge-intermediate">Intermédiaire</span>

Le niveau 2 part d'une baseline déjà évaluée. Il ajoute **une technique à la fois** pour corriger un type d'erreur observé : lexical vs sémantique, mauvais ranking, filtres manquants ou question ambiguë.

---

## 1. Classer les erreurs avant de changer l'architecture

Pour chaque question ratée :

```text
A. Le bon document n'est pas indexé
B. Le bon chunk n'est pas récupéré
C. Il est récupéré mais classé trop bas
D. Les résultats contiennent trop de bruit
E. La question est ambiguë
F. Le retrieval est correct mais la génération échoue
```

Seuls B à E justifient généralement une optimisation du retrieval.

---

## 2. Hybrid search

Le lexical est utile pour :

- identifiants exacts ;
- codes erreur ;
- noms de classes ;
- références juridiques ;
- versions ou SKU.

Le dense est utile pour les paraphrases et la similarité sémantique.

Un système hybride combine les deux rankings, par exemple avec Reciprocal Rank Fusion.

```python
def reciprocal_rank_fusion(result_lists, k: int = 60):
    scores = {}
    for results in result_lists:
        for rank, doc in enumerate(results, start=1):
            scores[doc.id] = scores.get(doc.id, 0.0) + 1.0 / (k + rank)
    return sorted(scores.items(), key=lambda item: item[1], reverse=True)
```

Ne supposez pas que l'hybride gagne : vérifiez votre dataset d'eval.

---

## 3. Metadata filtering

Les filtres sont souvent plus fiables que de demander aux embeddings de comprendre une contrainte structurée.

Exemples :

```text
tenant_id = 42
product_version = "v3"
language = "fr"
document_type = "policy"
effective_date <= query_date
```

Appliquez les ACL **avant** de retourner les documents au modèle.

---

Le filtre ACL doit provenir de l’identité authentifiée et être réappliqué aux recherches lexicales, denses, parents, reranking et caches. Une fusion ne doit pas réintroduire un candidat interdit par une autre branche. Le LLM ne décide jamais seul du tenant ou des droits d’accès.

## 4. Reranking

Symptôme : le bon document est souvent dans top-20 mais rarement top-5.

Pipeline :

```text
retrieve 20-50 candidats
→ reranker
→ garder 3-8 passages
→ génération
```

Mesurez :

- Recall@candidate_k ;
- MRR/nDCG après reranking ;
- latence ajoutée ;
- coût par requête ;
- impact final sur answer correctness.

Le fournisseur/modèle de reranking est un choix d'implémentation, pas une constante de cette documentation.

---

## 5. Query rewriting

Pour une requête vague :

```text
"ça marche pas après renouvellement"
```

un rewrite peut produire :

```text
"erreur d'authentification après renouvellement d'un access token"
```

Mais un rewrite peut aussi supprimer un identifiant important. Conservez la requête originale et évaluez les deux.

---

## 6. Multi-query

Une question complexe peut être décomposée :

```text
Question : "Pourquoi la commande est payée mais pas expédiée ?"

→ état du paiement
→ règles de transition order status
→ job de fulfillment
```

Fusionnez les résultats avec une méthode déterministe et limitez le nombre de sous-requêtes pour contrôler coût et latence.

---

## 7. Parent-child retrieval

Si les petits chunks récupèrent bien les concepts mais manquent de contexte :

```text
index = petit chunk
return = section parent
```

Mesurez la taille de contexte ajoutée : retourner un parent de 20 pages annule l'intérêt du chunking précis.

---

## 8. Choisir les embeddings par eval

Ne comparez pas les modèles avec des exemples inventés de similarité ou des seuils universels.

Procédure :

```text
1. figer corpus + queries + expected docs ;
2. indexer avec modèle A ;
3. mesurer Recall@k/MRR ;
4. répéter avec modèle B ;
5. comparer latence, taille d'index, coût et qualité.
```

Un modèle plus grand n'est pas automatiquement meilleur pour un vocabulaire métier ou multilingue.

---

## 9. Claude Code pour conduire l'expérience

```text
La baseline RAG est versionnée dans `evals/`.
Analyse les échecs et classe-les par cause.
Propose UNE amélioration du retrieval qui cible la cause principale.
Avant de coder, donne la métrique qui doit progresser et la régression acceptable en latence.
Implémente, exécute les evals et compare au run de référence.
```

Conservez le résultat dans un artefact JSON/CSV afin de ne pas dépendre de la conversation.

---

## Critères de sortie du niveau 2

- [ ] erreurs classées par cause ;
- [ ] amélioration reliée à une hypothèse ;
- [ ] benchmark avant/après au même protocole ;
- [ ] ACL/filtres testés ;
- [ ] latence et coût mesurés ;
- [ ] aucun « sweet spot » présenté sans données du projet.

---

## Prochaine étape

Poursuivez avec **[Niveau 3 (Expert)](niveau-3.md)**, la page suivante dans le menu.
