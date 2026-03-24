# Performance & Ressources

<span class="badge-beginner">Débutant</span>

## Impact de Copilot sur l'IDE

GitHub Copilot envoie du contexte à un serveur distant et reçoit des suggestions — ce processus consomme des ressources locales (CPU, RAM, réseau) et peut impacter les performances de l'IDE si mal configuré.

---

## Profil de consommation par IDE

| Ressource | IntelliJ (plugin) | VS Code (extension) | Notes |
|-----------|-------------------|---------------------|-------|
| RAM supplémentaire | +150–300 MB | +80–150 MB | Dépend du contexte ouvert |
| CPU (suggestions actives) | 5–15% | 3–10% | Pics lors de l'analyse PSI |
| CPU (inactif) | <1% | <1% | Background minimal |
| Latence réseau | 200–800 ms | 200–800 ms | Même API, même infrastructure |
| Bande passante | Faible (<1 MB/h) | Faible (<1 MB/h) | Texte compressé uniquement |

!!! info "IntelliJ consomme plus de RAM"
    L'analyse PSI (Programme Structure Interface) d'IntelliJ est plus approfondie que le parsing VS Code. Elle offre plus de contexte sémantique mais coûte plus en mémoire.

---

## Causes fréquentes de ralentissement

### 1. Grands fichiers ouverts

Copilot envoie le contenu des fichiers ouverts comme contexte. Un fichier de 5000+ lignes peut saturer la fenêtre de contexte et ralentir les suggestions.

**Solutions :**

1. **Fermer les onglets non utilisés** — c'est la mesure la plus efficace. Chaque onglet ouvert est du contexte supplémentaire envoyé à Copilot.

2. **Désactiver pour les types de fichiers peu utiles** :

```json
// .vscode/settings.json
{
    "github.copilot.enable": {
        "*": true,
        "markdown": false,
        "plaintext": false,
        "xml": false,
        "log": false
    }
}
```

3. Dans IntelliJ : **Settings → GitHub Copilot → Disabled for Languages** pour désactiver les langages peu utilisés activement.

### 2. Délai de suggestion trop bas

Un délai très court (< 200 ms) déclenche beaucoup de requêtes fréquentes, surtout sur les connexions lentes.

=== ":material-microsoft-visual-studio-code: VS Code"
    ```json
    // .vscode/settings.json
    {
        "editor.quickSuggestionsDelay": 300,
        "github.copilot.editor.enableAutoCompletions": true
    }
    ```
    Il n'y a pas de paramètre `delay` direct dans Copilot VS Code — la latence dépend de `quickSuggestionsDelay`.

=== ":simple-intellijidea: IntelliJ"
    **Settings → GitHub Copilot → Completion Delay (ms)**
    
    Valeur recommandée : **300–500 ms** pour un équilibre réactivité/performance.
    
    Valeur conservative : **700–1000 ms** si l'IDE rame.

### 3. Suggestions dans des fichiers non-code

Copilot peut s'activer dans des fichiers de configuration (JSON, YAML, XML) ou de documentation (Markdown). Ces suggestions sont souvent de faible valeur et consomment des ressources.

```json
// .vscode/settings.json — Désactiver pour les types non essentiels
{
    "github.copilot.enable": {
        "*": true,
        "markdown": false,
        "plaintext": false,
        "xml": false
    }
}
```

---

## Stratégies d'optimisation

### Désactivation contextuelle

**VS Code** — Via la barre de statut :
1. Cliquez sur l'icône Copilot dans la barre bleue en bas
2. **"Disable Completions"** → Globalement ou pour le langage courant

**IntelliJ** :
1. Icône Copilot dans la status bar en bas à droite
2. **"Disable GitHub Copilot completions"**

### Optimisation mémoire pour IntelliJ

Si IntelliJ est globalement lent avec Copilot actif :

1. **Help → Edit Custom VM Options**
2. Augmentez `-Xmx` (mémoire max JVM) :
   ```
   -Xmx4096m   # si vous avez 16 GB RAM
   -Xmx6144m   # si vous avez 32 GB RAM
   ```
3. Redémarrez IntelliJ

!!! tip "RAM recommandée pour IntelliJ + Copilot"
    Minimum confortable : **16 GB RAM** total. En dessous, des ralentissements sont normaux sur de gros projets.

### Réduire le contexte envoyé

Plus les fichiers ouverts sont nombreux et grands, plus le contexte est lourd. Stratégies pratiques :

