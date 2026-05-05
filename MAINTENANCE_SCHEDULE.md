# Calendrier de Maintenance — Documentation Copilot

**Fréquence:** Mensuelle (recommandé: 1er du mois)  
**Temps estimé:** 30-60 minutes  
**Propriétaire:** [Documentation maintainer]

---

## Checklist Mensuelle Standard

### Semaine 1 du mois

#### 1️⃣ Vérifier les annonces officielles

- [ ] Consulter [GitHub Blog — Copilot](https://github.blog/category/copilot/)
  - Filtrer par "copilot", "billing", "plans", "models"
  - Prendre note de toute annonce de changement de prix, quota, ou modèle

- [ ] Consulter [GitHub Copilot Official Docs](https://docs.github.com/fr/copilot)
  - Vérifier les pages:
    - [Plans GitHub Copilot](https://docs.github.com/fr/copilot/get-started/plans)
    - [Billing — Premium Requests](https://docs.github.com/fr/copilot/concepts/billing/copilot-requests)
    - [Billing — Usage-based (AI Credits)](https://docs.github.com/fr/copilot/concepts/billing/usage-based-billing-for-individuals)
    - [Models & Pricing](https://docs.github.com/fr/copilot/reference/copilot-billing/models-and-pricing)
  - Noter: Date de dernière mise à jour de chaque page

- [ ] Consulter [OpenAI Blog](https://openai.com/blog) et [Anthropic News](https://www.anthropic.com/news)
  - Nouveaux modèles lancés? (o3, Claude 4, GPT-5, etc.)
  - Changements de pricing chez les providers?

#### 2️⃣ Comparer état actuel vs. documentation

- [ ] Ouvrir [historique-modifications.md](docs/chapitre-12-couts-gouvernance/historique-modifications.md)
- [ ] Comparer **dernière entrée** (date: `YYYY-MM-DD`) vs. **aujourd'hui**
- [ ] Lister tout changement détecté dans vos notes:
  - Nouveaux modèles?
  - Quotas mis à jour?
  - Tiers d'abonnement modifiés?
  - Garanties de confidentialité évoluées?
  - Nouvelles fonctionnalités par plan?

#### 3️⃣ Si AUCUN changement détecté

- [ ] Ajouter une ligne de confirmation dans [historique-modifications.md](docs/chapitre-12-couts-gouvernance/historique-modifications.md):

```markdown
### YYYY-MM-DD — Pas de changement détecté
- **Changement:** [Aucun]
- **Avant:** [État du mois précédent]
- **Après:** [Identique]
- **Impact:** Aucun
- **Source:** Vérification manuelle des sources officielles
- **Vérifié le:** YYYY-MM-DD
```

#### 4️⃣ Si CHANGEMENT détecté

À faire pour chaque changement:

1. **Identifier les fichiers affectés:**
   - Utiliser `grep` ou "Find in Files" pour localiser toutes mentions:
     - Noms de modèles
     - Quotas/montants ($)
     - Noms de plans
     - Affirmations sur "Business/Enterprise"

2. **Créer une branche de travail:**
   ```bash
   git checkout -b update-[YYYY-MM] 
   ```

3. **Mettre à jour les fichiers impactés:**
   - Appliquer le changement
   - Ajouter date-stamp: "Vérifié le YYYY-MM-DD"
   - Si changement affecte multiple fichiers → utiliser `multi_replace_string_in_file`

4. **Mettre à jour [historique-modifications.md](docs/chapitre-12-couts-gouvernance/historique-modifications.md):**

```markdown
### YYYY-MM-DD — [Description courte du changement]
- **Changement:** [Quoi a changé]
- **Avant:** [État antérieur spécifique]
- **Après:** [État nouveau spécifique]
- **Impact:** [Fichiers modifiés, ex: "abonnements.md, premium-requests.md, parametrage-vscode.md"]
- **Source:** [URL officielle]
- **Vérifié le:** YYYY-MM-DD
```

5. **Valider la documentation:**
   - [ ] `python -m mkdocs build` → 0 erreurs
   - [ ] `python scripts/validate-links.py` → 0 liens cassés
   - [ ] Lire les fichiers modifiés pour vérifier cohérence

6. **Commit & Push:**
   ```bash
   git add .
   git commit -m "docs: update copilot costs/models for YYYY-MM — [détail changement]"
   git push origin update-[YYYY-MM]
   ```

7. **Créer une PR:**
   - Titre: `docs: update copilot billing/models (YYYY-MM-DD)`
   - Description: Lister tous changements + sources officielles
   - Review: 1 peer minimum avant merge

#### 5️⃣ Clôture mensuelle

- [ ] Merger la PR (si applicable)
- [ ] Valider site deployé avec derniers changements
- [ ] Ajouter une entrée au `CHANGELOG.md` si changements appliqués
- [ ] Documenter date prochaine révision

---

## Calendrier Critique (Dates Fixes)

### 1er Juin 2026 — Transition Majeure

🔴 **ACTION REQUISE:** Ce jour-là, la facturation passe de "premium requests" à "AI Credits"

**À faire d'urgence:**

1. Mettre à jour [abonnements.md](docs/chapitre-12-couts-gouvernance/abonnements.md)
   - Remplacer "Free 50, Pro 300, Pro+ 1500..." par les allocations AI Credits
   - Ajouter clarification: "À partir du 1er juin 2026, facturation à usage-based"

2. Mettre à jour [premium-requests.md](docs/chapitre-12-couts-gouvernance/premium-requests.md)
   - Ajouter avertissement: "Cette page documente le système PRE-juin 2026. Voir [AI Credits](usage-based-billing.md) pour post-juin."
   - Créer nouvelle page `usage-based-billing.md` pour le nouveau système

3. Mettre à jour [historique-modifications.md](docs/chapitre-12-couts-gouvernance/historique-modifications.md):
   ```markdown
   ### 2026-06-01 — TRANSITION APPLIQUÉE: Request-based → Usage-based
   - **Changement:** Basculement facturation de premium requests à AI Credits
   - **Avant:** Free 50/mois, Pro 300/mois, Pro+ 1500/mois, Business 300/user, Enterprise 1000/user
   - **Après:** [À documenter avec les vrais chiffres le 1er juin]
   - **Impact:** Chapitre 12 entièrement, chapitre 2, chapitre 13
   - **Source:** https://docs.github.com/fr/copilot/concepts/billing/usage-based-billing-for-individuals
   - **Vérifié le:** 2026-06-01
   ```

4. Tester tous les liens vers la page officielle de facturation
5. Deploy immédiatement après vérification

---

## Modèle de Commit

Utiliser ce format de message pour tous les commits de maintenance:

```
docs: update copilot [type] (YYYY-MM-DD)

[Description courte des changements]

Types de changement:
- costs: changements de prix, quotas, plans
- models: nouveaux modèles, suppression, renommage
- plans: nouveaux tiers, modification features par plan
- security: changements politiques Business/Enterprise
- features: nouvelles fonctionnalités Copilot

Exemples:
- docs: update copilot costs (2026-05) — Add Pro+ tier, fix Enterprise quota
- docs: update copilot models (2026-06) — Add o3, deprecate o1
- docs: update copilot plans (2026-06) — Usage-based billing transition
```

---

## Fichiers à Surveiller Mensuellement

| Fichier | Raison | Fréquence |
|---------|--------|-----------|
| [abonnements.md](docs/chapitre-12-couts-gouvernance/abonnements.md) | Plans, quotas, prix | Mensuelle |
| [premium-requests.md](docs/chapitre-12-couts-gouvernance/premium-requests.md) | Modèles disponibles, multiplicateurs | Mensuelle |
| [leviers-economie.md](docs/chapitre-12-couts-gouvernance/leviers-economie.md) | Recommandations modèles | Trimestrielle |
| [parametrage-vscode.md](docs/chapitre-2-parametrage/vscode-parametrage.md) | Modèles par plan | Mensuelle |
| [parametrage-intellij.md](docs/chapitre-2-parametrage/intellij-parametrage.md) | Modèles par plan | Mensuelle |
| [faq.md](docs/appendices/faq.md) | Disclaimers sur pricing | Mensuelle |
| [securite-risques.md](docs/chapitre-14-veille-ia/securite-risques.md) | Garanties Business/Enterprise | Semestrielle |

---

## Format Historique-Modifications Détaillé

Chaque entrée dans `historique-modifications.md` doit suivre ce format:

```markdown
### YYYY-MM-DD — [Titre descriptif]

- **Changement:** [Description du changement en 1 ligne]
- **Avant:** [État antérieur spécifique — prix, noms, quotas, garanties]
- **Après:** [État nouveau spécifique — prix, noms, quotas, garanties]
- **Impact:** [Liste des fichiers modifiés avec chemins relatifs]
- **Source:** [URL officielle si applicable]
- **Vérifié le:** YYYY-MM-DD
```

### Exemple complet:

```markdown
### 2026-06-15 — Nouveau modèle o3 Mini disponible

- **Changement:** Ajout o3 Mini comme modèle premium "powerful" alternatif
- **Avant:** Modèles premium: Claude 3.5 Sonnet, o1, GPT-5, etc.
- **Après:** Modèles premium: Claude 3.5 Sonnet, o1, o3 Mini, GPT-5, etc.
- **Impact:** premium-requests.md, leviers-economie.md, parametrage-vscode.md, parametrage-intellij.md
- **Source:** https://docs.github.com/fr/copilot/reference/copilot-billing/models-and-pricing
- **Vérifié le:** 2026-06-15
```

---

## Commandes Utiles

### Rechercher tous les mentions de modèles:
```bash
grep -r "claude-3.5\|gpt-4\|grok\|gemini" docs/ --include="*.md"
```

### Chercher mentions de prix:
```bash
grep -r "\$[0-9]\|€[0-9]\|/mois\|/month\|quota\|request" docs/chapitre-12* --include="*.md"
```

### Valider build rapidement:
```bash
python -m mkdocs build
```

### Valider liens:
```bash
python scripts/validate-links.py
```

---

## Support & Escalade

**Questions?** Consulter:
- [CHANGELOG.md](CHANGELOG.md) — Historique des changements appliqués
- [historique-modifications.md](docs/chapitre-12-couts-gouvernance/historique-modifications.md) — Timeline avant/après par mois
- [Plans Copilot Official](https://docs.github.com/fr/copilot/get-started/plans) — Source de vérité absolue

**Anomalie détectée?** (ex: doc dit $10, mais officiel dit $12):
- Créer issue: `Title: Pricing discrepancy: [fichier] says X, official says Y`
- Attacher lien officiel comme preuve
- Assigner pour révision

---

## Résumé Temps Estimé

| Tâche | Temps | Fréquence |
|-------|-------|-----------|
| Vérifier annonces officielles | 15 min | Mensuelle |
| Comparer documentation | 10 min | Mensuelle |
| Appliquer changements (si pertinent) | 20-30 min | Variable |
| Valider build + liens | 5 min | Chaque changement |
| Commit + PR | 10 min | Chaque changement |
| **Total par mois (sans changement)** | **25 min** | **Mensuelle** |
| **Total par mois (avec changement)** | **60 min** | **Variable** |

---

**Créé:** 4 mai 2026  
**Dernière révision:** 4 mai 2026  
**Prochaine révision planifiée:** 1er juin 2026

