# Concepts Fondamentaux du Machine Learning

<span class="badge-beginner">Débutant</span>

## Intelligence Artificielle, Machine Learning, Deep Learning

Ces trois termes sont souvent confondus. En réalité, ils s'emboîtent comme des poupées russes.

```mermaid
graph TD
    IA["🤖 Intelligence Artificielle\nSimuler l'intelligence humaine"]
    ML["🧠 Machine Learning\nApprendre à partir des données"]
    DL["⚡ Deep Learning\nRéseaux de neurones profonds"]
    IA --> ML --> DL
    style IA fill:#e3f2fd
    style ML fill:#bbdefb
    style DL fill:#90caf9
```

| Terme | Définition simple | Exemple concret |
|-------|-------------------|-----------------|
| **Intelligence Artificielle** | Tout système capable d'imiter des comportements intelligents | Un programme qui joue aux échecs |
| **Machine Learning** | IA qui apprend automatiquement à partir d'exemples, sans être explicitement programmée | Un filtre antispam qui s'améliore avec le temps |
| **Deep Learning** | ML utilisant des réseaux de neurones à plusieurs couches | La reconnaissance d'images dans votre téléphone |

!!! info "Analogie"
    L'IA, c'est le domaine. Le ML, c'est une approche de ce domaine. Le Deep Learning, c'est une technique du ML.

---

## Un Peu d'Histoire

L'intelligence artificielle n'est pas une invention récente. Elle a traversé des périodes d'enthousiasme intense et des "hivers" de désillusion avant d'atteindre la maturité actuelle.

```mermaid
graph TD
    subgraph F["🏛️ Fondations"]
        A["**1950** — Test de Turing\nAlan Turing pose la question :\n*Les machines peuvent-elles penser ?*"]
        B["**1956** — Conférence de Dartmouth\nNaissance officielle du terme\n*Intelligence Artificielle*"]
        C["**1957** — Premier perceptron\nFrank Rosenblatt — premier neurone\nartificiel simulé sur ordinateur"]
    end

    subgraph H["❄️ Hivers de l'IA"]
        D["**1970s** — Limites atteintes\nOrdinateurs trop lents,\nproblèmes trop complexes"]
        E["**1980s** — Systèmes experts\nRègles codées à la main —\nsuccès partiel, fragiles et coûteux"]
        G["**1987** — Deuxième hiver\nEffondrement du marché\ndes systèmes experts"]
    end

    subgraph R["🌱 Renaissance"]
        I["**1997** — Deep Blue bat Kasparov\nIBM — premier programme à battre\nun champion du monde aux échecs"]
        J["**1998** — LeNet\nYann LeCun — premiers CNN\npour la reconnaissance de chiffres"]
        K["**2006** — Deep Belief Networks\nGeoffrey Hinton — pré-entraînement\ndes réseaux profonds"]
    end

    subgraph E2["🚀 Explosion du Deep Learning"]
        L["**2012** — AlexNet\nGPU + big data — erreur divisée par 2\nsur ImageNet, tournant historique"]
        M["**2014** — GANs\nIan Goodfellow — génération\nd'images réalistes"]
        N["**2017** — Transformers\n*Attention is All You Need*\nbase de GPT et BERT"]
    end

    subgraph G2["🤖 IA Générative"]
        O["**2020** — GPT-3\n175 milliards de paramètres\ngénération de texte bluffante"]
        P["**2022** — ChatGPT & GitHub Copilot\nIA générative grand public\nmillions d'utilisateurs"]
        Q["**2024** — Agents autonomes\nLLMs capables de planifier,\nutiliser des outils, exécuter des tâches"]
    end

    F --> H --> R --> E2 --> G2
    A --> B --> C
    D --> E --> G
    I --> J --> K
    L --> M --> N
    O --> P --> Q
```

### Les grandes ruptures technologiques

Trois facteurs ont rendu possible la révolution du Deep Learning :

| Facteur | Avant (2000s) | Après (2010s+) |
|---------|--------------|----------------|
| **Données** | Quelques milliers d'exemples | Milliards d'exemples (internet, médias sociaux) |
| **Puissance de calcul** | CPUs lents, coûteux | GPUs massivement parallèles, cloud accessible |
| **Algorithmes** | Réseaux peu profonds (2-3 couches) | Réseaux très profonds (100+ couches), Transformers |

!!! info "Pourquoi 2012 est une date charnière ?"
    En 2012, le réseau **AlexNet** (Alex Krizhevsky, supervisé par Geoffrey Hinton) remporte le concours ImageNet avec un taux d'erreur de **16%**, contre **26%** pour le meilleur algorithme classique de l'époque. Cette rupture de 10 points en un an a convaincu toute la communauté scientifique de basculer vers le Deep Learning.

### Les pionniers à connaître

| Nom | Contribution | Récompense |
|-----|-------------|-----------|
| **Alan Turing** | Test de Turing, fondements théoriques | Prix Turing (posthume) |
| **Frank Rosenblatt** | Perceptron (1957) | — |
| **Geoffrey Hinton** | Backpropagation, Deep Belief Networks | Prix Turing 2018 |
| **Yann LeCun** | Réseaux convolutifs (CNN) | Prix Turing 2018 |
| **Yoshua Bengio** | Apprentissage de représentations | Prix Turing 2018 |
| **Ian Goodfellow** | GANs (Generative Adversarial Networks) | — |
| **Vaswani et al.** | Architecture Transformer (2017) | — |

