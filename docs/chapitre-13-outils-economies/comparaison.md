# Comparaison des Outils d'Économie de Requêtes

<span class="badge-intermediate">Intermédiaire</span>

Tableau de référence rapide pour choisir le bon outil selon la tâche, l'IDE et les contraintes (connexion, confidentialité, complexité).

---

## Comparaison générale

| Outil | Tier gratuit | Local / Offline | VS Code | IntelliJ | Chat | Complétion |
|-------|-------------|-----------------|---------|----------|------|------------|
| **SonarQube for IDE** | Oui (détection locale) | Oui (mode autonome) | Oui | Oui | :material-close: | :material-close: |
| **RTK** | Oui | Non (cloud) | Oui | Oui | :material-check: | :material-close: |
| **Continue.dev** | Oui | Oui (avec Ollama) | Oui | Oui | :material-check: | :material-check: |
| **Ollama** | Oui (gratuit total) | Oui | Via plugin | Via plugin | :material-check: | :material-check: |
| **LM Studio** | Oui (gratuit total) | Oui | Via Continue | Via Continue | :material-check: | :material-check: |
| **Codeium** | Oui | Non | Oui | Oui | :material-check: | :material-check: |
| **Tabnine** | Tier de base | Oui (Pro) | Oui | Oui | :material-check: | :material-check: |
| **Amazon Q** | Oui | Non | Oui | Oui | :material-check: | :material-check: |
| **Supermaven** | Tier de base | Non | Oui | Oui | :material-close: | :material-check: |
| **GitHub Copilot** | Non | Non | Oui | Oui | :material-check: | :material-check: |

---

## Focus SonarQube (Java + IntelliJ)

| Dimension | SonarQube | Notes opérationnelles |
|---|---|---|
| Analyse statique | Oui (IDE + serveur/cloud) | Détection sans crédit Copilot en local |
| Quick Fix | Oui (selon règle/langage/version) | Ne couvre pas toutes les règles |
| Connected Mode | Oui | Aligne IDE et profil qualité entreprise |
| AI CodeFix | Oui (selon édition/activation) | Service Sonar, pas un crédit Copilot direct |
| MCP | Oui (serveur MCP SonarQube) | Utile pour triage/correction bornée |
| Remediation Agent | Oui (beta selon documentation Sonar) | Disponibilité et limites contractuelles |
| Coût en crédits Copilot | Nul en détection locale; possible en usage Copilot Agent/Chat | Distinguer coûts Sonar vs coûts Copilot |
| Niveau d'automatisation | De déterministe (Quick Fix) à agentique | Commencer par déterministe |
| Intérêt Java/IntelliJ | Très élevé | Intégré au flux IDE + CI |
| Limites | Couverture partielle selon règle/langage/édition | Vérifier matrice officielle |
| Prérequis entreprise | Token utilisateur, serveur/cloud, gouvernance règles | Qualité profils + sécurité tokens |

!!! info "SonarQube et RTK ne font pas la même chose"
    RTK réduit la taille des sorties terminal et le contexte transmis. SonarQube détecte/cadre des problèmes de qualité par analyse statique. Les deux outils sont complémentaires.

---

## Matrice décisionnelle unique

Cette matrice sert de point d'entrée rapide. Identifie d'abord la contrainte
principale, puis choisis la stack correspondante.

| Contrainte principale | Stack recommandée | Pourquoi | À éviter |
|:----------------------|:------------------|:---------|:---------|
| 100% local / offline | Ollama + Continue.dev | pas de service externe | chat cloud par défaut |
| Budget zéro | Ollama + Continue.dev + RTK | aucun coût API | outils payants pour tâches simples |
| Gros bruit terminal | RTK avant tout autre outil | réduit les tokens envoyés | coller des logs bruts |
| Projet AWS dominant | Amazon Q Developer + RTK | contexte AWS natif | assistant générique sans contexte |
| Complétion inline rapide | Supermaven ou Codeium | faible friction d'écriture | utiliser le chat pour un simple snippet |
| Confidentialité forte | Tabnine + Ollama | gouvernance et local first | route cloud non approuvée |

