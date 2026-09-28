# Raccourcis & commandes — référence rapide

Les raccourcis IDE et commandes évoluent. Cette page privilégie les **points d'entrée stables** et renvoie vers `/help`, la palette de commandes VS Code ou le Keymap JetBrains pour la liste réellement disponible dans votre version.

---

## Claude Code — commandes utiles

Dans une session Claude Code :

| Commande | Usage |
|---|---|
| `/help` | Afficher les commandes disponibles dans la version installée |
| `/status` | Vérifier compte, modèle et état de session |
| `/doctor` | Diagnostiquer configuration et environnement |
| `/context` | Inspecter l'utilisation du contexte |
| `/model` | Choisir un modèle disponible |
| `/clear` | Repartir avec un contexte de conversation vide |
| `/compact` | Compacter le contexte lorsque la session devient longue |
| `/mcp` | Voir/configurer l'état des serveurs MCP |
| `/agents` | Gérer/utiliser les subagents lorsque disponible |

!!! tip "Source de vérité"
    Utilisez `/help` avant de recopier une commande dans un runbook : Claude Code évolue rapidement et certaines commandes peuvent être ajoutées, renommées ou retirées.

---

## Référencer du contexte

Claude Code sait travailler à partir des fichiers du dépôt et des références explicites. Le moyen exact de référencer un fichier ou une sélection dépend de la surface (CLI, VS Code, JetBrains) et de la version.

Bon réflexe :

```text
Lis `src/service/UserService.ts` et les tests associés.
Compare avec le pattern utilisé dans `src/service/ProductService.ts`.
```

Ne construisez pas une convention interne autour d'une syntaxe spéciale non vérifiée dans votre version.

---

## VS Code — Claude Code

Utilisez :

- la vue/extension Claude Code ;
- la palette de commandes (`Ctrl/Cmd+Shift+P`) puis recherchez « Claude » ;
- les raccourcis clavier (`Ctrl/Cmd+K`, puis `Ctrl/Cmd+S`) pour voir ou personnaliser les bindings actifs ;
- le terminal intégré pour lancer `claude` lorsque la CLI standalone est installée.

Les raccourcis exacts peuvent être personnalisés par utilisateur et évoluer avec l'extension.

---

## JetBrains — Claude Code

Utilisez :

- la fenêtre d'outils Claude Code ;
- **Settings → Keymap** puis recherchez « Claude » ;
- le terminal intégré pour lancer `claude` ;
- les actions IDE natives (Find Usages, Rename, Extract, tests, debugger) avant de demander à l'agent une transformation mécanique.

---

## Raccourcis IDE à connaître indépendamment de l'IA

### VS Code

| Action | Windows/Linux | macOS |
|---|---|---|
| Palette de commandes | `Ctrl+Shift+P` | `Cmd+Shift+P` |
| Raccourcis clavier | `Ctrl+K Ctrl+S` | `Cmd+K Cmd+S` |
| Terminal intégré | ``Ctrl+` `` | ``Ctrl+` `` |
| Recherche fichiers | `Ctrl+P` | `Cmd+P` |
| Recherche globale | `Ctrl+Shift+F` | `Cmd+Shift+F` |

### JetBrains

Les bindings dépendent fortement du keymap (Windows, macOS, IntelliJ, VS Code keymap, Vim...). Utilisez **Find Action** puis recherchez l'action voulue plutôt que de figer un raccourci universel dans cette documentation.

---

## GitHub Copilot — référence conservée

Les raccourcis Copilot varient également selon VS Code/JetBrains et la version. Pour éviter de conserver une table périmée :

- VS Code : ouvrez **Keyboard Shortcuts** et recherchez `Copilot` ;
- JetBrains : **Settings → Keymap** puis recherchez `Copilot` ;
- vérifiez la documentation GitHub Copilot avant de standardiser un binding d'équipe.

Les concepts restent : accepter/rejeter une suggestion inline, ouvrir le chat, ajouter du contexte et déclencher les actions disponibles dans le client.

---

## Commandes de diagnostic hors session

```bash
claude --version
claude doctor
```

Pour un problème complexe, voyez le chapitre [Troubleshooting](../chapitre-11-troubleshooting/index.md).

---

## À éviter

- mémoriser une longue liste de raccourcis versionnés dans un runbook ;
- supposer qu'un binding VS Code existe aussi dans JetBrains ;
- publier des noms de modèles figés dans la commande `/model` ;
- confondre une commande Claude Code avec une commande Copilot portant un nom similaire.

## Sources

- [Claude Code documentation](https://code.claude.com/docs/)
- [Claude Code changelog](https://code.claude.com/docs/en/changelog)
- [GitHub Copilot documentation](https://docs.github.com/en/copilot)
