# Coûts, limites d'usage & gouvernance Claude Code

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span> <span class="badge-cli">CLI</span>

Le coût de Claude Code dépend du **mode d'accès** : abonnement Claude avec usage inclus, usage credits au-delà de certaines limites, API Anthropic, ou facturation d'un provider cloud. Il faut donc distinguer **limites de plan** et **coût par token** au lieu de mélanger les deux.

!!! info "Prix vérifiés le 28 septembre 2026"
    Les prix et allocations changent. Cette page donne l'état actuel et surtout les mécanismes à surveiller. Pour une décision d'achat, vérifiez toujours `claude.com/pricing`, `/usage` et la console de facturation réellement utilisée.

---

## Plans Claude et accès Claude Code

À la date de cette révision :

| Plan | Claude Code | Logique générale |
|---|---|---|
| **Free** | Non inclus dans la grille publique actuelle | Chat Claude gratuit, mais pas Claude Code dans la matrice tarifaire actuelle |
| **Pro** | Inclus | Usage inclus sous limites ; usage credits optionnels pour continuer au-delà |
| **Max 5x / 20x** | Inclus | Limites d'usage supérieures à Pro ; usage credits possibles |
| **Team Standard / Premium** | Inclus | Allocation par siège ; usage credits configurables par l'organisation |
| **Enterprise usage-based** | Inclus | Prix de siège + consommation facturée aux tarifs API dès le premier token |
| **Enterprise legacy seat-based** | Inclus selon contrat | Ancien modèle avec allocation de siège + usage credits possibles |

Tarifs publics US affichés le 28 septembre 2026 :

