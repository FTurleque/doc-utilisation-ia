# Installation & Configuration de Base

Ce chapitre vous guide à travers l'installation complète de GitHub Copilot sur vos IDEs. Que vous utilisiez IntelliJ IDEA ou Visual Studio Code, la procédure est rapide (moins de 10 minutes) et ne nécessite pas de configuration système particulière.

---

## Prérequis communs

Avant de commencer, vérifiez que vous disposez de :

!!! warning "Compte GitHub avec Copilot activé"
    GitHub Copilot nécessite un plan actif (Free, Pro, Pro+, Business ou Enterprise) avant installation du plugin/extension.

    - [Activer GitHub Copilot](https://github.com/features/copilot) sur votre compte GitHub
    - Vérifier votre plan : [github.com/settings/copilot](https://github.com/settings/copilot)
    - Vérifier les plans officiels : [Plans GitHub Copilot](https://docs.github.com/fr/copilot/get-started/plans)

| Prérequis | Détail |
|-----------|--------|
| **Compte GitHub** | Compte personnel ou compte d'organisation avec Copilot activé |
| **Abonnement** | Copilot Free, Pro, Pro+, Business, ou Enterprise |
| **Connexion internet** | Requise lors de l'installation et de l'authentification |
| **IDE à jour** | Voir versions minimales ci-dessous |

---

## Choisissez votre IDE

<div class="grid cards" markdown>

- :simple-intellijidea: **IntelliJ IDEA**

    Version minimale : **2023.1**

    Installation via le Marketplace de plugins intégré. Compatible avec toute la suite JetBrains (PyCharm, WebStorm, GoLand, Rider...).

    [Tutoriel IntelliJ →](intellij/tutoriel.md){ .md-button .md-button--primary }

- :material-microsoft-visual-studio-code: **Visual Studio Code**

    Version minimale : **1.80**

    Installation via le Marketplace d'extensions. Fonctionne avec tous les langages supportés par VS Code.

    [Tutoriel VS Code →](vscode/tutoriel.md){ .md-button }

</div>

---

## Comparaison rapide

| Aspect | IntelliJ IDEA | VS Code |
|--------|--------------|---------|
| **Type d'intégration** | Plugin natif JetBrains | Extension Marketplace |
| **Authentification** | Via Tools → GitHub Copilot | Pop-up automatique à l'installation |
| **Copilot Chat** | Inclus dans le plugin | Extension séparée (GitHub Copilot Chat) |
| **Temps d'installation** | ~5 min | ~3 min |
| **Custom Instructions** | ✓ Supporté | ✓ Supporté |
| **Custom Agents** | ✓ Supporté | ✓ Supporté |
| **Prompt Files** | ✓ Supporté | ✓ Supporté |
| **Agent Skills** | ✓ Supporté (lecture) | ✓ Supporté |
| **MCP (Model Context Protocol)** | ✓ Supporté | ✓ Supporté |
| **Hooks personnalisés** | ✗ Non supportés | ✓ Supporté |

!!! warning "Versions minimales requises"
    - **IntelliJ IDEA** : 2023.1+ pour Copilot complet
    - **VS Code** : 1.85+ pour toutes les fonctionnalités (Custom agents, MCP, etc.)

!!! tip "Vous utilisez les deux IDEs ?"
    Si vous alternez entre IntelliJ et VS Code, installez Copilot sur les deux. Votre abonnement couvre tous vos IDEs simultanément.

---

## Prochaines étapes

Après l'installation, rendez-vous au [Paramétrage](../chapitre-2-parametrage/index.md) pour configurer Copilot selon votre workflow.

