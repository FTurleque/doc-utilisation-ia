# Comparaison des frameworks Deep Learning

<span class="badge-intermediate">Intermédiaire</span>

Le choix d'un framework dépend moins d'un classement absolu que de votre **code existant**, du matériel cible, des contraintes de déploiement et des compétences de l'équipe. Cette page évite donc les verdicts du type « X est toujours meilleur » et se concentre sur les différences durables.

---

## Vue d'ensemble

| Écosystème | Point fort | À vérifier avant adoption |
|---|---|---|
| **PyTorch** | API impérative, recherche et écosystème très large | stratégie d'export/serving adaptée à votre cible |
| **TensorFlow** | écosystème historique de production et outils de déploiement | compatibilité des APIs et du chemin de déploiement réellement utilisé |
| **Keras 3** | API haut niveau multi-backend | compatibilité de vos couches/ops custom avec le backend choisi |
| **JAX** | transformations fonctionnelles, JIT, vectorisation et calcul distribué | expertise de l'équipe et outillage de production |

Keras 3 peut fonctionner sur des backends JAX, TensorFlow ou PyTorch, ce qui rend la frontière entre « framework » et « API haut niveau » moins nette qu'auparavant.

---

## PyTorch

PyTorch reste adapté lorsque vous voulez :

- une boucle d'entraînement explicite ;
- un debugging proche du Python normal ;
- un écosystème riche pour la recherche et les modèles modernes ;
- un contrôle fin sur le modèle et l'optimisation.

```python
import torch
from torch import nn

class Classifier(nn.Module):
    def __init__(self, input_dim: int, classes: int):
        super().__init__()
        self.net = nn.Sequential(
            nn.Linear(input_dim, 128),
            nn.ReLU(),
            nn.Linear(128, classes),
        )

    def forward(self, x):
        return self.net(x)
```

!!! warning "Export moderne"
    Les documents anciens recommandent souvent TorchScript. La documentation PyTorch actuelle indique que **TorchScript est déprécié** et recommande `torch.export` pour les nouveaux workflows concernés. Vérifiez toujours la cible de déploiement avant de copier une recette historique.

---

## TensorFlow

TensorFlow reste pertinent lorsque votre organisation possède déjà :

- modèles et pipelines TensorFlow ;
- infrastructure de serving associée ;
- expertise `tf.data` / distribution ;
- contraintes mobile/web couvertes par l'écosystème TensorFlow/Google AI Edge.

Ne migrez pas un système stable uniquement parce qu'un autre framework domine une partie de la recherche : mesurez coût de migration, performance et maintenabilité sur votre cas réel.

---

## Keras 3

Keras 3 est une API multi-backend : un même workflow peut cibler JAX, TensorFlow ou PyTorch lorsque le code reste compatible avec les APIs Keras multi-backend.

```python
import os
os.environ["KERAS_BACKEND"] = "torch"  # ou jax / tensorflow

import keras
from keras import layers

model = keras.Sequential([
    layers.Input((128,)),
    layers.Dense(64, activation="relu"),
    layers.Dense(10),
])
```

C'est particulièrement intéressant pour :

- l'enseignement et le prototypage ;
- les équipes qui veulent une API haut niveau ;
- les composants que l'on souhaite rendre portables entre plusieurs backends.

La portabilité n'est toutefois pas magique : du code utilisant directement des opérations spécifiques TensorFlow/PyTorch/JAX peut casser l'abstraction.

Keras propose aussi un backend **OpenVINO pour l'inférence uniquement** : il ne remplace pas les backends d'entraînement JAX, TensorFlow et PyTorch. Fixez `KERAS_BACKEND` avant l'import et vérifiez les opérations supportées. [Documentation Keras 3](https://keras.io/keras_3/#run-inference-with-the-openvino-backend), revérifiée le 3 octobre 2026.

---

## JAX

JAX fournit notamment `jit`, `grad` et `vmap`, avec un style fonctionnel qui convient bien aux workloads numériques et aux architectures nécessitant un contrôle fin du calcul.

```python
import jax
import jax.numpy as jnp

@jax.jit
def mse(y_true, y_pred):
    return jnp.mean((y_true - y_pred) ** 2)
```

Le coût principal est souvent organisationnel : paradigme différent, gestion de l'état, compilation et debugging demandent une équipe à l'aise avec ces concepts.

Les fonctions transformées doivent respecter les contraintes de pureté de JAX, avec état et clés aléatoires explicites. Pour un benchmark, attendez la fin effective du calcul (`block_until_ready()` sur le résultat lorsque pertinent) et séparez compilation initiale et exécutions suivantes. [JAX — pièges de programmation](https://docs.jax.dev/en/latest/notebooks/Common_Gotchas_in_JAX.html), revérifié le 3 octobre 2026.

---

## Choisir avec une expérience, pas avec un tableau de popularité

Pour un nouveau projet, construisez un **spike reproductible** avec 1 ou 2 candidats :

1. implémenter une petite baseline identique ;
2. mesurer temps d'entraînement et mémoire sur le matériel cible ;
3. tester export/serving réel ;
4. mesurer simplicité du debugging ;
5. vérifier les dépendances de production ;
6. évaluer la compétence actuelle de l'équipe.

Le « meilleur framework » est celui qui satisfait ces contraintes avec le moins de complexité opérationnelle.

---

## Claude Code pour comparer deux frameworks

Claude peut automatiser un spike si vous l'empêchez de modifier plusieurs variables simultanément :

```text
Nous voulons comparer PyTorch et Keras 3 sur cette baseline.
Crée deux implémentations fonctionnellement équivalentes.
Utilise le même dataset, split, seed et métrique.
Exécute les deux avec le même protocole.
Rapporte :
- temps ;
- mémoire si mesurable ;
- métrique ;
- taille de l'artefact ;
- difficulté d'export ;
- différences de code.
Ne conclue pas sur la base de popularité.
```

Pour une décision importante, conservez le benchmark et sa configuration dans le dépôt.

---

## Interopérabilité

Quelques mécanismes utiles :

- **Keras 3** pour une API multi-backend ;
- **ONNX** lorsque vos opérateurs et votre cible sont compatibles ;
- formats/exporteurs propres à chaque framework ;
- hubs de modèles qui fournissent souvent plusieurs implémentations.

L'interopérabilité doit être testée sur le modèle réel : les opérateurs custom, la quantification et les runtimes cibles peuvent limiter les conversions.

---

## Ce que la documentation retire volontairement

Les affirmations telles que « PyTorch = 80 % des publications », « TensorFlow = standard industrie » ou « JAX = le plus rapide » ont été retirées. Elles dépendent du sous-domaine, de la période, du matériel et du benchmark et vieillissent mal.

---

## Prochaine étape

Poursuivez avec **[IntelliJ](sonarqube.md)**, la page suivante dans le menu.

## Sources

- [Keras — Keras 3](https://keras.io/keras_3/) — consulté le 2026-09-28
- [Keras — Getting started](https://keras.io/getting_started/) — consulté le 2026-09-28
- [PyTorch — documentation](https://pytorch.org/docs/stable/) — consulté le 2026-09-28
- [PyTorch — TorchScript deprecated, use torch.export](https://docs.pytorch.org/docs/stable/notes/cpu_threading_torchscript_inference.html) — consulté le 2026-09-28
- [TensorFlow — documentation](https://www.tensorflow.org/guide) — consulté le 2026-09-28
- [JAX — documentation](https://docs.jax.dev/) — consulté le 2026-09-28
