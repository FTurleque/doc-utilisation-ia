# Comparaison des outils — choisir par contrainte

<span class="badge-intermediate">Intermédiaire</span>

Cette page ne classe pas les assistants par « meilleur outil ». Elle aide à distinguer **agent principal, backend de modèle et outils complémentaires**, puis à choisir selon les contraintes du projet.

---

## Trois catégories à ne pas mélanger

| Catégorie | Exemples | Rôle |
|---|---|---|
| Agent / environnement | Claude Code, Windsurf, Tabnine, GitHub Copilot, Kiro | Lire/modifier le dépôt et orchestrer des tâches |
| Backend de modèle | Claude, Ollama, LM Studio | Fournir le modèle/inférence |
| Outil de preuve ou contexte | SonarQube, RTK, MCP, skills | Produire des signaux, réduire le bruit ou donner des capacités |

RTK et SonarQube ne sont donc pas des « alternatives à Claude » ; Ollama n'est pas un IDE ; OpenSkills n'est pas un modèle.

---

## Parcours principal du dépôt

```text
Claude Code
├── backend Claude habituel
├── OU Ollama / LM Studio si le local est justifié
├── SonarQube / tests / linters comme preuves
├── MCP pour services dynamiques
├── Skills pour procédures réutilisables
└── RTK uniquement si les sorties CLI sont trop volumineuses
```

GitHub Copilot reste documenté comme environnement de référence secondaire.

---

## Choisir selon la contrainte principale

| Contrainte | Piste à évaluer | Vérification indispensable |
|---|---|---|
| Agent généraliste dans plusieurs IDE/terminal | Claude Code | permissions, coût réel, qualité sur le repo |
| Inférence locale | Ollama ou LM Studio derrière Claude Code | RAM/VRAM, tool calling, contexte, sécurité réseau |
| Analyse statique / qualité | SonarQube for IDE + CI/MCP | règles, Quality Gate, tests |
| Sorties terminal trop verbeuses | RTK | mesurer avec `rtk gain` |
| Données structurées répétitives | TOON, après benchmark local | tokens + fidélité du round-trip |
| Skills multi-agents | OpenSkills | audit de la source et des scripts |
| IDE agentique dédié | Windsurf | gouvernance, migration IDE, coûts actuels |
| Gouvernance/déploiement privé poussés | Tabnine | engagements contractuels et architecture cible |
| Stack AWS | Kiro / Amazon Q pendant la transition | échéance Q IDE, permissions AWS |
| Copilot déjà déployé | GitHub Copilot | AI Credits, politiques org, modèles disponibles |

---

## Produits legacy ou en transition

| Produit | État documentaire |
|---|---|
| Continue | Référence legacy : dépôt plus activement maintenu, release finale 2.0.0 |
| Supermaven | Référence historique : sunset annoncé ; ne pas choisir pour un nouveau déploiement |
| Amazon Q Developer IDE | En transition vers Kiro ; fin de support annoncée au 30 avril 2027 |
| Codeium | Nom historique ; la surface actuelle à évaluer est Windsurf |

Cette distinction évite qu'une ancienne page du dépôt soit interprétée comme une recommandation 2026.

---

## Local ne veut pas dire automatiquement meilleur ou gratuit

Un modèle local peut supprimer un coût API marginal, mais introduit :

- matériel et consommation électrique ;
- administration ;
- téléchargement/stockage des modèles ;
- performances parfois plus faibles ;
- contraintes de contexte ;
- sécurité réseau si le serveur est exposé.

Mesurez le coût total et la qualité plutôt que de comparer uniquement le prix par token.

---

## Confidentialité

Pour un besoin de confidentialité forte, vérifiez toute la chaîne :

```text
éditeur / agent
→ modèle
→ MCP et outils
→ logs
→ télémétrie
→ stockage local
→ éventuels services distants
```

« Modèle local » ne garantit pas que tous les autres composants restent hors cloud.

---

## Validation commune à toutes les stacks

Une comparaison utile doit être faite sur un petit corpus de tâches réelles du dépôt :

1. correction de bug avec test reproduisant l'erreur ;
2. changement multi-fichiers ;
3. ajout de tests ;
4. tâche nécessitant documentation externe ;
5. tâche avec outil/MCP ;
6. mesure du coût, latence, rework et taux de réussite des validations.

Évitez les estimations génériques de « % d'économie » ou de « précision » sans protocole reproductible.

---

## Guides pratiques

- [Stack locale — VS Code](stack-prete-15-min-vscode.md)
- [Stack locale — IntelliJ](stack-prete-15-min-intellij.md)
- [Vue d'ensemble des outils](outils-complementaires.md)
- [Recommandations par contexte](recommandations-taille-type-application.md)

---

## Sources

Les pages détaillées de chaque outil citent leurs sources officielles et leur date de vérification. Pour les prix, quotas et disponibilités, utilisez toujours la source du fournisseur au moment de la décision.

## Prochaine étape

**[Vue d'ensemble des outils](outils-complementaires.md)** pour comprendre rapidement le rôle de chaque brique avant de composer une stack.