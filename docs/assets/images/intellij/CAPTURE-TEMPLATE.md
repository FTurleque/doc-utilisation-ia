# Template de capture — IntelliJ IDEA

Utiliser ce canevas pour ajouter une capture IntelliJ à la documentation sans figer des chemins UI ou versions qui évoluent rapidement.

## Avant la capture

- [ ] IntelliJ IDEA est sur une version stable compatible avec l'intégration ciblée.
- [ ] Le produit est clairement identifié : **Claude Code** ou **GitHub Copilot**.
- [ ] Le plugin concerné est installé depuis sa source officielle et authentifié si nécessaire.
- [ ] Le projet de démonstration ne contient aucune donnée sensible.
- [ ] Les notifications sans rapport sont fermées.
- [ ] La zone capturée contient assez de contexte pour comprendre où l'utilisateur se trouve.

Ne pas imposer une version minimale (`2024.1+`, etc.) dans ce template. Vérifier la compatibilité officielle au moment de la contribution.

## Fiche de capture

Copier cette section dans la description de PR pour chaque nouvel écran :

```markdown
### intellij-{produit}-{fonction}-{numero}.png

- Produit : Claude Code | GitHub Copilot
- IntelliJ IDEA : version observée
- Plugin : version observée
- OS : Windows | macOS | Linux
- Date de capture : YYYY-MM-DD
- Page(s) concernée(s) : chemin Markdown
- Objectif : information visuelle que la capture doit démontrer
- Données sensibles vérifiées/masquées : oui
```

## Captures Claude Code — priorité

Une capture est utile lorsqu'elle montre un élément visuel difficile à expliquer uniquement avec du texte, par exemple :

- recherche/installation du plugin Claude Code ;
- panneau ou point d'entrée Claude Code dans l'IDE ;
- permission ou confirmation IDE ;
- réglage/diagnostic dont l'emplacement est important.

Avant de définir une séquence de clics, la reproduire sur la version réellement installée. Ne pas écrire à l'avance des labels de menus supposés.

## Captures GitHub Copilot — référence

Les anciennes captures Copilot du dossier sont conservées. Pour en remplacer ou en ajouter une :

1. vérifier le parcours dans la documentation GitHub courante ;
2. reproduire l'écran sur le plugin réellement installé ;
3. ne pas supposer qu'un raccourci ou menu historique existe encore ;
4. indiquer dans la PR pourquoi la nouvelle capture remplace ou complète l'ancienne.

## Nommage

```text
intellij-claude-chat-01.png
intellij-claude-plugin-01.png
intellij-copilot-settings-02.png
```

Les noms historiques existants peuvent rester afin de préserver les liens.

## Qualité et confidentialité

- privilégier PNG pour l'UI ;
- garder le texte lisible ;
- masquer utilisateurs, organisations, URLs privées, chemins personnels, tokens et clés ;
- ne jamais utiliser une vraie clé comme exemple visuel ;
- ne pas retoucher l'interface pour créer artificiellement un bouton, un message ou un état.

Après intégration :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```
