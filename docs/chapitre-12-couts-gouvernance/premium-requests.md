# AI Credits : consommation detaillee (et legacy premium requests)

<span class="badge-intermediate">Intermediaire</span>

Depuis juin 2026, le referentiel principal de facturation Copilot est la consommation en **AI Credits**. Cette page explique comment la consommation est calculee, ce qui est facture, et comment optimiser l'usage pour garder un bon niveau de productivite sans derive de cout.

!!! info "Reference de cette page"
    Contenu reverifie le **1 juin 2026** sur la documentation officielle GitHub Copilot.

!!! warning "Important"
    Le modele **premium requests** est desormais **legacy** pour des cas specifiques (notamment certains abonnements annuels restes sur l'ancien mode). Pour la majorite des usages, piloter la consommation en **AI Credits**.

---

## Comment sont calcules les AI Credits

Le cout d'une interaction Copilot depend de deux variables:

- le **modele** utilise
- le nombre de **tokens** consommes (entree, sortie, cache)

Regle de conversion officielle:

- **1 AI Credit = 0,01 USD**

Formule pratique:

$$
\text{AI Credits} = \frac{\text{cout total en USD}}{0{,}01}
$$

ou le cout total en USD depend des tarifs par million de tokens du modele.

!!! tip "Lecture des tarifs"
    Utiliser la page officielle "Models and pricing for GitHub Copilot" pour convertir les volumes de tokens en credits selon le modele exact.

---

## Ce qui consomme des AI Credits (et ce qui ne consomme pas)

Consomme des AI Credits:

- Copilot Chat
- Copilot CLI
- Copilot cloud agent
- Copilot Spaces
- Spark
- Agents tiers

Ne consomme pas d'AI Credits:

- Code completions (autocompletion)
- Next edit suggestions

!!! info "Point cle"
    Les completions et suggestions d'edition restent non facturees en AI Credits sur les plans payants.

---

## Facteurs qui font varier la consommation

Les principaux leviers de consommation sont:

- **Longueur et complexite** de la conversation
- **Usage agentique** (plus d'appels modele au sein d'une tache)
- **Choix du modele** (cout/token different selon le modele)
- **Taille du contexte** (tokens envoyes en entree)

!!! tip "Reduction immediate"
    Reduire le contexte aux fichiers utiles et preferer un modele leger pour les taches simples est la maniere la plus rapide de diminuer les credits consommes.

---

## Exemples concrets de consommation

### Exemple A - Chat court, modele leger

- Prompt court + reponse courte
- Modele leger (ex. GPT-5 mini / Claude Haiku)
- Cout: souvent une fraction de credit a quelques credits

### Exemple B - Session agent longue, modele puissant

- Tache multi-fichiers avec iterations
- Modele frontier
- Cout: nettement plus eleve, potentiellement des dizaines a centaines de credits selon le volume de tokens

---

## Que se passe-t-il quand les credits sont epuises?

### Comptes individuels

- Definir un budget additionnel (facture en USD), ou
- Attendre le cycle mensuel suivant

### Organisations et entreprises

- Les credits inclus sont **pooles** au niveau de l'entite de facturation
- Si le pool est epuise:
  - usage additionnel autorise: la facturation continue
  - usage additionnel bloque: acces aux fonctionnalites consommatrices de credits bloque jusqu'au cycle suivant

Important:

- Il n'y a **pas de fallback automatique** vers un modele moins cher quand un budget bloque l'usage.
- Les code completions et next edit suggestions continuent de fonctionner.

---

## Surveiller la consommation

=== ":material-microsoft-visual-studio-code: VS Code"

    Icone Copilot dans la barre de statut puis parametres Copilot pour un apercu local.

    Pour la facturation detaillee: [github.com/settings/billing](https://github.com/settings/billing).

=== ":simple-intellijidea: IntelliJ IDEA"

    Selon la version, le quota est visible via l'icone Copilot.

    Pour les details complets: [github.com/settings/billing](https://github.com/settings/billing).

---

## Legacy : premium requests (cas restants)

Le modele premium requests reste documente pour certains abonnements annuels legacy.

A retenir:

- ce n'est plus le modele cible pour la majorite des nouveaux usages
- les pages legacy servent surtout a comprendre un heritage de facturation

---

## Sources

- [Usage-based billing for individuals](https://docs.github.com/en/copilot/concepts/billing/usage-based-billing-for-individuals) - consulte le 2026-06-01
- [Usage-based billing for organizations and enterprises](https://docs.github.com/en/copilot/concepts/billing/usage-based-billing-for-organizations-and-enterprises) - consulte le 2026-06-01
- [Models and pricing for GitHub Copilot](https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing) - consulte le 2026-06-01
- [Requests in GitHub Copilot (legacy)](https://docs.github.com/en/copilot/reference/copilot-billing/request-based-billing-legacy/copilot-requests) - consulte le 2026-06-03

---

## Prochaine etape

**[Les abonnements](abonnements.md)** : comparatif detaille des plans GitHub Copilot avec allocations AI Credits, gouvernance et criteres de choix.

Concepts cles couverts :

- **Plans disponibles** - Free, Student, Pro, Pro+, Max, Business, Enterprise
- **Allocations AI Credits** - individuel, pool organisation, depassement
- **Fonctionnalites exclusives** - Agent, gouvernance, audit, politiques
- **Quel plan choisir** - matrice decision selon volume, budget et conformite