- **Pro** : $20/mois ou $17/mois avec paiement annuel ($200 facturés à l'avance) ;
- **Max** : à partir de $100/mois ;
- **Team Standard** : $25/siège/mois ou $20 avec facturation annuelle ;
- **Team Premium** : $125/siège/mois ou $100 avec facturation annuelle ;
- **Enterprise usage-based** : $20/siège + usage au tarif API.

Taxes, devise et contrats entreprise peuvent modifier ces montants.

### Combien de sièges Team, et comment dépasser la limite ?

Un **siège** correspond à un accès attribué à un membre. Au **3 octobre 2026**, Team accepte **de 2 à 150 sièges**, Standard et Premium confondus. Le minimum est de deux membres, et non cinq dans la documentation actuelle. Les limites d'usage sont propres à chaque membre.

| Besoin | Possibilité |
|---|---|
| Ajouter des collègues en restant à 150 sièges ou moins | Ajouter des sièges dans l'organisation Team |
| Donner davantage d'usage à certains membres | Examiner les sièges Premium et les usage credits ; cela n'augmente pas le plafond de membres |
| Dépasser 150 sièges dans la même organisation | **Migrer vers Enterprise**, parcours indiqué par Anthropic ; Team n'offre pas une extension publique au-delà de 150 |

Exemple : une équipe de 120 membres peut ajouter 30 sièges Team. Pour accueillir un 151e membre, préparer la migration Enterprise plutôt que compter sur un changement Standard → Premium.

Voir [les limites Team](https://support.claude.com/en/articles/9266767-what-is-the-team-plan) et [la procédure de migration Team → Enterprise](https://support.claude.com/en/articles/13779868-migrate-your-organization-from-team-to-enterprise). Les conditions Enterprise doivent être vérifiées pour l'organisation concernée.

---

### Pro et Max

L'abonnement inclut une quantité d'usage. Lorsque la limite est atteinte, les **usage credits** permettent, s'ils sont activés, de continuer en pay-as-you-go aux tarifs API standards.

### Team et anciens Enterprise seat-based

L'organisation peut activer les usage credits et définir des limites de dépense au niveau organisation, groupe/seat ou utilisateur selon le plan.

### Enterprise usage-based actuel

Il n'y a pas d'allocation de tokens de siège à épuiser : l'usage est mesuré et facturé à l'organisation aux tarifs API dès le premier token. Les administrateurs utilisent des spend limits pour piloter la dépense.

---

## `/usage` : commande centrale de suivi

Dans Claude Code :

```text
/usage
```

`/cost` est actuellement un alias de `/usage`.

Pour les utilisateurs API, le bloc Session affiche notamment les tokens et une **estimation** de coût basée sur les prix catalogue ou une table de prix d'organisation configurée.

Pour les abonnés Pro, Max, Team et Enterprise, `/usage` peut afficher :

- barres de limites du plan ;
- statistiques d'activité ;
- attribution récente aux skills, subagents, plugins et serveurs MCP ;
- signaux tels que long context ou cache misses ;
- dépenses en usage credits lorsqu'elles sont activées.

!!! warning "Estimation ≠ facture"
    Pour la facturation API faisant foi, utilisez la **Claude Console** ou la console de votre provider. Le coût affiché dans Claude Code est un outil de suivi, pas une facture contractuelle.

---

## Comprendre ce qui consomme

Le coût ou les limites d'usage peuvent être affectés par :

- le modèle sélectionné ;
- la longueur du contexte utile ;
- les résultats d'outils et MCP ;
- les subagents et agent teams ;
- les thinking/effort settings ;
- les boucles et automatisations ;
- les cache hits et cache misses ;
- les sessions longues et leur compaction ;
- l'exécution parallèle de plusieurs sessions.

Il n'existe pas de ratio universel du type « une session de deux heures coûte X » ou « raccourcir `CLAUDE.md` divise le coût par Y ».

---

## Pourquoi l'usage augmente dans une longue session

Claude Code gère le contexte, le prompt caching et l'auto-compaction. Une session longue peut néanmoins consommer davantage parce que la quantité de contexte pertinent, les tool results et les étapes de raisonnement augmentent.

Les bons réflexes sont :

```text
/context
/usage
/compact
/clear
```

- `/context` : voir ce qui occupe le contexte ;
- `/usage` : voir consommation, attribution et limites ;
- `/compact` : compacter lorsque cela devient utile ;
- `/clear` : démarrer une nouvelle session pour une tâche réellement distincte.

Ne lancez pas `/compact` ou `/clear` mécaniquement toutes les N minutes : observez d'abord le contexte et la tâche.

---

## Réduire l'usage sans dégrader la qualité

La documentation Claude Code recommande plusieurs leviers :

| Levier | Quand l'utiliser |
|---|---|
| Gérer le contexte avec `/context` | Quand une session commence à accumuler beaucoup de fichiers/outils |
| Choisir un modèle adapté | Lorsque la tâche n'a pas besoin de la capacité maximale |
| Réduire les outils MCP inutilisés | Si leurs outils ou résultats ajoutent du contexte sans valeur |
| Déplacer des procédures vers des skills | Pour charger les longues instructions seulement quand nécessaires |
| Utiliser hooks/scripts déterministes | Pour filtrer ou prétraiter des sorties répétitives |
| Déléguer une exploration verbeuse à un subagent | Pour isoler un gros volume de recherche |
| Ajuster `/effort` | Si le modèle compatible travaille plus profondément que nécessaire |
| Formuler un objectif et des critères de réussite précis | Pour réduire les boucles de clarification/rework |

La priorité est de **réduire le travail inutile**, pas simplement de produire moins de tokens à tout prix.

---

## Prompt cache

Les versions récentes de Claude Code affichent dans `/usage` des statistiques de **prompt cache** pour la conversation principale : requêtes, part des tokens d'entrée servis depuis le cache, cache misses et état du cache.

Le cache change fortement l'économie d'un contexte réutilisé. Évitez donc d'estimer les coûts uniquement à partir de la longueur brute du prompt.

---

## Usage credits et Fable

Selon le plan et le siège, l'utilisation de **Fable** peut être facturée directement en usage credits plutôt que prise sur les limites incluses.

Dans les sessions interactives concernées, le picker `/model` indique `Requires usage credits` et Claude Code demande confirmation avant de facturer ce modèle. En mode non interactif/Agent SDK, cette confirmation peut ne pas être affichée : configurez donc les limites de dépense avant d'automatiser un modèle coûteux.

---

## API Anthropic / Claude Console

Lorsqu'une organisation utilise Claude Code via la Claude Console :

- Claude Code crée/utilise un workspace dédié pour le suivi ;
- les administrateurs peuvent configurer des spend/rate limits ;
- la Console fournit le reporting de coût/usage ;
- des APIs d'analytics permettent le suivi par utilisateur selon le type d'organisation.

L'usage API est distinct de l'abonnement Pro personnel : un abonnement Pro n'inclut pas un quota API général utilisable librement par vos applications.

---

## Bedrock, Agent Platform et Foundry

Avec Amazon Bedrock, Google Cloud Agent Platform ou Microsoft Foundry :

- la consommation est facturée par le provider cloud ;
- les contrôles de dépense vivent dans sa console de facturation ;
- les dashboards Claude Code hébergés par Anthropic ne couvrent pas nécessairement cette consommation ;
- OpenTelemetry ou un gateway peut être utile pour une attribution par utilisateur.

Ne recopiez pas les prix Anthropic API comme s'ils étaient automatiquement ceux du provider.

---

## Gouvernance d'équipe

Pour une équipe, suivez au minimum :

1. **mode de facturation** réellement utilisé ;
2. modèles et providers autorisés ;
3. limites/spend controls ;
4. consommation par utilisateur ou groupe lorsque disponible ;
5. attribution aux MCP, plugins, skills, subagents et automatisations ;
6. réussite réelle des tâches : tests, rework, temps humain économisé.

Le coût par token seul n'est pas suffisant pour choisir une stack : une solution moins chère par requête peut coûter plus cher si elle multiplie les reprises manuelles.

---

## Sources

- [Claude Help — Team, minimum et maximum de sièges](https://support.claude.com/en/articles/9266767-what-is-the-team-plan) — vérifié le 2026-10-03
- [Claude Help — Migration Team vers Enterprise](https://support.claude.com/en/articles/13779868-migrate-your-organization-from-team-to-enterprise) — consulté le 2026-10-03

- [Claude Code — Manage costs effectively](https://code.claude.com/docs/en/costs) — consulté le 2026-09-28
- [Claude Code — Monitoring](https://code.claude.com/docs/en/monitoring-usage) — consulté le 2026-09-28
- [Claude Code — Model configuration](https://code.claude.com/docs/en/model-config) — consulté le 2026-09-28
- [Claude — Pricing](https://claude.com/pricing) — consulté le 2026-09-28
- [Claude Help — Manage usage credits for paid plans](https://support.claude.com/en/articles/12429409-manage-usage-credits-for-paid-claude-plans) — consulté le 2026-09-28
- [Claude Help — Manage usage credits for Team and seat-based Enterprise](https://support.claude.com/en/articles/12005970-manage-usage-credits-for-team-and-seat-based-enterprise-plans) — consulté le 2026-09-28
- [Claude Help — Enterprise billing](https://support.claude.com/en/articles/11526368-how-am-i-billed-for-my-enterprise-plan) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-3b-claude-code-migration-copilot.md#page-chapitre-3b-claude-code-migration-copilot-couts-quotas).

## Prochaine étape

Poursuivez avec **[Prompt Engineering avec Claude](prompt-engineering-claude.md)**, la page suivante dans le menu.
