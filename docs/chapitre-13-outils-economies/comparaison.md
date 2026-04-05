# Comparaison des Outils d'Économie de Requêtes

<span class="badge-intermediate">Intermédiaire</span>

Tableau de référence rapide pour choisir le bon outil selon la tâche, l'IDE et les contraintes (connexion, confidentialité, complexité).

---

## Comparaison générale

| Outil | Tier gratuit | Local / Offline | VS Code | IntelliJ | Chat | Complétion |
|-------|-------------|-----------------|---------|----------|------|------------|
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
        - Autocomplétion inline : **Copilot** (gratuite) ou **Supermaven** (gratuit)
        - Chat simple : **Continue.dev + Ollama** (gratuit, local)
        - Chat complexe (architecture, refactoring critique) : **Copilot + Claude** (premium justifiée)

=== "IntelliJ IDEA"

    | Priorité | Outil | Cas d'usage | Installation |
    |----------|-------|-------------|--------------|
    | 1 | **Continue.dev** | Chat local, remplace Copilot Chat | Plugin |
    | 2 | **RTK** | Compresser les sorties CLI avant la fenêtre LLM | CLI (binaire) |
    | 3 | **Tabnine** | Complétion avec confidentialité | Plugin |
    | 4 | **Codeium** | Complétion gratuite | Plugin |
    | 5 | **Amazon Q** | Projets AWS | Via AWS Toolkit plugin |

    !!! tip "Configuration IntelliJ recommandée"
        - Autocomplétion inline : **Copilot** (gratuite)
        - Chat quotidien : **Continue.dev + Ollama** (gratuit)
        - Analyse de code Java/Spring complexe : **Copilot + Claude** (premium)

---

## Par type de tâche

| Type de tâche | Complexité | Outil recommandé | Premium requests |
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

---

## Par contrainte

### Contrainte : pas d'accès internet

```
Ollama + LM Studio + Continue.dev
→ 100% local, 0 connexion externe, 0 premium request
```

### Contrainte : confidentialité des données (enterprise)

```
Tabnine (mode local) + Continue.dev + Ollama
→ Aucune donnée ne quitte la machine
```

### Contrainte : projet cloud AWS

```
Amazon Q Developer (tier gratuit) + Ollama pour le reste
→ Meilleure connaissance AWS + 0 premium request Copilot
```

### Contrainte : budget $0 (étudiants, side-projects)

```
Continue.dev + Ollama + Codeium
→ Stack complète sans abonnement
```

---

## Économies estimées par combinaison

| Stack | Profil | Économie estimée sur premium requests |
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
  └─ Architecture / debug critique → Copilot + Claude 3.5 (premium OK)

Besoin de complétion inline ?
  ├─ Gratuit sans limite → Supermaven ou Codeium (🆓)
  └─ Intégré à Copilot → Copilot inline (🆓 dans l'abonnement)

Projet AWS ?
  └─ Amazon Q Developer tier gratuit (🆓)

Confidentialité totale ?
  └─ Tabnine local + Ollama (🔒🆓)
```

---

## Chapitre suivant

**[Appendices](../appendices/index.md)** : ressources de référence — FAQ, raccourcis clavier, templates de configuration prêts à copier-coller et liens vers les documentations officielles.
