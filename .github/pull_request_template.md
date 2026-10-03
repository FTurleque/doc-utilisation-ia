## Description

<!-- Décrire le but de la PR, les fichiers/chapitres concernés et le comportement attendu. -->

## Type de changement

- [ ] `docs` — contenu documentaire
- [ ] `feat` — nouvelle capacité/page/configuration
- [ ] `fix` — correction d'erreur
- [ ] `chore` — maintenance, config, CI/CD
- [ ] `refactor` — restructuration sans changement de fond

## Produit / périmètre IA

- [ ] Claude Code
- [ ] GitHub Copilot — référence/compatibilité
- [ ] Commun aux deux / indépendant de l'assistant
- [ ] Aucun impact IA

## Checklist avant soumission

- [ ] Je travaille sur une branche et **pas directement sur `main`**.
- [ ] La branche est synchronisée avec `main` selon la stratégie de contribution du dépôt.
- [ ] `python -m mkdocs build --strict` réussit si le site est affecté.
- [ ] `python scripts/validate-links.py` réussit après le build si le site est affecté.
- [ ] Toute nouvelle page publiée est placée dans `mkdocs.yml`, sauf ressource volontairement hors navigation.
- [ ] Les liens internes et ancres restent valides.
- [ ] Les images ajoutées ont un alt text utile et ne contiennent aucune donnée sensible.
- [ ] Les faits évolutifs modifiés (modèles, prix, quotas, compatibilité, preview, sécurité, API) ont été vérifiés auprès de sources officielles récentes.
- [ ] Une page générique IA reste Claude-first ; les contenus Copilot utiles sont conservés et identifiés comme références.
- [ ] Les formats `.claude/*` et `.github/*` ne sont pas présentés comme interchangeables.
- [ ] Aucun secret, token, credential ou réglage local (`.claude/settings.local.json`) n'est inclus.

## Validation effectuée

<!-- Commandes exécutées et résultat, ou N/A avec justification. -->

```text
python -m mkdocs build --strict
python scripts/validate-links.py
```

## Sources vérifiées

<!-- Pour les changements factuels évolutifs, lister les URLs officielles et la date de consultation. -->

## Issue associée

<!-- Optionnel : Closes #12 / Refs #8 -->

## Captures d'écran

<!-- Optionnel. Suivre CONTRIBUTING-SCREENSHOTS.md et préciser produit/IDE/version observée. -->
