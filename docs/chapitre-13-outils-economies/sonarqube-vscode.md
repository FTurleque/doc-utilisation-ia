# SonarQube — workflow VS Code avec Claude Code

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-vscode">VS Code</span>

Cette page décrit le workflow SonarQube dans VS Code avec **Claude Code comme agent principal**. Sonar détecte et qualifie les problèmes ; Claude intervient seulement lorsque la correction nécessite du raisonnement ou plusieurs modifications coordonnées.

---

## Prérequis

- VS Code ;
- extension officielle **SonarQube for IDE** ;
- projet dans un langage pris en charge ;
- accès SonarQube Cloud/Server si Connected Mode ;
- Claude Code dans VS Code ou via le terminal intégré.

---

## Workflow recommandé

```text
SonarQube for IDE détecte
→ Quick Fix / correction déterministe si possible
→ Claude Code sur le reliquat complexe
→ tests / build
→ réanalyse Sonar
```

Le même principe vaut avec IntelliJ ; seule l'intégration IDE change.

---

## Installer SonarQube for IDE

1. Ouvrez le Marketplace VS Code.
2. Recherchez `SonarQube for IDE`.
3. Vérifiez l'éditeur **SonarSource**.
4. Installez l'extension.
5. Ouvrez un fichier pris en charge et vérifiez l'analyse locale.

Si aucune issue ne remonte, vérifiez d'abord langage, exclusions, logs de l'extension et configuration du workspace.

---

## Connected Mode

Activez Connected Mode pour aligner le projet local avec SonarQube Cloud ou SonarQube Server : profils de qualité, configuration d'organisation et informations serveur disponibles selon le produit/version.

!!! danger "Secrets"
    Utilisez un token utilisateur adapté et ne le stockez jamais dans Git, un prompt ou une capture d'écran.

---

## Utiliser Claude à partir d'une issue précise

Évitez :

```text
Analyse tout mon projet et corrige les problèmes Sonar.
```

Préférez :

```text
L'issue Sonar suivante concerne `src/...` et la règle `java:Sxxxx`.
Lis le code voisin, explique la cause, propose le correctif minimal,
applique-le, exécute les tests ciblés puis vérifie que l'analyse Sonar ne remonte plus l'issue.
```

Le message Sonar exact, la règle et l'emplacement constituent le contexte de départ.

---

## MCP Sonar dans Claude Code

Pour une intégration plus structurée, utilisez le **SonarQube MCP Server officiel**. SonarSource documente Claude Code comme client pris en charge.

Le MCP permet à Claude d'interroger des données Sonar sans copier manuellement des rapports complets dans le chat.

Consultez le guide principal : **[SonarQube — analyse statique et boucle de validation avec Claude Code](sonarqube.md)**.

---

## RTK en complément

RTK peut être utile pour compacter les sorties terminal de tests/build exécutées pendant la correction. Il ne compacte pas « Sonar » au sens fonctionnel et ne remplace pas l'analyse Sonar.

```text
Sonar = signal qualité/sécurité
RTK   = réduction de certaines sorties CLI
Claude = raisonnement + modifications + orchestration
```

---

## Sources

- [SonarQube MCP Server](https://github.com/SonarSource/sonarqube-mcp-server) — consulté le 2026-09-28
- [SonarQube for IDE](https://docs.sonarsource.com/sonarqube-for-ide/) — consulté le 2026-09-28
- [Claude Code — VS Code](https://code.claude.com/docs/en/vs-code) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-13-outils-economies.md#page-chapitre-13-outils-economies-sonarqube-vscode).

## Prochaine étape

Poursuivez avec **[RTK + SonarQube](rtk-sonar.md)**, la page suivante dans le menu.
