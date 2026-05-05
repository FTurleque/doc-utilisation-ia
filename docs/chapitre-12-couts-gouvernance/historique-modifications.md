# Historique des restrictions & évolutions GitHub Copilot

<span class="badge-intermediate">Intermédiaire</span>

!!! info "Objet de cette page"
    Cette page trace les **changements décidés par GitHub dans son produit**, avec une date précise et une source officielle vérifiable.
    Elle ne documente pas les modifications de cette documentation, mais l'évolution réelle de l'offre Copilot.
    Utilisez-la pour **comparer ce qui était accessible hier et ce qui est restreint aujourd'hui**.

!!! tip "Cadence de maintenance"
    Mise à jour à chaque annonce majeure. Source de surveillance : [GitHub Copilot Changelog](https://github.blog/changelog/?label=copilot).

---

## Pourquoi ce registre existe

L'offre GitHub Copilot évolue rapidement. Des modèles autrefois inclus dans un abonnement standard deviennent premium. Des fonctionnalités réservées aux équipes payantes disparaissent de l'accès individuel. Des quotas autrefois souples sont maintenant strictement appliqués.

Ce registre documente ces changements **avec des preuves**, pour permettre à une équipe ou une direction de mesurer concrètement le coût de l'attente.

---

## Timeline des changements GitHub Copilot (2026 → 2024)

### 2026-06-01 — Bascule vers la facturation AI Credits (planifié)

- **Catégorie** : Tarification — changement de modèle
- **Plan impacté** : Tous les plans
- **Avant** : facturation basée sur des **premium requests** (quota mensuel fixe par plan)
- **Après** : facturation basée sur les **AI Credits** — 1 AI Credit = $0,01 USD, consommation proportionnelle aux tokens utilisés et au modèle choisi
- **Ce que ça signifie** : la prévisibilité du budget disparaît partiellement. Un même usage peut coûter différemment selon le modèle sélectionné. Les équipes sans culture de pilotage de la consommation IA seront les plus exposées.
- **Source** : [Plans GitHub Copilot](https://docs.github.com/fr/copilot/get-started/plans), [Usage-based billing (individuels)](https://docs.github.com/fr/copilot/concepts/billing/usage-based-billing-for-individuals)

---

### 2026-05-01 — Dépréciation annoncée de GPT-5.2 et GPT-5.2-Codex

- **Catégorie** : Modèles IA — obsolescence accélérée
- **Plan impacté** : Pro, Business, Enterprise
- **Avant** : GPT-5.2 et GPT-5.2-Codex disponibles et utilisables
- **Après** : annonce de leur suppression à venir — les utilisateurs qui ont intégré ces modèles dans leurs workflows doivent migrer
- **Ce que ça signifie** : le cycle de vie des modèles dans Copilot s'accélère. Un modèle peut devenir obsolète en quelques mois, forçant des adaptations régulières.
- **Source** : [Changelog GitHub — 2026-05-01](https://github.blog/changelog/2026-05-01-upcoming-deprecation-of-gpt-5-2-and-gpt-5-2-codex)

---

### 2026-04-24 — GPT-5.5 disponible en GA — modèle premium à multiplicateur élevé

- **Catégorie** : Modèles IA / Tarification
- **Plan impacté** : Business, Enterprise (uniquement)
- **Avant** : GPT-5.4 comme modèle OpenAI le plus récent
- **Après** : GPT-5.5 GA — réservé aux plans Business et Enterprise, avec un **multiplicateur de consommation de 7,5× par rapport au modèle de base**
- **Ce que ça signifie** : chaque interaction avec GPT-5.5 consomme 7,5 fois plus de quota premium que les modèles standard. Un modèle de pointe est maintenant doublement réservé : par plan ET par coût de consommation.
- **Source** : [Changelog GitHub — 2026-04-24](https://github.blog/changelog/2026-04-24-gpt-5-5-is-generally-available-for-github-copilot)

---

### 2026-04-22 — Nouvelles inscriptions Business self-serve suspendues

- **Catégorie** : Politique d'accès
- **Plan impacté** : Business (organisations sur GitHub Free et GitHub Team)
- **Avant** : possibilité de souscrire à Copilot Business en self-serve
- **Après** : inscriptions self-serve suspendues — les nouvelles organisations doivent contacter GitHub Sales
- **Ce que ça signifie** : une équipe qui décide aujourd'hui d'adopter Copilot Business ne peut plus le faire de manière autonome. Le passage par une étape commerciale ajoute du délai et de la friction.
- **Source** : [Changelog GitHub — 2026-04-22](https://github.blog/changelog/2026-04-22-pausing-new-self-serve-signups-for-github-copilot-business)

---

### 2026-04-20 — Opus retiré du plan Pro — Pro+ obligatoire

- **Catégorie** : Modèles IA — restriction majeure
- **Plan impacté** : **Pro** (impact direct), Pro+ (devient le nouveau minimum pour Opus)
- **Avant** : Claude Opus 4.5 et versions antérieures accessibles sur Pro ($10/mois)
- **Après** : **tous les modèles Opus retirés du plan Pro**. Opus 4.7 reste disponible uniquement sur Pro+ ($39/mois). Nouvelles inscriptions Pro, Pro+ et Student **suspendues** le même jour.
- **Ce que ça signifie** : un utilisateur Pro qui accédait à Opus pour $10/mois doit passer à Pro+ à $39/mois pour le même niveau de modèle — **soit +290% de coût**.
- **Source** : [Changelog GitHub — 2026-04-20](https://github.blog/changelog/2026-04-20-changes-to-github-copilot-plans-for-individuals)

!!! danger "C'est l'événement clé de ce registre"
    En moins de 5 mois (de décembre 2025 à avril 2026), l'accès à Claude Opus est passé de **inclus dans Pro à $10/mois** à **réservé à Pro+ à $39/mois**. Aucune fonctionnalité équivalente n'a été ajoutée au plan Pro pour compenser.

---

### 2026-04-16 — Claude Opus 4.7 disponible en GA

- **Catégorie** : Modèles IA
- **Plan impacté** : Business, Enterprise (uniquement — voir note ci-dessous)
- **Avant** : Opus 4.5 et 4.6 disponibles
- **Après** : Opus 4.7 GA — **mais déjà uniquement sur Business et Enterprise** au moment de sa sortie
- **Ce que ça signifie** : la génération suivante d'Opus arrive directement dans les tiers supérieurs, sans passer par Pro.
- **Source** : [Changelog GitHub — 2026-04-16](https://github.blog/changelog/2026-04-16-claude-opus-4-7-is-generally-available)

---

### 2026-04-10 — Essais gratuits de Copilot Pro suspendus

- **Catégorie** : Politique d'accès
- **Plan impacté** : Pro
- **Avant** : possibilité de tester Copilot Pro gratuitement avant souscription
- **Après** : essais gratuits suspendus — impossibilité d'évaluer le plan sans payer
- **Ce que ça signifie** : la pression sur l'infrastructure pousse GitHub à limiter l'onboarding. Les équipes qui n'ont pas encore évalué Copilot Pro ne peuvent plus le faire sans engagement financier.
- **Source** : [Changelog GitHub — 2026-04-10](https://github.blog/changelog/2026-04-10-pausing-new-github-copilot-pro-trials)

---

### 2026-04-10 — Limites de débit imposées + Opus 4.6 Fast retiré de Pro+

- **Catégorie** : Quotas / Restrictions de modèles
- **Plan impacté** : Pro+ (principalement)
- **Avant** : usage de Copilot sans limite de débit appliquée strictement par session
- **Après** : deux types de limites introduites : (1) limites de fiabilité générale du service, (2) limites par modèle ou famille de modèles. Opus 4.6 Fast retiré de Pro+ dès ce jour.
- **Ce que ça signifie** : premier signal concret de la mise sous pression de l'infrastructure. Les utilisateurs doivent désormais "étaler" leur consommation ou changer de modèle quand une limite est atteinte.
- **Source** : [Changelog GitHub — 2026-04-10](https://github.blog/changelog/2026-04-10-enforcing-new-limits-and-retiring-opus-4-6-fast-from-copilot-pro)

---

### 2025-12-18 — Claude Opus 4.5 disponible en GA pour les utilisateurs Pro

- **Catégorie** : Modèles IA — accès étendu
- **Plan impacté** : Pro, Business, Enterprise
- **Avant** : modèles Opus non disponibles ou en preview restreinte
- **Après** : Claude Opus 4.5 GA — accessible aux utilisateurs Pro ($10/mois) et niveaux supérieurs
- **Ce que ça signifie** : **fin 2025, un abonnement Pro à $10/mois donne accès à Claude Opus**, l'un des modèles les plus puissants d'Anthropic. Cette situation changera radicalement en avril 2026.
- **Source** : [Changelog GitHub — 2025-12-18](https://github.blog/changelog/2025-12-18-claude-opus-4-5-is-now-generally-available-in-github-copilot)

---

### 2024-12-18 — Lancement de GitHub Copilot Free

- **Catégorie** : Nouveaux plans / Découpage d'accès
- **Plan impacté** : Free (nouveau plan)
- **Avant** : pas de tier gratuit — Copilot nécessitait un abonnement Pro ($10/mois), Business, ou un accès via GitHub Education
- **Après** : plan Free lancé avec **2 000 complétions/mois** et **50 messages de chat/mois** — accès limité aux modèles de base
- **Ce que ça signifie** : GitHub crée un tier d'appel attractif, mais qui établit aussi des limites strictes là où il n'y en avait pas pour les nouveaux utilisateurs. Le plan Pro reste à $10/mois mais se voit désormais différencié par des quotas.
- **Source** : [Changelog GitHub — 2024-12-18](https://github.blog/changelog/2024-12-18-announcing-github-copilot-free)

---

### 2024-12-06 — Fenêtre contextuelle Chat portée à 64 000 tokens (GPT-4o)

- **Catégorie** : Limites de contexte
- **Plan impacté** : Pro, Business, Enterprise
- **Avant** : fenêtre contextuelle standard dans Copilot Chat, non documentée publiquement
- **Après** : fenêtre de 64 000 tokens annoncée pour le Chat avec GPT-4o — amélioration notable pour les échanges longs
- **Ce que ça signifie** : à cette époque, les contextes longs sont accessibles. Ce paramètre évoluera selon le modèle choisi et le plan, rendant les comparaisons ultérieures plus complexes.
- **Source** : [Changelog GitHub — 2024-12-06](https://github.blog/changelog/2024-12-06-copilot-chat-now-has-a-64k-context-window-with-openai-gpt-4o)

---

### 2024-11-12 — Content exclusion disponible en GA dans les IDEs

- **Catégorie** : Fonctionnalités réservées
- **Plan impacté** : Business, Enterprise (exclusivement)
- **Avant** : content exclusion en preview, périmètre flou
- **Après** : fonctionnalité GA — mais **réservée aux plans payants organisation** (Business/Enterprise). Indisponible sur Free, Pro, Pro+.
- **Ce que ça signifie** : la capacité d'exclure des fichiers sensibles du contexte Copilot (données métier, secrets) n'est pas accessible aux développeurs individuels, même payants
- **Source** : [Changelog GitHub — 2024-11-12](https://github.blog/changelog/2024-11-12-content-exclusion-ga)

---

### 2024-11-01 — Claude 3.5 Sonnet disponible pour tous (preview)

- **Catégorie** : Modèles IA
- **Plan impacté** : Free, Pro, Business, Enterprise
- **Avant** : seul GPT-4o disponible dans le Chat Copilot
- **Après** : Claude 3.5 Sonnet (Anthropic) ajouté comme modèle alternatif pour tous les utilisateurs
- **Ce que ça signifie** : premier signe de l'ère multi-modèles — l'accès est alors généreux, sans système de quotas stricts appliqués par modèle
- **Source** : [Changelog GitHub — 2024-11-01](https://github.blog/changelog/2024-11-01-claude-3-5-sonnet-is-now-available-to-all-copilot-users-in-public-preview)

---

## Synthèse : ce qu'un abonnement Pro ($10/mois) donnait selon la période

| Période | Modèles inclus | Accès Opus | Quotas | Essais gratuits |
|---------|---------------|:----------:|--------|:--------------:|
| Nov. 2024 | GPT-4o + Claude Sonnet 3.5 | Non (preview) | Accès souple | Oui |
| Déc. 2025 | GPT-4o + Sonnet + **Opus 4.5** | **Oui** | ~300 req/mois | Oui |
| **Avr. 2026** | GPT-4.1 + Sonnet 4.x | **Non** → Pro+ requis | 300 req/mois strict | **Non** |
| Juin 2026 | GPT-4.1 + Sonnet 4.x | Non → Pro+ requis | AI Credits | Non |

---

## Le coût de l'inaction : scénario chiffré

!!! danger "Le retard se traduit en euros"
    Voici l'impact financier direct d'une adoption tardive pour une **équipe de 5 développeurs** cherchant un accès aux modèles les plus avancés (type Opus) :

    | Moment d'adoption | Plan requis | Coût mensuel | Coût annuel |
    |---|---|---|---|
    | **Décembre 2025** | Pro — $10/user | $50/mois | **$600/an** |
    | **Mai 2026** | Pro+ — $39/user | $195/mois | **$2 340/an** |

    **Écart : +$1 740/an, soit +290% pour le même niveau d'accès aux modèles.**

    Ce calcul ne tient pas compte :

    - De la **dette d'apprentissage** : 12 à 18 mois de retard sur les pratiques IA face aux équipes déjà formées
    - De l'**inaccessibilité temporaire** : inscriptions Pro et Business suspendues depuis avril 2026, rendant la migration plus difficile
    - Du **coût de migration** : workflows et habitudes à rebâtir lors d'un changement de plan tardif

!!! info "Source des tarifs"
    Prix vérifiés le 4 mai 2026 sur [docs.github.com/fr/copilot/get-started/plans](https://docs.github.com/fr/copilot/get-started/plans).

---

## Checklist mensuelle de mise à jour

- [ ] Consulter le [Changelog GitHub Copilot](https://github.blog/changelog/?label=copilot) pour les nouvelles entrées
- [ ] Revalider plans, prix et quotas depuis la [page officielle des plans](https://docs.github.com/fr/copilot/get-started/plans)
- [ ] Revalider les modèles inclus/premium et leurs multiplicateurs
- [ ] Revalider les règles de dépassement (budget, blocage, fallback)
- [ ] Ajouter les nouvelles entrées à la timeline ci-dessus avec date précise et source
- [ ] Mettre à jour le tableau "Synthèse" si un plan ou un accès évolue
- [ ] Mettre à jour la date "Vérifié le" dans les pages du chapitre 12

---

## Sources officielles de contrôle

- Changelog Copilot (source primaire pour les mises à jour) : [github.blog/changelog/?label=copilot](https://github.blog/changelog/?label=copilot)
- Plans et prix : [docs.github.com/fr/copilot/get-started/plans](https://docs.github.com/fr/copilot/get-started/plans)
- Premium requests et multiplicateurs : [docs.github.com/fr/copilot/concepts/billing/copilot-requests](https://docs.github.com/fr/copilot/concepts/billing/copilot-requests)
- Facturation usage-based (individuels) : [docs.github.com/fr/copilot/concepts/billing/usage-based-billing-for-individuals](https://docs.github.com/fr/copilot/concepts/billing/usage-based-billing-for-individuals)
- Facturation usage-based (organisations) : [docs.github.com/fr/copilot/concepts/billing/usage-based-billing-for-organizations-and-enterprises](https://docs.github.com/fr/copilot/concepts/billing/usage-based-billing-for-organizations-and-enterprises)
- Modèles et tarification : [docs.github.com/fr/copilot/reference/copilot-billing/models-and-pricing](https://docs.github.com/fr/copilot/reference/copilot-billing/models-and-pricing)

---

## Lecture complémentaire

- **[Les abonnements](abonnements.md)** — comparatif détaillé des plans actuels (Free, Pro, Pro+, Business, Enterprise)
- **[Premium Requests](premium-requests.md)** — mécanique des quotas et multiplicateurs par modèle
- **[Leviers d'économie](leviers-economie.md)** — comment réduire la consommation quel que soit le plan
- **[Quand utiliser quel mode ?](modes-quand-utiliser.md)** — impact des modes Inline, Chat, Edits, Agent sur la consommation
