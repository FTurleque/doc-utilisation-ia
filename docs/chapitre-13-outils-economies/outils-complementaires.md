# Vue d'ensemble des outils complémentaires

<span class="badge-intermediate">Intermédiaire</span>

Claude Code est l'agent principal de cette documentation, mais il ne doit pas remplacer les outils plus déterministes ni empêcher un choix local ou spécialisé lorsque celui-ci est pertinent.

Cette page sert de carte du chapitre 13.

---

## Outils de preuve et de réduction du bruit

| Outil | Rôle | Page |
|---|---|---|
| SonarQube | Analyse statique, Quality Gates, MCP Sonar | [SonarQube](sonarqube.md) |
| RTK | Réduire certaines sorties CLI envoyées à l'agent | [RTK](rtk.md) |
| TOON | Représenter de façon compacte certaines données structurées | [TOON](toon.md) |
| MCP | Connecter Claude à des services/données dynamiques | [MCP](mcps/index.md) |
| OpenSkills | Installer/synchroniser des skills portables | [OpenSkills](openskills.md) |

Ces outils complètent Claude ; ils ne sont pas des modèles concurrents.

---

## Backends locaux

| Outil | Positionnement | Page |
|---|---|---|
| Ollama | CLI/API locale et cloud, compatibilité Anthropic pour Claude Code | [Ollama](ollama.md) |
| LM Studio | GUI + serveur local, API Anthropic compatible Claude Code | [LM Studio](lm-studio.md) |

Les deux permettent maintenant de garder **Claude Code comme interface agentique** tout en changeant le modèle servi.

---

## Assistants ou environnements alternatifs

| Produit | Statut / raison de l'évaluer | Page |
|---|---|---|
| Windsurf | IDE agentique actuel, issu de Codeium, désormais chez Cognition | [Windsurf](codeium-windsurf.md) |
| Tabnine | Gouvernance et options de déploiement entreprise | [Tabnine](tabnine.md) |
| Amazon Q / Kiro | Spécialisation AWS, migration en cours vers Kiro | [Amazon Q](amazon-q-developer.md) |
| GitHub Copilot | Référence conservée pour compatibilité et éventuel retour | Chapitres Copilot |

---

## Références legacy

| Produit | Pourquoi la page reste |
|---|---|
| Continue | Installations existantes et historique des stacks locales ; maintenance active arrêtée |
| Supermaven | Utilisateurs existants ; sunset annoncé |

Ne créez pas une nouvelle stack d'équipe autour d'une page legacy uniquement parce qu'elle existe encore dans la documentation.

---

## Comment composer la stack

Commencez par le problème, pas par l'outil :

```text
Besoin de corriger mécaniquement ? → IDE / linter / Sonar
Besoin de preuves dynamiques ?      → tests / MCP / API officielle
Besoin de réduire du bruit CLI ?    → RTK
Besoin de procédures réutilisables ?→ skills
Besoin de modèle local ?            → Ollama ou LM Studio
Besoin d'un autre environnement ?   → évaluer un assistant alternatif
```

---

## Règle de cohabitation IDE

Évitez d'activer plusieurs moteurs de complétion inline concurrents. Un agent principal et un moteur inline clairement choisis réduisent les conflits de raccourcis, de suggestions et de contexte.

---

## Validation avant standardisation équipe

Pour chaque outil ajouté :

- définir ce qu'il remplace ou complète ;
- vérifier sa maintenance actuelle ;
- documenter données envoyées et secrets requis ;
- mesurer le bénéfice sur des tâches réelles ;
- prévoir la désinstallation/migration ;
- ne pas dupliquer les mêmes règles dans cinq formats propriétaires.

---

## Pour aller plus loin

- [Comparaison des outils](comparaison.md)
- [Recommandations par contexte](recommandations-taille-type-application.md)
- [Stack locale — VS Code](stack-prete-15-min-vscode.md)
- [Stack locale — IntelliJ](stack-prete-15-min-intellij.md)

## Prochaine étape

**[Recommandations par contexte](recommandations-taille-type-application.md)** : partir des contraintes d'un projet plutôt que d'un classement d'outils.