# Coûts & Gouvernance — Claude Code

Ce chapitre explique comment piloter le **coût, l'usage et la gouvernance de Claude Code** sans confondre les différents modèles de facturation : abonnement Claude, limites d'usage partagées, crédits d'usage éventuels et facturation API/Console.

GitHub Copilot reste documenté : les pages historiques sur les **AI Credits Copilot** sont conservées comme référence distincte, mais ne constituent plus le parcours principal.

!!! info "Référence"
    Informations revérifiées le **28 septembre 2026** sur les pages officielles Anthropic. Les prix et limites peuvent évoluer ; vérifiez toujours la page de tarification avant une décision budgétaire.

---

## Pages du chapitre

<div class="grid cards" markdown>

- :material-swap-horizontal: **[Réduire les allers-retours](patterns-allers-retours.md)**

    Réduire le coût réel en donnant le bon contexte, en découpant les tâches et en demandant des validations exécutables.

- :material-credit-card: **[Abonnements Claude & accès Claude Code](abonnements.md)**

    Pro, Max, Team, Enterprise, limites d'usage, crédits d'usage et différence avec l'API.

- :material-piggy-bank: **[Leviers d'économie](leviers-economie.md)**

    Contexte minimal utile, `/clear`, `/compact`, skills, subagents, choix du modèle et limitation des outils.

- :material-transit-connection-variant: **[Quand utiliser quel mode ?](modes-quand-utiliser.md)**

    Interaction directe, Plan, agent principal, subagents et automatisation selon la complexité réelle.

- :material-routes: **[Workflow recommandé](workflow-recommande.md)**

    Explore → Plan → Implement → Verify avec contrôles de coût et de contexte.

- :material-star-circle: **[AI Credits Copilot — référence](premium-requests.md)**

    Ancien parcours principal conservé pour les utilisateurs GitHub Copilot.

- :material-history: **[Historique coûts & modèles](historique-modifications.md)**

    Journal des changements de tarification et de quotas ; les entrées Copilot restent conservées.

</div>

---

## Comprendre les quatre couches de coût

| Couche | Ce qu'elle signifie |
|---|---|
| **Abonnement Claude** | Pro, Max ou siège Team/Enterprise donnant accès à Claude Code selon le plan |
| **Limites d'usage** | Fenêtres d'usage et limites supplémentaires ; l'activité Claude et Claude Code peut partager le même pool |
| **Usage credits** | Sur certains plans payants, permettent de continuer après une limite selon les conditions du compte |
| **API / Console** | Facturation à l'usage aux tarifs API ; distincte de l'abonnement grand public |

!!! warning "Ne pas comparer directement avec les AI Credits Copilot"
    Les **AI Credits GitHub Copilot** et les limites/crédits d'usage Claude sont deux systèmes différents. Ne transposez pas un quota ou une unité d'un produit vers l'autre.

---

## Plans Claude actuels — vue rapide

D'après la tarification Anthropic vérifiée le 28 septembre 2026 :

- **Pro** inclut Claude Code ;
- **Max** inclut Claude Code avec deux niveaux d'usage supérieurs ;
- **Team** propose des sièges Standard et Premium avec Claude Code ;
- **Enterprise** combine un coût de siège et de l'usage facturé aux tarifs API selon l'offre ;
- le plan **Free** n'inclut pas Claude Code dans la matrice actuelle.

Les montants exacts et conditions sont détaillés dans [Les abonnements](abonnements.md).

---

## Le coût le plus important : le rework

Un contexte trop large, un objectif ambigu ou l'absence de tests peuvent coûter plus cher qu'un modèle plus puissant utilisé correctement.

```text
Contexte ciblé
→ plan adapté à la complexité
→ modification limitée
→ tests / build / diff
→ correction seulement si une preuve échoue
```

Les principaux leviers sont donc :

1. garder `CLAUDE.md` concis ;
2. charger les détails via rules/skills seulement quand ils sont utiles ;
3. utiliser `/clear` entre tâches sans rapport ;
4. utiliser `/compact` sur une session longue ;
5. déléguer les explorations volumineuses à des subagents ;
6. faire exécuter les validations plutôt que multiplier les échanges spéculatifs.

---

## Gouvernance d'équipe

Pour une équipe, suivez au minimum :

- consommation et limites par population ;
- modèles autorisés ;
- permissions d'outils et de providers ;
- MCP approuvés ;
- règles sur les données sensibles ;
- commandes destructives ou à haut impact ;
- qualité mesurée : taux de tests passés, rework, incidents et temps de revue.

Ne mesurez pas uniquement le nombre de requêtes. Une tâche autonome plus longue peut être rentable si elle produit un résultat testé et réduit plusieurs cycles de correction.

---

## Sources

- [Claude — Plans & Pricing](https://claude.com/pricing) — consulté le 2026-09-28
- [Anthropic Help — Use Claude Code with Pro or Max](https://support.claude.com/en/articles/11145838-use-claude-code-with-your-pro-or-max-plan) — consulté le 2026-09-28
- [Claude Code — Cost management](https://code.claude.com/docs/en/costs) — consulté le 2026-09-28

## Prochaine étape

**[Les abonnements Claude](abonnements.md)** : distinguer abonnement, limites d'usage et facturation API avant d'optimiser le workflow.