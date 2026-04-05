# Outils Complémentaires pour Économiser les Premium Requests

<span class="badge-intermediate">Intermédiaire</span>

Au-delà de RTK AI, un écosystème d'outils gratuits ou à faible coût permet de **déléguer les tâches légères** hors du quota Copilot. Cette page présente les plus pertinents, avec leur installation et leur positionnement par rapport à GitHub Copilot.

---

## Vue d'ensemble de la stratégie

| Niveau de complexité | Outils recommandés | Coût en premium requests |
|---------------------|--------------------|:------------------------:|
| **Complexité élevée** | Copilot + Claude 3.5 / o3 | Premium requests justifiées |
| **Complexité moyenne** | RTK + GPT-4o mini / Continue.dev | Peu ou pas de premium requests |
| **Complexité faible** | Ollama local / Codeium / Tabnine | Zéro premium request |

---

## Continue.dev {#continue-dev}

<span class="badge-beginner">Débutant</span>

**Continue.dev** ([continue.dev](https://www.continue.dev/)) est un assistant IA **open source** pour VS Code et JetBrains. Il s'intègre exactement comme Copilot Chat mais utilise le modèle de votre choix — y compris des modèles locaux gratuits.

### Pourquoi remplace-t-il Copilot Chat ?

- Interface Chat identique à Copilot
- Se connecte à Ollama, LM Studio, ou des API tierces (OpenAI, Anthropic)
- Supporte `@codebase`, `@file`, `@docs` pour le contexte (comme `#file` dans Copilot)
- Entièrement open source — aucun abonnement requis

### Installation

=== "Visual Studio Code"

    1. Extensions (++ctrl+shift+x++) → rechercher **"Continue"**
    2. Installer l'extension **Continue — Codestral, Claude, and more**
    3. Au premier démarrage, choisir un provider :
       - **Ollama** (local, gratuit) — recommandé
       - **Anthropic Claude** (API payante mais hors quota Copilot)
       - **OpenAI GPT-4o mini** (faible coût)

    Le panneau Continue s'ouvre dans la barre latérale, à côté de Copilot.

=== "IntelliJ IDEA"

    1. **File → Settings → Plugins → Marketplace**
    2. Rechercher **"Continue"** → Install
    3. Redémarrer l'IDE
    4. Configurez le modèle dans `~/.continue/config.json`

### Configuration minimale avec Ollama

```json
{
  "models": [
    {
      "title": "Mistral (local)",
      "provider": "ollama",
      "model": "mistral",
      "apiBase": "http://localhost:11434"
    }
  ],
  "tabAutocompleteModel": {
    "title": "Starcoder2 (local)",
    "provider": "ollama",
    "model": "starcoder2:3b"
  }
}
```

!!! tip "Stratégie combinée"
    Utilisez **Continue pour le Chat** (modèle local gratuit) et gardez **Copilot pour l'autocomplétion inline** (déjà gratuite). Vous couvrez 100% des usages sans toucher aux premium requests.

---

## Ollama {#ollama}

<span class="badge-intermediate">Intermédiaire</span>

**Ollama** ([ollama.ai](https://ollama.ai)) permet de faire tourner des LLMs open source **directement sur votre machine**, sans connexion internet, sans API key, sans coût.

### Modèles recommandés pour le développement

| Modèle | Taille | RAM min. | Bon pour |
|--------|--------|----------|----------|
| `codellama:7b` | 3.8 Go | 8 Go | Génération de code général |
| `starcoder2:3b` | 1.7 Go | 4 Go | Complétion de code (rapide) |
| `mistral:7b` | 4.1 Go | 8 Go | Chat, explication de code |
| `deepseek-coder:6.7b` | 3.8 Go | 8 Go | Code, debug, refactoring |
| `llama3.2:3b` | 2 Go | 4 Go | Tâches légères, questions simples |
| `qwen2.5-coder:7b` | 4.7 Go | 8 Go | Code multilangage, excellent rapport qualité/taille |

### Installation

```powershell
# Windows — télécharger l'installeur sur ollama.ai
# Puis lancer un modèle :
ollama run mistral

# Ou en arrière-plan (pour les extensions IDE) :
ollama serve
```

```bash
# macOS / Linux
curl -fsSL https://ollama.ai/install.sh | sh
ollama run codellama
```

### Utilisation avec Continue.dev ou RTK

Une fois Ollama lancé (`ollama serve`), il expose une API REST sur `http://localhost:11434` — compatible avec Continue.dev, RTK, et la plupart des assistants IA.

!!! info "0 euro, 0 request externe"
    Ollama tourne exclusivement en local. Aucune donnée ne quitte votre machine. Idéal pour les projets sensibles **et** pour préserver votre quota Copilot.

---

## LM Studio {#lm-studio}

<span class="badge-beginner">Débutant</span>

**LM Studio** ([lmstudio.ai](https://lmstudio.ai)) est une application desktop avec interface graphique pour télécharger et faire tourner des modèles locaux. Plus accessible qu'Ollama pour les débutants.

### Avantages

- Interface graphique pour rechercher et télécharger des modèles depuis Hugging Face
- Serveur local compatible OpenAI API — plug-and-play avec Continue.dev
- Pas de ligne de commande nécessaire

### Installation et démarrage

1. Télécharger sur [lmstudio.ai](https://lmstudio.ai)
2. Installer et ouvrir l'application
3. Onglet **Discover** → télécharger un modèle (ex: `Mistral 7B Instruct`)
4. Onglet **Local Server** → cliquer **Start Server** (port 1234 par défaut)
5. Configurer Continue.dev pour pointer sur `http://localhost:1234`

---

## Codeium / Windsurf {#codeium}

<span class="badge-beginner">Débutant</span>

**Codeium** ([codeium.com](https://codeium.com)) — renommé en **Windsurf** pour son IDE dédié — propose une **autocomplétion IA gratuite** et illimitée, alternative directe à l'autocomplétion inline de Copilot.

### Ce qu'il fait

- Autocomplétion inline (comme Copilot, gratuite sans limite)
- Chat intégré (tier gratuit avec limites généreuses)
- Support de 70+ langages

### Installation

=== "Visual Studio Code"

    1. Extensions → rechercher **"Codeium"**
    2. Installer et créer un compte sur codeium.com
    3. Se connecter depuis l'extension
    4. Optionnel : désactiver l'autocomplétion Copilot dans les paramètres pour éviter les conflits

=== "IntelliJ IDEA"

    1. **File → Settings → Plugins → Marketplace**
    2. Rechercher **"Codeium"** → Install
    3. Redémarrer et se connecter

!!! warning "Conflit avec Copilot"
    Codeium et Copilot peuvent entrer en conflit sur l'autocomplétion inline. Activez l'un ou l'autre selon la tâche, ou configurez Codeium pour les fichiers non critiques et Copilot pour les fichiers principaux.

---

## Tabnine {#tabnine}

<span class="badge-intermediate">Intermédiaire</span>

**Tabnine** ([tabnine.com](https://www.tabnine.com)) est un assistant IA orienté **confidentialité et entreprise**, avec option de modèle local (sans cloud).

### Avantages par rapport à Copilot

- Modèle local disponible (tier Pro) — zéro donnée envoyée en cloud
- Ne s'entraîne pas sur votre code (garantie contractuelle)
- Tier gratuit incluant la complétion de base

### Installation

=== "Visual Studio Code"
    Extensions → rechercher **"Tabnine"** → Install → créer un compte.

=== "IntelliJ IDEA"
    **Settings → Plugins → Marketplace** → "Tabnine AI Code Completion" → Install.

!!! info "Cas d'usage idéal"
    Tabnine est particulièrement utile dans les environnements **enterprise avec contraintes de conformité** où les données ne peuvent pas quitter la machine, tout en voulant garder Copilot pour les tâches exploratoires.

---

## Amazon Q Developer {#amazon-q}

<span class="badge-beginner">Débutant</span>

**Amazon Q Developer** ([aws.amazon.com/q/developer](https://aws.amazon.com/q/developer/)) est l'assistant IA d'AWS, anciennement **CodeWhisperer**. Il dispose d'un **tier gratuit généreux**.

### Tier gratuit

| Fonctionnalité | Inclus gratuitement |
|----------------|---------------------|
| Complétion inline | Illimitée |
| Chat (Q Chat) | 25 interactions/mois |
| Scan de sécurité | 50 scans/mois |
| Transformation de code | Limitée |

### Installation

=== "Visual Studio Code"

    1. Extensions → rechercher **"AWS Toolkit"**
    2. Installer → se connecter avec un compte AWS Builder ID (gratuit, pas besoin d'AWS payant)
    3. Q Developer est intégré dans le toolkit

=== "IntelliJ IDEA"

    1. **Settings → Plugins → Marketplace** → **"AWS Toolkit"** → Install
    2. Se connecter depuis la toolbar AWS → Builder ID

!!! tip "Idéal pour les projets AWS"
    Amazon Q a une connaissance native des services AWS (Lambda, S3, DynamoDB, CDK…). Sur les projets cloud AWS, il surpasse souvent Copilot sans consommer de premium requests.

---

## Supermaven {#supermaven}

<span class="badge-intermediate">Intermédiaire</span>

**Supermaven** ([supermaven.com](https://supermaven.com)) se démarque par une **fenêtre de contexte de 300 000 tokens** pour la complétion de code — bien au-delà de la plupart des concurrents. Son modèle propriétaire est optimisé pour la vitesse.

### Avantages

- Complétion inline ultra-rapide (latence < 250 ms)
- Contexte de 300K tokens — comprend des fichiers entiers
- Tier gratuit incluant la complétion de base sans limite de quota

### Installation

=== "Visual Studio Code"
    Extensions → **"Supermaven"** → Install → se connecter sur supermaven.com.

=== "IntelliJ IDEA"
    **Settings → Plugins → Marketplace** → **"Supermaven"** → Install.

---

## Récapitulatif : quel outil pour quelle situation

| Scénario | Outil recommandé | Premium requests économisées |
|----------|-----------------|------------------------------|
| Chat exploratoire simple | Continue.dev + Ollama local | **100%** |
| Génération de code boilerplate | Supermaven ou Codeium (complétion) | **100%** |
| Debug guidé avec contexte riche | RTK AI + GPT-4o mini | **~80%** |
| Projet cloud AWS | Amazon Q Developer (tier gratuit) | **100%** |
| Environnement sans internet | Ollama + LM Studio + Continue | **100%** |
| Entreprise, données sensibles | Tabnine local | **100%** |
| Analyse d'architecture complexe | Copilot + Claude 3.5 Sonnet | 0% (justifié) |

!!! success "Règle d'or"
    **Commencez toujours par le gratuit.** Si la réponse est insuffisante, montez en gamme vers un modèle premium. Ne partez jamais directement de Claude ou o3 pour une question à laquelle GPT-4o mini peut répondre.

---

## Prochaine étape

**[Comparaison des Outils](comparaison.md)** : tableau de référence pour choisir le bon outil selon l'IDE, le type de tâche et les contraintes (connexion, confidentialité, budget).

Points couverts :

- **Par IDE** — quelle stack pour VS Code, quelle stack pour IntelliJ
- **Par type de tâche** — quel outil pour quelle complexité de problème
- **Économies estimées** — impact mesuré par combinaison d'outils
- **Décision rapide** — arbre de décision pour choisir en 30 secondes
