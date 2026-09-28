# JetBrains / IntelliJ IDEA — installer GitHub Copilot

<span class="badge-intellij">IntelliJ IDEA</span> <span class="badge-beginner">Débutant</span>

!!! info "Référence Copilot conservée"
    Le parcours principal du dépôt est désormais **Claude Code**. Cette page reste maintenue pour les équipes utilisant GitHub Copilot dans IntelliJ IDEA et les autres IDE JetBrains pris en charge.

GitHub Copilot pour JetBrains fournit les suggestions de code, le chat et plusieurs fonctions agentiques. Leur disponibilité exacte dépend de la version du plugin, du plan Copilot et des politiques de l'organisation.

---

## Prérequis

- un compte GitHub avec accès à Copilot, y compris **Copilot Free** ou un plan payant ;
- une connexion Internet ;
- un IDE JetBrains actuellement compatible ;
- la version du plugin Copilot compatible avec votre IDE ;
- les politiques de votre organisation autorisant Copilot si le compte est géré.

!!! warning "Compatibilité : vérifier le Marketplace"
    Ne considérez pas `IntelliJ 2024.1+` comme un prérequis universel et permanent. GitHub renvoie désormais vers la fiche **GitHub Copilot Versions** du JetBrains Marketplace pour la compatibilité exacte entre IDE et plugin. Utilisez de préférence la dernière version stable compatible.

Les IDE actuellement cités par GitHub incluent notamment IntelliJ IDEA, Android Studio, CLion, DataGrip, DataSpell, GoLand, PhpStorm, PyCharm, Rider, RubyMine, RustRover et WebStorm.

---

## Installation du plugin

1. Ouvrez votre IDE JetBrains.
2. Accédez à **Settings/Preferences → Plugins**.
3. Ouvrez l'onglet **Marketplace**.
4. Recherchez **GitHub Copilot**.
5. Vérifiez que le plugin est publié par GitHub.
6. Cliquez **Install**.
7. Redémarrez l'IDE lorsque cela est demandé.

---

## Connexion à GitHub

Après redémarrage :

1. ouvrez **Tools → GitHub Copilot → Login to GitHub** ;
2. utilisez **Copy and Open** pour ouvrir la page d'activation ;
3. collez le device code ;
4. connectez-vous au bon compte GitHub ;
5. autorisez le plugin ;
6. revenez dans l'IDE et confirmez la connexion.

Pour les comptes gérés sur GHE.com, consultez la procédure GitHub dédiée avant l'authentification.

---

## Vérification rapide

Testez séparément :

1. **complétion inline** dans un petit fichier ;
2. **Chat** sur du code déjà présent ;
3. **Agent/Edit mode** uniquement si la fonction est disponible dans votre version ;
4. **diff + build/tests** après toute modification proposée.

La présence du plugin ne garantit pas que toutes les fonctions de la matrice Copilot sont activées : le plan, les politiques d'organisation et le canal stable/preview peuvent modifier l'expérience.

---

## État des fonctions JetBrains

GitHub publie une **Copilot feature matrix** par IDE et par version de plugin. À la date de cette révision, JetBrains prend en charge notamment :

- code completion ;
- Chat ;
- Agent mode ;
- Edit mode ;
- MCP ;
- checkpoints ;
- code review ;
- workspace indexing.

Plusieurs personnalisations sont encore indiquées **Preview** dans la matrice courante, notamment selon la version :

- custom instructions ;
- custom agents ;
- prompt files ;
- agent skills ;
- next edit suggestions ;
- certaines fonctions BYOK/vision.

Ne présentez donc pas l'ensemble des capacités JetBrains comme strictement équivalentes à VS Code.

---

## Réglages essentiels après installation

Dans **Settings → Tools → GitHub Copilot** :

- contrôlez le compte connecté ;
- vérifiez le canal de mise à jour ;
- activez/désactivez les complétions par langage si nécessaire ;
- vérifiez les fonctions preview autorisées par votre organisation ;
- revoyez les raccourcis dans **Settings → Keymap** plutôt que de supposer un mapping universel.

---

## Sécurité minimale

- n'installez que le plugin officiel ;
- relisez les diffs ;
- évitez les secrets dans les prompts et logs ;
- gardez les permissions agentiques minimales ;
- contrôlez les dépendances proposées ;
- compilez, testez et appliquez les contrôles CI/Sonar/SAST habituels.

---

## Claude Code dans JetBrains

Pour le parcours principal de cette documentation :

**[Claude Code — Installation CLI, VS Code et JetBrains](../../chapitre-3b-claude-code-migration-copilot/installation.md)**

Le plugin JetBrains Claude Code et la CLI ont leur propre modèle de configuration ; ne supposez pas qu'un réglage Copilot est automatiquement transposable à Claude.

---

## Sources

- [GitHub Docs — Installing the GitHub Copilot extension in your environment](https://docs.github.com/en/copilot/how-tos/set-up/install-copilot-extension) — consulté le 2026-09-28
- [GitHub Docs — Copilot feature matrix](https://docs.github.com/en/copilot/reference/copilot-feature-matrix) — consulté le 2026-09-28
- [GitHub Docs — Configuring GitHub Copilot in your environment](https://docs.github.com/en/copilot/how-tos/configure-personal-settings/configure-in-ide) — consulté le 2026-09-28

## Prochaine étape

**[Référence Copilot JetBrains](reference.md)** pour les fichiers de configuration, capacités et diagnostics version-safe.