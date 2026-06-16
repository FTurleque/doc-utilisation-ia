# Stack prête en 15 min — IntelliJ

<span class="badge-beginner">Débutant</span> <span class="badge-intellij">IntelliJ</span>

Cette stack reprend le même socle local-first que la version
[VS Code](stack-prete-15-min-vscode.md), mais en profitant des forces
natives d'IntelliJ pour le diagnostic et le refactoring. L'objectif est de
rester autonome pour le quotidien, tout en gardant Copilot pour les cas les
plus complexes.

---

## Prérequis

- IntelliJ IDEA installée
- Accès internet pour l'installation initiale
- Plugin SonarQube for IDE (recommandé)
- Ollama disponible en local
- Plugin Continue.dev installé
- RTK disponible pour le terminal

!!! tip "Ordre recommandé"
    Commence par les outils natifs IntelliJ, puis ajoute **[Continue.dev](continue-dev.md)** et **[Ollama](ollama.md)** pour le chat local.

---

## Parallèle avec VS Code

Cette page suit la même logique que la version VS Code : Ollama pour le
modèle local, Continue.dev pour le chat, puis RTK pour réduire le bruit du
terminal. La différence principale est qu'IntelliJ ajoute ses inspections,
ses refactorings natifs et, si besoin, SonarQube for IDE.

=== "IntelliJ IDEA"
    - Corriger et refactorer avec les outils natifs avant toute IA distante.
    - Utiliser SonarQube for IDE pour détecter les issues locales et proposer
      des quick fixes sur les règles compatibles.
    - Activer Connected Mode ou MCP Sonar seulement si l'équipe en a besoin.

=== "Visual Studio Code"
    - Conserver la même base locale : Ollama + Continue.dev + RTK.
    - S'appuyer davantage sur les extensions pour l'analyse et les refactorings.
    - Suivre le playbook dédié dans [Stack prête en 15 min — VS Code](stack-prete-15-min-vscode.md).

---

## Étape 1 — Installer les plugins

1. Ouvrir **Settings -> Plugins -> Marketplace**.
2. Installer **Continue**.
3. Installer **SonarQube for IDE** (éditeur SonarSource).
4. Redémarrer l'IDE.
5. Vérifier que la barre latérale Continue est disponible.
6. Vérifier que la fenêtre SonarQube est visible et qu'une issue locale remonte sur un fichier Java.

!!! tip "Validation rapide Sonar"
    Place le curseur sur une issue Sonar compatible puis utilise `Alt+Enter` pour vérifier si un Quick Fix est proposé.

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

## Étape 6 (optionnelle) — Connected Mode Sonar

Active ce mode seulement si ton équipe dispose d'un serveur SonarQube Cloud/Server.

1. Ouvre les paramètres SonarQube for IDE.
2. Configure la connexion avec un token utilisateur.
3. Lie le projet (bind) et vérifie la synchro des règles.

!!! warning "Promesse réaliste"
    L'installation plugin + analyse locale entre souvent dans 15 minutes. La configuration Connected Mode complète dépend de l'infrastructure entreprise.

## Étape 7 (avancée) — MCP Sonar

Ne configure MCP Sonar qu'en niveau avancé, après validation du workflow local.

- Priorité : détection + correction déterministe.
- MCP : utile pour triage/correction multi-issues à périmètre borné.
- Vérifier la compatibilité réelle de ton plugin Copilot JetBrains avant configuration.

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

Concepts clés couverts :

- **Natif avant IA** - exploiter les inspections et refactorings
- **Chat local** - conserver les questions simples hors quota
- **Terminal filtré** - limiter le bruit des commandes
- **Passage à Copilot** - savoir quand monter en puissance