!!! tip "Les trois prix Turing 2018"
    Hinton, LeCun et Bengio sont surnommés les **"parrains du Deep Learning"**. Ils ont persisté dans leurs recherches pendant les "hivers de l'IA", quand la communauté scientifique les considérait marginaux. Leur ténacité a rendu possible la révolution actuelle.

---

## Les 3 Types d'Apprentissage

### 1. Apprentissage Supervisé

La machine apprend à partir d'exemples **étiquetés** : on lui donne les données ET les réponses correctes.

```mermaid
graph LR
    D["📦 Données étiquetées\n(email + label spam/ham)"] --> M["🤖 Modèle\ns'entraîne"]
    M --> P["🎯 Prédiction\nnouvel email = spam ?"]
```

**Exemples d'utilisation :**

- Prédire le prix d'une maison (régression)
- Classer un email en spam ou non (classification)
- Choisir le bon Pokémon selon ses statistiques de combat

### 2. Apprentissage Non Supervisé

La machine cherche **seule des structures** dans les données, sans étiquettes.

```mermaid
graph LR
    D["📦 Données brutes\n(sans étiquettes)"] --> M["🤖 Algorithme\ncherche des groupes"]
    M --> C["🗂️ Clusters\ngroupes découverts"]
```

**Exemples d'utilisation :**

- Segmentation de clients par comportement d'achat
- Détection d'anomalies (fraude)
- Clustering de fruits par couleur et taille (abricots vs cerises)

### 3. Apprentissage par Renforcement

Un agent apprend par **essais et erreurs** : il reçoit une récompense ou une punition selon ses actions.

```mermaid
graph LR
    A["🎮 Agent"] -->|"Effectue une action"| E["🌍 Environnement"]
    E -->|"Récompense / Punition"| A
```

**Exemples d'utilisation :**

- Jeux vidéo (AlphaGo, Dota 2)
- Robots autonomes
- Optimisation de campagnes publicitaires

---

## Vocabulaire Essentiel

Avant de coder un modèle, il faut maîtriser ce vocabulaire fondamental.

| Terme | Définition | Exemple |
|-------|------------|---------|
| **Observation** | Une ligne de données (un exemple) | Les stats d'un Pokémon |
| **Feature** (attribut) | Une colonne de données (une variable) | `PV`, `Attaque`, `Type` |
| **Label** (étiquette) | La valeur à prédire | `Gagnant = Oui/Non` |
| **Jeu d'entraînement** | Données pour apprendre | 80% du dataset |
| **Jeu de test** | Données pour évaluer | 20% du dataset |
| **Modèle** | L'algorithme une fois entraîné | `RandomForestClassifier` entraîné |
| **Hyperparamètre** | Paramètre réglé avant l'entraînement | Nombre d'arbres dans une forêt |
| **Overfitting** | Modèle trop ajusté aux données d'entraînement | 99% sur train, 60% sur test |
| **Underfitting** | Modèle pas assez ajusté | 60% partout |

!!! warning "Overfitting : le piège classique"
    Un modèle qui fait 99% de précision sur les données d'entraînement mais seulement 60% sur de nouvelles données a **sur-appris** (overfitting). Il a mémorisé les données plutôt qu'appris les patterns généraux.

---

## Les Données : La Base de Tout

### Types de données

| Type | Description | Exemple | Traitement |
|------|------------|---------|-----------|
| **Numérique continu** | Valeurs décimales | Prix, température | Normalisation |
| **Numérique discret** | Valeurs entières | Nombre de victoires, PV | Souvent tel quel |
| **Catégoriel ordinal** | Catégories avec ordre | Note (A/B/C), rang | Label Encoding |
| **Catégoriel nominal** | Catégories sans ordre | Type de Pokémon, pays | One-Hot Encoding |
| **Booléen** | Vrai/Faux | Légendaire = Oui/Non | 0/1 |

### Indicateurs statistiques clés

```python
import pandas as pd

df = pd.read_csv("pokemon.csv")

# Mesures de tendance centrale
print(df["PV"].mean())    # Moyenne
print(df["PV"].median())  # Médiane (moins sensible aux extremes)
print(df["PV"].mode())    # Mode (valeur la plus fréquente)

# Mesures de dispersion
print(df["PV"].std())     # Écart type
print(df["PV"].describe())  # Résumé complet
```

!!! tip "Moyenne vs Médiane"
    Si vos données contiennent des **valeurs extrêmes** (outliers), préférez la **médiane** à la moyenne. Exemple : dans une classe de 30 élèves où un millionnaire a tout skewé, la moyenne des revenus sera trompeuse.

---

## Prochaine étape

**[Algorithmes Courants du Machine Learning](algorithmes-courants.md)** : découvrir les principaux algorithmes et savoir lequel choisir selon votre problème.

Concepts clés couverts :

- **Choisir le bon algorithme** — Arbre de décision selon le type d'apprentissage et le type de problème
- **Régression** — Linéaire, polynomiale, logistique, et le mécanisme de descente de gradient
- **Classification** — Random Forest, SVM, KNN, Naive Bayes : forces et cas d'usage de chacun
- **Clustering** — K-Means, DBSCAN, GMM : regrouper des données sans étiquettes
