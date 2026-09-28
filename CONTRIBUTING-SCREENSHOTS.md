# Contribution de captures d'écran

Ce guide décrit comment ajouter des captures fiables à la documentation. Le parcours principal est **Claude Code** ; les captures GitHub Copilot existantes sont conservées comme références produit et ne doivent pas être supprimées uniquement parce que l'orientation du dépôt a changé.

## Principes

- Capturer uniquement une interface réellement observée sur une version stable récente de l'IDE/extension.
- Ne pas figer dans ce guide une version minimale d'IntelliJ IDEA ou de VS Code : vérifier la compatibilité officielle au moment de la capture.
- Ne jamais fabriquer un écran, un état UI, un raccourci ou un libellé.
- Masquer les noms de compte, organisations, dépôts privés, tokens, clés, chemins personnels et données métier.
- Une capture datée reste utile comme référence historique, mais son contexte doit être identifiable.

## Nommage

Utiliser un nom explicite :

```text
{ide}-{produit}-{fonction}-{numero}.png
```

Exemples :

```text
vscode-claude-chat-01.png
vscode-copilot-marketplace-01.png
intellij-claude-plugin-01.png
intellij-copilot-settings-01.png
```

Les anciens fichiers dont le nom ne suit pas encore cette convention peuvent rester en place afin de ne pas casser les liens existants.

## Emplacement actuel

Les images sont actuellement stockées à plat dans :

```text
docs/assets/images/intellij/
docs/assets/images/vscode/
```

Ne créez pas de sous-dossiers `01-installation/`, `02-parametrage/`, etc. sans mettre à jour les liens et les guides associés : cette structure n'est pas utilisée actuellement.

## Préparer la capture

1. Utiliser la dernière version stable compatible de l'IDE et de l'intégration concernée.
2. Ouvrir un projet de démonstration sans données sensibles.
3. Désactiver les notifications non pertinentes.
4. Garder suffisamment de contexte UI pour que la capture soit compréhensible.
5. Vérifier le nom exact du produit visible : Claude/Claude Code ou GitHub Copilot.

La résolution doit rendre le texte lisible ; `1920×1080` est une bonne cible, pas une obligation absolue. Éviter d'imposer un scale système de 100 % si cela réduit l'accessibilité du poste de capture.

## Produits à documenter

### Claude Code — priorité documentaire

Captures utiles lorsqu'elles apportent une information que le texte ne suffit pas à transmettre :

- installation/intégration VS Code ;
- plugin JetBrains ;
- panneau Claude Code ;
- permissions ou réglages propres à l'intégration ;
- écrans de diagnostic dont l'emplacement UI est important.

Ne pas créer une capture uniquement pour illustrer une commande CLI stable : un bloc de code est souvent plus durable.

### GitHub Copilot — référence conservée

Les captures existantes Copilot restent valides comme référence si elles correspondent encore à l'interface documentée. Pour une nouvelle capture Copilot, vérifier la documentation GitHub et la version réellement installée avant de décrire un bouton, raccourci ou menu.

## Format et optimisation

- PNG pour l'UI et le texte ; JPEG seulement si une image existante l'impose ou si le contenu photographique le justifie.
- Recadrer sans supprimer le contexte nécessaire.
- Optimiser raisonnablement la taille sans dégrader la lisibilité.
- Ne pas utiliser de service en ligne pour optimiser une capture contenant des informations privées non masquées.

## Intégration Markdown

```markdown
![Panneau Claude Code dans VS Code](../../assets/images/vscode/vscode-claude-chat-01.png)
```

Le texte alternatif doit expliquer l'information utile, pas seulement dire « screenshot ».

Après ajout ou remplacement d'une image :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```

## Workflow Git

```bash
git switch -c docs/screenshots-claude-vscode
git add docs/assets/images/
git commit -m "docs: ajouter des captures Claude Code VS Code"
git push -u origin HEAD
```

Ouvrir ensuite une Pull Request vers `main`. Ne pas pousser directement sur `main`.

## Métadonnées à inclure dans la PR

Pour toute nouvelle capture UI, indiquer :

- produit concerné : Claude Code ou GitHub Copilot ;
- IDE et système d'exploitation ;
- version IDE/extension observée si elle est utile à la reproductibilité ;
- page(s) qui utilisent l'image ;
- date de capture lorsque l'interface est susceptible d'évoluer rapidement.

## Contacts

Le dépôt ne définit pas d'adresse e-mail ou de canal Slack/Discord de support documentaire. Utiliser les issues et Pull Requests GitHub du dépôt pour toute question afin d'éviter les coordonnées fictives ou périmées.
