# Coûts & Gouvernance

Utiliser GitHub Copilot efficacement, c'est aussi savoir gérer ce qu'il consomme. Ce chapitre couvre les mécanismes de facturation, les leviers pour optimiser l'usage quotidien, et les workflows qui maximisent la valeur tout en minimisant le gaspillage de requêtes.

!!! info "État de référence"
    Contenu vérifié le **4 mai 2026**.
    La facturation Copilot bascule vers un modèle **usage-based avec AI Credits** à partir du **1er juin 2026**. Ce chapitre documente la période de transition et fournit un suivi avant/après.

---

## Pages du Chapitre

<div class="grid cards" markdown>

- :material-swap-horizontal: **[Patterns pour réduire les allers-retours](patterns-allers-retours.md)**

    Structurer ses prompts pour obtenir la bonne réponse dès la première fois : contexte complet, formulation directe, templates réutilisables.

- :material-star-circle: **[Premium Requests : mécanique](premium-requests.md)**

    Ce qu'est une premium request, quels modèles la consomment, comment surveiller son solde et anticiper les limites.

- :material-history: **[Historique des changements coûts & modèles](historique-modifications.md)**

    Suivi mensuel daté avec comparaison **Avant / Après** sur les plans, quotas, modèles et règles de facturation.

- :material-credit-card: **[Les abonnements](abonnements.md)**

    Comparatif Free / Pro / Business / Enterprise : quotas, fonctionnalités et critères de choix selon le profil.

- :material-piggy-bank: **[Leviers d'économie (pragmatiques)](leviers-economie.md)**

    Décisions concrètes pour dépenser moins sans payer en productivité : bon modèle, bon mode, bon contexte.

- :material-transit-connection-variant: **[Quand utiliser quel mode ?](modes-quand-utiliser.md)**

    Autocomplétion, Chat, Edits, Agent — coût et pertinence de chaque mode selon la tâche à réaliser.

- :material-routes: **[Workflow recommandé](workflow-recommande.md)**

    Séquence optimale au quotidien pour combiner les modes intelligemment et éviter les requêtes inutiles.

</div>

---

## Vue d'ensemble rapide

| Sujet | Résumé |
|-------|--------|
| [Allers-retours](patterns-allers-retours.md) | Chaque itération coûte des requêtes — le contexte complet dès le départ réduit les cycles |
| [Premium requests](premium-requests.md) | Fonctionnement request-based actuel, transition AI Credits et impacts par mode |
| [Historique](historique-modifications.md) | Traçabilité mensuelle des évolutions coûts/modèles avec diff Avant/Après |
| [Abonnements](abonnements.md) | Free · Pro · Pro+ · Business · Enterprise — comparaison datée et périmètres |
| [Économies](leviers-economie.md) | Choisir le modèle le plus léger adapté à la tâche |
| [Modes](modes-quand-utiliser.md) | Inline < Chat < Edits < Agent en termes de coût de requêtes |
| [Workflow](workflow-recommande.md) | Inline pour la répétition, Chat pour l'exploration, Agent pour les grandes tâches |

---

## Prochaine étape

**[Patterns pour réduire les allers-retours](patterns-allers-retours.md)** : structurer ses prompts pour obtenir la bonne réponse dès la première fois et éviter les cycles inutiles de corrections.

Concepts clés couverts :

- **Contexte complet dès le départ** — Passer de 5 échanges à 1 en formulant précisément
- **Templates de prompts réutilisables** — Supprimer la redondance dans les explicications
- **Références explicites avec #file/@workspace** — Éliminer l'ambiguïté sur le contexte
- **Checkpoints en Agent Mode** — Valider le plan avant exécution plutôt que refactoriser après
