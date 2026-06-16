# Stack prête en 15 min — VS Code

<span class="badge-beginner">Débutant</span> <span class="badge-vscode">VS Code</span>

Cette stack vise un objectif simple: te donner un environnement de travail
local-first en moins de 15 minutes. Tu gardes les crédits IA pour les
cas complexes, et tu délègues le quotidien à des outils légers.

---

## Prérequis

- VS Code installé
- Accès internet pour l'installation initiale
- Au moins 8 Go de RAM pour un modèle local confortable
- Un compte Continue.dev si tu veux aussi un routage cloud optionnel

!!! tip "Stack cible"
    Pour cette version rapide, la combinaison recommandée est:
    **[Ollama](ollama.md)** + **[Continue.dev](continue-dev.md)** + **[RTK](rtk.md)**.

---

## Étape 1 — Installer Ollama

1. Télécharger Ollama depuis son site officiel.
2. Installer l'application.
3. Lancer un modèle local de démarrage.

```powershell
ollama run mistral
```

4. Laisser le serveur local disponible sur `http://localhost:11434`.

---

## Étape 2 — Installer Continue.dev

1. Ouvrir les extensions de VS Code.
2. Installer **Continue**.
3. Ouvrir le panneau Continue dans la barre latérale.
4. Configurer un modèle local via Ollama.

Exemple minimal:

```json
{
  "models": [
    {
      "title": "Chat local",
      "provider": "ollama",
      "model": "mistral",
      "apiBase": "http://localhost:11434"
    }
  ]
}
```

---

## Étape 3 — Ajouter RTK au terminal

RTK sert à filtrer les sorties CLI avant de les partager dans un chat IA.
Dans cette stack, son rôle est simple: réduire le bruit avant analyse.

Exemple:

```powershell
rtk npm test
rtk git diff
rtk rg "PaymentTimeout" src
```

---

## Étape 4 — Valider la stack

Teste ces 3 usages avant de considérer la stack opérationnelle:

1. **Chat simple** dans Continue.dev
   - demander l'explication d'un fichier
2. **Sortie terminal filtrée** avec RTK
   - comparer un log brut et un log compressé
3. **Modèle local** via Ollama
   - vérifier qu'un prompt simple répond sans cloud

!!! success "Critère de validation"
    La stack est valide si tu peux: expliquer un fichier, filtrer un log, et
    obtenir une réponse locale sans consommer de crédits IA.

---

## Ce que cette stack couvre

- Questions simples sur le code
- Génération de brouillons de tests
- Explication de fichiers ou fonctions
- Nettoyage de logs et de diffs

Elle ne remplace pas Copilot pour:

- Les refactorings multi-fichiers complexes
- Les décisions d'architecture ambigües
- Les sujets qui demandent un raisonnement profond et long

---

## Quand passer à Copilot

Passe à Copilot Chat ou Agent quand:

- plusieurs modules doivent être modifiés ensemble
- le contexte est trop large pour un modèle local
- tu veux une solution plus robuste sur un cas critique

!!! info "Bonne règle"
    Si Continue + Ollama + RTK ne suffit pas, monte d'abord en précision de
    contexte avant de monter en puissance de modèle.

---

## Sources

- VS Code extensions: [Continue sur Marketplace](https://marketplace.visualstudio.com/items?itemName=Continue.continue) (consultée le 2026-06-07)
- Documentation officielle: [Continue Docs](https://docs.continue.dev/) (consultée le 2026-06-07)
- Site officiel: [Continue](https://www.continue.dev/) (consultée le 2026-06-07)
- Site officiel: [Ollama](https://ollama.com/) (consultée le 2026-06-07)
- Documentation officielle: [Ollama GitHub](https://github.com/ollama/ollama) (consultée le 2026-06-07)

---

## Prochaine étape

**[Stack prête en 15 min — IntelliJ](stack-prete-15-min-intellij.md)** : adapter le même principe local-first à IntelliJ IDEA.

Concepts clés couverts :

- **Installation rapide** - démarrer sans reconfigurer tout le projet
- **Chat local** - garder les prompts simples hors quota
- **Filtrage terminal** - réduire les logs avant analyse
- **Validation de base** - vérifier que la stack répond à 3 usages majeurs
