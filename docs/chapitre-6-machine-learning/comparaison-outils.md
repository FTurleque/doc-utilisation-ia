# Comparaison des outils ML : scikit-learn, TensorFlow, PyTorch et Keras

<span class="badge-intermediate">Intermédiaire</span>

Le choix d'un outil dépend du type de problème, du code existant, du runtime de production et de l'équipe. Les anciennes notes en étoiles et « support Copilot » ont été retirés : elles ne mesuraient rien de reproductible.

---

## Vue d'ensemble

| Outil | Usage fréquent | Point de vigilance |
|---|---|---|
| scikit-learn | ML classique, pipelines tabulaires, preprocessing | pas un framework général de deep learning |
| TensorFlow | deep learning et écosystème TensorFlow | chemin de déploiement/API à vérifier selon version |
| PyTorch | deep learning, recherche et production | export/serving dépend du runtime cible |
| Keras 3 | API haut niveau multi-backend | rester dans les APIs portables si vous voulez changer de backend |

---

## scikit-learn

Très adapté à :

- régression/classification/clustering classiques ;
- preprocessing structuré ;
- pipelines reproductibles ;
- cross-validation et model selection.

Exemple :

```python
pipeline = Pipeline([
    ("preprocess", preprocess),
    ("model", LogisticRegression(max_iter=1000)),
])

pipeline.fit(X_train, y_train)
```

L'intérêt principal du `Pipeline` est méthodologique : les transformations apprises peuvent rester dans la boucle d'entraînement/CV et limiter les fuites de données.

---

## TensorFlow

TensorFlow reste pertinent pour les équipes qui utilisent son écosystème d'entraînement et de déploiement.

Avant adoption ou migration, vérifiez :

- APIs réellement supportées dans la version installée ;
- chemin de serving/mobile/edge ;
- besoins de distribution ;
- compatibilité hardware ;
- expertise équipe.

Évitez la formule « framework de production par défaut » : une production PyTorch/JAX/scikit-learn peut être tout aussi légitime selon le cas.

---

## PyTorch

PyTorch fournit une API impérative et un écosystème très large.

Point important pour la documentation actuelle : **TorchScript est déprécié** dans les versions PyTorch récentes ; les nouveaux workflows d'export doivent examiner `torch.export` et les options recommandées pour leur runtime. citeturn921034search0turn921034search4

Ne remplacez toutefois pas un pipeline legacy TorchScript fonctionnel sans évaluer la compatibilité et le coût de migration.

---

## Keras 3

Keras 3 adopte une approche multi-backend : il peut cibler JAX, TensorFlow et PyTorch. citeturn921034search3

Cette portabilité est surtout valable lorsque le code s'appuie sur les APIs Keras compatibles multi-backend. Un modèle utilisant directement beaucoup d'opérations spécifiques au backend réduit cette portabilité.

---

## Comment choisir

### Tabulaire classique

Commencez généralement par une baseline simple et bien évaluée. scikit-learn est souvent suffisant ; un réseau profond n'est pas une étape obligatoire.

### Vision / NLP / modèles profonds

Choisissez selon :

- modèles pré-entraînés disponibles ;
- runtime cible ;
- hardware ;
- bibliothèques internes ;
- compétences équipe ;
- capacité à benchmarker/exporter/monitorer.

### Besoin d'API haut niveau multi-backend

Évaluez Keras 3 avec un prototype réel plutôt que supposer que toutes les opérations seront portables.

---

## Spike comparatif

```text
Implémente la même baseline avec les deux frameworks candidats.
Garde constants : dataset, split, seed, métrique et hardware.
Mesure :
- qualité ;
- temps d'entraînement ;
- mémoire ;
- latence d'inférence ;
- taille/export ;
- complexité de code et déploiement.
```

Claude Code peut créer et exécuter ce spike, mais les résultats doivent être conservés dans un artefact reproductible.

---

## Export et déploiement

Ne choisissez pas le format d'export avant d'avoir défini la cible :

- Python server ;
- C++ ;
- mobile ;
- navigateur ;
- edge accelerator ;
- service managé.

Dans PyTorch, les documents officiels actuels orientent les nouveaux workflows vers `torch.export`, et l'export ONNX moderne s'appuie également sur les mécanismes Dynamo/export. citeturn921034search6turn921034search7

---

## Copilot — référence

Le fait qu'un outil possède beaucoup d'exemples publics ne permet pas de conclure à un « support Copilot 5/5 ». Ces scores ont été supprimés. Les usages Copilot restent couverts par les pages dédiées.

---

## Sources

- [scikit-learn — User Guide](https://scikit-learn.org/stable/user_guide.html)
- [TensorFlow — Guide](https://www.tensorflow.org/guide)
- [PyTorch — Documentation](https://pytorch.org/docs/stable/)
- [Keras — Keras 3](https://keras.io/keras_3/)

## Prochaine étape

**[Deep Learning](../chapitre-8-deep-learning/index.md)** pour les architectures et workflows d'entraînement plus avancés.
