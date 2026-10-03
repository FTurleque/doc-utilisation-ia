# Continue — référence legacy

<span class="badge-beginner">Débutant</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">JetBrains</span>

Continue a été un assistant IA open source important pour VS Code, JetBrains et la CLI. **En 2026, il ne doit plus être présenté comme une solution activement développée à adopter par défaut.**

Le dépôt officiel `continuedev/continue` indique qu'il n'est plus activement maintenu et que la **version 2.0.0 est la release finale**. L'organisation Continue indique également avoir été **acquise par Cursor**.

Cette page est donc conservée comme **référence legacy** pour les installations existantes et pour comprendre les anciennes stacks locales Ollama/Continue.

---

## Que faire si vous utilisez déjà Continue ?

Vous pouvez continuer à exploiter une installation existante tant qu'elle répond à vos besoins, mais traitez-la comme une dépendance à durée de vie limitée :

- épinglez la version utilisée ;
- archivez votre configuration ;
- testez vos workflows après chaque mise à jour IDE ;
- n'attendez pas de nouvelles fonctions ou corrections régulières ;
- préparez une stratégie de remplacement.

Le README officiel recommande désormais plutôt le **Continue CLI** que le plugin JetBrains pour les utilisateurs qui restent sur la version finale.

---

## Ancien positionnement

Continue permettait notamment de choisir différents fournisseurs/modèles pour :

- chat ;
- édition ;
- autocomplétion ;
- workflows CLI ;
- modèles locaux via Ollama.

Cette architecture reste instructive : séparer le client IDE du moteur d'inférence permet de choisir un modèle local ou cloud par usage.

Mais ne construisez pas une nouvelle stratégie d'équipe 2026 autour de Continue sans accepter explicitement son statut de maintenance.

---

## Continue + Ollama — installation existante

Pour une installation déjà en place, la configuration moderne utilise `config.yaml`. Le fournisseur Ollama pointe typiquement vers :

```yaml
models:
  - name: local-model
    provider: ollama
    model: <modele-installe>
    apiBase: http://localhost:11434
```

Vérifiez la configuration réellement acceptée par votre release finale : les formats de configuration ont changé au cours de la vie du projet.

---

## Migration vers le parcours principal du dépôt

Pour les nouveaux projets de cette documentation :

```text
Claude Code
├── CLAUDE.md / rules / skills
├── MCP pour les services externes
├── RTK si les sorties terminal sont trop volumineuses
└── outils locaux séparés si une tâche justifie une inférence hors cloud
```

Ollama ou LM Studio peuvent toujours être utilisés comme **outils locaux complémentaires**, sans faire de Continue une dépendance centrale.

---

## Alternatives pour une installation legacy

Lors d'une migration, distinguez le besoin :

| Besoin historique Continue | Remplacement à évaluer |
|---|---|
| Agent principal sur le dépôt | Claude Code |
| Modèle local ponctuel | Ollama ou LM Studio + client adapté |
| Procédure spécialisée | Claude Skills / OpenSkills |
| Accès outil/API | MCP |
| Qualité statique | SonarQube / linters / IDE |

Le choix d'un autre assistant complet (Cursor, Windsurf, etc.) doit faire l'objet d'une évaluation distincte plutôt que d'être présenté comme équivalent automatique.

---

## Sources

- [Continue — dépôt officiel](https://github.com/continuedev/continue) — consulté le 2026-09-28
- [Organisation Continue sur GitHub](https://github.com/continuedev) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-13-outils-economies.md#page-chapitre-13-outils-economies-continue-dev).

## Prochaine étape

Poursuivez avec **[Ollama](ollama.md)**, la page suivante dans le menu.
