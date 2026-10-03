# Les abonnements Claude et l'accès à Claude Code

<span class="badge-beginner">Débutant</span>

Cette page décrit le modèle de coût **Claude** actuel.

!!! info "Référence"
    Tarification vérifiée le **3 octobre 2026** sur `claude.com/pricing` et le centre d'aide Anthropic. Les prix affichés ici sont hors taxes et peuvent évoluer.

---

## Vue d'ensemble actuelle

Pour Team, le plafond est de **150 sièges**, avec un minimum de **2 membres** selon la documentation revérifiée le 3 octobre 2026. Au-delà, Anthropic indique le passage à Enterprise. Les sièges Premium et usage credits augmentent les possibilités d'usage, pas le plafond de membres : voir [les détails et la procédure de migration](../chapitre-3b-claude-code-migration-copilot/couts-quotas.md#combien-de-sieges-team-et-comment-depasser-la-limite).

| Plan | Prix public indiqué | Claude Code | Usage |
|---|---:|:---:|---|
| Free | 0 USD | ❌ | Usage Claude de base |
| Pro | 20 USD/mois, ou 200 USD/an | ✅ | Plus d'usage que Free |
| Max 5x | 100 USD/mois | ✅ | 5x l'usage Pro par fenêtre de session, sous réserve des autres limites |
| Max 20x | 200 USD/mois | ✅ | 20x l'usage Pro par fenêtre de session, sous réserve des autres limites |
| Team Standard | 20 USD/siège/mois annuel, 25 USD mensuel | ✅ | Plus d'usage que Pro |
| Team Premium | 100 USD/siège/mois annuel, 125 USD mensuel | ✅ | 5x l'usage d'un siège Standard |
| Enterprise | offre publique : 20 USD/siège/mois annuel ; contrat à vérifier | ✅ | Usage aux tarifs API en supplément selon l'offre |

!!! warning "Pas de nombre fixe de messages"
    Anthropic n'annonce pas un nombre universel de requêtes Claude Code. La consommation dépend notamment de la longueur des conversations, du modèle, des outils et de la complexité des tâches.

---

Les tarifs Team ci-dessus sont les prix publics **US en USD**. Devise, taxes et prix locaux peuvent différer. [Centre d’aide — Team](https://support.claude.com/en/articles/9266767-what-is-the-team-plan), revérifié le 3 octobre 2026. Vérifiez le devis Enterprise : les offres par sièges et les contrats à consommation ne donnent pas une enveloppe identique.

## Pro et Max : pool partagé

Pour les abonnements individuels, Claude Code et les autres surfaces Claude utilisent un **pool d'usage partagé**. Les limites se réinitialisent notamment sur une fenêtre glissante de cinq heures, avec des limites supplémentaires possibles sur des périodes plus longues.

Conséquence :

- une longue session Claude Code peut réduire la capacité disponible ailleurs ;
- une conversation web volumineuse peut aussi consommer une partie du même budget ;
- la bonne unité de pilotage n'est pas « nombre de prompts », mais la quantité de travail réellement accomplie avant rework.

---

## Que se passe-t-il à la limite ?

Selon le plan et les réglages disponibles, vous pouvez :

1. attendre le renouvellement de la limite ;
2. passer à un plan avec davantage d'usage ;
3. sur certains plans payants, activer des **usage credits** pour continuer au tarif API standard.

Vérifiez l'état actuel dans **Settings → Usage** côté Claude.

---

## Abonnement Claude ≠ API Anthropic

Deux modèles de facturation coexistent :

### Abonnement Claude

Adapté aux développeurs utilisant Claude Code au quotidien avec une enveloppe d'usage incluse.

### Claude API / Console

Facturation à l'usage selon le modèle et les tokens/ressources consommés. Elle convient notamment aux intégrations programmatiques, agents automatisés et pipelines applicatifs.

Ne supposez pas qu'un abonnement Pro ou Max constitue automatiquement un crédit API général.

---

## Comment choisir un plan sans pseudo-benchmark

Ne choisissez pas uniquement sur la taille du dépôt. Mesurez pendant une période représentative :

- nombre de sessions interrompues par une limite ;
- fréquence des tâches longues ;
- volume de contexte nécessaire ;
- part de travail interactif vs automatisé ;
- coût du temps perdu lorsque l'usage est bloqué ;
- possibilité d'utiliser un provider/API géré par l'organisation.

```text
Usage occasionnel de Claude Code
→ Pro peut suffire

Usage quotidien avec sessions longues
→ comparer Pro et Max sur vos limites réelles

Équipe avec gouvernance centralisée
→ Team / Enterprise selon sécurité, identité, audit et budget

Automatisation applicative / CI
→ raisonner aussi en coût API, pas seulement en siège
```

Ce sont des critères de décision, pas une recommandation universelle.

---

## Réduire la consommation avant d'augmenter le plan

Avant de payer davantage, vérifiez :

- `CLAUDE.md` trop long ;
- sessions mélangeant plusieurs sujets ;
- gros outputs de commandes réinjectés intégralement ;
- MCP trop bavards ;
- sous-agents lancés sans besoin clair ;
- absence de `/clear` entre tâches ;
- absence de tests ou critères de validation, entraînant plusieurs corrections.

Un meilleur contexte peut réduire la consommation sans diminuer la qualité.

---

## Sources

- [Claude — Plans & Pricing](https://claude.com/pricing) — consulté le 2026-09-28
- [Anthropic Help — Use Claude Code with Pro or Max](https://support.claude.com/en/articles/11145838-use-claude-code-with-your-pro-or-max-plan) — consulté le 2026-09-28
- [Anthropic Help — What is the Max plan?](https://support.claude.com/en/articles/11049741-what-is-the-max-plan) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-12-couts-gouvernance.md#page-chapitre-12-couts-gouvernance-abonnements).

## Prochaine étape

Poursuivez avec **[Leviers d'économie](leviers-economie.md)**, la page suivante dans le menu.
