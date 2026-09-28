# Stack locale rapide — VS Code + Claude Code

<span class="badge-beginner">Débutant</span> <span class="badge-vscode">VS Code</span>

Cette page remplace l'ancienne stack **Continue + Ollama + RTK**. Continue n'étant plus activement maintenu, le parcours recommandé est désormais plus simple : **Claude Code + backend Claude officiel, Ollama ou LM Studio**, avec RTK et SonarQube en compléments si nécessaire.

Le nom de fichier historique contient « 15 min », mais le temps réel dépend du téléchargement des modèles, du matériel et de l'environnement réseau.

---

## Stack cible

```text
VS Code
└── Claude Code
    ├── Anthropic / fournisseur Claude habituel
    ├── OU Ollama compatible Anthropic
    └── OU LM Studio compatible Anthropic

Compléments optionnels
├── RTK pour réduire les sorties terminal
├── SonarQube for IDE pour l'analyse statique
└── MCP pour les services externes
```

---

## Option A — Claude Code standard

Installez Claude Code selon le guide principal puis ouvrez le dépôt dans VS Code.

Validez :

```bash
claude --version
claude doctor
```

Dans Claude Code, vérifiez `/status` et les permissions avant de lancer une modification importante.

---

## Option B — Claude Code + Ollama

Ollama documente directement Claude Code comme client compatible.

```bash
ollama launch claude
```

Ou manuellement :

```bash
export ANTHROPIC_AUTH_TOKEN=ollama
export ANTHROPIC_BASE_URL=http://localhost:11434
claude --model <modele-local>
```

Le modèle local doit être évalué sur vos tâches réelles, en particulier tool calling et contexte.

---

## Option C — Claude Code + LM Studio

Démarrez le serveur :

```bash
lms server start --port 1234
```

Puis :

```bash
export ANTHROPIC_BASE_URL=http://localhost:1234
export ANTHROPIC_AUTH_TOKEN=lmstudio
claude --model <modele-local>
```

LM Studio permet également de configurer ces variables pour l'extension Claude Code VS Code.

---

## Ajouter RTK si nécessaire

RTK est utile lorsque tests, builds ou Git produisent des sorties très volumineuses.

```bash
rtk init --global --dry-run
rtk init --global
rtk gain
```

Ne l'ajoutez pas « par principe » : mesurez d'abord le bruit réel.

---

## Ajouter SonarQube for IDE

Pour les problèmes de qualité déterministes :

1. installez l'extension officielle SonarSource ;
2. corrigez les issues simples avec les quick fixes ;
3. utilisez Claude pour les cas complexes ;
4. relancez tests et analyse Sonar.

---

## Validation minimale

Avant de considérer la stack opérationnelle :

- Claude Code lit le dépôt ;
- une modification simple peut être annulée/revue ;
- les tests ciblés sont exécutables ;
- le backend choisi tient le contexte nécessaire ;
- les secrets ne sont pas stockés dans les settings du workspace ;
- les outils MCP éventuels sont limités au strict nécessaire.

---

## Continue — référence legacy

Si une équipe utilise encore Continue, conservez sa configuration tant qu'elle fonctionne, mais ne l'introduisez pas comme nouvelle dépendance centrale : son dépôt officiel n'est plus activement maintenu et la release 2.0.0 est finale.

---

## Sources

- [Claude Code — VS Code](https://code.claude.com/docs/en/vs-code) — consulté le 2026-09-28
- [Ollama — Claude Code](https://docs.ollama.com/api/anthropic-compatibility) — consulté le 2026-09-28
- [LM Studio — Claude Code](https://lmstudio.ai/docs/integrations/claude-code) — consulté le 2026-09-28

## Prochaine étape

**[Stack locale rapide — IntelliJ](stack-prete-15-min-intellij.md)** pour le même principe avec les outils de refactoring JetBrains.