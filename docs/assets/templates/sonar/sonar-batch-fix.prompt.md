---
description: Correction Sonar par lot borné (une seule règle).
mode: agent
tools:
  - codebase
  - editFiles
---

Corrige uniquement les occurrences de la règle Sonar `<RULE_KEY>` dans `<SCOPE>`.

Paramètres :

- max fichiers : <MAX_FILES>
- branche dédiée : <BRANCH_NAME>
- commande compile : <BUILD_COMMAND>
- commande tests cibles : <TEST_COMMAND>

Règles d'exécution :

1. Une seule règle Sonar par exécution.
2. Vérifier et valider le premier correctif avant propagation.
3. Corriger par petits lots (max fichiers).
4. Compiler après chaque lot.
5. Exécuter les tests ciblés après chaque lot.
6. Arrêt immédiat en cas de régression.
7. Aucun commit automatique.

Interdictions :

- aucune modification fonctionnelle volontaire.
- aucune nouvelle dépendance.
- aucun `NOSONAR`.
- aucune désactivation de règle.

Rapport final :

- liste fichiers modifiés.
- lots traités et statuts.
- résultat compilation/tests.
- régressions détectées et actions prises.

