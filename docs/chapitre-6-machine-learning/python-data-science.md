# Python & Data Science avec GitHub Copilot

<span class="badge-intermediate">Intermédiaire</span>

## Stack Recommandé

| Bibliothèque | Version | Rôle |
|-------------|---------|------|
| **Python** | 3.11+ | Langage principal |
| **pandas** | 2.0+ | Manipulation et analyse de données tabulaires |
| **numpy** | 1.24+ | Calcul numérique vectorisé |
| **scikit-learn** | 1.4+ | Algorithmes ML, pipelines, évaluation |
| **matplotlib** | 3.7+ | Visualisation de base |
| **seaborn** | 0.12+ | Visualisation statistique avancée |
| **scipy** | 1.11+ | Statistiques et algorithmes scientifiques |

### Installation rapide

```powershell
# Créer un environnement virtuel
python -m venv .venv
.venv\Scripts\activate  # Windows
# source .venv/bin/activate  # Linux/Mac

# Installer le stack data science
pip install pandas numpy scikit-learn matplotlib seaborn scipy jupyter
```

!!! tip "Copilot suggère les imports"
    Commencez simplement par un commentaire comme `# Analyser les stats d'un dataset Pokémon` — Copilot propose automatiquement les imports nécessaires.

---

## Configurer Copilot pour le Data Science

### Custom Instructions (`.github/copilot-instructions.md`)

```markdown
# GitHub Copilot — Data Science Project

Stack: Python 3.11, pandas 2.x, numpy 1.24, scikit-learn 1.4, matplotlib, seaborn

Conventions:
- Toujours importer pandas as pd, numpy as np
- Variables DataFrames: suffixe _df (ex: pokemon_df, train_df)
- random_state=42 pour reproducibilité
- Séparation train/test: 80/20 avec stratify= quand applicable
- Évaluation: toujours cross_val_score (5-fold) avant split final

Affichage:
- Toujours afficher df.shape et df.dtypes lors du chargement
- Afficher df.isnull().sum() pour les NaN
- Utiliser seaborn pour les visualisations statistiques

Chemin des données: data/
Modèles sauvegardés: models/
Visualisations: output/plots/
```

---

## pandas — Patterns avec Copilot

### Chargement et inspection

```python
import pandas as pd
import numpy as np

# Charger le dataset Pokémon
pokemon_df = pd.read_csv("data/pokemon.csv")

# Copilot complète automatiquement ces vérifications
print(f"Forme : {pokemon_df.shape}")            # (800, 13)
print(f"\nTypes de colonnes :\n{pokemon_df.dtypes}")
print(f"\nValeurs manquantes :\n{pokemon_df.isnull().sum()}")
print(f"\nPremières lignes :\n{pokemon_df.head()}")
print(f"\nStatistiques :\n{pokemon_df.describe()}")
```

### Filtrage et sélection

```python
# Prompt : "Filtrer les Pokémons légendaires de type Feu avec PV > 80"
legendaires_feu = pokemon_df[
    (pokemon_df['Legendaire'] == True) &
    (pokemon_df['Type1'] == 'Feu') &
    (pokemon_df['PV'] > 80)
]

# Prompt : "Grouper par Type1 et calculer moyenne de chaque stat"
stats_par_type = pokemon_df.groupby('Type1')[
    ['PV', 'Attaque', 'Defense', 'Vitesse']
].mean().round(1).sort_values('Attaque', ascending=False)

print(stats_par_type)
```

### Nettoyage de données

```python
# Prompt : "Nettoyer le DataFrame : supprimer doublons, gérer NaN,
#           convertir types"

# Supprimer les doublons
pokemon_df = pokemon_df.drop_duplicates()

# Remplir les NaN de Type2 par 'None'
pokemon_df['Type2'] = pokemon_df['Type2'].fillna('None')

# Convertir Legendaire en booléen si besoin
pokemon_df['Legendaire'] = pokemon_df['Legendaire'].astype(bool)

# Créer une feature "Total Stats"
pokemon_df['Total'] = (pokemon_df[['PV', 'Attaque', 'Defense',
                                    'Sp. Atk', 'Sp. Def', 'Vitesse']].sum(axis=1))
```

---

## numpy — Calcul Vectorisé

```python
import numpy as np

# Prompt : "Créer une matrice de combat : simuler 1000 combats aléatoires"
n_pokemon = len(pokemon_df)
np.random.seed(42)

combattant1 = np.random.randint(0, n_pokemon, 1000)
combattant2 = np.random.randint(0, n_pokemon, 1000)

# Vectorisé — pas de boucle for !
force1 = pokemon_df.iloc[combattant1]['Total'].values
force2 = pokemon_df.iloc[combattant2]['Total'].values

victoires = (force1 > force2).astype(int)
print(f"Taux de victoire du premier combattant : {victoires.mean():.1%}")
```

!!! tip "Copilot et numpy"
    Copilot excelle pour les opérations numpy vectorisées. Décrivez l'opération souhaitée en commentaire et il évite les boucles `for` au profit d'opérations sur les arrays.

---

## scikit-learn — Pipeline Complet

### Structure de projet recommandée

```
projet-ml/
├── data/
│   ├── raw/           ← données brutes
│   └── processed/     ← données préparées
├── models/            ← modèles sauvegardés (.pkl)
├── notebooks/         ← exploration Jupyter
├── src/
│   ├── data_prep.py   ← nettoyage et features
│   ├── train.py       ← entraînement
│   └── evaluate.py    ← métriques
└── .github/
    └── copilot-instructions.md
```

