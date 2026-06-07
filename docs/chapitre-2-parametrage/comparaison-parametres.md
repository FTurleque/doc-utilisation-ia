# Comparaison des Paramètres — IntelliJ vs VS Code

<span class="badge-intellij">IntelliJ</span> <span class="badge-vscode">VS Code</span>

## Présentation

Cette page compare les options de configuration disponibles entre IntelliJ IDEA et Visual Studio Code pour GitHub Copilot. Les deux IDEs offrent aujourd'hui un socle fonctionnel proche, mais la **documentation officielle** n'est pas aussi détaillée sur tous les mécanismes dans les deux environnements.

!!! info "Règle de lecture"
    Quand un mécanisme est **documenté explicitement** côté GitHub pour VS Code mais pas détaillé de la même façon pour JetBrains, nous l'indiquons comme **mieux documenté** plutôt que comme automatiquement identique.

---

## Tableau comparatif général

| Paramètre / Fonctionnalité | IntelliJ IDEA | VS Code |
|---------------------------|:-------------:|:-------:|
| **Activer/Désactiver Copilot** | ✅ Interface Settings | ✅ `settings.json` / UI |
| **Configurer le chat et les complétions** | ✅ UI | ✅ UI + JSON |
| **Choisir un modèle** | ✅ Selon plan / build | ✅ Selon plan / build |
| **Instructions de dépôt `.github/copilot-instructions.md`** | ✅ Oui | ✅ Oui |
| **Instructions ciblées** | ⚠️ Oui, mais UX/documentation moins explicites | ✅ Très bien documenté |
| **Prompt files / artefacts avancés** | ⚠️ Selon version et workflow | ✅ Très bien documenté |
| **Hooks Copilot** | ❌ Non documenté pour JetBrains | ✅ Documenté |
| **MCP / contexte externe** | ✅ Présent dans l'écosystème Copilot, disponibilité selon environnement | ✅ Très bien documenté |
| **Partage d'équipe par Git** | ✅ Via fichiers du dépôt | ✅ Via fichiers du dépôt |
| **Partage de réglages IDE** | ⚠️ Possible mais moins portable | ✅ Très naturel avec `.vscode/` |
| **Pilotage fin du contexte** | ✅ Bon niveau avec instructions + structure projet | ✅ Excellent niveau avec doc plus riche |
| **Contexte sémantique JVM** | ✅ Excellente force d'IntelliJ | ⚠️ Bon, mais moins natif |

**Légende :** ✅ Bien supporté · ⚠️ Disponible mais moins explicite / dépendant de la version · ❌ Non documenté comme mécanisme de référence dans cet IDE

---

## Ce qui a réellement progressé côté IntelliJ

L'écosystème GitHub Copilot a désormais une documentation officielle plus large sur :

- les **instructions de dépôt**
- la **configuration du contexte**
- le **choix des modèles**
- MCP comme mécanisme d'extension du contexte
- les fonctions avancées liées aux usages agentiques

Conséquence pratique : **IntelliJ n'est plus seulement un IDE de complétion**. Pour beaucoup d'équipes, il permet maintenant un niveau de personnalisation utile et rentable à condition de partir d'un socle simple et portable :

1. `README.md` à jour
2. `.github/copilot-instructions.md` propre
3. règles ciblées seulement si elles corrigent un vrai bruit
4. exclusions des dossiers générés / sensibles

---

## Fonctionnalités où VS Code reste mieux documenté

| Sujet | IntelliJ IDEA | VS Code |
|---|---|---|
| **Prompt files** | ⚠️ À vérifier selon votre version / workflow | ✅ Documentation explicite |
| **Custom agents** | ⚠️ Disponibilité à valider dans votre environnement | ✅ Documentation explicite |
| **Hooks** | ❌ | ✅ |
| **Instruction files avancés** | ⚠️ Moins lisible côté doc JetBrains | ✅ Très bien expliqué |
| **Références de personnalisation** | ⚠️ Plus dispersées | ✅ Plus centralisées |

!!! warning "Ne pas confondre produit et interface"
    GitHub Copilot propose aujourd'hui plus de mécanismes avancés au niveau produit. Cela ne signifie pas que **chaque écran IntelliJ** expose toutes les options avec la même granularité que VS Code.

---

## Équivalences utiles pour une équipe

| Objectif | IntelliJ | VS Code |
|----------|----------|---------|
| Réduire le bruit des suggestions | Désactiver certains langages / ajuster les complétions | `settings.json` ciblé |
| Stabiliser le style des réponses | `.github/copilot-instructions.md` | `.github/copilot-instructions.md` |
| Réduire le coût des sessions longues | Fonctions avancées à la demande, peu d'auto-approve | Idem, avec réglages plus visibles |
| Partager la gouvernance IA | Fichiers du dépôt versionnés | Fichiers du dépôt versionnés |
| Travailler sur Java / Kotlin | Avantage fort IntelliJ | Bon support, moins natif |
| Travailler sur workflows de personnalisation très poussés | Possible, mais à valider version par version | Plus simple et mieux documenté |

---

## Recommandation

**Pour un usage standard** (complétions + chat + instructions de dépôt) : les deux IDEs sont aujourd'hui **beaucoup plus proches** qu'avant.

**Pour une personnalisation avancée et très documentée** : **VS Code** garde un avantage grâce à la richesse de sa documentation officielle sur les artefacts de personnalisation.

**Pour des projets Java / JVM** : **IntelliJ IDEA** reste souvent le meilleur choix grâce à son contexte sémantique natif et à sa compréhension du projet.

**Pour optimiser précision + coût dans IntelliJ** : commencez par le trio suivant avant tout raffinement avancé :

- `README.md` clair
- `.github/copilot-instructions.md` maintenu
- périmètre de fichiers et de dossiers réduit au strict utile

---

## Sources

- GitHub Docs — *[Support for different types of custom instructions](https://docs.github.com/en/copilot/reference/custom-instructions-support)* (consulté le 2026-06-03)
- GitHub Docs — *[Adding repository custom instructions for GitHub Copilot in your IDE](https://docs.github.com/en/copilot/how-tos/configure-custom-instructions-in-your-ide/add-repository-instructions-in-your-ide)* (consulté le 2026-06-03)
- GitHub Docs — *[Models and pricing for GitHub Copilot](https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing)* (consulté le 2026-06-03)
- GitHub Docs — *[Improving agent quality to optimize AI usage](https://docs.github.com/en/copilot/tutorials/optimize-ai-usage)* (consulté le 2026-06-03)
- Visual Studio Code Docs — *[Prompt files](https://code.visualstudio.com/docs/copilot/customization/prompt-files)* (consulté le 2026-06-03)

---

## Prochaine étape

**[CLI Modes et Workflows](../chapitre-3-cli-modes/index.md)** : découvrir les différents modes de fonctionnement de Copilot et savoir quand passer d'une interaction simple à un workflow plus agentique.

Concepts clés couverts :

- **Mode inline** — complétion automatique et suggestions de code
- **Mode Chat** — conversation interactive avec Copilot
- **Mode CLI** — usage orienté tâches et automatisation
- **Choix du bon mode** — comment limiter coût, bruit et rework selon le besoin
