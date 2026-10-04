# Copilot — archives : Deep Learning & Réseaux de Neurones

Extraits déplacés du parcours principal le **3 octobre 2026**. Les affirmations, exemples et dates de vérification sont ceux des pages d’origine ; ils ne constituent pas une nouvelle validation des fonctionnalités Copilot. Les passages comparatifs peuvent aussi citer Claude afin de conserver leur sens.


## Fondations Mathématiques { #page-chapitre-8-deep-learning-fondations-mathematiques }

Origine : [chapitre-8-deep-learning/fondations-mathematiques.md](../../chapitre-8-deep-learning/fondations-mathematiques.md).

<!-- Extrait original : chapitre-8-deep-learning/fondations-mathematiques.md:818 ; section dédiée -->

#### Refaire ces calculs dans les IDE avec Copilot

=== "IntelliJ IDEA"
    1. Crée un fichier `test_gradients.py` dans ton projet Python.
    2. Demande à Copilot Chat : *"Implémente pas à pas le forward pass et le backward pass pour ce réseau à un neurone caché : w1=0.4, b1=0.1, w2=0.5, b2=0, x=2, y=1. Calcule la perte MSE et les gradients sans utiliser PyTorch autograd."*
    3. Compare les valeurs avec les calculs de cette page.
    4. Ensuite demande : *"Ajoute une version PyTorch avec `autograd` et vérifie que les gradients correspondent."*

=== "Visual Studio Code"
    1. Ouvre un notebook Jupyter (`Ctrl+Shift+P` → "New Jupyter Notebook").
    2. Dans la première cellule, demande à Copilot : *"Génère une cellule NumPy qui vérifie le produit matrice-vecteur, la norme L2 et une étape de descente de gradient pour l'exemple de cette page."*
    3. Ajoute une deuxième cellule : *"Trace la courbe de la perte en fonction du learning rate η entre 0.001 et 1 pour cet exemple."*
    4. Lance cellule par cellule.

!!! example "Objectif pratique"
    Faire tourner ces calculs dans un notebook avec des `print()` à chaque étape est la meilleure façon de s'assurer que la compréhension est solide avant d'utiliser PyTorch ou TensorFlow.

---


## Architectures de Deep Learning { #page-chapitre-8-deep-learning-architectures-deep-learning }

Origine : [chapitre-8-deep-learning/architectures-deep-learning.md](../../chapitre-8-deep-learning/architectures-deep-learning.md).

<!-- Extrait original : chapitre-8-deep-learning/architectures-deep-learning.md:32 ; tableau comparatif -->

| Architecture | Données cibles | Forces | Exemples d'application |
|:-------------|:--------------|:-------|:----------------------|
| **MLP** (Dense) | Données tabulaires | Simple, polyvalent | Prédiction de prix, classification |
| **CNN** | Images, signaux 2D | Extraction de motifs spatiaux | Reconnaissance faciale, imagerie médicale |
| **RNN / LSTM / GRU** | Séquences, séries temporelles | Mémoire du contexte passé | Traduction, prédiction de stocks |
| **Transformer** | Texte, images, multimodal | Attention parallélisable, contexte long | GPT, BERT, Copilot, DALL-E |
| **GAN** | Génération de données | Crée des données réalistes | Génération d'images, augmentation de données |
| **Autoencodeur** | Compression, anomalies | Apprend des représentations compactes | Détection de fraude, débruitage |

---

## Prochaine étape

Poursuivez avec **[Bonnes Pratiques](chapitre-9-bonnes-pratiques.md)**, la page suivante dans le menu.