### Pipeline sklearn complet

```python
from sklearn.pipeline import Pipeline
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.metrics import classification_report
import pandas as pd
import joblib

# Définir les features
FEATURES_NUM = ['PV', 'Attaque', 'Defense', 'Sp. Atk', 'Sp. Def', 'Vitesse']
FEATURES_CAT = ['Type1', 'Type2']
TARGET = 'Victoire'

X = pokemon_df[FEATURES_NUM + FEATURES_CAT]
y = pokemon_df[TARGET]

# Découpage
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42, stratify=y
)

# Preprocessor : numérique → standardisation, catégoriel → one-hot
preprocessor = ColumnTransformer(transformers=[
    ('num', StandardScaler(), FEATURES_NUM),
    ('cat', OneHotEncoder(handle_unknown='ignore'), FEATURES_CAT)
])

# Pipeline complet
pipeline = Pipeline(steps=[
    ('prep', preprocessor),
    ('model', RandomForestClassifier(n_estimators=100, random_state=42))
])

# Entraînement avec cross-validation
cv_scores = cross_val_score(pipeline, X_train, y_train, cv=5, scoring='f1')
print(f"Score F1 moyen (CV5) : {cv_scores.mean():.3f} ± {cv_scores.std():.3f}")

# Entraînement final et évaluation
pipeline.fit(X_train, y_train)
y_pred = pipeline.predict(X_test)
print(classification_report(y_test, y_pred))

# Sauvegarde
joblib.dump(pipeline, 'models/pokemon_classifier.pkl')
```

---

## Visualisation Data Science

### Analyse de distribution

```python
import matplotlib.pyplot as plt
import seaborn as sns

# Prompt : "Visualiser la distribution des stats par type de Pokémon"
fig, axes = plt.subplots(2, 3, figsize=(18, 12))
stats = ['PV', 'Attaque', 'Defense', 'Sp. Atk', 'Sp. Def', 'Vitesse']

for ax, stat in zip(axes.flat, stats):
    top_types = pokemon_df['Type1'].value_counts().head(5).index
    subset = pokemon_df[pokemon_df['Type1'].isin(top_types)]
    sns.boxplot(data=subset, x='Type1', y=stat, ax=ax, palette='viridis')
    ax.set_title(f'Distribution {stat} par Type')
    ax.tick_params(axis='x', rotation=45)

plt.suptitle('Statistiques Pokémon par Type (Top 5)', fontsize=16)
plt.tight_layout()
plt.savefig('output/plots/stats_par_type.png', dpi=150)
plt.show()
```

### Importance des features

```python
# Prompt : "Afficher l'importance des features du modèle RandomForest"
feature_names = (FEATURES_NUM +
    pipeline.named_steps['prep']
        .named_transformers_['cat']
        .get_feature_names_out(FEATURES_CAT).tolist()
)

importances = pipeline.named_steps['model'].feature_importances_
indices = importances.argsort()[::-1][:10]  # Top 10

plt.figure(figsize=(10, 6))
sns.barplot(
    x=importances[indices],
    y=[feature_names[i] for i in indices],
    palette='Blues_d'
)
plt.title('Top 10 Features les Plus Importantes')
plt.xlabel('Importance')
plt.tight_layout()
plt.show()
```

---

## Astuces Copilot pour le Data Science

| Situation | Prompt Copilot | Résultat typique |
|-----------|---------------|-----------------|
| NaN inattendus | `# Stratégie NaN : médiane numérique, mode catégoriel` | Code d'imputation complet |
| Données déséquilibrées | `# Gérer déséquilibre classes avec SMOTE ou class_weight` | Rééchantillonnage ou paramètre |
| Feature engineering | `# Créer feature d'interaction entre Attaque et Vitesse` | `df['puissance'] = df['Attaque'] * df['Vitesse']` |
| Visualisation rapide | `# Pairplot des features numériques coloré par label` | `sns.pairplot(df, hue='Victoire')` |
| Sauvegarde pipeline | `# Sauvegarder pipeline sklearn avec metadata` | joblib + dict de metadata |

!!! warning "Attention aux fuites de données (data leakage)"
    Copilot peut parfois proposer de scaler ou d'encoder **avant** le split train/test. Cela crée une **fuite de données** (le modèle voit les statistiques du jeu de test lors de l'entraînement). Utilisez toujours un `Pipeline` sklearn pour éviter ce piège.

---

## Prochaine étape

**[Deep Learning avec GitHub Copilot](deep-learning.md)** : aller au-delà de scikit-learn avec les réseaux de neurones et les frameworks TensorFlow/PyTorch.

Concepts clés couverts :

- **Du perceptron aux réseaux profonds** — Comment un neurone artificiel calcule sa sortie, fonctions d'activation (ReLU, Softmax, Sigmoid)
- **TensorFlow & Keras** — Construire, compiler et entraîner un réseau Dense ou CNN avec `model.fit()` et `EarlyStopping`
- **Réseaux Convolutifs (CNN)** — Architecture convolution → pooling → classification pour les images (Fashion MNIST, MNIST)
- **PyTorch** — Même réseau implémenté en PyTorch avec la boucle d'entraînement manuelle
