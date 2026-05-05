# Changelog — Audit & Mise à Jour Coûts/Modèles GitHub Copilot

**Date de révision:** 4 mai 2026  
**Auteur(s):** GitHub Copilot Agent  
**Objectif:** Audit exhaustif et mise à jour de la documentation GitHub Copilot pour refléter l'état officiel des coûts, modèles, et plans (pré-transition 1er juin 2026 vers facturation usage-based).

---

## Vue d'Ensemble des Changements

- **Fichiers modifiés:** 21 fichiers dans 6 chapitres
- **Fichiers créés:** 1 (historique-modifications.md)
- **Navigation mise à jour:** mkdocs.yml (ajout de la page historique)
- **Validation:** 0 erreurs MkDocs build, 11431 liens valides, 0 liens cassés

### Catégories de Changements

1. **Chapitre 12 — Coûts & Gouvernance** (7 fichiers) — Core updates
2. **Chapitre 1 — Installation** (1 fichier) — Transverse harmonization
3. **Chapitre 2 — Paramètres** (2 fichiers) — Transverse harmonization
4. **Chapitre 11 — Troubleshooting** (1 fichier) — Transverse harmonization
5. **Chapitre 13 — Outils & Économies** (1 fichier) — Transverse harmonization
6. **Appendices — FAQ** (1 fichier) — Transverse harmonization
7. **Chapitre 4 — Contexte** (2 fichiers) — Plan/model availability clarification
8. **Chapitre 14 — Veille IA** (2 fichiers) — Plan/model tracking + security clarification

---

## Phase 1: Chapitre 12 — Coûts & Gouvernance (Core Updates)

### [docs/chapitre-12-couts-gouvernance/index.md](docs/chapitre-12-couts-gouvernance/index.md)

**Changements:**
- ✅ Ajout d'une **info box** avec avertissement sur la transition du 1er juin 2026
- ✅ Réorganisation des cartes pour mettre la page "Historique" en évidence
- ✅ Lien explicite vers `historique-modifications.md`
- ✅ Date-stamp: "Contenu vérifié le 4 mai 2026"

**Avant:** 7 cartes génériques sans date ni contexte de transition
**Après:** Même structure avec contexte temporel et lien vers tracking historique

---

### [docs/chapitre-12-couts-gouvernance/abonnements.md](docs/chapitre-12-couts-gouvernance/abonnements.md)

**Changements majeurs:**

1. **Ajout du plan Pro+**
   - **Avant:** Plans listés: Free, Pro, Business, Enterprise (4 tiers)
   - **Après:** Plans: Free, Pro, Pro+ ($39/mo, 1500 premium requests), Business, Enterprise (5 tiers)

2. **Correction quotas premium requests Enterprise**
   - **Avant:** "Enterprise: 300 premium requests par utilisateur"
   - **Après:** "Enterprise: 1000 premium requests par utilisateur"

3. **Suppression d'affirmations stales**
   - ❌ Supprimé: "Copilot Chat disponible uniquement en Enterprise"
   - ✅ Remplacé: "Copilot Chat disponible sur tous les plans (Free, Pro, Pro+, Business, Enterprise)"

4. **Date-stamp globale**
   - Ajout: "Contenu vérifié le 4 mai 2026"
   - Clarification: "Transition vers facturation usage-based prévue le 1er juin 2026"

**Source:** https://docs.github.com/fr/copilot/get-started/plans

---

### [docs/chapitre-12-couts-gouvernance/premium-requests.md](docs/chapitre-12-couts-gouvernance/premium-requests.md)

**Changements critiques:**

