# Ollama — backend local ou cloud pour Claude Code

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">JetBrains</span>

Ollama exécute des modèles localement et propose aussi des modèles cloud. Son API expose désormais une compatibilité **Anthropic Messages API**, ce qui permet de connecter **Claude Code directement à Ollama** sans passer par Continue.

---

## Pourquoi Ollama est pertinent ici

Ollama peut servir à :

- exécuter un modèle local sur votre machine ;
- exposer une API locale sur `http://localhost:11434` ;
- utiliser un modèle local ou cloud via les API Ollama ;
- fournir un backend compatible Anthropic à Claude Code ;
- tester une stratégie local-first avant d'utiliser un modèle distant plus coûteux.

!!! warning "Claude Code ≠ modèle Claude"
    Lorsque Claude Code pointe vers Ollama, l'interface et les outils restent ceux de Claude Code, mais le **modèle sous-jacent peut être un modèle Ollama non-Anthropic**. Les capacités, la qualité des tool calls, le contexte et le comportement peuvent donc différer fortement.

---

## Démarrage rapide avec Claude Code

La documentation Ollama actuelle propose :

```bash
ollama launch claude
```

Pour configurer sans lancer immédiatement :

```bash
ollama launch claude --config
```

Configuration manuelle :

```bash
export ANTHROPIC_AUTH_TOKEN=ollama
export ANTHROPIC_BASE_URL=http://localhost:11434
claude --model <modele-ollama>
```

Sur Windows, adaptez les variables d'environnement au shell utilisé.

---

## API locale

Le serveur local Ollama expose notamment :

```text
http://localhost:11434/api
```

et des surfaces de compatibilité :

```text
OpenAI compatible :   http://localhost:11434/v1
Anthropic compatible : http://localhost:11434
```

La compatibilité Anthropic inclut actuellement `/v1/messages`, streaming, messages multi-tours et tool calling, avec certaines différences par rapport à l'API Anthropic complète.

---

## Différences à connaître

La documentation Ollama signale notamment que certaines fonctions Anthropic ne sont pas prises en charge ou seulement partiellement :

- endpoint `count_tokens` ;
- prompt caching Anthropic ;
- Batches API ;
- citations ;
- documents PDF via les content blocks Anthropic ;
- certains détails de `tool_choice` ou metadata ;
- extended thinking avec sémantique différente selon le modèle.

Ne partez donc pas du principe qu'un workflow testé sur Claude Sonnet/Opus se comporte à l'identique sur un modèle local.

---

## Choisir un modèle

Évitez de figer ici une liste « meilleure en 2026 ». La bibliothèque évolue rapidement.

Pour un agent de code, testez au minimum :

- qualité du tool calling ;
- longueur de contexte réellement utilisable ;
- respect des instructions ;
- capacité à modifier plusieurs fichiers sans dérive ;
- latence ;
- mémoire GPU/RAM ;
- réussite sur vos tests de dépôt.

La documentation Ollama recommande elle-même plusieurs modèles orientés code, mais cette liste doit être vérifiée au moment du choix.

---

## Sécurité locale

« Local » ne signifie pas automatiquement « sécurisé ».

- Vérifiez où sont stockés les modèles et logs.
- Ne bind pas le serveur sur `0.0.0.0` sans authentification/règles réseau appropriées.
- Un modèle local peut toujours lire des secrets si Claude Code lui donne accès au fichier.
- Les permissions Claude, hooks et MCP restent nécessaires pour contrôler les actions.

---

## Quand utiliser Ollama avec Claude Code

| Situation | Intérêt |
|---|---|
| Code sensible devant rester sur le poste | Fort si le modèle et tout le pipeline restent locaux |
| Tâches simples/répétitives | Bon candidat |
| Machine GPU puissante | Permet des modèles plus capables |
| Laptop limité | Préférer petit modèle ou backend distant |
| Workflow agentique critique | Benchmark obligatoire avant adoption |

---

## Copilot et autres clients

Ollama peut aussi alimenter d'autres clients compatibles OpenAI/Anthropic ou des plugins IDE. Ces usages restent possibles, mais le parcours principal de ce dépôt est désormais **Claude Code directement connecté à Ollama** lorsque l'objectif est local-first.

---

## Sources

- [Ollama — API](https://docs.ollama.com/api) — consulté le 2026-09-28
- [Ollama — compatibilité Anthropic et Claude Code](https://docs.ollama.com/api/anthropic-compatibility) — consulté le 2026-09-28
- [Ollama — dépôt officiel](https://github.com/ollama/ollama) — consulté le 2026-09-28

## Prochaine étape

**[LM Studio](lm-studio.md)** pour une alternative locale avec GUI, API v1, compatibilité Anthropic et intégration Claude Code documentée.