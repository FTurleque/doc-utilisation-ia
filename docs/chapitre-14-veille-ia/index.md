# Veille IA — Claude, agents et sécurité

L'écosystème IA change trop vite pour figer dans la documentation des listes de modèles, de prix ou de fonctionnalités pendant plusieurs mois. Ce chapitre propose une veille **orientée maintenance de la documentation** : suivre d'abord les sources officielles qui peuvent rendre une page du dépôt obsolète.

Claude Code est le parcours principal du dépôt.

---

## Pages du chapitre

<div class="grid cards" markdown>

- :material-youtube: **[Vidéos, podcasts & conférences](videos-podcasts.md)**

    Contenus secondaires utiles pour approfondir, sans remplacer les sources produit officielles.

- :material-shield-alert: **[Sécurité, risques & failles](securite-risques.md)**

    OWASP GenAI, sécurité agentique, prompt injection, supply chain, permissions et données sensibles.

- :material-email-newsletter: **[Newsletters & communautés](newsletters-communautes.md)**

    Signaux communautaires à utiliser pour découvrir un sujet, puis à confirmer auprès d'une source primaire.

</div>

---

## Priorité de veille pour ce dépôt


Une newsletter ou un post social peut signaler un changement, mais ne doit pas être la source finale d'une affirmation sur un prix, un quota, une fonctionnalité ou une vulnérabilité.

---

## Ce qui mérite une vérification fréquente

| Sujet | Pourquoi il vieillit vite |
|---|---|
| Claude Code | commandes, settings, hooks, skills, MCP et IDE évoluent rapidement |
| Modèles Claude | noms, disponibilité, capacités, prix et limites changent |
| Outils locaux | compatibilités API, modèles et statuts de maintenance évoluent |
| Sécurité agentique | nouvelles classes d'attaque et nouveaux contrôles apparaissent |
| Réglementation | échéances et obligations dépendent du texte et du cas d'usage |

---

## OWASP : mise à jour 2026

La veille sécurité ne doit plus pointer uniquement vers le Top 10 LLM 2025. Le **OWASP GenAI Security Project** a publié en septembre 2026 une nouvelle édition du **Top 10 for LLM Applications 2026** ainsi qu'un **Agent Control Standard** pour les systèmes agentiques.

Cela correspond mieux au périmètre de ce dépôt, qui documente des agents capables de lire des fichiers, d'exécuter des commandes et d'appeler des outils externes.

---

## Routine de maintenance recommandée

Pour ce dépôt :

1. vérifier les changelogs avant chaque lot documentaire important ;
2. dater toute information périssable ;
3. préférer un lien officiel à une copie de tableau de prix ;
4. supprimer les pseudo-benchmarks non reproductibles ;
6. ouvrir une issue ou une PR lorsqu'un changement produit invalide plusieurs pages.

---

## Sources principales

- [Claude Code — changelog](https://code.claude.com/docs/en/changelog)
- [Claude Code — documentation](https://code.claude.com/docs/)
- [Anthropic — Newsroom](https://www.anthropic.com/news)
- [GitHub Changelog](https://github.blog/changelog/)
- [OWASP GenAI Security Project](https://genai.owasp.org/)

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-14-veille-ia.md#page-chapitre-14-veille-ia-index).

## Prochaine étape

Poursuivez avec **[Sources Officielles & Changelogs](sources-officielles.md)**, la page suivante dans le menu.
