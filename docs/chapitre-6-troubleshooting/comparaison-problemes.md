# Comparaison des Problèmes par IDE

Certains problèmes sont communs aux deux IDEs, d'autres sont spécifiques à l'architecture de chaque environnement. Ce tableau vous aide à orienter votre diagnostic.

---

## Problèmes communs aux deux IDEs

| Problème | Cause | Solution commune |
|----------|-------|-----------------|
| Aucune suggestion | Token expiré | Se reconnecter |
| Latence élevée | Réseau lent / proxy | Configurer proxy |
| Rate limit | Trop de requêtes | Attendre 1-2 min |
| Suggestions hors sujet | Contexte insuffisant | Ouvrir fichiers liés |
| Code généré non fonctionnel | Prompts imprécis | Reformuler + contexte |
| Chat sans réponse | Serveur GitHub dégradé | Vérifier githubstatus.com |

---

## Problèmes spécifiques à IntelliJ

| Problème | Cause | Solution |
|----------|-------|----------|
| Plugin non visible après installation | IDE redémarrage requis | Redémarrer IntelliJ |
| Suggestions bloquées en Power Save Mode | Mode économie énergie actif | File → Power Save Mode (désactiver) |
| IDE très lent après activation | JVM undersized | Augmenter `-Xmx` dans VM Options |
| `OutOfMemoryError` dans les logs | Heap insuffisant pour PSI + Copilot | Help → Edit Custom VM Options → `-Xmx4096m` |
| Autocomplétion IntelliJ et Copilot en conflit | Double suggestion | Ajuster la priorité dans les paramètres Keymap |
| Suggestions coupées à mi-chemin | PSI timeout | Simplifier le fichier ouvert, fermer onglets |
| Plugin Copilot incompatible avec la version IDE | Version plugin obsolète | Mettre à jour le plugin |
| Erreur SSL sur réseau d'entreprise | Certificat proxy non reconnu | Importer le certificat dans le keystore JVM |
| `.instructions.md` ignoré | Fonctionnalité absente dans IntelliJ | Utiliser `.idea/copilot-context.md` (partiel) |
| Mode Agent indisponible | Feature VS Code uniquement | Utiliser VS Code pour le mode Agent |

---

## Problèmes spécifiques à VS Code

| Problème | Cause | Solution |
|----------|-------|----------|
| Extension désactivée automatiquement | Conflits avec autre extension | Identifier et désactiver les conflits |
| Copilot Chat absent du panneau | Extension Chat non installée | Installer "GitHub Copilot Chat" séparément |
| Inline Chat (Ctrl+I) inactif | VS Code version < 1.83 | Mettre à jour VS Code |
| `.instructions.md` ignoré | Feature flag désactivé | Activer `github.copilot.chat.codeGeneration.useInstructionFiles` |
| `.agent.md` non reconnu | VS Code version ou Copilot Chat obsolète | Mettre à jour les deux |
| Mode Edits fermé sans raison | Bug d'interface | Réouvrir le panneau Copilot Edits |
| Suggestions désactivées pour un fichier | Fichier dans `.copilotignore` | Vérifier `.copilotignore` |
| Paramétrage `.vscode/settings.json` ignoré | Syntaxe JSON incorrecte | Valider avec un linter JSON |
| Extension ne se met pas à jour | Cache VS Code corrompu | `code --uninstall-extension GitHub.copilot` puis réinstaller |
| Crashs du Language Server | Conflit avec extension LSP tierce | Désactiver extensions LSP concurrentes |

---

## Comportements différents entre les IDEs

Ces comportements ne sont pas des bugs, mais des différences d'implémentation à connaître :

| Comportement | IntelliJ | VS Code | Notes |
|-------------|----------|---------|-------|
| Analyse du code | PSI sémantique | Token-based | IntelliJ comprend mieux la structure |
| Vitesse de suggestion | Légèrement plus lent | Plus rapide | PSI = plus de latence mais meilleure qualité |
| Contexte des imports | Analysé via PSI | Via fichiers ouverts | IntelliJ détecte mieux les dépendances |
| Support `.instructions.md` | ❌ Non supporté | ✅ Supporté | Feature VS Code uniquement |
| Support `.agent.md` | ❌ Non supporté | ✅ Supporté | Feature VS Code uniquement |
| Support `.prompt.md` | ❌ Non supporté | ✅ Supporté | Feature VS Code uniquement |
| Support `SKILL.md` | ❌ Non supporté | ✅ Supporté | Feature VS Code uniquement |
| Mode Agent (Chat) | ❌ Non disponible | ✅ Disponible | Feature VS Code uniquement |
| Copilot Edits multi-fichiers | ❌ Non disponible | ✅ Disponible | Feature VS Code uniquement |
| Inline Chat | ✅ Alt+Entrée | ✅ Ctrl+I | Noms différents |
| Raccourci accepter | ++tab++ | ++tab++ | Identique |
| Raccourci voir alternatives | ++alt+bracket-right++ | ++alt+bracket-right++ | Identique |
| Configuration proxy | JVM/IDE level | OS/settings.json | Approches différentes |
| Gestion multi-repo | Via modules IntelliJ | Via multi-root workspace | Philosophies différentes |

---

## Matrice de compatibilité des fonctionnalités

| Fonctionnalité | IntelliJ ≥ 2023.1 | VS Code ≥ 1.80 |
|---------------|-------------------|----------------|
| Inline completions | ✅ | ✅ |
| Copilot Chat | ✅ (intégré au plugin) | ✅ (extension séparée) |
| Inline Chat | ✅ | ✅ |
| `.instructions.md` | ❌ | ✅ (≥ 1.90) |
| Prompt files | ❌ | ✅ (≥ 1.91) |
| `.agent.md` | ❌ | ✅ (Preview) |
| `SKILL.md` | ❌ | ✅ (Preview) |
| Mode Agent (Ask/Edit/Agent) | ❌ | ✅ (≥ 1.90) |
| Copilot Edits | ❌ | ✅ (≥ 1.91) |
| Désactiver par langage | ✅ | ✅ |
| `.copilotignore` | ❌ | ✅ |

---

## Recommandations selon la situation

| Situation | Recommandation |
|-----------|---------------|
| Projet Java/Kotlin complexe | Préférez IntelliJ — le PSI offre un meilleur contexte |
| Personnalisation avancée (instructions, agents) | Utilisez VS Code — toutes les features sont disponibles |
| Performance machine limitée | VS Code consomme moins de RAM |
| Gestion de proxy d'entreprise | IntelliJ a une meilleure gestion du keystore JVM |
| Ateliers d'équipe sur les conventions | VS Code + `.instructions.md` partagées dans git |
| Développement multi-technologies | VS Code avec un workspace multi-root |

---

## Prochaines étapes

- [Cas d'Usage](../chapitre-7-cas-usage/index.md) — Configurations pratiques par technologie
- [Appendices FAQ](../appendices/faq.md) — Réponses rapides aux questions fréquentes
