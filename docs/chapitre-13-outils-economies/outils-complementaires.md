# Vue d'ensemble des outils complémentaires

<span class="badge-intermediate">Intermédiaire</span>

Au-delà de RTK, tu peux construire une stack d'outils locaux ou low-cost
pour déléguer les tâches simples hors quota Copilot.
Cette page sert de sommaire : chaque outil dispose de sa page détaillée.

---

## Comment lire cette section

Chaque page outil couvre:

- **À quoi sert l'outil**
- **Quand l'utiliser**
- **Comment l'installer (VS Code et IntelliJ)**
- **Comment exploiter son plein potentiel**
- **Exemples concrets**
- **Sources officielles**

---

## Pages détaillées par outil

| Outil | Utilité principale | Coût Copilot typique | Cas d'usage | Page détaillée |
|------|---------------------|----------------------|------------|----------------|
| SonarQube (IntelliJ) | Analyse statique, Quick Fix, gouvernance qualité | Nul en détection locale | Java/IntelliJ, sécurité, dette technique | [SonarQube — IntelliJ](sonarqube.md) |
| SonarQube (VS Code) | Analyse statique et triage d'issues en workflow VS Code | Nul en détection locale | Qualité continue, correction bornée, gouvernance | [SonarQube — VS Code](sonarqube-vscode.md) |
| TOON | Automatiser et compiler des configurations IA complexes | Faible à nul | Automatisation de workflows IA | [TOON](toon.md) |
| OpenSkills | Installer et partager des skills universels entre agents IA | Nul | Standardisation d'instructions et skills | [OpenSkills](openskills.md) |
| Continue.dev | Orchestrer chat + complétion avec modèles locaux/cloud | Nul à variable | Routage local/cloud dans l'IDE | [Continue.dev](continue-dev.md) |
| Ollama | Exécuter des LLM en local via CLI/API | Nul | Chat/génération locale | [Ollama](ollama.md) |
| LM Studio | Exécuter des LLM locaux via interface graphique | Nul | Expérimentation locale de modèles | [LM Studio](lm-studio.md) |
| Codeium / Windsurf | Complétion/chat alternatif pour tâches courantes | Nul à faible | Complétion quotidienne | [Codeium / Windsurf](codeium-windsurf.md) |
| Tabnine | Assistant orienté confidentialité et entreprise | Variable | Complétion orientée gouvernance | [Tabnine](tabnine.md) |
| Amazon Q Developer | Assistant spécialisé écosystème AWS | Nul à variable | Support dev cloud AWS | [Amazon Q Developer](amazon-q-developer.md) |
| Supermaven | Complétion inline très rapide | Nul à faible | Flux d'écriture rapide | [Supermaven](supermaven.md) |

---

## Stratégie recommandée

1. **Commencer local** avec [Ollama](ollama.md) ou [LM Studio](lm-studio.md)
2. **Activer l'analyse statique** avec [SonarQube](sonarqube.md) pour corriger sans IA
3. **Connecter l'IDE** avec [Continue.dev](continue-dev.md)
4. **Choisir un moteur inline principal**:
   - [Codeium / Windsurf](codeium-windsurf.md)
   - [Tabnine](tabnine.md)
   - [Supermaven](supermaven.md)
5. **Utiliser [Amazon Q Developer](amazon-q-developer.md)** sur les projets AWS
6. **Garder Copilot (AI Credits)** pour les cas de raisonnement réellement complexes

!!! tip "Rappel important"
    N'active qu'un moteur principal de complétion inline pour éviter les conflits de suggestions.

---

## Quand l'utiliser

- Quand tu veux une vue d'ensemble des outils complémentaires
- Quand tu dois orienter rapidement un lecteur vers la bonne page
- Quand tu cherches une stratégie de stacking avant la mise en œuvre

## Quand l'éviter

- Quand tu veux la configuration détaillée d'un outil précis
- Quand tu as besoin d'un tutoriel pas-à-pas par IDE
- Quand tu cherches à comparer finement plusieurs stacks

---

## Pour aller plus loin

- **[Comparaison des Outils](comparaison.md)** : utiliser la matrice de décision pour choisir la bonne stack.
- **[SonarQube — IntelliJ](sonarqube.md)** : workflow économique détaillé pour IntelliJ + Java.
- **[SonarQube — VS Code](sonarqube-vscode.md)** : version VS Code du workflow SonarQube orienté coûts.
- **[Stack prête en 15 min — VS Code](stack-prete-15-min-vscode.md)** : démarrer rapidement sur VS Code.
- **[Stack prête en 15 min — IntelliJ](stack-prete-15-min-intellij.md)** : démarrer rapidement sur IntelliJ.

---

## Résumé

Cette page sert de sommaire général du sous-chapitre. Elle oriente vers les
fiches détaillées, la comparaison, puis les playbooks rapides pour passer
de la lecture à l'action.

---

## Sources

- [GitHub Copilot extensions marketplace](https://github.com/marketplace?type=apps&copilot_app=true) - consulté le 2026-06-20

## Prochaine étape

**[Recommandations par application](recommandations-taille-type-application.md)** : adapter la stack aux tailles de codebase et aux types d'applications les plus courants.

Concepts clés couverts :

- **Routage de modèles** - local pour simple, cloud pour complexe
- **Installation IDE** - VS Code et IntelliJ
- **Configuration minimale** - modèle chat et modèle complétion
- **Workflow hybride** - combinaison avec Ollama, LM Studio et RTK
