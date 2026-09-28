# Choisir le bon modèle avec Claude Code

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span> <span class="badge-cli">CLI</span>

Claude Code peut utiliser plusieurs familles Claude et plusieurs fournisseurs. Le choix d'un modèle doit donc partir de la **tâche réelle**, des modèles accessibles à votre compte et de vos évaluations, pas d'une règle figée du type « toujours Sonnet » ou « toujours Opus ».

!!! info "Source de vérité au moment de l'utilisation"
    Lancez `/model` dans Claude Code pour voir ce qui est réellement disponible pour votre compte, votre organisation et votre provider. Les alias évoluent dans le temps et ne pointent pas toujours vers la même version sur Anthropic API, Bedrock, Agent Platform ou Microsoft Foundry.

---

## Alias Claude Code actuels

Claude Code permet de sélectionner un alias ou un identifiant complet de modèle.

| Alias | Usage prévu par Claude Code |
|---|---|
| `default` | Retire l'override et revient au modèle par défaut du runtime/compte |
| `best` | Utilise Fable lorsqu'il est disponible, sinon l'équivalent de `opus` |
| `fable` | Tâches les plus difficiles et longues ; sessions agentiques de longue haleine |
| `opus` | Raisonnement complexe, coding agentique et knowledge work |
| `sonnet` | Coding quotidien, bon compromis vitesse/capacité |
| `haiku` | Tâches simples, rapides et économiques |
| `opusplan` | Utilise Opus pendant le plan puis Sonnet pendant l'exécution |
| `sonnet[1m]` / `opus[1m]` | Demande une fenêtre 1M lorsqu'elle est pertinente pour le provider/modèle |

!!! warning "Un alias n'est pas un numéro de version"
    Les alias pointent vers la version recommandée pour votre provider et peuvent évoluer. Si votre environnement exige une reproductibilité stricte, épinglez un identifiant de modèle explicitement supporté par votre provider.

---

## Gamme Claude actuelle

Au **28 septembre 2026**, la Claude Platform documente notamment :

| Modèle | Positionnement officiel | Contexte Platform | Prix API liste entrée / sortie* |
|---|---|---:|---:|
| **Claude Fable 5.1** | Raisonnement exigeant et travail agentique longue durée | 1M | $10 / $50 par MTok |
| **Claude Opus 5.5** | Coding agentique complexe et knowledge work | 1M | $4 / $20 par MTok |
| **Claude Sonnet 5** | Vitesse + intelligence pour les usages quotidiens | 1M | $2 / $10 par MTok |
| **Claude Haiku 4.5** | Latence et coût les plus faibles | 200K | $1 / $5 par MTok |

\* Prix API Anthropic affichés dans la documentation Platform à cette date. Un abonnement Claude, un provider cloud ou un contrat entreprise peut avoir une logique de facturation différente.

La documentation Platform recommande actuellement **Opus 5.5 comme point de départ pour la plupart des workloads**, Fable 5.1 lorsque le niveau de capacité supplémentaire est justifié, Sonnet 5 pour les workloads quotidiens où vitesse/coût comptent davantage, et Haiku 4.5 pour les tâches à fort volume ou sensibles à la latence.

---

## Résolution des alias selon le provider

La configuration Claude Code actuelle précise que les alias peuvent résoudre vers des versions différentes selon le fournisseur.

Exemple au 28 septembre 2026 :

| Provider | `opus` | `sonnet` |
|---|---|---|
| Anthropic API | Opus 5.5 | Sonnet 5 |
| Claude Platform on AWS | Opus 5.5 | Sonnet 4.6 |
| Amazon Bedrock / Google Cloud Agent Platform | Opus 5.5 | Sonnet 4.5 |
| Microsoft Foundry | Opus 4.6 | Sonnet 4.5 |

Ces valeurs sont **temporelles**. Consultez la page Model configuration avant de documenter un mapping dans une procédure d'équipe.

---

## Changer de modèle

### Pendant une session

```text
/model
```

Le picker affiche les modèles disponibles. Vous pouvez aussi sélectionner explicitement :

