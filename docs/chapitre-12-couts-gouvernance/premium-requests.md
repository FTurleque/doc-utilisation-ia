# GitHub Copilot — AI Credits et facturation (référence)

<span class="badge-intermediate">Intermédiaire</span>

Cette page est conservée comme **référence GitHub Copilot**. Le parcours principal du chapitre Coûts & Gouvernance concerne désormais Claude Code ; Copilot utilise un système distinct de facturation appelé **GitHub AI Credits**.

!!! info "État vérifié"
    Référence revérifiée le **28 septembre 2026** sur la documentation GitHub officielle.

---

## Modèle actuel : GitHub AI Credits

GitHub mesure l'usage Copilot facturable en **AI Credits** :

- **1 AI Credit = 0,01 USD** ;
- le coût dépend du **modèle** utilisé ;
- il dépend aussi des **tokens consommés** : entrée, sortie et cache selon le modèle ;
- chaque plan comprend une allocation mensuelle.

Les plans individuels payants affichent actuellement :

| Plan | Prix mensuel | AI Credits mensuels inclus |
|---|---:|---:|
| Copilot Pro | 10 USD | 1 500 |
| Copilot Pro+ | 39 USD | 7 000 |
| Copilot Max | 100 USD | 20 000 |

Pour les organisations :

| Plan | Prix par siège / mois | AI Credits par utilisateur / mois |
|---|---:|---:|
| Copilot Business | 19 USD | 1 900 |
| Copilot Enterprise | 39 USD | 3 900 |

Les crédits des organisations/entreprises sont mutualisés au niveau de l'entité de facturation.

!!! warning "Valeurs évolutives"
    Vérifiez toujours la page officielle des plans avant une décision d'achat. Les montants et catalogues de modèles peuvent évoluer.

---

## Ce qui consomme des AI Credits

GitHub indique notamment comme usages facturés :

- Copilot Chat ;
- Copilot CLI ;
- Copilot coding/cloud agent ;
- Copilot Spaces ;
- Spark ;
- agents tiers intégrés.

Les **code completions** et **next edit suggestions** ne sont pas facturées en AI Credits sur les plans payants.

---

## Comment le coût varie

Une interaction courte avec un modèle léger peut coûter une fraction de crédit. Une session agentique longue, utilisant un modèle plus coûteux et beaucoup de contexte, consomme davantage.

Évitez donc les estimations fixes du type « un message = un crédit » ou « un agent = N crédits ». Le coût est lié au modèle et aux tokens réellement consommés.

---

## Que se passe-t-il lorsque l'allocation est épuisée ?

### Individuels

Selon la configuration du compte, l'utilisateur peut :

- autoriser un budget d'usage additionnel ;
- ou attendre le prochain cycle si aucune dépense supplémentaire n'est autorisée.

### Organisations et entreprises

Les licences alimentent un pool partagé. Lorsque le pool est épuisé :

- un budget autorisé permet de continuer avec facturation additionnelle ;
- un budget bloquant peut empêcher les usages facturables jusqu'au prochain cycle ou jusqu'à modification du budget.

GitHub permet de piloter les budgets à plusieurs niveaux selon le type de compte.

---

## Legacy : premium requests

Depuis le **1er juin 2026**, GitHub a remplacé le modèle principal basé sur les **premium requests** par la facturation basée sur l'usage en AI Credits.

Le modèle premium-requests reste documenté uniquement pour certains abonnés annuels Copilot Pro / Pro+ restés sur l'ancien système. Les multiplicateurs de modèles appartiennent à ce système legacy et ne doivent pas être mélangés avec la logique AI Credits actuelle.

---

## Claude Code : système différent

Claude Code ne consomme pas de GitHub AI Credits lorsqu'il est utilisé avec un abonnement Claude. Les plans Claude disposent de limites d'usage partagées entre Claude et Claude Code ; après épuisement, des **usage credits** peuvent être activés pour continuer en tarification à l'usage.

Voir [Les abonnements Claude](abonnements.md) pour le parcours principal.

---

## Sources

- [GitHub Docs — GitHub Copilot billing](https://docs.github.com/en/billing/concepts/product-billing/github-copilot-billing) — consulté le 2026-09-28
- [GitHub Docs — Plans for GitHub Copilot](https://docs.github.com/en/copilot/get-started/plans) — consulté le 2026-09-28
- [GitHub Docs — Legacy billing changes](https://docs.github.com/en/copilot/reference/copilot-billing/request-based-billing-legacy/what-changed-with-billing) — consulté le 2026-09-28

## Prochaine étape

**[Historique des évolutions](historique-modifications.md)** : conserver les changements Copilot comme registre historique sans les confondre avec le modèle économique Claude.