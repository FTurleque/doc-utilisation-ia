# Deep Learning & Réseaux de Neurones

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span>

Le **Deep Learning** est une branche du Machine Learning fondée sur des réseaux de neurones à plusieurs couches. Ce chapitre reste d'abord un chapitre technique : mathématiques, architectures, entraînement, optimisation et frameworks.

Claude Code intervient comme **outil d'ingénierie** autour de ces expériences : préparation du dépôt, génération de tests, exécution des runs, comparaison de métriques, diagnostic et automatisation. Il ne remplace pas le protocole expérimental.

---

## Parcours d'apprentissage

```mermaid
graph LR
    M["Fondations\nmathématiques"] --> A["Réseaux de\nneurones"]
    A --> B["Architectures"]
    B --> C["Concevoir\n& entraîner"]
    C --> D["Optimiser"]
    D --> E["Comparer\nles frameworks"]
```

---

## Contenu du chapitre

| Page | Niveau | Description |
|---|---|---|
| [Fondations mathématiques](fondations-mathematiques.md) | Débutant / Intermédiaire | Probabilités, vecteurs, matrices, gradients |
| [Réseaux de neurones : fondamentaux](reseaux-neurones.md) | Intermédiaire | Perceptron, propagation et apprentissage |
| [Architectures de Deep Learning](architectures-deep-learning.md) | Intermédiaire / Expert | CNN, RNN/LSTM, Transformers, autoencodeurs et autres familles |
| [Concevoir et entraîner](concevoir-entrainer.md) | Expert | Données, architecture, hyperparamètres, entraînement et évaluation |
| [Optimisation et performance](optimisation-performance.md) | Expert | Régularisation, accélération, distribution, quantification et pruning |
| [Comparaison des frameworks](comparaison.md) | Intermédiaire | PyTorch, TensorFlow, Keras 3, JAX et critères de choix |

---

## Workflow Claude recommandé

Pour une expérience Deep Learning :

```text
1. Lis la configuration et le code d'entraînement.
2. Identifie le dataset, les splits, la seed et la métrique.
3. Exécute un smoke test court avant le run coûteux.
4. Vérifie qu'aucune donnée du test final n'entre dans le tuning.
5. Lance l'expérience avec la configuration versionnée.
6. Enregistre métriques, logs et artefacts.
7. Compare à la baseline au même protocole.
8. N'attribue un gain qu'à une modification isolée ou explicitement documentée.
```

Pour les runs longs, Claude peut préparer et vérifier la commande, mais le monitoring de l'entraînement doit reposer sur vos outils habituels plutôt que sur une conversation ouverte indéfiniment.

---

## `CLAUDE.md` minimal pour un projet DL

```markdown
## Deep Learning
- Smoke test: `python -m train --config configs/smoke.yaml`
- Tests: `pytest -q`
- Never tune against the final test set.
- Record config, seed, dataset version and metrics for every run.
- Do not change architecture and data pipeline in the same experiment unless explicitly requested.
- Validate export on the real target runtime before declaring deployment compatibility.
```

---

## Baseline avant complexité

Un réseau plus profond n'est pas automatiquement meilleur. Comparez toujours à une baseline simple et documentez :

- gain de qualité ;
- temps d'entraînement ;
- mémoire ;
- latence d'inférence ;
- complexité de déploiement.

Claude peut produire le tableau comparatif, mais il doit utiliser les **mesures exécutées** du projet, pas des chiffres génériques trouvés dans sa connaissance du monde.

---

## Frameworks : vérifier la documentation actuelle

L'écosystème évolue rapidement. La page [Comparaison des frameworks](comparaison.md) a été actualisée pour éviter les classements figés. Exemples de changements importants : Keras 3 est multi-backend (JAX, TensorFlow, PyTorch) et les nouveaux workflows PyTorch ne doivent plus partir du principe que TorchScript est la voie d'export recommandée partout.

---

## Prérequis

Ce chapitre suppose une connaissance des bases couvertes au [chapitre Machine Learning](../chapitre-6-machine-learning/index.md), en particulier :

- séparation train/validation/test ;
- métriques ;
- overfitting ;
- fuite de données ;
- baseline expérimentale.

---

## Sources principales

- [PyTorch documentation](https://pytorch.org/docs/stable/) — consulté le 2026-09-28
- [TensorFlow Guide](https://www.tensorflow.org/guide) — consulté le 2026-09-28
- [Keras 3](https://keras.io/keras_3/) — consulté le 2026-09-28
- [JAX documentation](https://docs.jax.dev/) — consulté le 2026-09-28
- [Claude Code — fonctionnalités et extensions](https://code.claude.com/docs/en/features-overview) — consulté le 2026-09-28
