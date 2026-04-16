# Outils pour Économiser les Premium Requests

Les premium requests de GitHub Copilot sont limitées par abonnement. Ce chapitre recense les outils complémentaires — comme **RTK AI** — qui permettent de réduire cette consommation en déléguant certaines tâches à des assistants gratuits, locaux ou spécialisés, sans sacrifier la productivité.

---

## Pages du Chapitre

<div class="grid cards" markdown>

- :material-lightning-bolt: **[RTK (Rust Token Killer)](rtk.md)**

    Outil CLI open source qui compresse les sorties de commandes terminal de 60 à 90 % avant qu'elles n'atteignent la fenêtre de contexte de l'agent IA. Aucun plugin IDE — s'installe en une commande.

- :material-format-text: **[TOON (Token-Oriented Object Notation)](toon.md)**

    Format de données compact qui réduit la consommation de tokens de 40 % par rapport à JSON. Idéal pour passer des tableaux de données à Copilot.

- :material-puzzle: **[OpenSkills](openskills.md)**

    Installateur universel de skills pour agents IA. Standardise et partage des capacités entre Copilot, Claude Code, Cursor et d'autres agents via un format SKILL.md unique.

- :material-toolbox: **[Outils Complémentaires](outils-complementaires.md)**

    Continue.dev, Ollama, Codeium, Tabnine, Amazon Q, LM Studio et Supermaven : des outils gratuits ou locaux pour prendre le relais de Copilot sur les tâches légères.

- :material-compare: **[Comparaison des Outils](comparaison.md)**

    Tableau récapitulatif : quel outil pour quel cas d'usage, par niveau de complexité et par IDE.

</div>

---

## Pourquoi ce chapitre existe

Un abonnement GitHub Copilot Pro inclut **300 premium requests/mois** — suffisant pour une utilisation raisonnée, mais vite épuisé si vous utilisez systématiquement Claude 3.5 Sonnet ou o3 pour des tâches simples.

```
Autocomplétion    → toujours gratuite (aucune premium request)
Chat GPT-4o mini  → gratuite ou peu consommatrice selon le plan
Chat Claude 3.5   → 1 premium request par échange
Agent (o3-mini)   → comptabilisé, parfois multiple par tâche complexe
```

L'idée directrice de ce chapitre : **utiliser les bons outils pour les bonnes tâches**, de façon à réserver votre quota premium aux moments où la puissance des grands modèles fait vraiment la différence.

---

## Vue d'ensemble rapide

| Outil | Type | Gratuit | Local | Installation | Meilleur pour |
|-------|------|---------|-------|-------------|---------------|
| [RTK](rtk.md) | CLI proxy (Rust, open source) | Oui (gratuit) | Non | Binaire / brew / curl | Comprimer les sorties terminal de l'agent |
| [TOON](toon.md) | Format de données compact | Oui (gratuit) | Non | `npx @toon-format/cli` | Réduire les tokens des données tabulaires (-40 %) |
| [OpenSkills](openskills.md) | CLI skills universel | Oui (gratuit) | Non | `npx openskills` | Standardiser les skills entre agents IA |
| [Continue.dev](outils-complementaires.md#continue-dev) | Assistant open source | Oui | Oui | Extension VS Code / JetBrains | Remplacer le Chat Copilot |
| [Ollama](outils-complementaires.md#ollama) | Runner de modèles locaux | Oui | Oui | CLI | Inférence locale illimitée |
| [LM Studio](outils-complementaires.md#lm-studio) | Interface modèles locaux | Oui | Oui | App desktop | Tester des modèles facilement |
| [Codeium / Windsurf](outils-complementaires.md#codeium) | Complétion IA gratuite | Oui | Non | Extension | Autocomplétion alternative |
| [Tabnine](outils-complementaires.md#tabnine) | Complétion IA privée | Tier gratuit | Oui | Extension | Complétion offline/enterprise |
| [Amazon Q Developer](outils-complementaires.md#amazon-q) | Assistant AWS | Tier gratuit | Non | Extension | Projets cloud AWS |
| [Supermaven](outils-complementaires.md#supermaven) | Complétion ultra-rapide | Tier gratuit | Non | Extension | Complétions longues, rapides |

---

## Prochaine étape

Commencez par **[RTK AI](rtk.md)** : l'outil le plus directement orienté vers la réduction de consommation de requêtes, avec une installation simple dans VS Code ou IntelliJ.
