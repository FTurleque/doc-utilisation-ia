# RAG — Cas d'usage par secteur

<span class="badge-intermediate">Intermédiaire</span>

Cette page illustre comment les contraintes changent selon le domaine. Les anciens chiffres de ROI, erreurs « avant/après » et faux exemples réglementaires ont été supprimés : sans étude sourcée, ils ne doivent pas être présentés comme des résultats réels.

---

## 1. RH, paie et réglementation

### Besoin

Retrouver rapidement des règles applicables dans des documents versionnés : textes réglementaires, accords, procédures internes, jurisprudence ou guides.

### Contraintes critiques

- date d'effet et version ;
- juridiction / population concernée ;
- données personnelles ;
- auditabilité ;
- décision humaine pour les actes sensibles.

Architecture :

```text
identity + ACL
→ filtre date/juridiction
→ retrieval lexical + sémantique
→ reranking éventuel
→ réponse avec citations exactes
→ validation humaine avant décision/paie
```

Le RAG peut retrouver et synthétiser des sources ; il ne doit pas inventer un calcul de paie ou une conclusion juridique non vérifiée.

### Evals

- article applicable récupéré ;
- texte expiré non récupéré ;
- citation exacte ;
- absence de fuite entre populations/tenants ;
- réponse « insuffisante » lorsque les sources ne tranchent pas.

---

## 2. Support client

### Besoin

Répondre à partir d'une knowledge base produit avec versions et procédures.

### Architecture de départ

```text
question
→ filtre produit/version/langue
→ hybrid retrieval
→ top passages
→ réponse sourcée
```

### À mesurer

- taux de bonne source en top-k ;
- taux de résolution avec réponse correcte ;
- escalade vers humain ;
- latence ;
- fraîcheur des articles.

Ne mesurez pas uniquement la satisfaction générée par le style de réponse : une réponse fluide mais basée sur la mauvaise version produit est un échec.

---

## 3. Documentation technique / développeurs

### Besoin

Combiner guides, API docs, ADR, code et tickets.

Le lexical est important pour :

- noms de classes ;
- erreurs ;
- symboles ;
- versions.

Le sémantique aide pour les questions conceptuelles.

Un agentic retrieval peut être utile pour rechercher successivement : documentation → code → issue. Mais un moteur multi-source ne doit pas rendre les provenance illisibles.

### Evals

- API réellement présente dans la version utilisée ;
- fichier/symbole correct ;
- citation de la documentation officielle ;
- code proposé compatible avec le build du projet.

---

## 4. Juridique / conformité

### Besoin

Recherche et synthèse de documents avec provenance stricte.

### Contraintes

- corpus autorisé ;
- version/temporalité ;
- confidentialité ;
- juridiction ;
- conservation des citations ;
- distinction entre texte source et analyse.

Le système doit permettre à un juriste de retrouver facilement le passage original. Évitez de présenter une synthèse générée comme avis juridique définitif.

---

## 5. Santé

### Besoin

Retrouver procédures, littérature ou documentation clinique autorisée.

### Contraintes renforcées

- données de santé ;
- contrôle d'accès ;
- source et date ;
- validation clinique ;
- traçabilité ;
- politique de rétention.

Le RAG peut soutenir la recherche d'information, mais les décisions cliniques requièrent des contrôles et responsabilités adaptés au contexte réglementaire.

---

## 6. Finance

### Besoin

Questions sur politiques internes, produits, recherche ou données autorisées.

### Risques

- données sensibles ;
- temporalité des prix/règles ;
- confondre information historique et actuelle ;
- actions transactionnelles déclenchées par un agent.

Séparez clairement :

```text
retrieval lecture
≠ analyse
≠ exécution d'une transaction
```

Une capacité d'écriture vers un système financier doit être beaucoup plus restreinte qu'un outil de recherche.

---

## 7. E-commerce

### Besoin

Assistant produit, support, politiques de livraison/retour.

Le corpus mélange souvent :

- données structurées produit ;
- docs marketing ;
- inventaire/prix dynamiques ;
- politiques.

Utilisez une API/DB pour prix et stock actuels plutôt qu'un index documentaire potentiellement obsolète. Le RAG est mieux adapté aux descriptions et politiques.

---

## 8. Sécurité / SOC

### Besoin

Corréler runbooks, incidents, documentation et données d'observabilité.

Agentic retrieval possible :

```text
alerte
→ runbook
→ logs/metrics
→ incidents similaires
→ hypothèses
→ recommandation
```

Gardez les actions de remédiation dangereuses sous validation humaine ou politique explicite. Une prompt injection dans un ticket ou log externe ne doit pas pouvoir déclencher une commande privilégiée.

---

## Concevoir à partir des contraintes

| Secteur | Métadonnées souvent critiques |
|---|---|
| RH / légal | date d'effet, juridiction, population |
| Support | produit, version, langue |
| Technique | repo, version, symbole, langage |
| Santé | source, date, population, confidentialité |
| Finance | date, produit, entité, autorisation |
| E-commerce | SKU, locale, disponibilité |
| SOC | service, environnement, horodatage, sévérité |

Le schéma de metadata est souvent aussi important que le modèle d'embeddings.

---

## Claude Code pour prototyper un cas métier

```text
À partir de ce besoin métier :
1. liste les sources de données ;
2. classe-les par sensibilité et fraîcheur ;
3. définis les métadonnées nécessaires ;
4. propose 20 cas d'eval réalistes ;
5. identifie les actions qui doivent rester humaines ;
6. seulement ensuite propose une architecture RAG minimale.
```

---

## Sources

- [Anthropic — Building effective agents](https://www.anthropic.com/engineering/building-effective-agents) — consulté le 2026-09-28
- [Anthropic — Claude Code sandboxing](https://www.anthropic.com/engineering/claude-code-sandboxing) — consulté le 2026-09-28

## Prochaine étape

Poursuivez avec **[Optimisation Avancée](optimisation-avancee.md)**, la page suivante dans le menu.
