# Visual Studio Code — installer GitHub Copilot

<span class="badge-vscode">VS Code</span> <span class="badge-beginner">Débutant</span>

!!! info "Référence Copilot conservée"
    Le parcours principal de cette documentation est désormais **Claude Code**. Cette page reste maintenue pour les équipes qui utilisent GitHub Copilot, pour les environnements hybrides et pour permettre un retour à Copilot si l'offre redevient pertinente.

GitHub Copilot dans Visual Studio Code fournit notamment les suggestions de code, le chat et, selon la version courante de VS Code/Copilot et le plan disponible, des fonctions agentiques supplémentaires.

---

## Prérequis

- un compte GitHub avec accès à Copilot, y compris **Copilot Free** ou un plan payant ;
- une connexion Internet ;
- **la dernière version stable de Visual Studio Code** recommandée par GitHub ;
- les politiques de votre organisation autorisant Copilot si le compte est géré.

!!! warning "Ne figez pas une vieille version minimale"
    GitHub fait évoluer rapidement Copilot et recommande d'utiliser les versions stables les plus récentes de l'IDE et des extensions. Pour une compatibilité précise, vérifiez la documentation officielle au moment de l'installation.

---

## Installation

La documentation GitHub actuelle indique que, lors de la première configuration de Copilot dans VS Code, les extensions requises sont installées automatiquement par le parcours de setup de VS Code.

1. Ouvrez VS Code.
2. Lancez le parcours **Set up GitHub Copilot** depuis l'interface Copilot ou la palette de commandes lorsque proposé.
3. Connectez-vous à GitHub.
4. Autorisez VS Code/Copilot si le navigateur vous le demande.
5. Revenez dans VS Code et vérifiez que le chat et les suggestions sont disponibles.

Vous pouvez également contrôler les extensions installées avec :

- Windows/Linux : ++ctrl+shift+x++
- macOS : ++cmd+shift+x++

Si vous installez manuellement une extension, vérifiez toujours qu'elle est publiée par **GitHub**.

---

## Authentification

L'accès Copilot est lié au compte GitHub et aux politiques de l'organisation.

Lors du setup :

1. choisissez **Sign in to GitHub** ;
2. terminez l'autorisation dans le navigateur ;
3. revenez dans VS Code ;
4. vérifiez le compte actif depuis le menu Accounts / Copilot.

Pour un compte géré sur GHE.com, suivez la procédure GitHub dédiée : des réglages supplémentaires peuvent être requis avant la connexion.

---

## Vérification rapide

Ouvrez un fichier de code et testez séparément :

1. **complétion inline** : commencez une fonction ou une expression simple ;
2. **chat** : demandez une explication du fichier courant ;
3. **modification** : demandez un petit changement réversible ;
4. **validation** : relisez le diff et exécutez les tests du projet.

Ne validez jamais le bon fonctionnement de Copilot uniquement parce qu'une réponse textuelle est affichée : vérifiez que les changements proposés correspondent bien au dépôt et passent les contrôles habituels.

---

## Fonctionnalités : vérifier la matrice courante

GitHub publie une **Copilot feature matrix** maintenue par IDE et par version. À la date de cette révision, VS Code prend en charge notamment :

- code completion ;
- Chat ;
- Agent mode ;
- Edit mode ;
- MCP ;
- custom instructions ;
- custom agents ;
- prompt files ;
- agent skills ;
- workspace indexing.

Certaines fonctions restent en preview selon la version. Utilisez la matrice officielle comme source de vérité plutôt qu'une liste figée dans ce dépôt.

---

## Sécurité minimale

- relisez les diffs avant validation ;
- n'injectez pas de secrets dans le chat ;
- contrôlez les permissions des outils/agents ;
- vérifiez les dépendances proposées avant installation ;
- appliquez les politiques GitHub de votre organisation ;
- conservez tests, lint, SAST/SCA et CI comme preuves indépendantes.

---

## Claude Code dans VS Code

Si vous suivez le parcours principal de cette documentation, utilisez plutôt :

**[Claude Code — Installation CLI, VS Code et JetBrains](../../chapitre-3b-claude-code-migration-copilot/installation.md)**

Les deux outils peuvent coexister, mais évitez de dupliquer les mêmes instructions projet dans plusieurs formats lorsque `CLAUDE.md`, `AGENTS.md` ou les fichiers Copilot peuvent référencer une source commune.

---

## Sources

- [GitHub Docs — Installing the GitHub Copilot extension in your environment](https://docs.github.com/en/copilot/how-tos/set-up/install-copilot-extension) — consulté le 2026-09-28
- [GitHub Docs — Copilot feature matrix](https://docs.github.com/en/copilot/reference/copilot-feature-matrix) — consulté le 2026-09-28
- [GitHub Docs — Configuring GitHub Copilot in your environment](https://docs.github.com/en/copilot/how-tos/configure-personal-settings/configure-in-ide) — consulté le 2026-09-28

## Prochaine étape

Poursuivez avec **[Visual Studio Code — Référence](reference.md)**, la page suivante dans le menu.
