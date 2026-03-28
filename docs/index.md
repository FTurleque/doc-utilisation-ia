---
hide:
  - navigation
  - toc
---

# GitHub Copilot — Configuration & Utilisation

<div class="hero-banner" markdown>

## Votre assistant IA intégré à IntelliJ et VS Code

GitHub Copilot est un assistant de programmation propulsé par l'IA qui suggère du code, génère des fonctions entières, et répond à vos questions directement dans votre éditeur. Cette documentation vous guide de l'installation jusqu'aux techniques avancées de personnalisation.

[:simple-intellijidea: Commencer avec IntelliJ IDEA](chapitre-1-installation/intellij/tutoriel.md){ .md-button .md-button--primary }
[:material-microsoft-visual-studio-code: Commencer avec VS Code](chapitre-1-installation/vscode/tutoriel.md){ .md-button }

</div>

---

## Qu'est-ce que GitHub Copilot ?

GitHub Copilot est un service d'IA développé par GitHub et OpenAI. Il s'intègre directement dans votre IDE et propose des suggestions de code en temps réel : complétions de lignes, génération de fonctions entières, écriture de tests, refactoring, et réponses à vos questions techniques via le chat.

**Ce que Copilot fait concrètement :**

- **Suggestions inline** : il complète votre code en gris pendant que vous tapez — acceptez avec ++tab++
- **Génération à partir de commentaires** : écrivez `// fonction qui trie un tableau par date` et Copilot génère le code
- **Copilot Chat** : posez des questions en langage naturel, demandez des explications, des refactorings, des tests
- **Agents et personnalisation** : créez des agents custom, des instructions réutilisables, des prompts sauvegardés

---

## Bénéfices pour le développement

<div class="grid cards" markdown>

- :material-lightning-bolt: **Vitesse**

    Réduisez le temps passé sur les tâches répétitives : boilerplate, getters/setters, tests unitaires, documentation

- :material-brain: **Apprentissage**

    Découvrez des patterns et APIs que vous ne connaissez pas encore, avec des explications contextualisées

- :material-shield-check: **Qualité**

    Générez des tests automatiquement, obtenez des suggestions de refactoring, identifiez les problèmes potentiels

- :material-code-tags: **Focus**

    Restez dans votre éditeur sans jongler entre documentation, StackOverflow et votre IDE

</div>

---

## À qui s'adresse cette documentation ?

| Niveau | Profil | Ce que vous trouverez ici |
|--------|--------|---------------------------|
| 🟢 **Débutant** | Vous venez d'activer Copilot ou vous débutez | Tutoriels pas à pas, captures d'écran, explications des termes techniques |
| 🟡 **Intermédiaire** | Vous utilisez Copilot au quotidien | Paramétrage avancé, bonnes pratiques, optimisation du contexte |
| 🔴 **Expert** | Vous voulez personnaliser Copilot profondément | Agents custom, instructions, skills, hooks, cas d'usage par langage |

---

## Structure de cette documentation

```
📖 Installation & Configuration de base
   └── Comment installer et authentifier Copilot sur chaque IDE

⚙️  Paramétrage détaillé
   └── Tous les paramètres expliqués, profils de configuration

🧠 Contexte & Personnalisation
   └── Instructions, agents, skills, hooks, .copilotignore

✅ Bonnes Pratiques
   └── Prompts efficaces, sécurité, productivité

🔧 Troubleshooting
   └── Résolution des problèmes courants, logs, diagnostic

💼 Cas d'Usage Concrets
   └── Node.js/React, Python, Java — configs clé en main

📎 Appendices
   └── Raccourcis clavier, templates, ressources, FAQ
```

---

## Versions couvertes

| Logiciel | Version minimale | Recommandée |
|----------|-----------------|-------------|
| IntelliJ IDEA | 2023.1 | 2024.1+ |
| Visual Studio Code | 1.80 | Dernière stable |
| Plugin GitHub Copilot (IntelliJ) | 1.5+ | Dernière |
| Extension GitHub Copilot (VS Code) | 1.150+ | Dernière |
| Abonnement | GitHub Copilot Individual / Business / Enterprise | — |

!!! info "GitHub Copilot Free"
    Depuis fin 2024, GitHub propose un tier **Copilot Free** avec des limites mensuelles (2 000 complétions, 50 messages Chat). Cette documentation couvre toutes les offres.

---

## Comment utiliser cette documentation

- **Vous débutez ?** → Suivez le [tutoriel IntelliJ](chapitre-1-installation/intellij/tutoriel.md) ou [tutoriel VS Code](chapitre-1-installation/vscode/tutoriel.md) de A à Z
- **Vous cherchez un paramètre précis ?** → Utilisez la **barre de recherche** en haut (++slash++ pour l'activer)
- **Vous avez un problème ?** → Rendez-vous directement au [Troubleshooting](chapitre-10-troubleshooting/index.md)
- **Vous voulez les raccourcis ?** → [Appendice A — Raccourcis clavier](appendices/raccourcis-clavier.md)
