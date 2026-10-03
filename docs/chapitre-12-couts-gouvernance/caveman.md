# Caveman — réduire le bruit et les tokens des agents

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span>

**Caveman** est un projet centré sur la **réduction du volume de tokens** produit et consommé par les agents de développement. Il propose trois niveaux distincts : un skill qui force des réponses plus concises, un proxy local qui compresse les sorties lues par l'agent, et un middleware pour intégrer la même logique dans ses propres applications agentiques.

Sa place principale dans cette documentation est **Coûts & Gouvernance** : Caveman n'améliore pas la qualité d'un modèle par lui-même ; il vise surtout à réduire le bruit, les sorties verbeuses et certaines consommations inutiles.

!!! info "Vérifié le 1er octobre 2026"
    Le README actuel documente Claude Code parmi les agents pris en charge. Les chiffres d'économie publiés par le projet ou des tiers doivent être lus comme des résultats de protocoles spécifiques, pas comme une garantie universelle sur votre dépôt.

---

## Trois mécanismes différents

### 1. Skill

Le skill agit surtout sur la **forme des réponses** de l'agent : réponses plus courtes, moins de préambules, conservation des commandes, chemins, messages d'erreur et avertissements importants.

Installation générique documentée :

```bash
npx skills add JuliusBrussee/caveman -g
```

Le projet propose également une installation comme plugin Claude Code.

### 2. Proxy local

Le proxy se place entre l'agent et le provider et cherche à réduire ce que l'agent **relit** : logs, sorties de tests, JSON, diffs ou pages volumineuses.

```bash
npm install -g @caveman-ai/cli
caveman setup --install
caveman claude
```

L'original est conservé localement afin de pouvoir être récupéré si la compression retire un détail nécessaire.

### 3. Middleware

Pour les applications agentiques développées en TypeScript ou Python, Caveman fournit aussi un middleware et un SDK pour compresser les tool results avant leur envoi au modèle.

---

## Caveman n'est pas `/compact`

Les mécanismes ne travaillent pas au même niveau :

| Mécanisme | Ce qu'il réduit |
|---|---|
| skill Caveman | verbosité de la réponse de l'agent |
| proxy Caveman | certaines entrées/outils avant lecture par le modèle |
| `/compact` Claude Code | historique/contexte de conversation |
| RTK | sortie de commandes terminales ciblées |
| Semble | quantité de code chargée pour trouver un élément |

Ils peuvent être complémentaires, mais empiler tous les mécanismes sans mesure peut rendre le diagnostic plus difficile.

---

## Quand Caveman peut être utile

- agent qui produit des réponses inutilement longues ;
- logs/test outputs très volumineux ;
- sessions répétitives où le coût de lecture domine ;
- équipe qui veut comparer un workflow compressé et non compressé ;
- application agentique qui contrôle précisément les tool results envoyés au modèle.

Il est moins pertinent lorsque :

- le coût principal vient d'un raisonnement complexe réellement nécessaire ;
- les sorties sont déjà petites ;
- la compression risque de masquer un détail critique ;
- le workflow est court et peu fréquent.

---

## Mesurer avant d'adopter

Le projet publie ses propres métriques et cite des évaluations externes. Pour décider dans votre environnement, utilisez plutôt un test A/B sur des tâches réelles :

1. même modèle ;
2. même tâche ;
3. mêmes outils ;
4. une exécution sans Caveman ;
5. une exécution avec le mécanisme choisi ;
6. comparaison des tokens, coût, latence, taux de réussite et rework.

Le projet fournit notamment des commandes de statistiques et de trial ; vérifiez leur syntaxe dans la version installée avant automatisation.

---

Le proxy conserve les originaux dans une base SQLite locale : leur rétention, leurs droits d’accès et leur suppression font partie de la gouvernance. Un proxy partagé nécessite en plus une isolation des namespaces/sessions et une authentification adaptée. Réduire le texte envoyé au modèle ne supprime pas la copie originale sur disque. [Architecture officielle Caveman](https://github.com/JuliusBrussee/caveman), revérifiée le 3 octobre 2026.

## Risques et gouvernance

Une compression agressive peut supprimer du contexte utile. Les garde-fous importants sont :

- ne jamais supprimer les avertissements de sécurité ;
- conserver les messages d'erreur exacts lorsque le diagnostic en dépend ;
- garder une voie de récupération vers la sortie originale ;
- éviter de compresser aveuglément les résultats structurés utilisés par une machine ;
- auditer le proxy avant de lui faire traiter des données sensibles ;
- comparer le résultat final, pas uniquement le nombre de tokens.

!!! warning "Économie de tokens ≠ économie totale"
    Une réponse plus courte peut coûter moins cher mais provoquer plus de rework si elle perd une information importante. Le KPI principal reste la tâche terminée correctement avec validation.

---

## Caveman, RTK et Semble

| Outil | Cible principale |
|---|---|
| **Caveman** | verbosité agent + compression de certaines entrées/tool results |
| [RTK](../chapitre-13-outils-economies/rtk.md) | sorties terminales volumineuses |
| [Semble](../chapitre-4-contexte/semble.md) | recherche de code avec snippets ciblés |

Choisissez le mécanisme qui correspond à la source réelle du bruit.

---

## Sources

Sources consultées le **1er octobre 2026** :

- [Caveman — dépôt officiel](https://github.com/JuliusBrussee/caveman)
- [Caveman — guide d'installation](https://github.com/JuliusBrussee/caveman/blob/main/INSTALL.md)
- [Caveman — documentation](https://github.com/JuliusBrussee/caveman/tree/main/docs)

## Prochaine étape

Poursuivez avec **[Quand utiliser quel mode ?](modes-quand-utiliser.md)**, la page suivante dans le menu.
