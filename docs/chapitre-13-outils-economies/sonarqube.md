# SonarQube — analyse statique et boucle de validation avec Claude Code

<span class="badge-expert">Expert</span> <span class="badge-intellij">IntelliJ</span>

SonarQube complète Claude Code avec une source de vérité déterministe sur la qualité et la sécurité du code. Le principe recommandé est simple : **détecter avec Sonar, corriger avec l'outil le plus déterministe possible, puis utiliser Claude sur les cas complexes et vérifier à nouveau**.


---

## Workflow recommandé

```text
SonarQube for IDE / analyse CI
        ↓
issue précise + règle + emplacement
        ↓
Quick Fix / refactoring déterministe si disponible
        ↓
Claude Code si la correction nécessite analyse ou coordination
        ↓
compiler + tester + réanalyser Sonar
```

Un identifiant de règle et un emplacement précis constituent un meilleur contexte qu'une demande générale du type « analyse tout le dépôt ».

---

## SonarQube for IDE

Le plugin officiel SonarQube for IDE fonctionne indépendamment d'un LLM pour de nombreuses détections : bugs, vulnérabilités, code smells et règles de qualité prises en charge par la version installée.

En **Connected Mode**, l'IDE peut être lié à SonarQube Server ou SonarQube Cloud afin d'aligner les règles et le projet avec la configuration de l'organisation.

Bonnes pratiques :

- installer uniquement le plugin officiel SonarSource ;
- utiliser un token utilisateur à privilèges minimaux ;
- ne jamais committer un token ;
- conserver les profils de qualité et Quality Gates comme source de vérité ;
- vérifier la compatibilité exacte des fonctions selon version, édition et langage.

---

## Quick Fix et AI CodeFix

Ne confondez pas :

| Mécanisme | Nature | Usage |
|---|---|---|
| Quick Fix Sonar | Correction déterministe fournie par une règle | Premier choix lorsqu'il existe |
| Refactoring / intention IDE | Transformation locale de l'IDE | Premier choix pour les opérations structurelles sûres |
| AI CodeFix | Proposition générée par IA côté Sonar | Escalade sur issue éligible |
| Claude Code | Agent généraliste avec accès au dépôt et aux outils | Cas complexes, multi-fichiers, validation coordonnée |

Aucune correction IA ne dispense de compiler, tester et réanalyser.

---

## SonarQube MCP Server avec Claude Code

SonarSource fournit un **SonarQube MCP Server officiel**. La documentation actuelle donne directement des exemples Claude Code.

### SonarQube Cloud

```bash
claude mcp add sonarqube \
  --env SONARQUBE_TOKEN=$SONAR_TOKEN \
  --env SONARQUBE_ORG=$SONAR_ORG \
  -- docker run --init --pull=always -i --rm \
  -e SONARQUBE_TOKEN -e SONARQUBE_ORG \
  sonarsource/sonarqube-mcp
```

### SonarQube Server

```bash
claude mcp add sonarqube \
  --env SONARQUBE_TOKEN=$SONAR_USER_TOKEN \
  --env SONARQUBE_URL=$SONAR_URL \
  -- docker run --init --pull=always -i --rm \
  -e SONARQUBE_TOKEN -e SONARQUBE_URL \
  sonarsource/sonarqube-mcp
```

!!! danger "Ne mettez pas le token dans Git"
    Les exemples utilisent des variables d'environnement. Évitez de placer un token réel dans `.mcp.json`, une commande copiée dans un ticket ou une capture d'écran.