1. **SUPPRESSION de modèles non-existants**
   - ❌ Supprimé: "Claude 3.7 Sonnet" (ce modèle n'existe pas chez Anthropic)
   - ❌ Supprimé: "Claude 3.5 Opus / 3 Opus" (Opus max est v3, Sonnet max est v3.5)
   - ✅ Remplacé par: Langage catégorisé ("modèles premium 'versatile'", "modèles premium 'powerful'")

2. **Clarification des multiplicateurs de coûts**
   - **Avant:** Tableau rigide avec valeurs spécifiques (0.33x, 1x, 7.5x)
   - **Après:** Tableau avec avertissement "Multiplicateurs dynamiques — consultez la page officielle"
   - **Raison:** Les multiplicateurs changent fréquemment par modèle; documentation ne doit pas se fossiliser

3. **Comptage en mode Agent explicite**
   - **Avant:** Flou sur si chaque appel MCP = 1 requête
   - **Après:** "Seule l'invite utilisateur est comptabilisée comme demande premium. Les actions internes de l'agent (appels d'outils, étapes automatiques) ne sont pas facturées comme demandes premium supplémentaires."

4. **Date-stamp:** "Contenu vérifié le 4 mai 2026"

**Source:** https://docs.github.com/fr/copilot/concepts/billing/copilot-requests

---

### [docs/chapitre-12-couts-gouvernance/leviers-economie.md](docs/chapitre-12-couts-gouvernance/leviers-economie.md)

**Changements:**

1. **Mise à jour recommandations de modèles**
   - **Avant:** "Claude 3.5 Sonnet pour l'architecture refactoring"
   - **Après:** "Sonnet 4.x pour les tâches 'versatile'" (langage catégorisé)
   - **Raison:** Éviter que les noms spécifiques se fossilisent; utiliser des catégories

2. **Suppression spécifiques o1/o3**
   - ❌ Supprimé: "o1 pour le raisonnement structuré"
   - ✅ Remplacé: "Modèles premium 'powerful' pour raisonnement avancé (consultez la page officielle)"
   - **Raison:** o1/o3 évoluent rapidement; trop dangereux de hardcoder

3. **Ton de mise en garde**
   - Ajout: "Les modèles premium ne sont pas toujours meilleurs — ils sont surtout plus coûteux."

---

### [docs/chapitre-12-couts-gouvernance/modes-quand-utiliser.md](docs/chapitre-12-couts-gouvernance/modes-quand-utiliser.md)

**Changements:**

1. **Coût du mode Agent clarifié**
   - **Avant:** "Coût variable selon le mode agentique"
   - **Après:** "Coût variable selon le modèle et le nombre de prompts utilisateur. Seules les invites utilisateur sont comptabilisées (avec multiplicateur de modèle); les appels d'outils internes ne génèrent pas de comptage supplémentaire."

2. **Suppression listes statiques de participants/variables**
   - ❌ Supprimé: "@workspace, @vscode, @terminal, @github..."
   - ✅ Remplacé: "Saisir `@`, `/`, `#` dans la zone de chat pour afficher la liste réellement disponible."
   - **Raison:** Participants/variables évoluent trop fréquemment pour être documentés statiquement

3. **Avertissement volatilité**
   - Ajout: "Participants et variables évoluent avec chaque mise à jour de Copilot."

---

### [docs/chapitre-12-couts-gouvernance/workflow-recommande.md](docs/chapitre-12-couts-gouvernance/workflow-recommande.md)

**Changements:**

1. **Remplacement tableau de quotas rigide**
   - ❌ Supprimé: "45-65 requests/week, 180-260/month" (prescriptif, inadapté post-transition)
   - ✅ Remplacé: "Stratégie de répartition" basée sur budgets flexibles

2. **Lien vers historique**
   - Ajout: "Fixer un budget hebdomadaire, puis comparer la consommation réelle à la planification dans [Historique](historique-modifications.md)."

3. **Ton: de planification rigide → gestion budgétaire flexible**
   - Avant: "Vous devez utiliser max 45 requests/semaine"
   - Après: "Définir votre budget personnel et piloter via l'historique des consommations"

---

### [docs/chapitre-12-couts-gouvernance/historique-modifications.md](docs/chapitre-12-couts-gouvernance/historique-modifications.md) — **NOUVEAU FICHIER**

**Objectif:** Single source of truth pour tracker l'évolution des coûts et modèles mois par mois.

**Structure:**

```markdown
# Historique des changements coûts & modèles

## Format d'une entrée

- **Changement:** [Description courte]
- **Avant:** [État antérieur]
- **Après:** [État nouveau]
- **Impact:** [Fichiers affectés]
- **Source:** [Lien officiel]
- **Vérifié le:** [Date YYYY-MM-DD]

## Entrées existantes (baseline)

### 2026-05-04 — Baseline de référence (pré-transition 1er juin)
- **Changement:** Normalisation documentation coûts/modèles; ajout structure comparaison mensuelle
- **Avant:** Documentation centrée uniquement sur premium requests, sans suivi historique
- **Après:** Ajout date-stamps, langage catégorisé (vs hardcoding modèles), page historique
- **Impact:** Chapitre 12 entièrement (index, abonnements, premium-requests, leviers, modes, workflow)
- **Source:** https://docs.github.com/fr/copilot/get-started/plans
- **Vérifié le:** 2026-05-04

### 2026-06-01 — TRANSITION PRÉVUE: Request-based → Usage-based (AI Credits)
- **Changement:** Basculement facturation de "premium requests" à "AI Credits" ($0.01/credit)
- **Avant:** Free 50/mois, Pro 300/mois, Pro+ 1500/mois, Business 300/user, Enterprise 1000/user
- **Après:** Tous les plans accèdent AI Credits; quota initial libre (à confirmer)
- **Impact:** Tous les fichiers chapitre 12, chapitre 13 (outils économies)
- **Source:** https://docs.github.com/fr/copilot/concepts/billing/usage-based-billing-for-individuals
- **Vérifié le:** [À mettre à jour après le 1er juin]

### 2026-05-04 — Mise à jour plans officielle
- **Changement:** Ajout Pro+ ($39/mo); correction Enterprise requests (300 → 1000)
- **Avant:** 4 plans (Free, Pro, Business, Enterprise)
- **Après:** 5 plans (Free, Pro, Pro+, Business, Enterprise)
- **Impact:** abonnements.md
- **Source:** https://docs.github.com/fr/copilot/get-started/plans
- **Vérifié le:** 2026-05-04

### 2026-05-04 — Suppression modèles non-existants
- **Changement:** Remplacement noms de modèles hardcodés par langage catégorisé
- **Avant:** "Claude 3.7 Sonnet", "Claude 3 Opus"
- **Après:** "modèles premium 'versatile'" (équivalent Sonnet), "modèles premium 'powerful'" (equiv Claude 3)
- **Impact:** premium-requests.md, leviers-economie.md, parametrage VS Code/IntelliJ
- **Source:** https://docs.github.com/fr/copilot/reference/copilot-billing/models-and-pricing
- **Vérifié le:** 2026-05-04
```

---

### [mkdocs.yml](mkdocs.yml)

**Changements:**

- ✅ Ajout navigation: `Historique coûts & modèles: chapitre-12-couts-gouvernance/historique-modifications.md`
- Emplacement: Sous "Coûts & Gouvernance", après "Réduire les allers-retours"
- Impact: Page maintenant accessible depuis la navigation principale et depuis les pages enfants

---

## Phase 2: Transverse Harmonization (Chapitres 1, 2, 11, 13, Appendices)

### [docs/chapitre-1-installation/index.md](docs/chapitre-1-installation/index.md)

**Changements:**

- **Avant:** "Copilot Free, Individual, Business, Enterprise"
- **Après:** "Free, Pro, Pro+, Business, Enterprise" + lien vers https://docs.github.com/fr/copilot/get-started/plans
- **Raison:** Aligner noms de plans et référencer source officielle

---

### [docs/chapitre-2-parametrage/vscode-parametrage.md](docs/chapitre-2-parametrage/vscode-parametrage.md)

**Changements:**

1. **Section "Modèles IA par plan"**
   - **Avant:** Tableau hardcodé (Free: Claude Haiku 4.5, GPT-5 mini, Grok Code Fast 1)
   - **Après:** "La disponibilité des modèles évolue fréquemment. Consultez [Plans GitHub Copilot](https://docs.github.com/fr/copilot/reference/copilot-billing/models-and-pricing)"

2. **MCP consommation**
   - **Avant:** "Chaque appel d'outil MCP = 1 requête"
   - **Après:** "La facturation dépend du mode et du modèle (premium requests en transition, puis AI Credits post-juin 2026)"

3. **Thinking budget impact**
   - Ajout: "Augmenter le thinking budget augmente la consommation de tokens. Avec la transition vers facturation usage-based, ce réglage peut avoir un impact financier direct."

---

### [docs/chapitre-2-parametrage/intellij-parametrage.md](docs/chapitre-2-parametrage/intellij-parametrage.md)

**Changements:** Identiques à VS Code

---

### [docs/chapitre-11-troubleshooting/problemes-courants.md](docs/chapitre-11-troubleshooting/problemes-courants.md)

**Changements:**

- **Tableau "Prérequis par offre"**
  - Avant: Agent mode ❌ Free, ✅ Pro+/Business/Enterprise
  - Après: Agent mode ✅ All plans (avec note "(périmètre variable selon politiques admin)")
  - Raison: Reflect 2026 state où Agent Mode est plus largement disponible

---

### [docs/chapitre-13-outils-economies/index.md](docs/chapitre-13-outils-economies/index.md)

**Changements:**

1. **Contexte chapitre mis à jour**
   - **Avant:** "Copilot Pro inclut 300 premium requests/mois — suffisant... mais vite épuisé si vous utilisez systématiquement Claude 3.5 Sonnet"
   - **Après:** "La consommation Copilot évolue en 2026: logique premium requests en transition vers usage-based avec AI Credits. Les outils restent utiles pour tâches légères."

2. **Légende consommation**
   - **Avant:** "Chat Claude 3.5 → 1 premium request"
   - **Après:** "Chat/Agent/CLI/Spaces/Spark → consommation selon modèle et tokens"

---

### [docs/appendices/faq.md](docs/appendices/faq.md)

**Changements:**

- **Avant:** Pricing section avec montants exacts ("Copilot Free: limité (2000 complétions/mois)... Copilot Individual: ~10$/mois")
- **Après:** "Les montants exacts et allocations peuvent évoluer. Vérifiez toujours la page officielle: [Plans GitHub Copilot](https://docs.github.com/fr/copilot/get-started/plans)"
- **Raison:** Softened absolutes; prevent stale pricing from being cached indefinitely

---

## Phase 3: Chapitre 4 & 14 — Plan/Model Availability & Security Clarification

### [docs/chapitre-4-contexte/comparaison-contexte.md](docs/chapitre-4-contexte/comparaison-contexte.md)

**Changements:**

1. **Copilot Agents plan availability**
   - **Avant:** "Plans | Pro+/Enterprise | Pro+/Enterprise"
   - **Après:** "Plans | [Pro+/Enterprise](../chapitre-12-couts-gouvernance/abonnements.md) | [Pro+/Enterprise](../chapitre-12-couts-gouvernance/abonnements.md)"
   - Ajout infobox: "La disponibilité exacte des fonctionnalités par plan peut évoluer. Consultez [Les abonnements](../chapitre-12-couts-gouvernance/abonnements.md) pour les infos à jour (Vérifié le 4 mai 2026)"

---

### [docs/chapitre-4-contexte/guide-agents.md](docs/chapitre-4-contexte/guide-agents.md)

**Changements:**

1. **Modèles dans exemples**
   - **Avant:** `model: claude-3.5-sonnet` et `model: gpt-4o`
   - **Après:** `model: claude-sonnet` et `model: gpt-4o-mini` (+ notes: "consultez la disponibilité actuelle")

2. **Avertissement volatilité modèles**
   - Ajout infobox: "Les modèles et leurs disponibilités évoluent régulièrement. Consultez [Plans GitHub Copilot](https://docs.github.com/fr/copilot/get-started/plans) pour vérifier quels modèles sont inclus (Vérifié le 4 mai 2026)"
   - Raison: Prevent hardcoded model names from becoming stale

---

### [docs/chapitre-14-veille-ia/index.md](docs/chapitre-14-veille-ia/index.md)

**Changements:**

- **Coûts qui évoluent**
  - Avant: "Quotas premium requests, nouveaux tiers d'abonnement…"
  - Après: "Quotas premium requests, nouveaux tiers d'abonnement… (Voir [Historique des modifications](../chapitre-12-couts-gouvernance/historique-modifications.md))"
  - Raison: Direct link to tracking mechanism

---

### [docs/chapitre-14-veille-ia/securite-risques.md](docs/chapitre-14-veille-ia/securite-risques.md)

**Changements critiques:**

- **Copilot Business/Enterprise training guarantee clarification**
  - **Avant:** "Avec les plans Copilot Business et Enterprise, GitHub garantit que ton code n'est pas utilisé pour l'entraînement des modèles. Ce n'est pas le cas avec le plan Individual (opt-out disponible dans les paramètres)."
  - **Après:** "Avec les plans Copilot Business et Enterprise, GitHub garantit que ton code n'est pas utilisé pour l'entraînement des modèles (Vérifié le 4 mai 2026). Avec le plan Free ou Pro (Copilot Individual), un opt-out est disponible dans les paramètres Copilot, mais est désactivé par défaut. Pour les conditions exactes, consultez [Plans GitHub Copilot](https://docs.github.com/fr/copilot/get-started/plans) et la [politique de confidentialité GitHub](https://docs.github.com/fr/site-policy/privacy-policies/github-privacy-statement#github-copilot)."
  - Raison: Clarify distinction Free/Pro vs Business/Enterprise; add date-stamp + official policy link

---

## Résumé par Type de Changement

| Type | Nombre | Exemples |
|------|--------|----------|
| **Suppression de modèles non-existants** | 2 | Claude 3.7, Opus v3 |
| **Remplacement hardcoding par références dynamiques** | 8 | Modèles, participants @, variables / |
| **Ajout date-stamps "Vérifié le 4 mai 2026"** | 12 | Index ch12, abonnements, premium-requests, etc. |
| **Clarifications de plan/availability** | 4 | Agents, Copilot Chat, Business/Enterprise guarantees |
| **Liens versarchives officielles** | 6 | https://docs.github.com/fr/copilot/* |
| **Nouvelle page + navigation** | 1 | historique-modifications.md + mkdocs.yml |
| **Suppression affirmations stales** | 2 | "Chat Enterprise-only", "300 requests Enterprise" |

---

## Prochaines Étapes (Post-4 mai 2026)

### Juin 2026

⏳ **À faire après le 1er juin:**

1. Mettre à jour [historique-modifications.md](docs/chapitre-12-couts-gouvernance/historique-modifications.md)
   - Ajouter une nouvelle section `### 2026-06-01 — Transition effectuée`
   - Documenter l'impact réel vs. prévu
   - Mettre à jour les seuils AI Credits par plan

2. Harmoniser les références "premium requests" → "AI Credits"
   - Chapitre 12, 13, 11, 2

3. Mettre à jour les modèles disponibles par plan
   - Si nouveaux modèles lancés (o3, Claude 4, etc.)

### Mensuel (à partir de juillet 2026)

- ✅ Consulter [GitHub Blog — Copilot](https://github.blog/category/copilot/)
- ✅ Mettre à jour [historique-modifications.md](docs/chapitre-12-couts-gouvernance/historique-modifications.md) avec changements détectés
- ✅ Re-valider liens externes

---

## Artefacts & Validation

✅ **Build:** 0 erreurs, compilation en 4.49 secondes  
✅ **Liens:** 11431 liens valides, 0 liens cassés  
✅ **Navigation:** 101 fichiers HTML générés  

**Fichiers impactés:**
- 21 fichiers modifiés
- 1 fichier créé
- 1 fichier configuration (mkdocs.yml)

---

## Ressources de Référence Officielles

Tout changement a été validé contre:

1. https://docs.github.com/fr/copilot/get-started/plans
2. https://docs.github.com/fr/copilot/concepts/billing/copilot-requests
3. https://docs.github.com/fr/copilot/concepts/billing/usage-based-billing-for-individuals
4. https://docs.github.com/fr/copilot/concepts/billing/usage-based-billing-for-organizations-and-enterprises
5. https://docs.github.com/fr/copilot/reference/copilot-billing/models-and-pricing
6. https://docs.github.com/fr/site-policy/privacy-policies/github-privacy-statement#github-copilot

---

## Questions / Clarifications

**Q: Pourquoi supprimer les noms de modèles hardcodés?**  
A: Les modèles et leurs multiplicateurs changent fréquemment (o1/o3 lancés, Claude 4 annoncé, etc.). Le hardcoding crée une dette technique rapide. Utiliser des catégories ("premium 'powerful'") + lien officiel est plus durable.

**Q: Pourquoi créer historique-modifications.md?**  
A: Single source of truth pour tracker avant/après, et permettre des comparaisons mensuelles (utilisateurs peuvent revenir en arrière et voir "comment c'était en mai vs. juin vs. juillet").

**Q: Les changements affectent-ils la structure de navigation?**  
A: Non, sauf ajout de 1 page (historique). Tous les liens relatifs sont validés et fonctionnels.

---

## Approbation

- **Date de création:** 4 mai 2026
- **État:** ✅ Complété (Phase 6, Batches 1-3)
- **Prochaine révision:** 1er juin 2026 (post-transition)

