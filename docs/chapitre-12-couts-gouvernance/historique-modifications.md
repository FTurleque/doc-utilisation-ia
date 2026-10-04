# Historique GitHub Copilot — plans, limites et facturation

<span class="badge-intermediate">Intermédiaire</span>

Cette page est un **registre historique Copilot**. Elle conserve les changements de produit utiles pour comprendre pourquoi certaines anciennes captures, procédures ou comparaisons ne correspondent plus à l'offre actuelle.

!!! info "Comment lire cette page"
    Une entrée décrit l'état annoncé à une date donnée. Elle ne doit pas être interprétée comme l'état actuel sans vérifier la documentation GitHub récente.

---

## État actuel à retenir

Depuis le **1er juin 2026**, le modèle principal de facturation Copilot est basé sur les **GitHub AI Credits**. Les plans disposent d'une allocation mensuelle et l'usage additionnel peut être contrôlé par des budgets. Les anciens **premium requests** ne subsistent que pour certains abonnements annuels legacy.

Voir [AI Credits — référence Copilot](premium-requests.md) pour le fonctionnement actuel.

---

## Timeline vérifiée

### 2026-06-01 — AI Credits généralisés

GitHub a activé la facturation basée sur l'usage pour tous les plans Copilot :

- consommation mesurée en GitHub AI Credits ;
- allocation mensuelle incluse selon le plan ;
- budget additionnel configurable ;
- contrôles budgétaires plus fins ;
- Copilot code review consomme aussi des minutes GitHub Actions sur les dépôts privés, en plus des AI Credits.

**Source :** [GitHub Changelog — Updates to GitHub Copilot billing and plans](https://github.blog/changelog/2026-06-01-updates-to-github-copilot-billing-and-plans/)

---

### 2026-04-20 — modifications temporaires des plans individuels

GitHub a annoncé :

- une pause temporaire des nouvelles inscriptions Student, Pro et Pro+ ;
- des limites d'usage plus strictes pour les plans individuels ;
- le retrait des modèles Opus du plan Pro ;
- Opus 4.7 maintenu sur Pro+ à cette date.

Cette entrée est historique : ne déduisez pas l'état actuel des inscriptions ou du catalogue de modèles à partir de cette annonce d'avril.

**Source :** [GitHub Changelog — Changes to GitHub Copilot plans for individuals](https://github.blog/changelog/2026-04-20-changes-to-github-copilot-plans-for-individuals/)

---

### 2026-04-16 — Claude Opus 4.7 dans Copilot

GitHub a lancé Claude Opus 4.7 pour Copilot Pro+, Business et Enterprise. L'annonce utilisait encore le système de multiplicateurs **premium requests**, avant la migration générale vers AI Credits du 1er juin.

**Source :** [GitHub Changelog — Claude Opus 4.7 is generally available](https://github.blog/changelog/2026-04-16-claude-opus-4-7-is-generally-available/)

---

### 2026-04-10 — limites de capacité renforcées

GitHub a annoncé deux familles de limites :

- limites globales de fiabilité du service ;
- limites propres à certains modèles ou familles de modèles.

L'annonce recommandait de répartir les requêtes dans le temps ou de changer de modèle lorsque la limite d'un modèle était atteinte.

**Source :** [GitHub Changelog — Enforcing new limits](https://github.blog/changelog/2026-04-10-enforcing-new-limits-and-retiring-opus-4-6-fast-from-copilot-pro/)

---

### 2024-12-18 — lancement de Copilot Free

GitHub a lancé Copilot Free avec :

- 2 000 code completions par mois ;
- 50 messages de chat par mois à son lancement ;
- accès depuis VS Code et GitHub.

Ces quotas décrivent **le lancement de 2024**, pas nécessairement l'allocation actuelle du plan Free.

**Source :** [GitHub Changelog — Announcing GitHub Copilot Free](https://github.blog/changelog/2024-12-18-announcing-github-copilot-free/)

---

## Transition premium requests → AI Credits

Avant juin 2026, le système Copilot utilisait des **premium request units** et des multiplicateurs par modèle. Depuis juin 2026, la facturation standard dépend du modèle et des tokens consommés, puis le coût est converti en AI Credits.

| Période | Référentiel principal |
|---|---|
| Avant le 1er juin 2026 | Premium requests / multiplicateurs |
| Depuis le 1er juin 2026 | AI Credits / usage basé sur tokens et modèle |
| Certains abonnements annuels legacy | Premium requests jusqu'à migration du contrat |

Ne comparez donc pas directement un multiplicateur historique « 7,5× » avec une consommation AI Credits actuelle : il s'agit de deux systèmes de facturation différents.

---

## Ce qui a été retiré de cette page

Les anciennes versions contenaient des conclusions commerciales sur le « coût de l'inaction », des projections annuelles supposant qu'un modèle précis resterait attaché à un plan, et des comparaisons de valeur fondées sur une disponibilité de modèle temporaire.

Ces éléments vieillissent vite et ne constituent pas une base fiable pour une documentation technique. Le registre conserve désormais uniquement les **faits datés et sourcés** utiles à la compréhension du produit.

---

## Pour une décision actuelle

Ne partez pas de cette timeline. Consultez plutôt :

1. [Plans for GitHub Copilot](https://docs.github.com/en/copilot/get-started/plans) ;
2. [GitHub Copilot billing](https://docs.github.com/en/billing/concepts/product-billing/github-copilot-billing) ;
3. le [GitHub Copilot Changelog](https://github.blog/changelog/?label=copilot).

---

## Claude Code

Cette page ne décrit pas la tarification Claude. Pour Claude Code, consultez [Les abonnements Claude](abonnements.md) et les pages d'usage Anthropic. Le fait qu'un modèle Claude soit disponible dans Copilot ne signifie pas que les limites ou prix Copilot s'appliquent à Claude Code utilisé via un abonnement Anthropic.

---

## Sources

- [GitHub Docs — Plans for GitHub Copilot](https://docs.github.com/en/copilot/get-started/plans) — consulté le 2026-09-28
- [GitHub Docs — Legacy billing changes](https://docs.github.com/en/copilot/reference/copilot-billing/request-based-billing-legacy/what-changed-with-billing) — consulté le 2026-09-28
- [GitHub Changelog — Updates to Copilot billing and plans](https://github.blog/changelog/2026-06-01-updates-to-github-copilot-billing-and-plans/) — consulté le 2026-09-28

## Prochaine étape

Poursuivez avec **[Comparaison Copilot vs Claude](../chapitre-3b-claude-code-migration-copilot/comparaison-copilot-claude.md)**, la page suivante dans le menu.
