# Python & Data Science avec Claude Code

<span class="badge-intermediate">Intermédiaire</span>

Cette page montre comment travailler avec pandas, NumPy et scikit-learn en utilisant Claude Code comme **agent de développement et de vérification**. Le principe est simple : le dépôt et l'environnement Python sont la source de vérité ; Claude lit, modifie et exécute le code, puis rapporte les résultats observés.

---

## Stack : ne pas figer les versions dans la documentation

Utilisez les bibliothèques adaptées au projet :

- Python ;
- pandas ;
- NumPy ;
- scikit-learn ;
- matplotlib / seaborn si nécessaire ;
- SciPy selon les besoins.

Les versions supportées doivent venir de `pyproject.toml`, `requirements*.txt`, d'un lockfile ou de l'image de développement.

```bash
python -m venv .venv
# Linux/macOS
source .venv/bin/activate
# Windows PowerShell : .venv\Scripts\Activate.ps1
python -m pip install -e .
```

Si le projet n'est pas packagé, documentez explicitement la commande d'installation dans `README.md` et `CLAUDE.md`.

---

## Configuration Claude recommandée

`CLAUDE.md` :

```markdown
# Data science project

## Commands
- Tests: `pytest -q`
- Lint: `ruff check .`
- Profile sample: `python scripts/profile_data.py`
- Train: `python -m src.train`
- Evaluate: `python -m src.evaluate`

## Invariants
- Keep the final test split untouched until final evaluation.
- Fit preprocessing only on training data.
- Prefer sklearn Pipeline/ColumnTransformer.
- Every metric must identify its split and dataset.
- Never expose raw confidential data or secrets in logs.
```

Utilisez `.claude/rules/ml.md` pour les conventions détaillées et un skill pour les procédures répétitives d'évaluation.

---

## Organisation de projet

```text
projet-ml/
├── CLAUDE.md
├── .claude/
│   ├── rules/ml.md
│   └── skills/evaluate-model/SKILL.md
├── data/
│   ├── raw/
│   └── processed/
├── notebooks/
├── scripts/
│   └── profile_data.py
├── src/
│   ├── data.py
│   ├── features.py
│   ├── train.py
│   └── evaluate.py
├── tests/
└── pyproject.toml
```

Le code stable vit dans `src/`; les notebooks servent surtout à l'exploration et à la communication.

---

## pandas : demander une analyse reproductible

Au lieu de demander « analyse ce CSV », demandez un script que vous pouvez relancer :

```text
Crée `scripts/profile_data.py` pour @data/raw/customers.csv.
Le script doit afficher :
- shape et dtypes ;
- valeurs manquantes par colonne ;
- doublons ;
- cardinalité des catégories ;
- résumé des variables numériques ;
- distribution de la cible.
Exécute-le et sépare les observations mesurées de tes hypothèses.
```

Exemple minimal :

```python
import pandas as pd

customers_df = pd.read_csv("data/raw/customers.csv")

print("shape", customers_df.shape)
print("dtypes")
print(customers_df.dtypes)
print("missing")
print(customers_df.isna().sum().sort_values(ascending=False))
print("duplicates", customers_df.duplicated().sum())
print(customers_df.describe(include="all").transpose())
```

---

## NumPy : faire mesurer avant d'optimiser

Claude peut proposer une vectorisation, mais faites vérifier qu'elle conserve le comportement :

```text
Cette fonction NumPy est lente.
1. ajoute un benchmark reproductible ;
2. propose une version vectorisée ;
3. ajoute des tests d'équivalence numérique ;
4. exécute tests et benchmark ;
5. conserve la version optimisée uniquement si les résultats le justifient.
```

Ne considérez pas « vectorisé » comme synonyme de « plus rapide » sans mesure sur vos données.

---

## scikit-learn : encapsuler le preprocessing

Le pattern de référence pour du tabulaire est un pipeline qui évite d'ajuster des transformations avant le split :

