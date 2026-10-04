# Template de capture — Visual Studio Code

Utiliser ce canevas pour produire des captures VS Code vérifiables et durables. Claude Code est le parcours principal ; les captures GitHub Copilot restent des références produit.

## Avant la capture

- [ ] VS Code est sur une version stable compatible avec l'intégration ciblée.
- [ ] Le produit est identifié : **Claude Code** ou **GitHub Copilot**.
- [ ] L'extension concernée est installée depuis sa source officielle et authentifiée si nécessaire.
- [ ] Le workspace de démonstration ne contient aucune donnée sensible.
- [ ] Les notifications non pertinentes sont fermées.
- [ ] Le texte et les contrôles importants sont lisibles.

Ne pas figer dans ce template un numéro de version, un raccourci ou une liste de slash commands : ces éléments évoluent avec VS Code et les extensions.

## Fiche de capture

```markdown
### vscode-{produit}-{fonction}-{numero}.png

- Produit : Claude Code | GitHub Copilot
- VS Code : version observée
- Extension : version observée
- OS : Windows | macOS | Linux
- Date de capture : YYYY-MM-DD
- Page(s) concernée(s) : chemin Markdown
- Objectif : information visuelle démontrée
- Données sensibles vérifiées/masquées : oui
```

## Captures Claude Code — priorité

Capturer seulement lorsqu'une image apporte une information supplémentaire, par exemple :

- installation de l'intégration Claude Code ;
- panneau Claude Code ;
- sélecteur ou confirmation de permissions ;
- diagnostic spécifique à l'intégration VS Code.

Pour `CLAUDE.md`, `.claude/settings.json`, rules, skills, agents, hooks et commandes CLI, préférer les exemples textuels versionnés.

## Captures GitHub Copilot — référence

Pour actualiser une capture existante :

1. vérifier le parcours dans les docs GitHub courantes ;
2. reproduire l'interface sur l'extension installée ;
3. ne pas supposer qu'un raccourci (`Ctrl+I`, etc.), une commande ou un menu historique est encore identique ;
4. indiquer dans la PR la capture remplacée et la version observée.

## Nommage

```text
vscode-claude-chat-01.png
vscode-claude-permissions-01.png
vscode-copilot-marketplace-02.png
```

Ne pas renommer les fichiers historiques sans corriger toutes leurs références.

## Qualité et confidentialité

- PNG recommandé pour l'UI ;
- texte lisible après affichage dans MkDocs ;
- masquer utilisateurs, organisations, repositories privés, URLs sensibles, tokens et clés ;
- ne jamais exposer un vrai device code encore utilisable ;
- ne pas retoucher l'interface pour simuler un état non observé.

Après intégration :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```
