# Continue.dev

<span class="badge-beginner">Débutant</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span>

Continue.dev est un assistant IA open source pour VS Code et JetBrains.
Son point fort: tu choisis le modèle (local ou cloud) selon la tâche,
sans être enfermé dans un seul fournisseur.

---

## À quoi sert Continue.dev

Continue.dev sert à orchestrer plusieurs usages dans l'IDE:

- **Chat contextualisé** sur un fichier, un dossier ou une base de code
- **Édition guidée** (refactoring, tests, documentation)
- **Autocomplétion** avec un modèle dédié
- **Routage de modèles** (ex: local pour simple, cloud pour complexe)

!!! info "Positionnement"
    Continue.dev ne remplace pas forcément Copilot partout. Il est excellent pour découpler les usages : modèle local pour le quotidien, modèle premium uniquement pour les cas difficiles.

---

## Quand l'utiliser

- Quand tu veux un chat local ou hybride dans l'IDE
- Quand tu veux choisir le modèle selon la tâche
- Quand tu veux réduire les crédits IA consommés par les questions simples

## Quand l'éviter

- Quand tu n'as pas encore d'endpoint local ou de provider configuré
- Quand la tâche demande une orchestration très simple sans chat
- Quand tu veux uniquement de la complétion inline et rien d'autre

---

## Mise en œuvre

### Installation

=== "Visual Studio Code"
    1. Ouvrir les extensions (++ctrl+shift+x++).
    2. Installer **Continue**.
    3. Ouvrir le panneau Continue dans la barre latérale.

=== "IntelliJ IDEA"
    1. Ouvrir **Settings -> Plugins -> Marketplace**.
    2. Rechercher **Continue** puis installer le plugin.
    3. Redémarrer l'IDE.

### Configuration minimale

Continue lit une configuration qui permet de séparer chat et autocomplétion.
Exemple type (à adapter selon ta version de config) :

```json
{
  "models": [
    {
      "title": "Chat local Mistral",
      "provider": "ollama",
      "model": "mistral",
      "apiBase": "http://localhost:11434"
    }
  ],
  "tabAutocompleteModel": {
    "title": "Complétion locale rapide",
    "provider": "ollama",
    "model": "starcoder2:3b"
  }
}
```

!!! tip "Avec quels outils le combiner"
    - **[Ollama](ollama.md)** pour un usage 100% local
    - **[LM Studio](lm-studio.md)** si tu préfères une interface graphique
    - **[RTK](rtk.md)** pour réduire le bruit des sorties terminal avant de les coller dans le chat

### Continue.dev et GitHub Copilot en parallèle

Oui, tu peux utiliser Continue.dev et GitHub Copilot en parallèle dans le
même IDE.

- **Configuration recommandée**: Copilot pour la complétion inline,
  Continue.dev pour le chat
- **Alternative**: Continue.dev pour le local-first, Copilot pour les cas
  complexes

!!! warning "Éviter les conflits de suggestions"
    Si plusieurs outils de complétion inline sont actifs en même temps, les
    suggestions peuvent se chevaucher. Garde un seul moteur principal de
    complétion inline et réserve les autres outils au chat.

---

## Cas d'usage pertinents

- **Explication de code**: "explique cette classe et ses dépendances"
- **Génération de tests**: produire un squelette de tests unitaires
- **Refactoring localisé**: renommer, simplifier, documenter une zone précise
- **Préparation de PR**: brouillon de description et checklist de vérification

Cas moins adaptés :

- Raisonnement architecture critique sans validation humaine
- Modifications massives multi-modules sans revue CI/tests

---

## Exploiter son plein potentiel

1. **Modèle par type de tâche**
   - Local (Ollama/LM Studio) pour Q/R simples et reformulation
   - Cloud pour debug complexe ou raisonnement long
2. **Contexte strictement utile**
   - Sélectionner seulement les fichiers concernés
   - Éviter d'envoyer des logs bruts non filtrés
3. **Workflow équipe**
   - Versionner une config commune
   - Définir un standard de prompts (objectif, contraintes, résultat attendu)
4. **Boucle de vérification**
   - Toujours valider avec tests, linter, build

---

## Exemple concret

```text
Contexte:
- Fichier: src/payment/checkout.ts
- Erreur: timeout sur provider externe

Demande à Continue:
"Propose un refactoring minimal pour isoler la gestion de timeout,
ajoute 3 tests unitaires, et garde le comportement actuel."
```

```bash
# Avant d'envoyer les logs à Continue, réduire le bruit
rtk npm test
```

---

## Résumé

Continue.dev sert de couche d'orchestration entre l'IDE et les modèles.
Il devient très puissant combiné avec un modèle local, des prompts courts,
et un filtrage du contexte avant toute analyse IA.

---

## Sources

- Documentation officielle: [Continue Docs](https://docs.continue.dev/) (consultée le 2026-06-07)
- Site officiel: [continue.dev](https://www.continue.dev/) (consultée le 2026-06-07)
- Dépôt officiel: [continuedev/continue](https://github.com/continuedev/continue) (consultée le 2026-06-07)
- Extension VS Code: [Continue sur Marketplace](https://marketplace.visualstudio.com/items?itemName=Continue.continue) (consultée le 2026-06-07)

---

## Prochaine étape

**[Ollama](ollama.md)** : lancer des modèles localement pour alimenter Continue.dev sans consommer de crédits IA.

Concepts clés couverts:

- **Exécution locale** - faire tourner un LLM sur ta machine
- **Choix de modèle** - adapter qualité, vitesse et RAM
- **API locale** - connecter l'IDE via `http://localhost:11434`
- **Confidentialité** - limiter la sortie de données vers le cloud