Attention : le shell développe `$SONAR_TOKEN` **avant** d'appeler `claude mcp add --env ...`. La valeur peut donc être enregistrée dans la configuration locale du client ; le nom d'une variable dans un exemple ne garantit pas que le secret reste uniquement en mémoire. Protégez cette configuration. Pour un `.mcp.json` versionné, utilisez une référence littérale `${SONARQUBE_TOKEN}` et fournissez sa valeur hors Git. [Expansion des variables MCP](https://code.claude.com/docs/en/mcp#environment-variable-expansion-in-mcp-json), revérifiée le 3 octobre 2026.

Pour un projet partagé, préférez une configuration documentée avec noms de variables et laissez chaque développeur fournir ses secrets localement.

---

## Transport et déploiement

Le serveur SonarQube MCP supporte actuellement :

- **stdio** : recommandé pour un client local qui lance le serveur comme subprocess ;
- **Streamable HTTP** : pour les déploiements distants/multi-utilisateurs ; utilisez HTTPS en production.

L'ancien transport HTTP SSE-only n'est plus le transport réseau recommandé par le serveur actuel.

Pour un environnement reproductible, épinglez une version de l'image au lieu d'utiliser systématiquement `--pull=always`.

---

## Version de SonarQube Server

Le serveur MCP vérifie la version SonarQube Server au démarrage. La documentation actuelle indique un minimum de **SonarQube Server 2025.1** ou **SonarQube Community Build 25.1** pour les connexions Server ; SonarQube Cloud n'est pas soumis à ce contrôle de version.

Vérifiez cette exigence à nouveau avant déploiement : elle peut évoluer avec le serveur MCP.

---

## Intégration Claude Code plus poussée

SonarSource documente également un setup Claude Code combinant :

- SonarQube MCP Server ;
- CLI Sonar ;
- hooks Claude Code ;
- commandes dédiées de qualité/sécurité ;
- contrôles de secrets avant certaines lectures ou soumissions.

Ce type d'intégration peut être utile si Sonar fait partie du workflow quotidien. Il doit cependant rester soumis aux mêmes règles : permissions minimales, revue des hooks, validation humaine et Quality Gate côté CI.

---

## Claude Code ne remplace pas le Quality Gate

Utilisez Claude pour :

- expliquer une issue ;
- rechercher la cause dans plusieurs fichiers ;
- proposer une correction ;
- ajouter ou adapter les tests ;
- relancer l'analyse via les outils disponibles.

Mais la décision « l'issue est corrigée » doit venir de l'analyse Sonar et des tests, pas de la formulation du modèle.

---

## Exemple de demande ciblée

```text
Interroge SonarQube pour les nouvelles issues de ce projet.
Choisis uniquement les issues bloquantes du code modifié.
Pour chacune :
1. montre règle, fichier et ligne ;
2. explique la cause ;
3. propose le correctif minimal ;
4. applique une seule correction à la fois ;
5. exécute les tests pertinents ;
6. réanalyse avant de conclure.
```

Cette boucle évite de demander à l'agent d'inventer son propre référentiel de qualité.

---

### Déploiement reproductible et télémétrie

Les exemples `--pull=always` suivent les mises à jour de l’image. Pour un déploiement d’équipe validé, épinglez une version ou un digest et testez les mises à jour. Le serveur officiel documente aussi une collecte de données d’usage : vérifiez la politique et les réglages de la version déployée. Le MCP, l’analyse IDE et le Quality Gate serveur sont trois étapes distinctes. [README SonarQube MCP](https://github.com/SonarSource/sonarqube-mcp-server), revérifié le 3 octobre 2026.

## Sources

- [SonarSource — SonarQube MCP Server](https://github.com/SonarSource/sonarqube-mcp-server) — consulté le 2026-09-28
- [SonarSource — setup SonarQube plugin pour Claude Code](https://www.sonarsource.com/developers/blueprints/set-up-the-sonarqube-plugin-for-claude-code/) — consulté le 2026-09-28
- [Claude Code — MCP](https://code.claude.com/docs/en/mcp) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-13-outils-economies.md#page-chapitre-13-outils-economies-sonarqube).

## Prochaine étape

Poursuivez avec **[VS Code](sonarqube-vscode.md)**, la page suivante dans le menu.
