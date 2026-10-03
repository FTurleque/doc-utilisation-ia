# Machine Learning avec Claude Code

<span class="badge-intermediate">Intermédiaire</span>

Ce chapitre couvre le Machine Learning sous deux angles complémentaires : comprendre les **fondamentaux théoriques** et utiliser **Claude Code comme agent de développement** pour rendre les expérimentations reproductibles, testables et vérifiables.


---

## Parcourir ce chapitre

<div class="grid cards" markdown>

- :material-brain: **[Concepts fondamentaux](concepts-fondamentaux.md)**

    IA, Machine Learning, Deep Learning, types d'apprentissage et métriques.

- :material-function: **[Algorithmes courants](algorithmes-courants.md)**

    Régression, classification, clustering et choix d'une baseline.

- :material-robot-outline: **[Claude Code pour le workflow ML](claude-workflow-ml.md)**

    Parcours principal : cadrage, exploration, pipelines reproductibles, tests, évaluation, subagents et MLOps.

- :simple-python: **[Python & Data Science](python-data-science.md)**

    pandas, NumPy, scikit-learn et organisation d'un projet data avec Claude.

- :simple-jupyter: **[Notebooks Jupyter](notebooks-jupyter.md)**

    Bonnes pratiques de collaboration IA sur les notebooks et limites à connaître.

- :material-rocket-launch: **[MLOps & Déploiement](mlops-deploiement.md)**

    Passage de l'expérimentation au pipeline versionné, testé et monitoré.

- :material-scale-balance: **[Comparaison écosystèmes ML](comparaison-ecosystemes-ml.md)**

    Python, R, Julia et critères de choix techniques.

- :material-compare: **[Comparaison des outils](comparaison-outils.md)**

    scikit-learn, TensorFlow, PyTorch, Keras et autres frameworks selon le besoin.

</div>

---

## Prérequis

!!! info "Ce dont vous avez besoin"
    - Python installé et un environnement virtuel par projet ;
    - Claude Code installé, en CLI ou via son intégration IDE ;
    - notions de base en Python ;
    - Git pour versionner code, configuration et protocoles d'expérience.

Les numéros de versions de bibliothèques évoluent vite : préférez les contraintes réellement supportées par votre projet (`pyproject.toml`, lockfile, image Docker) plutôt qu'une version figée dans cette documentation.

---

## Le workflow ML : la boucle scientifique avant l'outil

```mermaid
graph TB
    A["Définir le problème"] --> B["Collecter / qualifier les données"]
    B --> C["Préparer sans fuite"]
    C --> D["Établir une baseline"]
    D --> E["Entraîner"]
    E --> F["Évaluer"]
    F --> G{"Critères atteints ?"}
    G -- Non --> H["Formuler une nouvelle hypothèse"]
    H --> C
    G -- Oui --> I["Versionner et déployer"]
    I --> J["Monitorer"]
```

Claude Code peut accélérer cette boucle en lisant le dépôt, en écrivant les scripts, en exécutant les commandes, en corrigeant les erreurs et en comparant les résultats. Il ne remplace pas le choix des hypothèses, la définition d'une métrique métier ni la décision finale sur la validité scientifique d'une expérience.

---

## Les règles Claude les plus utiles en ML

Mettez dans `CLAUDE.md` uniquement les invariants du projet :

```markdown
## Machine Learning
- Tests: `pytest -q`
- Lint: `ruff check .`
- Never fit preprocessing on the final test set.
- Report the dataset split with every metric.
- Keep training/evaluation commands reproducible.
- Do not commit confidential raw data or credentials.
```

Pour les procédures longues, utilisez `.claude/rules/` et `.claude/skills/` plutôt que de gonfler `CLAUDE.md`.

---

## Validation avant confiance

Une réponse textuelle n'est pas une preuve d'expérience ML. Demandez systématiquement :

1. quelle commande a été exécutée ;
2. sur quel split/dataset ;
3. quelle métrique a été mesurée ;
4. quels tests ont été passés ;
5. quels fichiers et artefacts ont été produits.

Cette discipline rejoint le fonctionnement agentique recommandé par Anthropic : l'agent doit récupérer du **ground truth** depuis son environnement pendant l'exécution plutôt que se fier uniquement à son raisonnement interne.

---

## Sources

- [Claude Code — fonctionnalités et extensions](https://code.claude.com/docs/en/features-overview) — consulté le 2026-09-28
- [Claude Code — répertoire `.claude/`](https://code.claude.com/docs/en/claude-directory) — consulté le 2026-09-28
- [Anthropic — Building effective agents](https://www.anthropic.com/engineering/building-effective-agents) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-6-machine-learning.md#page-chapitre-6-machine-learning-index).

## Prochaine étape

Poursuivez avec **[Concepts Fondamentaux](concepts-fondamentaux.md)**, la page suivante dans le menu.
