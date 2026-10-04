# Caveman & RTK — réduire le bruit et mesurer le coût

Caveman et RTK agissent sur des sources différentes de consommation. Choisissez l’outil en fonction du bruit observé, puis comparez le coût total et la qualité sur les mêmes tâches.

## Fiche détaillée dans Outils

**[Guide complet : caveman](../chapitre-13-outils-economies/caveman.md)** — Configurer le skill, le proxy ou le middleware Caveman.

## RTK ou Caveman : choisir selon la sortie

| Mécanisme | Cible | Fiche détaillée |
|---|---|---|
| RTK | Sorties terminales : commandes Git, tests, builds et linters | [RTK](../chapitre-13-outils-economies/rtk.md) |
| Caveman skill | Verbosité des réponses de l’agent | [Caveman](../chapitre-13-outils-economies/caveman.md) |
| Caveman proxy / middleware | Certaines entrées et résultats d’outils | [Caveman](../chapitre-13-outils-economies/caveman.md) |
| TOON | Représentation de données structurées | [TOON](../chapitre-13-outils-economies/toon.md) |
| `/compact` | Historique de conversation Claude | [Leviers d’économie](leviers-economie.md) |

Si le bruit vient des logs de tests ou des builds, évaluez d’abord **RTK**. Si les réponses de l’agent sont trop longues, examinez le **skill Caveman**. Un proxy ajoute un traitement des données : contrôlez sa configuration et les informations conservées.

## Vérifier le bénéfice réel

1. Fixer un corpus de tâches et les mêmes critères de réussite.
2. Mesurer sans compression, puis avec un seul mécanisme.
3. Comparer volume de sortie, consommation totale, temps, tests et corrections nécessaires.
4. Conserver l’accès aux sorties originales pour diagnostiquer les erreurs.

`rtk gain` aide à suivre la réduction des sorties ; les nombres de tokens sont des estimations. Une diminution de la sortie terminale n’est pas une diminution équivalente de la facture : prompts, historique et réponses restent consommés. Les filtres peuvent aussi retirer une information utile. Voir le [README officiel RTK](https://github.com/rtk-ai/rtk#how-savings-work), consulté le **4 octobre 2026**.

Ne cumulez pas automatiquement RTK et un proxy Caveman sur la même sortie : mesurez chaque transformation et vérifiez que les diagnostics restent exploitables.

## Prochaine étape

Poursuivez avec **[Quand utiliser quel mode ?](modes-quand-utiliser.md)**, la page suivante dans le menu.
