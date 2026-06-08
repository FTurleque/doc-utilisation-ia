# Stack prête en 15 min — IntelliJ

<span class="badge-beginner">Débutant</span> <span class="badge-intellij">IntelliJ</span>

Cette stack donne à IntelliJ une base locale et pratique pour le chat,
le diagnostic et le filtrage de contexte. L'objectif est de rester autonome
pour le quotidien, tout en gardant Copilot pour les cas les plus complexes.

---

## Prérequis

- IntelliJ IDEA installée
- Accès internet pour l'installation initiale
- Ollama disponible en local
- Plugin Continue.dev installé
- RTK disponible pour le terminal

!!! tip "Ordre recommandé"
    Commence par les outils natifs IntelliJ, puis ajoute **[Continue.dev](continue-dev.md)** et **[Ollama](ollama.md)** pour le chat local.

---

## Étape 1 — Installer les plugins

1. Ouvrir **Settings -> Plugins -> Marketplace**.
2. Installer **Continue**.
3. Redémarrer l'IDE.
4. Vérifier que la barre latérale Continue est disponible.

---

## Étape 2 — Installer Ollama

1. Installer Ollama depuis le site officiel.
2. Lancer un modèle local.
3. Vérifier le service local sur `http://localhost:11434`.

```powershell
ollama run mistral
```

---

## Étape 3 — Brancher Continue.dev

Configurer Continue pour pointer vers Ollama.

```json
{
  "models": [
    {
      "title": "Chat local IntelliJ",
      "provider": "ollama",
      "model": "mistral",
      "apiBase": "http://localhost:11434"
    }
  ]
}
```

Ensuite, teste sur un fichier Java ou Kotlin pour:

- expliquer une classe
- proposer un refactoring simple
- générer un test unitaire brouillon

---

## Étape 4 — Activer RTK dans le terminal

RTK sert à nettoyer les sorties de build avant de les faire analyser.

```powershell
rtk gradle test
rtk git diff
rtk rg "IllegalStateException" src
```

---

## Étape 5 — Vérifier les inspections et refactorings

Avant toute IA distante, valide les gains natifs IntelliJ:

- `Analyze -> Inspect Code`
- `Refactor -> Rename`
- `Find Usages`
- `Navigate -> Class / Symbol`
- `Run tests`

!!! success "Critère de validation"
    La stack est valide si IntelliJ peut corriger, refactorer et tester sans
    prompt IA pour les cas locaux les plus simples.

---

## Ce que cette stack couvre

- Correction de warnings simples
- Diagnostic local de problèmes de compilation
- Explication de code ciblé
- Nettoyage de logs avant partage

Elle ne remplace pas Copilot pour:

- Les modifications multi-fichiers coordonnées
- Les décisions d'architecture longues
- Les cas qui exigent un contexte très large

---

## Quand garder Copilot

Garde Copilot pour:

- un refactoring transversal
- un bug qui touche plusieurs couches
- une tâche de conception ou de revue complexe

!!! info "Règle simple"
    IntelliJ natif d'abord, Continue.dev ensuite, Copilot en dernier recours.

---

## Sources

- Documentation officielle: [Continue Docs](https://docs.continue.dev/) (consultée le 2026-06-07)
- Site officiel: [Continue](https://www.continue.dev/) (consultée le 2026-06-07)
- Site officiel: [Ollama](https://ollama.com/) (consultée le 2026-06-07)
- Documentation officielle: [Ollama GitHub](https://github.com/ollama/ollama) (consultée le 2026-06-07)
- Plugin IntelliJ: [Continue sur JetBrains Marketplace](https://plugins.jetbrains.com/plugin/22794-continue) (consultée le 2026-06-07)

---

## Prochaine étape

**[Recommandations par application](recommandations-taille-type-application.md)** : adapter la stack aux tailles de codebase et aux types d'applications les plus courants.

Concepts clés couverts:

- **Natif avant IA** - exploiter les inspections et refactorings
- **Chat local** - conserver les questions simples hors quota
- **Terminal filtré** - limiter le bruit des commandes
- **Passage à Copilot** - savoir quand monter en puissance
