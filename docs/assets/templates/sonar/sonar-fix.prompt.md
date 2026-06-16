---
description: Corriger une issue Sonar unitaire avec périmètre minimal.
mode: agent
tools:
  - codebase
  - editFiles
---

Traite uniquement l'issue Sonar suivante :

- Règle : <RULE_KEY>
- Message : <MESSAGE>
- Fichier : <FILE>
- Ligne : <LINE>
- Méthode concernée : <METHOD>
- Contraintes techniques : <CONSTRAINTS>
- Commande de compilation : <BUILD_COMMAND>
- Commande de test : <TEST_COMMAND>

Contraintes obligatoires :

- correction minimale.
- comportement métier strictement conservé.
- aucune dépendance supplémentaire.
- aucune suppression de règle.
- aucun `NOSONAR`.
- aucune suppression d'alerte sans correction réelle.
- aucun changement hors périmètre.
- compilation et test obligatoires.

Procédure :

1. Vérifie d'abord un Quick Fix Sonar ou une correction déterministe IntelliJ.
2. Si absent, propose un correctif ciblé.
3. Applique uniquement le minimum nécessaire.
4. Compile et exécute les tests commandés.
5. Donne un rapport final :
   - fichiers modifiés,
   - résultat compilation,
   - résultat tests,
   - statut de l'issue Sonar.