| Action | Impact sur performance |
|--------|----------------------|
| Fermer les onglets non utilisés | Élevé — réduit le contexte |
| Fermer les projets secondaires | Élevé (IntelliJ multi-projets) |
| Utiliser `.copilotignore` | Moyen — exclut les fichiers |
| Travailler par modules | Moyen — moins de fichiers actifs |

### Mode hors-ligne pour les sessions intensives

Si vous travaillez sur une nouvelle fonctionnalité et avez besoin de concentration maximale sans interruption de l'IDE, désactivez temporairement Copilot :

=== ":material-microsoft-visual-studio-code: VS Code"
    ++ctrl+shift+p++ → `GitHub Copilot: Disable Completions`
    
    Ou ++ctrl+shift+p++ → `GitHub Copilot: Toggle Completions`

=== ":simple-intellijidea: IntelliJ"
    Clic sur l'icône Copilot dans la status bar → **Disable GitHub Copilot**

---

## Surveillance de la performance

### VS Code — Outils de diagnostic

```
Help → Developer Tools (F12) → Performance tab
```

Ou dans le terminal :
```bash
# Code --prof lance VS Code en mode profilage
code --prof
```

Vérifiez dans **Output** (++ctrl+shift+u++) → sélectionnez **GitHub Copilot** dans le dropdown pour voir les logs de l'extension.

### IntelliJ — Diagnostics

```
Help → Diagnostics Tools → Record Freezes
Help → Show Log in Explorer    # Ouvre idea.log
```

Dans `idea.log`, cherchez les lignes contenant `Copilot` pour identifier les erreurs ou la latence.

---

## Configuration recommandée selon le contexte

| Contexte | IntelliJ | VS Code | Notes |
|----------|----------|---------|-------|
| Machine puissante (32 GB+) | Tout actif | Tout actif | Expérience optimale |
| Machine standard (16 GB) | Delay 400ms | Defaults | Bon équilibre |
| Machine modeste (8 GB) | Delay 700ms, auto-disabled on large files | Désactiver pour markdown/yaml | Activer à la demande |
| Réseau lent | Delay 600ms | Delay via quickSuggestionDelay | Réduire la fréquence |
| CI/CD ou build actif | Suspendre Copilot | Suspendre Copilot | Libérer CPU/RAM |

---

## Maîtriser la consommation MCP

Activer des MCPs multiplie mécaniquement le nombre de requêtes et les tokens consommés. Il est important de comprendre ces deux impacts avant de configurer plusieurs serveurs.

**1. Chaque appel d'outil MCP = 1 requête**

Chaque invocation d'outil MCP (interroger Jira, rechercher dans la doc, exécuter une requête SQL) est comptabilisée comme une requête individuelle dans le compteur GitHub Copilot, au même titre qu'une question dans le Chat.

**2. La réponse MCP est injectée dans la fenêtre de contexte → tokens consommés**

Le résultat retourné par le serveur (liste de tickets, rapport SonarQube, page de documentation) est transmis directement au modèle dans la **fenêtre de contexte**. Plus la réponse est volumineuse, plus elle consomme de tokens — réduisant l'espace disponible pour votre code.

**Exemple d'escalade en mode Agent**

| Étape | Déclencheur | Requêtes | Tokens estimés |
|-------|-------------|----------|----------------|
| 1 | Question : « Analyse ce composant et ouvre un ticket Jira » | +1 | ~500 |
| 2 | Appel MCP SonarQube → rapport d'analyse | +1 | +800 |
| 3 | Appel MCP Jira → liste des projets | +1 | +300 |
| 4 | Appel MCP Jira → création du ticket | +1 | +200 |
| **Total** | | **4 requêtes** | **~1 800 tokens** |

Sans MCP, la même demande : **1 requête**, ~500 tokens.

!!! warning "Effet multiplicateur en mode Agent"
    En mode Agent, Copilot peut enchaîner plusieurs appels MCP automatiquement sans confirmation. Un agent face à une tâche ambiguë peut multiplier les appels silencieusement. Gardez `Auto-approve` désactivé pendant la prise en main et activez uniquement les MCPs réellement utiles.

### Bonnes pratiques

