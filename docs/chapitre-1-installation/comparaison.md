# Comparaison — Installation IntelliJ vs VS Code

## Présentation
Cette page compare les deux expériences d'installation de GitHub Copilot côte à côte : IntelliJ IDEA et Visual Studio Code. Utile si vous utilisez les deux IDEs ou si vous aidez un collègue à choisir où commencer.

---

## Tableau comparatif complet

| Critère | IntelliJ IDEA | Visual Studio Code |
|---------|:-------------:|:-----------------:|
| **Version minimale requise** | 2023.1 | 1.80 |
| **Source d'installation** | JetBrains Marketplace (intégré) | VS Code Marketplace (intégré) |
| **Nombre d'extensions à installer** | 1 (plugin tout-en-un) | 2 (Copilot + Copilot Chat séparés) |
| **Authentification** | Tools → GitHub Copilot → Login | Pop-up automatique post-installation |
| **Code de vérification** | Oui (copier-coller dans le navigateur) | Oui (redirection automatique) |
| **Redémarrage requis** | Oui (obligatoire) | Non (rechargement de fenêtre suffit) |
| **Temps d'installation total** | ~5-8 min | ~3-5 min |
| **Copilot Chat inclus** | Oui (dans le plugin) | Non (extension séparée) |
| **Icône dans la barre d'état** | Oui (barre d'état IntelliJ) | Oui (barre de statut VS Code) |
| **Test de vérification** | Fichier Java + commentaire | Tout type de fichier + commentaire |

---

## Différences d'authentification

### IntelliJ IDEA

L'authentification est **semi-manuelle** :

1. Copilot affiche un code dans une fenêtre dialogue de l'IDE
2. Vous copiez le code manuellement
3. Vous ouvrez le navigateur et collez le code sur `github.com/login/device`
4. Vous autorisez l'application et revenez dans l'IDE

### VS Code

L'authentification est **automatisée** :

1. VS Code ouvre automatiquement votre navigateur
2. La redirection vers GitHub est pré-configurée
3. Vous autorisez, VS Code est notifié automatiquement
4. Aucun copier-coller de code nécessaire

!!! tip "Quelle méthode est préférable ?"
    La méthode VS Code est plus fluide, mais les deux aboutissent exactement au même résultat. Sur réseau d'entreprise avec proxy, la méthode IntelliJ peut être plus fiable car elle n'implique pas de redirection automatique.

---

## Différences d'expérience au quotidien

| Aspect | IntelliJ | VS Code |
|--------|----------|---------|
| **Suggestions inline** | Même expérience (++"Tab"++ pour accepter) | Même expérience (++"Tab"++ pour accepter) |
| **Chat Copilot** | Panneau latéral intégré | Panneau latéral (extension séparée) |
| **Menu contextuel** | *GitHub Copilot → Explain/Fix/Tests* | *Copilot → Explain/Fix/Tests* |
| **Personnalisation (instructions, agents)** | Non supporté nativement | Supporté nativement `.github/` |
| **Qualité des suggestions** | Excellente pour Java/Kotlin/JVM | Excellente pour JS/TS/Python et tous langages |
| **Impact mémoire** | Modéré (s'ajoute à l'IDE lourd) | Faible (VS Code est léger) |

---

## Compatibilité avec la suite JetBrains

Le plugin GitHub Copilot fonctionne sur **tous les IDEs de la suite JetBrains** avec la même procédure d'installation :

| IDE JetBrains | Domaine principal | Compatible Copilot |
|---------------|-------------------|:-----------------:|
| IntelliJ IDEA | Java, Kotlin | ✅ |
| PyCharm | Python | ✅ |
| WebStorm | JavaScript, TypeScript | ✅ |
| GoLand | Go | ✅ |
| Rider | C#, .NET | ✅ |
| CLion | C, C++ | ✅ |
| DataGrip | SQL, Databases | ✅ (limité) |
| Android Studio | Android, Kotlin | ✅ (via plugin) |

---

## Pièges spécifiques par IDE

=== ":simple-intellijidea: IntelliJ IDEA"

    - Oublier de redémarrer l'IDE après installation → les suggestions ne fonctionnent pas
    - Plugin installé sur une version IntelliJ trop ancienne (< 2023.1)
    - Conflit avec Tabnine ou d'autres plugins d'IA actifs simultanément
    - Proxy d'entreprise bloquant le navigateur → utiliser la méthode manuelle du code

=== ":material-microsoft-visual-studio-code: Visual Studio Code"

    - Installer l'extension Copilot globalement mais n'avoir que des suggestions pour certains langages → vérifier `github.copilot.enable`
    - Oublier d'installer **Copilot Chat** (extension séparée)
    - Proxy d'entreprise bloquant la redirection OAuth → configurer `http.proxy` dans les settings VS Code
    - Conflit entre la complétion Copilot et IntelliSense → ajuster la priorité dans les settings

---

## Recommandation selon le contexte

| Contexte | Recommandation |
|----------|----------------|
| **Projet Java / Kotlin** | IntelliJ IDEA en IDE principal, VS Code optionnel |
| **Projet JavaScript / TypeScript** | VS Code recommandé, WebStorm alternatif |
| **Projet Python** | VS Code ou PyCharm selon vos habitudes |
| **Personnalisation avancée (agents, instructions)** | VS Code obligatoire pour les features `.github/` |
| **Utilisation en entreprise avec proxy strict** | IntelliJ (auth plus robuste sur proxy) |
| **Ressources machine limitées (RAM < 8 Go)** | VS Code (plus léger qu'IntelliJ) |