### Lecture rapide

```text
Si le besoin est local -> Ollama + Continue.dev
Si le besoin est du bruit terminal -> RTK d'abord
Si le besoin est AWS -> Amazon Q Developer
Si le besoin est de la complétion -> Supermaven ou Codeium
Si la confidentialité est prioritaire -> Tabnine + local
```

!!! tip "Règle de décision"
    Commence par la contrainte la plus forte: local, budget, AWS, ou
    confidentialité. Ensuite seulement, choisis l'outil de confort.

---

## Quand l'utiliser

- Quand tu veux choisir rapidement une stack adaptée à ton contexte
- Quand tu compares plusieurs outils avant une phase d'adoption
- Quand tu as besoin d'un point d'entrée unique pour l'équipe

## Quand l'éviter

- Quand tu cherches le détail de configuration d'un outil précis
- Quand tu as déjà une stack imposée par l'équipe ou le client
- Quand la décision est déjà tranchée par contrainte technique

---

## Par IDE

=== "Visual Studio Code"

    | Priorité | Outil | Cas d'usage | Installation |
    |----------|-------|-------------|--------------|
    | 1 | **Ollama + Continue.dev** | Chat local illimité, remplace Copilot Chat | Extension + CLI |
    | 2 | **RTK** | Compresser les sorties CLI avant la fenêtre LLM | CLI (binaire) |
    | 3 | **Supermaven** | Complétion ultra-rapide (alternative Copilot inline) | Extension |
    | 4 | **Codeium** | Complétion gratuite si Supermaven ne convient pas | Extension |
    | 5 | **Amazon Q** | Projets AWS uniquement | Via AWS Toolkit |

    !!! tip "Configuration VS Code recommandée"
        - Autocomplétion inline : **Copilot** (gratuit) ou **Supermaven** (gratuit)
        - Chat simple : **Continue.dev + Ollama** (gratuit, local)
        - Chat complexe (architecture, refactoring critique) : **Copilot + Claude** (AI Credits pertinents)

=== "IntelliJ IDEA"

    | Priorité | Outil | Cas d'usage | Installation |
    |----------|-------|-------------|--------------|
    | 1 | **Continue.dev** | Chat local, remplace Copilot Chat | Plugin |
    | 2 | **RTK** | Compresser les sorties CLI avant la fenêtre LLM | CLI (binaire) |
    | 3 | **Tabnine** | Complétion avec confidentialité | Plugin |
    | 4 | **Codeium** | Complétion gratuite | Plugin |
    | 5 | **Amazon Q** | Projets AWS | Via AWS Toolkit plugin |

    !!! tip "Configuration IntelliJ recommandée"
        - Autocomplétion inline : **Copilot** (gratuit)
        - Chat quotidien : **Continue.dev + Ollama** (gratuit)
        - Analyse de code Java/Spring complexe : **Copilot + Claude** (AI Credits)

---

## Playbooks rapides

Quand tu veux passer à l'action sans refaire toute l'analyse, utilise ces
parcours prêts à exécuter:

- **[Stack prête en 15 min — VS Code](stack-prete-15-min-vscode.md)**
- **[Stack prête en 15 min — IntelliJ](stack-prete-15-min-intellij.md)**

Ces pages donnent un chemin concret: installation, connexion à Ollama,
tests de validation, puis critères pour savoir quand basculer vers Copilot.

---

## Par type de tâche

