# Newsletters & communautés

<span class="badge-beginner">Débutant</span>

Newsletters, Reddit, Hacker News, Discord, forums et réseaux sociaux sont utiles pour **découvrir rapidement** un changement, une régression ou un nouvel outil. Ils ne constituent pas la preuve finale utilisée pour maintenir cette documentation.

---

## Règle de base

```text
signal communautaire
→ source primaire
→ vérification date/statut
→ mise à jour documentaire
```

Exemples de sources primaires : changelog officiel, documentation, dépôt de l'éditeur, advisory de sécurité, papier de recherche ou texte réglementaire.

---

## Newsletters utiles

Quelques sources généralistes ou techniques peuvent compléter la veille :

- The Batch ;
- TLDR AI / TLDR InfoSec ;
- The Pragmatic Engineer ;
- Changelog Weekly ;
- Latent Space.

Évitez de maintenir dans ce dépôt des fréquences exactes ou un classement permanent : ces publications changent de rythme et de positionnement.

---

## Communautés utiles

Selon le sujet :

- Hacker News pour les discussions techniques et annonces ;
- r/LocalLLaMA pour modèles locaux, Ollama et hardware ;
- r/MachineLearning pour recherche ML ;
- GitHub Discussions/Issues pour les bugs et retours liés à un projet précis ;
- communautés officielles des outils lorsque disponibles.

Un commentaire communautaire peut décrire un bug réel sans être reproductible ni confirmé. Cherchez ensuite l'issue officielle, le changelog ou une reproduction minimale.

---

## GitHub : la veille la plus utile pour les outils open source

Pour RTK, OpenSkills, Ollama, MCP servers et autres projets suivis par ce dépôt :

1. ouvrir le dépôt officiel ;
2. utiliser **Watch → Custom → Releases** ;
3. surveiller les advisories/security notices si le projet les publie ;
4. consulter les issues seulement pour compléter un diagnostic, pas pour établir une règle produit générale.

---

## Flux à privilégier

Plutôt qu'une longue liste figée de RSS, construisez un lecteur autour de :

- Claude Code changelog ;
- Anthropic Newsroom ;
- GitHub Changelog ;
- OWASP GenAI Security Project ;
- releases des dépôts réellement utilisés.

Ajoutez des sources secondaires uniquement si elles réduisent réellement votre temps de veille.

---

## Anti-patterns de veille

- annoncer une fonctionnalité sur la base d'un tweet uniquement ;
- recopier un prix vu dans une newsletter sans vérifier l'offre officielle ;
- prendre un benchmark communautaire pour une vérité générale ;
- maintenir des compteurs de membres/abonnés dans la documentation ;
- garder une liste de communautés mortes uniquement parce qu'elle figurait dans une ancienne version de la page.

---

## Utiliser Claude Code pour assister la veille

Claude peut aider à préparer un audit :

```text
Compare les liens et informations datées de ce chapitre avec les sources officielles disponibles.
Sépare :
- encore valide ;
- obsolète ;
- impossible à confirmer ;
- nécessite une décision humaine.
Ne modifie rien avant d'avoir fourni les sources.
```

La vérification externe reste indispensable pour les faits actuels.

---

## Prochaine étape

Retour à l'[index de veille](index.md), puis utilisez les [ressources externes des appendices](../appendices/ressources-externes.md) pour les liens durables.