# Copilot dans les Notebooks Jupyter

<span class="badge-intermediate">Intermédiaire</span>

Les notebooks Jupyter sont l'environnement de prédilection pour l'exploration de données et le prototypage ML. GitHub Copilot s'y intègre nativement dans VS Code, offrant une assistance puissante cellule par cellule.

---

## Configurer Copilot dans Jupyter

### VS Code + Extension Jupyter

<span class="badge-vscode">VS Code</span>

1. Installer l'extension **Jupyter** depuis la marketplace VS Code
2. Créer un fichier `.ipynb` ou ouvrir un notebook existant
3. Copilot est automatiquement actif dans les cellules de code

!!! tip "Activation de Copilot dans Jupyter"
    Copilot est actif dès que l'extension Jupyter est installée. Les suggestions apparaissent en gris clair — appuyez sur ++tab++ pour accepter.

### Raccourcis utiles en mode notebook

| Action | Raccourci VS Code |
|--------|------------------|
| Accepter suggestion Copilot | ++tab++ |
| Voir suggestions alternatives | ++alt+]++ / ++alt+[++ |
| Ouvrir Copilot Chat | ++ctrl+alt+i++ |
| Exécuter la cellule | ++shift+enter++ |
| Nouvelle cellule en dessous | ++b++ (mode commande) |

---

## Patterns d'Utilisation Copilot en Notebook

### Pattern 1 — Cellule de commentaire → Code généré

Écrivez une cellule markdown expliquant ce que vous voulez faire, puis créez une cellule code vide en dessous : Copilot génère le code correspondant.

**Cellule Markdown :**
```markdown
## Étape 3 : Préparer les Données

On va :
1. Supprimer les colonnes inutiles (Numéro, Nom)
2. Remplir les NaN de Type2 par "None"  
3. Encoder Type1 et Type2 en one-hot
4. Normaliser les features numériques
```

**Cellule Code (Copilot génère) :**
```python
# Copilot suggère automatiquement ce code basé sur la cellule markdown précédente
import pandas as pd
from sklearn.preprocessing import MinMaxScaler

# 1. Suppression colonnes inutiles
df = pokemon_df.drop(columns=['#', 'Nom'])

# 2. Remplir NaN Type2
df['Type2'] = df['Type2'].fillna('None')

# 3. One-hot encoding
df_encoded = pd.get_dummies(df, columns=['Type1', 'Type2'])

# 4. Normalisation
scaler = MinMaxScaler()
cols_num = ['PV', 'Attaque', 'Defense', 'Sp. Atk', 'Sp. Def', 'Vitesse']
df_encoded[cols_num] = scaler.fit_transform(df_encoded[cols_num])

print(f"✅ DataFrame prêt : {df_encoded.shape}")
df_encoded.head()
```

### Pattern 2 — Commentaire en tête de cellule

```python
# Afficher un graphique en barres du nombre de Pokémons par type primaire,
# trié par ordre décroissant, avec palette de couleurs par type

import matplotlib.pyplot as plt
import seaborn as sns

type_counts = pokemon_df['Type1'].value_counts()

plt.figure(figsize=(14, 6))
bars = plt.bar(type_counts.index, type_counts.values,
               color=plt.cm.tab20.colors[:len(type_counts)])
plt.xlabel('Type Primaire')
plt.ylabel('Nombre de Pokémons')
plt.title('Distribution des Pokémons par Type Primaire')
plt.xticks(rotation=45, ha='right')
plt.tight_layout()
plt.show()
```

### Pattern 3 — Copilot Chat pour expliquer et générer

Dans Jupyter, utilisez **Copilot Chat** (`Ctrl+Alt+I`) pour :

```
/explain  → expliquer le code d'une cellule
/fix      → corriger une erreur Python
/tests    → générer des assertions pour vérifier les résultats
```

**Exemple :**
```
Prompt Chat : "Cette cellule génère un modèle Random Forest. 
              Génère-moi une cellule suivante qui affiche 
              les features les plus importantes sous forme de tableau pandas"
```

---

## Workflow Notebook ML Recommandé

```
📓 pokemon_analysis.ipynb
│
├── 📋 Cellule 1 — Imports et configuration
├── 📊 Cellule 2 — Chargement données
├── 🔍 Cellule 3 — Exploration (shape, dtypes, head)
├── 📈 Cellule 4 — Statistiques descriptives
├── 🖼️  Cellule 5 — Visualisations
├── 🔧 Cellule 6 — Nettoyage données
├── ⚙️  Cellule 7 — Feature engineering
├── 🤖 Cellule 8 — Split train/test
├── 🏋️  Cellule 9 — Entraînement modèle
├── 📊 Cellule 10 — Évaluation métriques
└── 💾 Cellule 11 — Sauvegarde modèle
```

### Cellule 1 — Template d'imports

```python
# Imports standard pour un notebook ML
# Copilot complète automatiquement les imports manquants au fur et à mesure

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.preprocessing import StandardScaler, OneHotEncoder, LabelEncoder
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report, confusion_matrix
import joblib
import warnings

warnings.filterwarnings('ignore')
pd.set_option('display.max_columns', None)
pd.set_option('display.float_format', '{:.2f}'.format)

%matplotlib inline
plt.style.use('seaborn-v0_8-whitegrid')
sns.set_palette('viridis')

print("✅ Imports OK")
```

---

## Variables Magiques Utiles

```python
# Mesurer le temps d'exécution d'une cellule
%%time

model.fit(X_train, y_train)
```

```python
# Afficher toutes les variables définies dans le notebook
%who

# Taille des objets en mémoire
%whos
```

```python
# Profiler les performances
%prun model.predict(X_test)
```

!!! tip "Copilot connaît les magic commands"
    Tapez `%` ou `%%` dans une cellule — Copilot suggère la commande magique adaptée au contexte.

---

## Documentation Automatique des Cellules

Copilot peut générer des résumés de cellules complexes :

```python
# Copilot Chat : "Documente cette cellule avec un commentaire markdown expliquant
#                ce qu'elle fait, les inputs et les outputs"
```

Résultat généré par Copilot :
```python
"""
Etape de feature engineering.

Inputs:
    - pokemon_df : DataFrame brut (800 lignes, 13 colonnes)
    
Transformations:
    - Suppression des colonnes identifiantes (#, Nom)
    - Encodage one-hot de Type1 et Type2 (18 types possibles)
    - Normalisation MinMax des 6 stats numériques → [0, 1]
    - Création feature 'Total' : somme des 6 stats
    
Outputs:
    - df_ready : DataFrame prêt pour ML (800 lignes, ~45 colonnes)
"""
```

---

## Intégration Jupyter dans les IDE

=== "VS Code"

    Copilot est intégré nativement dans les fichiers `.ipynb` :
    
    - Suggestions inline dans chaque cellule
    - Copilot Chat accessible en sidebar
    - Commande `/explain` pour expliquer une cellule sélectionnée
    - **Copilot Edits** peut modifier plusieurs cellules à la fois
    
    ```json
    // settings.json — améliorer Copilot dans Jupyter
    {
        "jupyter.askForKernelRestart": false,
        "editor.inlineSuggest.enabled": true,
        "github.copilot.editor.enableAutoCompletions": true
    }
    ```

=== "IntelliJ IDEA"

    <span class="badge-intellij">IntelliJ</span>
    
    Jupyter est supporté via le plugin **Python** (PyCharm) ou le plugin dédié Jupyter :
    
    - Copilot actif dans les cellules de code
    - Utiliser ++alt+enter++ pour voir les suggestions alternatives
    - Le panneau Copilot Chat (icône en sidebar) fonctionne aussi dans les notebooks

---

## Bonnes Pratiques Notebook avec Copilot

!!! success "À faire"
    - Écrire un **titre Markdown avant chaque cellule complexe** — guide Copilot
    - Utiliser des **noms de variables descriptifs** (`X_train_scaled` plutôt que `X`)
    - Indiquer dans un commentaire le **format attendu** du résultat
    - Exécuter les cellules **dans l'ordre** pour que Copilot ait tout le contexte

!!! failure "À éviter"
    - Cellules trop longues (>50 lignes) — découpez en étapes logiques
    - Variables globales réutilisées sans contexte clair
    - Sauter des cellules lors de l'exécution (contexte brisé pour Copilot)
    - Mélanger exploration et production dans le même notebook

---

## Prochaine étape

**[MLOps & Déploiement de Modèles avec Copilot](mlops-deploiement.md)** : passer du prototype en notebook à un modèle déployé et monitoré en production.

Concepts clés couverts :

- **MLflow** — Tracker les expériences, logger hyperparamètres/métriques/artefacts, comparer les runs dans l'interface web
- **API REST avec FastAPI** — Exposer un modèle joblib comme endpoint `/predict` avec validation Pydantic
- **Containerisation Docker** — Dockerfile optimisé pour une API ML, `docker-compose` pour l'orchestration locale
- **Monitoring & Data Drift** — Détecter quand les données de production divergent du jeu d'entraînement avec Evidently
