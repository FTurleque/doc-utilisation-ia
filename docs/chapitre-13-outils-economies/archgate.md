# Archgate CLI — vérifier les décisions d'architecture

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-cli">CLI</span>

**Archgate** associe des ADR Markdown à des contrôles exécutables. Avec Claude Code, il complète la rédaction et la revue par des vérifications reproductibles. Pour décider quels ADR conserver ou créer, suivre la méthode **[Gérer les ADR avec Claude Code et OpenSpec](../chapitre-9-bonnes-pratiques/adr-claude.md)**.

!!! info "Vérifié le 10 octobre 2026"
    Le CLI est gratuit et open source (Apache-2.0), utilisable sans compte pour les contrôles. Le plugin Claude Code est une intégration distincte, annoncée en bêta et nécessitant une connexion pour l'accès. Le parcours proposé ci-dessous utilise d'abord le CLI et les instructions du projet.

## Ce qui se combine avec OpenSpec

| Composant | Utilisation proposée |
|---|---|
| OpenSpec déjà installé | Conserver le workflow de changement et les artefacts existants |
| Claude Code | Lire les décisions, améliorer les textes et proposer les contrôles |
| Archgate CLI | Exécuter les règles associées aux ADR |
| Build et tests applicatifs | Vérifier les comportements et propriétés spécifiques au langage |

C'est une composition de workflow, pas une synchronisation native garantie entre OpenSpec et Archgate. Aucun besoin de réinstaller OpenSpec ni d'activer le plugin bêta pour commencer.

## Installer le CLI sur le poste

Avec npm disponible, notamment sur un poste qui utilise déjà OpenSpec :

```powershell
npm install -g archgate
archgate --version
archgate --help
```

