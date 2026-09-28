# RTK — Rust Token Killer

<span class="badge-intermediate">Intermédiaire</span>

**RTK (Rust Token Killer)** est un outil CLI open source qui filtre et compacte les sorties de commandes avant qu'elles ne soient renvoyées à un agent de développement. Dans ce dépôt, son usage principal est désormais **Claude Code** : réduire le bruit produit par `git`, les tests, les linters, les builds ou les commandes d'infrastructure afin de préserver le contexte utile.

!!! info "Ce que RTK fait — et ne fait pas"
    RTK ne rend pas une commande moins coûteuse à exécuter. Il réduit surtout la **quantité de sortie textuelle** renvoyée à l'agent. Le gain réel dépend de la commande et de son output ; il faut le mesurer avec `rtk gain` au lieu de reprendre un pourcentage générique.

---

## Vérifier l'installation

Deux projets différents utilisent le nom `rtk`. Le contrôle le plus simple est :

```bash
rtk --version
rtk gain
```

Si `rtk gain` affiche le tableau de statistiques de réduction, il s'agit bien de **Rust Token Killer**. Si cette sous-commande n'existe pas, vérifiez le binaire installé avant de poursuivre.

---

## Installation

Utilisez de préférence les méthodes documentées par le projet `rtk-ai/rtk` : binaire précompilé, Homebrew tap ou installation depuis le dépôt Git lorsque cela convient à votre environnement.

### Homebrew

```bash
brew install rtk-ai/tap/rtk
```

### Cargo depuis le dépôt Git

```bash
cargo install --git https://github.com/rtk-ai/rtk rtk
```

`cargo install rtk` sans URL explicite est à éviter à cause de la collision de nom avec un autre projet.

### Windows

Des binaires Windows précompilés sont publiés dans les releases. Pour l'intégration de hooks la plus complète, la documentation RTK recommande de vérifier les limites propres à Windows et, si nécessaire, d'utiliser WSL.

---

## Initialisation recommandée avec Claude Code

Pour activer RTK sur tous les projets Claude Code de l'utilisateur :

```bash
rtk init --global
```

Avant toute modification de configuration, vous pouvez prévisualiser ce que RTK écrirait :

```bash
rtk init --global --dry-run
```

Cette option est particulièrement utile sur une machine déjà configurée avec des hooks ou des instructions Claude personnalisées.

Pour un seul projet :

```bash
cd /chemin/du/projet
rtk init
```

!!! warning "Toujours relire les fichiers modifiés"
    Une commande d'initialisation peut modifier les fichiers de configuration de l'agent. Exécutez d'abord `--dry-run` lorsque disponible, puis vérifiez les changements produits. Dans un dépôt Git, contrôlez également `git diff`.

---

## Utilisation explicite

Sans hook, préfixez les commandes :

```bash
rtk git status
rtk git diff
rtk npm test
rtk pytest
rtk cargo test
```

Pour une commande que RTK ne sait pas optimiser, utilisez son mode passthrough/proxy documenté par la version installée plutôt que de supposer qu'une transformation existe.

---

## Mesurer au lieu d'estimer

```bash
rtk gain
```

Le tableau permet de comparer la quantité d'entrée et de sortie réellement observée, commande par commande. C'est la métrique à utiliser pour décider si RTK est utile à votre projet.

Évitez les affirmations universelles telles que « RTK économise 90 % » ou « triple la durée des sessions » : le résultat dépend fortement du mix de commandes et de la verbosité initiale.

---

## Pourquoi cela aide Claude Code

Une sortie de test ou de build très longue peut consommer une part importante du contexte alors que seules quelques erreurs sont utiles. RTK cherche à conserver les informations actionnables et à supprimer ou regrouper le bruit répétitif.

Workflow recommandé :

```text
commande
  ↓
RTK filtre / agrège la sortie
  ↓
Claude reçoit une sortie plus compacte
  ↓
Claude corrige
  ↓
la commande de validation est relancée
```

Cette approche complète `/compact`, `/clear`, les subagents et les règles de contexte ; elle ne les remplace pas.

---

## Claude Code, Copilot et autres agents

Claude Code est le parcours principal de cette documentation. RTK documente également des intégrations pour d'autres assistants, dont GitHub Copilot, Cursor, Gemini CLI ou Codex selon la version.

Les options d'initialisation propres à ces agents évoluent. Pour Copilot, conservez les configurations existantes du dépôt et utilisez uniquement l'option explicitement documentée par votre version de RTK ; ne laissez pas une commande d'initialisation écraser `.github/copilot-instructions.md` ou des hooks existants sans revue.

---

## Sécurité et limites

- Une sortie « compacte » peut masquer un détail utile : reproduisez sans RTK si le diagnostic semble incomplet.
- Ne considérez pas un résumé de logs comme une preuve que le build ou les tests passent.
- Les logs peuvent contenir des secrets ; RTK ne doit pas être considéré comme un mécanisme de redaction de secrets.
- Vérifiez les scripts/hooks installés avant de les déployer à toute une équipe.
- Épinglez une version dans les environnements reproductibles si un changement de filtrage pourrait affecter le diagnostic.

---

## Sources

- [RTK — dépôt officiel](https://github.com/rtk-ai/rtk) — consulté le 2026-09-28
- [RTK — Quick Start](https://github.com/rtk-ai/rtk/blob/develop/docs/guide/getting-started/quick-start.md) — consulté le 2026-09-28
- [RTK — Installation](https://github.com/rtk-ai/rtk/blob/develop/docs/guide/getting-started/installation.md) — consulté le 2026-09-28

## Prochaine étape

**[SonarQube](sonarqube.md)** : utiliser l'analyse statique et le MCP Sonar comme sources de preuves ciblées avant de demander une correction agentique.