- **Activez uniquement les MCPs dont vous avez besoin** — chaque serveur enregistré est potentiellement invoqué par l'agent dès qu'il juge cela pertinent.
- **Formulez des requêtes ciblées** — précisez « Analyse uniquement `OrderService.java` » plutôt que « Analyse tout ».
- **Préférez les MCPs avec réponses compactes** — 50 lignes JSON coûtent moins qu'une page HTML entière.
- **Vérifiez le compteur d'utilisation** via [github.com/settings/copilot](https://github.com/settings/copilot) si vous êtes sur un plan avec quota.
- **N'utilisez pas un MCP pour parcourir votre propre code** (voir section suivante).

### MCP et code browsing — votre code local n'a pas besoin de MCP

Le terme **code browsing** désigne la capacité de naviguer dans le code source d'un projet : lire des fichiers, rechercher des symboles, explorer l'arborescence, identifier les dépendances entre classes.

En mode Agent, Copilot dispose déjà d'**outils intégrés** pour faire exactement cela sur votre workspace local, sans passer par MCP et sans consommation de requêtes supplémentaires. Créer un MCP qui expose votre code local revient à dupliquer ce que l'agent fait nativement, avec un surcoût : un serveur à lancer, une sérialisation JSON, et une requête MCP à chaque lecture.

**La règle d'or — quoi accéder via MCP vs nativement**

| Ressource | Accès recommandé |
|-----------|------------------|
| Votre code, vos fichiers locaux | Accès natif de l'agent (0 MCP) |
| Base de données distante | MCP DB (ex. DBHub) |
| Tickets Jira / Confluence | MCP Atlassian |
| Documentation externe volumineuse | MCP Context7, Microsoft Docs |
| Rapport qualité SonarQube | MCP SonarQube |

Context7 apporte une vraie valeur en **sélectionnant les extraits pertinents** dans une documentation de 10 000 pages — ce qu'un agent ne peut pas faire nativement. Un MCP qui lit vos fichiers locaux, lui, est inutile et coûteux.

### Accéder à des fichiers hors du projet courant

Une question fréquente : peut-on demander à Copilot de consulter des fichiers en dehors du projet ouvert, en donnant un chemin absolu (ex. `C:\\projets\\autre-projet\\src\\Service.java`) ?

**En mode Chat (référence manuelle) — Oui**

Vous pouvez attacher n'importe quel fichier accessible sur votre système en utilisant :

=== "VS Code"
    - **`#file:`** dans le chat : tapez `#file:` puis entrez le chemin absolu du fichier
    - **Glisser-déposer** le fichier depuis l'explorateur système directement dans la fenêtre de chat
    - **Ouvrir le fichier** dans l'IDE et le mentionner avec `#editor`

=== "IntelliJ IDEA"
    - **Ouvrir le fichier** dans l'IDE (File → Open) puis le mentionner dans le chat Copilot
    - Utiliser le bouton **Attach file** dans la fenêtre de chat Copilot

**En mode Agent (navigation autonome) — Limité au workspace**

L'agent peut lire et modifier des fichiers **uniquement dans les dossiers du workspace ouvert**. Il ne navigue pas de façon autonome en dehors, même avec un chemin absolu dans la demande. C'est une contrainte de sécurité intentionnelle : sans cette limite, l'agent pourrait accéder à des fichiers sensibles hors du projet (clés SSH, `.env` d'autres projets, etc.).

!!! tip "Astuce — Ajouter un dossier externe au workspace"
    Pour qu'un agent accède de façon autonome à un autre projet ou dossier, ajoutez-le au workspace courant :

    === "VS Code"
        **Fichier → Ajouter un dossier à l'espace de travail** (multi-root workspace). L'agent aura alors accès natif à ce dossier comme s'il faisait partie du projet.

    === "IntelliJ IDEA"
        **File → New → Module from Existing Sources** pour intégrer un module externe au projet IntelliJ. Le code devient alors accessible à l'index PSI et donc à l'agent.

---

## En résumé

- **Fermer les onglets inutilisés** est la mesure de performance la plus simple et la plus efficace
- **16 GB RAM minimum** recommandé pour IntelliJ + Copilot sur des projets moyens
- **Désactiver pour markdown/plaintext/xml** réduit les requêtes inutiles sans impact sur le workflow
- **Augmenter `-Xmx`** dans les VM Options IntelliJ si vous avez plus de 16 GB RAM disponibles
- Consultez le **tableau de configuration** selon votre profil machine pour trouver le bon équilibre

---

## Prochaines étapes

- [Troubleshooting](../chapitre-6-troubleshooting/index.md) — Résoudre les problèmes courants
- [Cas d'Usage](../chapitre-7-cas-usage/index.md) — Exemples par technologie