Le paquet npm utilise un wrapper vers un binaire propre à la plateforme. Un installateur autonome est également disponible sur le [site officiel](https://cli.archgate.dev/getting-started/installation/).

Pour un projet qui possède déjà un `package.json`, une dépendance de développement verrouillée et `npx archgate` peuvent remplacer l'installation globale. Pour Java, il n'est pas nécessaire de convertir l'application en projet Node : le CLI peut rester un outil externe. En CI, fixer la version retenue après le pilote, au lieu de dépendre d'une mise à jour implicite.

## Initialiser dans une application existante

Depuis une branche de travail propre de l'application :

```powershell
openspec --version
archgate init --help
archgate init --editor claude
git diff
git status --short
```

La commande initialise `.archgate/` avec un exemple et peut configurer l'intégration éditeur. **Sans identifiants Archgate existants, l'installation automatique du plugin est ignorée ; avec des identifiants valides, elle peut être déclenchée même sans `--install-plugin`.** Vérifier l'aide de la version installée et les changements produits, y compris les réglages locaux non suivis par Git.

Ne pas remplacer la configuration `.claude/` ou OpenSpec déjà présente. Examiner l'ADR d'exemple avant de le retirer ou de le remplacer par une décision pertinente ; un exemple généré n'est pas une décision acceptée du projet.

## Reprendre les ADR existants

1. Inventorier et relire le corpus avant toute conversion.
2. Choisir le registre canonique et préparer une correspondance des anciens chemins/identifiants.
3. Adapter les ADR retenus au [schéma Archgate](https://cli.archgate.dev/reference/adr-schema/) et à son modèle, dans une PR dédiée.
4. Relier les artefacts OpenSpec au registre au lieu de maintenir des copies.
5. Vérifier que les décisions et leurs périmètres sont effectivement reconnus avant d'activer un contrôle bloquant.

`archgate adr import` vise notamment les packs et les sources Git, et peut remapper les identifiants. Ce n'est pas une promesse de conversion sans perte de n'importe quel dossier Markdown local. Pour reprendre un historique, préférer une migration relue ; ne pas importer massivement des décisions étrangères au projet.

## Règles et couverture réelle

Un ADR portant `rules: true` est associé à un fichier compagnon `.rules.ts`. Avec `rules: false`, documenter le contrôle externe ou la revue manuelle prévue. Conserver les métadonnées et les titres attendus par le modèle de l'outil ; le texte explicatif peut être français.

Écrire les règles avec l'[API officielle](https://cli.archgate.dev/reference/rule-api/), puis les vérifier sur un exemple conforme et un contre-exemple. Ne pas marquer une contrainte comme automatisée tant que le contrôle n'existe pas et n'a pas été exécuté.

Pour Java, conserver les tests ArchUnit dans la chaîne Maven/Gradle du projet. L'ADR référence leur classe et leur commande. Aucune intégration native Archgate–ArchUnit n'est supposée ici : Claude et la CI exécutent les deux contrôles nécessaires.

## Commandes au quotidien

```powershell
archgate review-context
archgate check
archgate check --staged
archgate check --strict
```

`review-context` sélectionne le contexte des changements ; il ne remplace pas le contrôle bloquant `check`. Avant toute modification, lire aussi les ADR concernant les fichiers prévus : un diff encore vide ne suffit pas à identifier le périmètre futur.

`check` exécute les règles configurées. Les ADR peuvent être filtrés par les changements et leurs motifs `files`. **Un succès ne prouve donc pas une analyse intégrale du dépôt** : vérifier la liste des règles exécutées et leurs périmètres. Prévoir un audit global distinct du contrôle de PR, conformément au comportement de la version installée.

`--strict` rend aussi bloquants les avertissements et diagnostics concernés. Les codes de sortie documentés sont : `0` succès, `1` violations ou diagnostics bloquants, `2` erreur d'exécution. Une exécution sans règle pertinente n'est pas une preuve de conformité.

## Utiliser Claude sans plugin Archgate

Conserver un bref renvoi au registre et à la politique ADR dans `CLAUDE.md`. Demander à Claude de :

1. lire le changement OpenSpec et les décisions applicables ;
2. justifier la nécessité d'un nouvel ADR avant toute création ;
3. améliorer l'existant et signaler les contradictions ;
4. implémenter après validation des arbitrages ;
5. exécuter `archgate check` et les tests du projet ;
6. présenter les résultats, les écarts et les limites de couverture.

Le CLI ne fournit pas, à lui seul, un rédacteur IA. Claude réalise ce travail avec les instructions du dépôt. L'exécution systématique des contrôles doit aussi être prévue dans la CI ; une consigne au modèle seule ne la garantit pas.

## Plugin Claude Code facultatif

Le plugin fournit notamment des fonctions de rédaction/revue des ADR et de développement guidé par les décisions. Si son accès bêta est disponible et souhaité, la documentation décrit :

```powershell
archgate login
archgate plugin install --editor claude
```

Examiner les agents, permissions et réglages installés avant de les combiner avec le workflow existant. La politique de pertinence doit rester explicite, y compris lorsque le plugin propose de nouveaux ADR. Consulter le [guide officiel du plugin](https://cli.archgate.dev/guides/claude-code-plugin/) pour les conditions d'accès actuelles.

## Ajouter les contrôles à la CI applicative

Dans le pipeline existant, après installation de la version Archgate retenue :

```yaml
- name: Vérifier les règles ADR
  run: archgate check --strict
```

Cet extrait est une **étape à intégrer**, pas un workflow complet. Conserver le checkout, l'installation des outils et les étapes de build/tests du projet. Faire exécuter les tests ArchUnit par la commande Maven ou Gradle déjà configurée. Si le contrôle utilise un diff, s'assurer que la référence de base et l'historique nécessaires sont présents.

La mise en place doit établir la liste des modules couverts, les règles réellement exécutées et les exceptions restantes. Relier chaque échec à un ADR identifiable. Ne pas masquer une erreur avec `continue-on-error` pour déclarer le projet conforme.

## Dépannage

| Symptôme | Vérification |
|---|---|
| `archgate` introuvable dans IntelliJ | PATH du terminal, installation et réouverture du terminal |
| Aucun ADR reconnu | Emplacement, métadonnées et schéma attendu |
| Contrôle vert sans résultat utile | `rules`, fichier compagnon, motifs `files` et sélection par diff |
| Plugin inaccessible | Accès bêta ; poursuivre avec CLI et instructions si le CLI fonctionne |
| Doublons après adoption d'OpenSpec | Revenir à un registre canonique et des liens |
| Trop de nouvelles décisions proposées | Appliquer le filtre de pertinence avant création |

---

## Prochaine étape

Poursuivez avec **[Jupyter](jupyter.md)**, la page suivante dans le menu.

## Sources

Sources officielles consultées le **10 octobre 2026** :

- [Archgate — dépôt et licence du CLI](https://github.com/archgate/cli)
- [Installation](https://cli.archgate.dev/getting-started/installation/)
- [Initialisation et comportement du plugin](https://cli.archgate.dev/reference/cli/init/)
- [Importer des ADR](https://cli.archgate.dev/guides/importing-adrs/)
- [Schéma des ADR](https://cli.archgate.dev/reference/adr-schema/)
- [Rédaction et règles compagnons](https://cli.archgate.dev/guides/writing-adrs/)
- [Contrôle, périmètres et codes de sortie](https://cli.archgate.dev/reference/cli/check/)
- [Contexte de revue](https://cli.archgate.dev/reference/cli/review-context/)
- [Plugin Claude Code](https://cli.archgate.dev/guides/claude-code-plugin/)
