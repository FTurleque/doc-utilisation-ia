# Guide des captures d'écran

Ce dossier contient des captures **Claude Code** lorsqu'elles sont disponibles et des captures **GitHub Copilot** conservées comme références. Les fichiers existants ne sont pas renommés automatiquement afin de préserver les liens déjà utilisés dans la documentation.

## Organisation réelle

```text
docs/assets/images/
├── logo-documentation-ia.jpg
├── intellij/
│   ├── README.md
│   ├── CAPTURE-TEMPLATE.md
│   └── images existantes
└── vscode/
    ├── README.md
    ├── CAPTURE-TEMPLATE.md
    └── images existantes
```

Les anciennes consignes mentionnaient des sous-dossiers `01-installation/`, `02-parametrage/`, etc. Ils ne font pas partie de l'arborescence actuelle et ne doivent pas être supposés dans les nouveaux liens.

## Convention pour les nouvelles images

```text
{ide}-{produit}-{fonction}-{numero}.png
```

Exemples :

```text
intellij-claude-settings-01.png
intellij-copilot-chat-01.png
vscode-claude-chat-01.png
vscode-copilot-marketplace-01.png
```

Utiliser `claude` ou `copilot` dans le nom lorsqu'une capture est spécifique à un produit.

## Captures existantes

Les répertoires `intellij/` et `vscode/` contiennent déjà plusieurs captures Copilot. Elles constituent un inventaire réel, pas une checklist de captures à produire. Consulter leur `README.md` respectif avant d'ajouter un fichier.

Une capture ancienne peut rester dans le dépôt si :

- elle est encore référencée par une page ;
- elle illustre explicitement un parcours Copilot de référence ;
- elle ne contient aucune donnée sensible.

Lorsqu'elle devient trompeuse, remplacer la référence dans la page ou capturer l'interface actuelle plutôt que de retoucher artificiellement l'image.

## Capturer Claude Code

Claude Code étant le parcours principal, les nouvelles captures génériques doivent le privilégier lorsque l'interface visuelle apporte une vraie valeur. Exemples : intégration VS Code, plugin JetBrains, écran de permissions ou diagnostic IDE.

Pour les commandes terminal, settings JSON, `CLAUDE.md`, rules, skills, subagents et hooks, préférer généralement des exemples texte versionnables aux captures d'écran.

## Qualité

- texte lisible ;
- contexte UI suffisant ;
- aucune donnée privée ;
- alt text descriptif dans la page qui référence l'image ;
- interface réellement observée sur une version stable compatible ;
- format PNG privilégié pour les interfaces.

La résolution `1920×1080` est une cible pratique mais pas une exigence d'accessibilité. Éviter les règles rigides de zoom ou d'échelle système.

## Ajouter une capture

1. vérifier qu'une image équivalente n'existe pas déjà ;
2. capturer l'interface réelle ;
3. enregistrer dans `intellij/` ou `vscode/` ;
4. ajouter la référence Markdown avec un texte alternatif utile ;
5. mettre à jour le README d'inventaire concerné ;
6. valider :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```

## Ne pas faire

- inventer un device code, un écran ou un bouton pour « compléter » une capture ;
- publier un token ou identifiant de compte ;
- supposer qu'un raccourci clavier est stable entre versions ;
- créer une arborescence de dossiers non utilisée sans migration coordonnée des liens ;
- supprimer les captures Copilot uniquement parce que Claude Code est désormais prioritaire.