| Type de tâche | Complexité | Outil recommandé | AI Credits |
|---------------|-----------|-----------------|-----------------|
| Complétion inline de code connu | Très faible | Copilot (inline gratuit) ou Supermaven | 0 |
| Question simple sur la syntaxe | Faible | Ollama + Continue | 0 |
| Générer un CRUD standard | Faible | RTK + GPT-4o mini | 0 |
| Expliquer un algorithme | Faible | Continue + Mistral local | 0 |
| Rédiger des tests unitaires | Moyenne | Continue + CodeLlama local | 0 |
| Refactoring d'une méthode | Moyenne | RTK ou Continue | 0–1 |
| Debug d'une erreur multi-fichiers | Haute | Copilot Chat + Claude 3.5 | 1–2 |
| Architecture d'un nouveau module | Haute | Copilot Agent ou RTK + Claude | 2–5 |
| Revue de sécurité approfondie | Très haute | Copilot + o1 ou Amazon Q (scan) | 3–10 |

!!! info "Clarification terminologie"
    "Premium requests" est un terme hérité encore visible dans certains plans.
    Le modèle principal à suivre dans cette page est "AI Credits".

---

## Par contrainte

### Contrainte : pas d'accès internet

```
Ollama + LM Studio + Continue.dev
→ 100% local, 0 connexion externe, 0 AI Credits
```

### Contrainte : confidentialité des données (entreprise)

```
Tabnine (mode local) + Continue.dev + Ollama
→ Aucune donnée ne quitte la machine
```

### Contrainte : projet cloud AWS

```
Amazon Q Developer (tier gratuit) + Ollama pour le reste
→ Meilleure connaissance AWS + 0 AI Credits Copilot
```

### Contrainte : budget $0 (étudiants, side-projects)

```
Continue.dev + Ollama + Codeium
→ Stack complète sans abonnement
```

---

## Économies estimées par combinaison

| Stack | Profil | Économie estimée sur AI Credits |
|-------|--------|--------------------------------------|
| Copilot seul (pas d'optimisation) | Baseline | 0% |
| Copilot + RTK (modèle mini) | Développeur solo | -40 à -60% |
| Copilot + Continue + Ollama | Équipe technique | -70 à -85% |
| Copilot (inline seul) + Continue + Ollama | Utilisateur avancé | -90 à -95% |
| Continue + Ollama (sans Copilot Chat) | Budget zéro | -100% (quota intact) |

!!! info "Ces chiffres sont indicatifs"
    Les économies réelles dépendent de votre mix de tâches. Un développeur qui fait beaucoup de génération de code économisera davantage qu'un développeur axé debug complexe.

---

## Décision rapide

```
Besoin d'un Chat IA ?
  ├─ Tâche simple / répétitive → Continue.dev + Ollama (🆓 local)
  ├─ Contexte riche nécessaire → RTK + GPT-4o mini (faible coût)
  └─ Architecture / debug critique → Copilot + Claude 3.5 (AI Credits OK)

Besoin de complétion inline ?
  ├─ Gratuit sans limite → Supermaven ou Codeium (🆓)
  └─ Intégré à Copilot → Copilot inline (🆓 dans l'abonnement)

Projet AWS ?
  └─ Amazon Q Developer tier gratuit (🆓)

Confidentialité totale ?
  └─ Tabnine local + Ollama (🔒🆓)
```

---

## Résumé

Cette page sert de boussole: elle aide à choisir la bonne combinaison d'outils
avant de passer à la mise en œuvre. Pour le détail, utilise les pages outils
et les playbooks rapides du chapitre.

---

## Prochaine étape

**[Outils Complémentaires](outils-complementaires.md)** : consolider la sélection avec une vue d'ensemble opérationnelle avant de passer aux stacks prêtes en 15 minutes.

Concepts clés couverts :

- **Choix par taille de codebase** — adapter le niveau d'outillage au volume réel
- **Choix par type d'application** — backend, front, data/ML, microservices
- **Arbitrage IntelliJ vs Copilot** — quand rester natif, quand déclencher l'IA
- **Plan actionnable en 30 jours** — démarrer immédiatement sans refonte complète
