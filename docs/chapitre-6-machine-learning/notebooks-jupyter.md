# Notebooks Jupyter avec Claude Code

<span class="badge-intermediate">Intermédiaire</span>

Les notebooks Jupyter sont excellents pour l'exploration, la visualisation et la communication d'une analyse. Avec Claude Code, le workflow le plus robuste consiste à utiliser le notebook comme **interface d'exploration**, puis à déplacer la logique stable vers des modules Python testables et versionnables.

!!! info "Copilot reste documenté"
    GitHub Copilot conserve une expérience notebook très intégrée dans VS Code. Une section dédiée en bas de page résume ce workflow ; elle est conservée comme référence.

---

## Ce que Claude Code peut apporter

Claude peut vous aider à :

- lire et modifier du code associé à un notebook ;
- diagnostiquer une exception à partir de la sortie réelle ;
- extraire une cellule stable vers `src/` ;
- écrire des tests pour la logique extraite ;
- générer des scripts reproductibles à partir d'une exploration ;
- exécuter des commandes Python, tests et linters dans le dépôt ;
- revoir un diff avant commit.

L'objectif n'est pas de transformer le notebook en gigantesque conversation, mais de **réduire progressivement la part non reproductible** de l'analyse.

---

## Structure recommandée

```text
projet-data/
├── notebooks/
│   ├── 01-exploration.ipynb
│   └── 02-modelisation.ipynb
├── src/
│   ├── data.py
│   ├── features.py
│   └── model.py
├── tests/
│   ├── test_features.py
│   └── test_model.py
├── scripts/
│   └── profile_data.py
└── CLAUDE.md
```

Le notebook **orchestre** l'expérience ; `src/` contient la logique que vous voulez pouvoir tester, réutiliser et relire facilement.

---

## Pattern 1 — Explorer dans le notebook, stabiliser dans `src/`

Après une exploration réussie :

```text
La cellule de feature engineering dans @notebooks/01-exploration.ipynb
est maintenant stable.

1. extrais sa logique pure dans `src/features.py` ;
2. garde dans le notebook uniquement l'appel à la fonction ;
3. ajoute des tests sur valeurs normales, NaN et catégories inconnues ;
4. exécute les tests ;
5. résume le diff.
```

Ce pattern évite que la logique métier n'existe uniquement dans une cellule difficile à tester.

---

## Pattern 2 — Reproduire une erreur réelle

Évitez :

```text
Mon notebook ne marche pas, corrige-le.
```

Préférez :

```text
Cette cellule échoue avec l'erreur suivante :
<coller le traceback>

Trouve d'abord la cause racine.
Ne modifie rien avant d'avoir identifié :
- la cellule ou le module responsable ;
- l'hypothèse violée ;
- une reproduction minimale.
Ensuite propose le correctif le plus petit et vérifie-le.
```

Si la logique existe déjà dans `src/`, demandez à Claude d'écrire un test de régression plutôt que de corriger uniquement la cellule.

---

## Pattern 3 — Transformer une exploration en script reproductible

```text
À partir de l'exploration actuelle, crée `scripts/profile_data.py`.
Le script doit reproduire les statistiques importantes sans dépendre de l'état du kernel.
Ajoute une option `--input` et retourne un code de sortie non nul si les colonnes obligatoires manquent.
Exécute-le sur l'échantillon de test.
```

C'est un excellent moyen de supprimer les dépendances cachées liées à l'ordre d'exécution des cellules.

---

## État du kernel : source fréquente de faux résultats

Un notebook peut sembler fonctionner uniquement parce qu'une variable a été créée plusieurs cellules plus tôt dans un ordre différent de celui affiché.

Avant de considérer une analyse comme reproductible :

1. redémarrez le kernel ;
2. exécutez toutes les cellules dans l'ordre ;
3. vérifiez qu'aucune cellule ne dépend d'un état implicite ;
4. sauvegardez le protocole et les dépendances.

Demandez à Claude de rechercher les variables utilisées avant définition et les dépendances d'état implicites.

---

## Notebooks volumineux

Les `.ipynb` contiennent du JSON, des métadonnées et parfois des outputs volumineux. Cela peut créer :

- des diffs très bruyants ;
- une consommation de contexte inutile ;
- des revues difficiles ;
- des conflits Git pénibles.

Pratiques recommandées :

- ne versionner les outputs que s'ils ont une valeur documentaire ;
- extraire les fonctions stables en `.py` ;
- éviter d'embarquer des blobs ou images massives dans Git ;
- utiliser un outil de nettoyage/diff notebook si votre équipe en a besoin ;
- segmenter les notebooks très longs par objectif.

Des tickets publics du dépôt Claude Code ont signalé des limites et problèmes d'ergonomie sur de gros notebooks et certains scénarios d'édition. Traitez donc le notebook comme une interface utile, pas comme le meilleur format pour tout le code du projet.

---

## Exemple de `CLAUDE.md` pour projet notebook

```markdown
## Notebook workflow
- Stable logic belongs in `src/`, not only in notebooks.
- Run `pytest -q` after extracting notebook code.
- Notebooks must execute top-to-bottom from a fresh kernel.
- Do not commit confidential data or large generated outputs.
- When changing an experiment, report the dataset split and seed.
```

---

## Utiliser Claude dans VS Code ou JetBrains

Claude Code dispose d'intégrations IDE pour VS Code et JetBrains. Pour travailler sur un notebook :

- gardez le dépôt ouvert à sa racine ;
- référencez explicitement le notebook ou le module Python concerné ;
- faites exécuter les tests/commandes hors notebook quand c'est possible ;
- relisez le diff Git après une modification de `.ipynb`.

Pour les tâches longues, utilisez un subagent d'exploration afin que les sorties volumineuses ne saturent pas la conversation principale.

---

## Référence GitHub Copilot

Copilot reste pertinent pour un workflow très centré sur la complétion **cellule par cellule** dans VS Code avec l'extension Jupyter. Les principes historiques restent valables :

- suggestions inline dans les cellules de code ;
- chat IDE ;
- génération à partir d'une cellule Markdown ou d'un commentaire ;
- commandes et contexte propres à l'intégration Copilot/VS Code.

Cette capacité est conservée dans la documentation car elle peut redevenir utile si l'équipe réactive Copilot. Le parcours principal du dépôt reste cependant Claude Code.

---

## Checklist avant commit

- [ ] notebook exécutable depuis un kernel propre ;
- [ ] logique réutilisable extraite dans `src/` ;
- [ ] tests associés aux transformations critiques ;
- [ ] outputs lourds supprimés s'ils n'apportent rien ;
- [ ] aucun secret ou donnée confidentielle dans les cellules/output ;
- [ ] diff `.ipynb` relu.

---

## Sources

- [Claude Code — VS Code](https://code.claude.com/docs/en/vs-code) — consulté le 2026-09-28
- [Claude Code — JetBrains](https://code.claude.com/docs/en/jetbrains) — consulté le 2026-09-28
- [Claude Code — fonctionnalités et extensions](https://code.claude.com/docs/en/features-overview) — consulté le 2026-09-28
- [Claude Code issue tracker — notebook file-size limitations](https://github.com/anthropics/claude-code/issues/16984) — consulté le 2026-09-28

## Prochaine étape

**[MLOps & Déploiement](mlops-deploiement.md)** : transformer les expériences reproductibles en pipeline de validation, packaging et monitoring.
