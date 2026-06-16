---
description: Triage Sonar sans modifier le code.
mode: ask
tools:
  - codebase
---

Analyse la liste d'issues Sonar fournie sans modifier le code.

Objectifs :

- regrouper par règle.
- identifier les Quick Fix probables.
- séparer les cas déterministes et ambigus.
- estimer le périmètre de correction.
- proposer l'ordre de traitement.
- identifier les points nécessitant une décision métier.
- proposer des lots réduits et vérifiés.

Format de sortie attendu :

1. Regroupement par règle (`RULE_KEY`) avec sévérité.
2. Tableau déterministe vs ambigu.
3. Plan de lots (taille, risque, préconditions).
4. Liste des blocages métier.

Interdiction :

- aucune génération de correctif à cette étape.