```text
/model sonnet
/model opus
/model fable
```

Dans les versions actuelles, choisir un modèle avec `/model` peut également l'enregistrer comme préférence utilisateur pour les nouvelles sessions. Le picker propose une action distincte pour changer uniquement la session courante.

### Au lancement

```bash
claude --model sonnet
```

### Variable d'environnement

```bash
export ANTHROPIC_MODEL=sonnet
```

### Settings

```json
{
  "model": "opus"
}
```

Préférez les alias pour suivre les versions recommandées du provider ; utilisez un identifiant complet si vous avez réellement besoin de pinner une version.

---

## Subagents, skills et organisation

Un subagent peut avoir son propre modèle :

```markdown
---
name: fast-explorer
model: haiku
---
```

Cette séparation est utile lorsque le travail est naturellement hétérogène : exploration volumineuse, implémentation quotidienne, puis revue difficile.

Ne créez cependant pas une architecture multi-modèles par principe. Vérifiez d'abord qu'elle améliore réellement coût, latence ou taux de réussite sur vos tâches.

Les organisations Enterprise peuvent aussi limiter les modèles accessibles via `availableModels` et définir des defaults organisationnels.

---

## Fable : cas particulier

Fable est conçu pour les problèmes qui dépassent souvent une seule courte interaction : investigation complexe, architecture, recherche longue ou session agentique prolongée.

Il n'est pas le modèle par défaut d'un plan ou provider. Selon le plan et le type de siège, son usage peut nécessiter des **usage credits**. Claude Code l'indique dans le picker et demande un consentement avant facturation en usage credits dans les sessions interactives concernées.

Utilisez Fable lorsque la tâche justifie cette capacité supplémentaire, pas comme simple montée de gamme automatique.

---

## Effort et modèle sont deux décisions différentes

Les modèles récents disposent de mécanismes de thinking/effort différents. Claude Code expose `/effort` pour les modèles compatibles.

```text
/effort
```

L'effort disponible dépend du modèle. Avant de changer de famille de modèle, testez si un niveau d'effort différent sur le modèle actuel résout déjà le problème de façon satisfaisante.

---

## Méthode de choix recommandée

Pour une décision reproductible :

1. constituez quelques tâches représentatives de votre dépôt ;
2. définissez des critères vérifiables : tests, qualité du diff, erreurs, temps, coût ;
3. testez les modèles réellement accessibles ;
4. comparez le résultat sur ces tâches ;
5. choisissez le modèle le moins coûteux/rapide qui atteint votre niveau de qualité ;
6. réévaluez lorsque les alias ou modèles changent.

Cette démarche est préférable à un classement universel des familles Claude.

---

## Vérifier le modèle réellement utilisé

Utilisez :

```text
/model
/status
```

Pour les usages automatisés, inspectez également les métadonnées retournées par Claude Code/Agent SDK lorsque votre workflow doit prouver quel modèle a réellement exécuté la tâche.

---

## Providers cloud et gateways

`ANTHROPIC_BASE_URL` change la destination des requêtes, pas automatiquement le modèle. Derrière Bedrock, Agent Platform, Foundry ou un gateway, les identifiants, versions accessibles et prix peuvent différer.

Pour un environnement entreprise reproductible :

- documentez le provider ;
- documentez l'alias **et** sa résolution actuelle si cela importe ;
- utilisez un allowlist si nécessaire ;
- testez les migrations de modèle avant déploiement large.

---

## Sources

- [Claude Code — Model configuration](https://code.claude.com/docs/en/model-config) — consulté le 2026-09-28
- [Claude Platform — Models overview](https://platform.claude.com/docs/en/models/overview) — consulté le 2026-09-28
- [Claude Platform — Choosing the right model](https://platform.claude.com/docs/en/about-claude/models/choosing-a-model) — consulté le 2026-09-28

## Prochaine étape

**[Coûts & quotas](couts-quotas.md)** pour comprendre comment les plans, usage credits, API et providers changent la logique de coût.