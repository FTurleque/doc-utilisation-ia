# Cline — agent de code open source et multi-provider

<span class="badge-intermediate">Intermédiaire</span>

**Cline** est un agent de développement open source qui fonctionne dans l'IDE et en CLI. Il met en avant une boucle **Plan / Act**, le contrôle des actions, le choix du provider et l'extension via MCP, rules, skills et hooks.

Dans ce dépôt, Cline est documenté comme **alternative agentique**. Claude Code reste le parcours principal.

---

## Ce que Cline apporte

La documentation Cline actuelle présente notamment :

- édition multi-fichiers ;
- exécution de commandes terminal ;
- modes Plan et Act ;
- checkpoints et retour arrière ;
- rules et skills ;
- MCP ;
- choix de différents fournisseurs de modèles ;
- modèles locaux via Ollama ou endpoints compatibles ;
- CLI utilisable en automatisation/CI.

---

## Surfaces

Cline existe sur plusieurs surfaces, avec une forte orientation IDE/CLI.

La documentation officielle actuelle mentionne notamment :

- VS Code ;
- JetBrains, selon la version de plugin et l'offre retenues ;
- CLI ;
- application desktop et SDK pour les intégrations propres ;
- autres éditeurs ou intégrations selon les mécanismes supportés.

!!! warning "Vérifiez la surface exacte"
    Les disponibilités IDE évoluent rapidement. Ne copiez pas une matrice de compatibilité ancienne ; vérifiez la page Cline IDE avant déploiement en équipe.

Les surfaces CLI, extension, plugin, desktop et SDK sont documentées dans le [README officiel Cline](https://github.com/cline/cline), revérifié le **3 octobre 2026**. Leur présence ne garantit pas une parité de fonctions ni de permissions.

---

## Plan / Act

Le découpage Plan / Act est utile pour séparer :

```text
comprendre / proposer
        ↓
valider la stratégie
        ↓
modifier / exécuter
        ↓
vérifier
```

Cette logique est comparable au besoin de séparer exploration, planification et exécution dans Claude Code, même si les interfaces et mécanismes diffèrent.

---

## Modèles et providers

Cline se positionne comme runtime **multi-provider**. Il peut utiliser différents fournisseurs et, selon la configuration, des modèles locaux ou des endpoints compatibles.

Cela permet d'évaluer séparément :

```text
agent runtime
≠
modèle
≠
provider
```

C'est important lors d'un benchmark : un meilleur résultat peut venir du modèle choisi, pas nécessairement de l'agent lui-même.

---

## MCP

Cline peut utiliser MCP pour connecter des outils externes.

Exemples :

- documentation interne ;
- base de données ;
- issue tracker ;
- plateforme cloud ;
- moteur de recherche spécialisé.

Même règle que pour Claude Code : n'exposez pas un MCP d'administration globale quand un outil de lecture ciblé suffit.

---

## Rules, skills et hooks

Cline propose des mécanismes pour enseigner au runtime les conventions d'un dépôt et automatiser certains événements.

Si un projet doit fonctionner avec **Claude Code et Cline**, évitez de dupliquer manuellement des centaines de lignes de règles.

Conservez :

- les conventions partagées dans `AGENTS.md` ou la documentation projet lorsque possible ;
- les contrats propres à Claude dans `.claude/` ;
- les contrats Cline dans les emplacements attendus par Cline ;
- une source de vérité unique pour les commandes de build/test.

---

## CLI

La CLI Cline actuelle est conçue pour des workflows interactifs mais aussi headless/CI.

Installation documentée actuellement :

```bash
npm install -g cline
```

Puis :

```bash
cline
```

Pour les pipelines, Cline documente également des modes machine-readable et d'auto-approval. En production, utilisez ces options avec une **identité et des permissions minimales**.

---

## Sécurité

Points à contrôler avant adoption :

- provider et lieu de traitement des données ;
- clés API / BYOK ;
- permissions fichiers ;
- commandes shell autorisées ;
- auto-approve ;
- MCP installés ;
- hooks/plugins ;
- logs et historique ;
- intégration CI.

!!! danger "Auto-approve"
    L'automatisation headless peut transformer une erreur de raisonnement en action réelle. Réservez l'auto-approval aux environnements et commandes bornés, avec tests et permissions limitées.

---

## Cline vs Claude Code

| Sujet | Claude Code | Cline |
|---|---|---|
| Modèle principal | Claude | multi-provider |
| Configuration projet | `CLAUDE.md`, `.claude/` | rules/configuration Cline |
| Skills | ✅ | ✅ selon surface/version |
| MCP | ✅ | ✅ |
| CLI | ✅ | ✅ |
| IDE | VS Code + JetBrains | VS Code, JetBrains selon surface actuelle |
| Modèles locaux | dépend intégration/provider | oui via providers/endpoints compatibles |
| Position ici | principal | alternative |

Le choix doit dépendre de vos contraintes, pas d'une comparaison marketing.

---

## Quand Cline est particulièrement intéressant

- vous voulez comparer plusieurs modèles dans le même harness ;
- vous utilisez des modèles locaux ;
- votre workflow est très centré sur l'IDE ;
- vous voulez une boucle d'approbation visible ;
- vous automatisez des tâches agentiques depuis le terminal/CI ;
- vous avez besoin d'un runtime agentique indépendant d'un seul fournisseur.

---

## Sources

Sources officielles consultées le **28 septembre 2026** :

- [Cline — The Open Coding Agent](https://cline.bot/)
- [Cline — IDE](https://cline.bot/ide)
- [Cline — CLI](https://cline.bot/cli)
- [Cline — CLI 2.0](https://cline.bot/blog/announcing-cline-cli-2-0)

## Prochaine étape

Poursuivez avec **[Kilo Code](kilo-code.md)**, la page suivante dans le menu.
