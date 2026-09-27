@AGENTS.md

# Claude Code — instructions du projet

Ce dépôt contient une documentation MkDocs en français sur l'utilisation de l'IA pour le développement. Le parcours principal doit désormais être **Claude Code**, tout en conservant la documentation GitHub Copilot existante comme référence, comparaison et solution de repli éventuelle.

## Priorités éditoriales

1. Présenter **Claude Code** comme outil principal dans les pages génériques et les parcours recommandés.
2. **Ne pas supprimer** les contenus GitHub Copilot, `.github/copilot-instructions.md`, `.github/agents/`, `.github/instructions/` ou `.github/prompts/` uniquement parce qu'ils concernent Copilot.
3. Quand une page générique est historiquement centrée sur Copilot, la réorienter vers Claude et conserver une section Copilot explicite, ou un lien vers la page Copilot dédiée.
4. Distinguer clairement les fonctionnalités propres à Claude, celles propres à Copilot et celles communes aux deux outils.
5. Traiter la migration **par lots cohérents** : installation, paramétrage, contexte, prompting, workflows, coûts, troubleshooting, outils, puis audit final.

## Sources et vérification

Pour toute information susceptible d'évoluer, vérifier les sources officielles avant de modifier la documentation.

Priorité des sources :

- Claude Code : `https://code.claude.com/docs/`
- Claude Platform / API : `https://docs.anthropic.com/` et `https://platform.claude.com/docs/`
- Anthropic : `https://www.anthropic.com/`
- GitHub Copilot : documentation officielle GitHub
- Outils tiers : documentation et dépôts officiels des éditeurs

Éviter de figer inutilement des numéros de version, noms de modèles ou tarifs dans les pages générales. Quand une valeur datée est utile, indiquer sa date de vérification et une source officielle.

## Conventions du dépôt

- Langue : français.
- Ton : pédagogique, concret, progressif.
- Site : MkDocs Material.
- Documentation publique : `docs/`.
- Navigation : `mkdocs.yml`.
- Les pages ajoutées doivent être référencées dans `nav:` lorsqu'elles font partie du parcours public.
- Conserver les badges, admonitions, tableaux et diagrammes Mermaid lorsqu'ils améliorent la lecture.
- Ne pas inventer de captures, commandes, paramètres, quotas, prix ou capacités.
- Pour les liens externes techniques, préférer les pages officielles et vérifier qu'elles correspondent encore au produit décrit.

## Validation locale

Avant de considérer un lot terminé :

```powershell
py -m mkdocs build
```

Si l'environnement utilise un virtualenv :

```powershell
py -m pip install -r requirements.txt
py -m mkdocs build
```

Corriger les liens internes, erreurs de navigation et warnings pertinents avant commit lorsque c'est possible.

## Git et Pull Request

- Ne jamais pousser directement ni merger automatiquement dans `main`.
- Travailler sur une branche dédiée ou sur la branche de travail explicitement demandée.
- Ouvrir ou mettre à jour une Pull Request vers `main`.
- Garder les commits lisibles et centrés sur un lot documentaire.
- Ne pas activer l'auto-merge pour ce dépôt sauf demande explicite.

## Fichiers d'instructions IA

- `CLAUDE.md` : instructions principales pour Claude Code.
- `AGENTS.md` : conventions communes aux agents/outils compatibles.
- `.github/copilot-instructions.md` : instructions GitHub Copilot, **à conserver**.
- `.github/agents/`, `.github/instructions/`, `.github/prompts/` : patrimoine et configuration Copilot ; les conserver et les maintenir lorsque les pages Copilot sont mises à jour.

Claude Code sait charger `CLAUDE.md` et peut utiliser `AGENTS.md`. Le présent fichier importe explicitement `AGENTS.md` afin de partager les règles communes tout en gardant ici les consignes spécifiques à Claude.

## Définition d'un lot terminé

Un lot est terminé quand :

- les pages ciblées sont cohérentes entre elles ;
- Claude est le parcours par défaut lorsque le sujet est générique ;
- les informations Copilot utiles sont toujours présentes ;
- les sources officielles ont été vérifiées pour les faits évolutifs ;
- la navigation et les liens impactés ont été contrôlés ;
- la PR décrit clairement ce qui est fait et ce qui reste à traiter.