```python
from sklearn.compose import ColumnTransformer
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import OneHotEncoder, StandardScaler

X_train, X_test, y_train, y_test = train_test_split(
    X,
    y,
    test_size=0.2,
    random_state=42,
    stratify=y,
)

preprocess = ColumnTransformer(
    transformers=[
        ("num", StandardScaler(), numeric_features),
        ("cat", OneHotEncoder(handle_unknown="ignore"), categorical_features),
    ]
)

model = Pipeline(
    steps=[
        ("preprocess", preprocess),
        ("classifier", RandomForestClassifier(random_state=42)),
    ]
)

model.fit(X_train, y_train)
```

!!! warning "Le pipeline n'empêche pas toutes les fuites"
    Une feature peut déjà contenir une information future ou dérivée de la cible. Demandez à Claude de revoir **la provenance de chaque feature**, pas uniquement le code sklearn.

---

## Prompt de revue anti-leakage

```text
Audite le pipeline ML de ce dépôt pour la fuite de données.
Vérifie séparément :
1. split temporel / aléatoire ;
2. preprocessing ;
3. feature engineering ;
4. agrégations calculées avec des données futures ;
5. sélection de features ;
6. tuning d'hyperparamètres ;
7. réutilisation du test final.

Pour chaque risque, donne le fichier/la ligne et une méthode de vérification.
N'apporte aucune correction avant d'avoir produit le diagnostic.
```

---

## Visualisation : séparer génération et interprétation

Claude peut écrire les graphiques, mais le message « ce graphique prouve X » doit être vérifié.

Bon workflow :

1. générer un graphique avec axes, unités et titre explicites ;
2. enregistrer l'artefact ;
3. vérifier la population et les filtres utilisés ;
4. seulement ensuite interpréter les tendances.

Pour les analyses récurrentes, préférez un script à une cellule de notebook isolée.

---

## Évaluation : fournir les preuves

Demandez un tableau reproductible :

```text
Évalue la baseline avec le protocole existant.
Retourne :
- commande exécutée ;
- hash/config du run si disponible ;
- taille des splits ;
- métriques CV avec dispersion ;
- métriques du test final ;
- chemin des artefacts générés.
Ne compare deux modèles que s'ils utilisent le même protocole.
```

Pour les tâches sensibles, utilisez un subagent séparé pour relire le protocole avant de regarder les scores.

---

## Données sensibles

Claude Code peut lire des fichiers auxquels son processus a accès. Réduisez le périmètre :

- n'ajoutez jamais de secrets dans les datasets ou notebooks ;
- utilisez les permissions pour refuser la lecture de chemins sensibles ;
- anonymisez ou échantillonnez lorsque les données complètes ne sont pas nécessaires ;
- évitez d'imprimer des données personnelles dans les logs et résultats de commandes.

Les transcriptions locales de Claude Code peuvent contenir les sorties d'outils ; une commande qui affiche un secret peut donc aussi le faire apparaître dans l'historique local de session.

---

## Copilot

Les exemples historiques Copilot restent disponibles dans [Copilot pour le workflow ML](copilot-workflow-ml.md). Ils ne sont pas supprimés : cette documentation reste utile pour comparaison ou retour futur à Copilot.

---

## Sources

- [Claude Code — répertoire `.claude/`](https://code.claude.com/docs/en/claude-directory) — consulté le 2026-09-28
- [Claude Code — fonctionnalités et extensions](https://code.claude.com/docs/en/features-overview) — consulté le 2026-09-28
- [scikit-learn — Pipelines and composite estimators](https://scikit-learn.org/stable/modules/compose.html) — consulté le 2026-09-28

## Prochaine étape

**[Notebooks Jupyter](notebooks-jupyter.md)** puis **[MLOps & Déploiement](mlops-deploiement.md)** pour passer d'une exploration locale à un workflow reproductible et industrialisé.
