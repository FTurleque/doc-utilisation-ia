# LM Studio — backend local pour Claude Code

<span class="badge-beginner">Débutant</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">JetBrains</span>

LM Studio permet de télécharger, charger et servir des modèles locaux depuis une application desktop, une CLI ou un daemon headless. Depuis LM Studio 0.4.x, il expose une **API compatible Anthropic** et documente explicitement l'utilisation avec **Claude Code**.

---

## Positionnement

LM Studio est intéressant si vous voulez :

- une interface graphique pour gérer les modèles ;
- un serveur local sur `localhost` ;
- des APIs REST, OpenAI-compatible et Anthropic-compatible ;
- connecter directement Claude Code à un modèle local ;
- éventuellement exécuter le modèle sur une autre machine via LM Link.

---

## Démarrage avec Claude Code

Démarrez le serveur local :

```bash
lms server start --port 1234
```

Puis configurez Claude Code :

```bash
export ANTHROPIC_BASE_URL=http://localhost:1234
export ANTHROPIC_AUTH_TOKEN=lmstudio
claude --model <identifiant-du-modele>
```

Si l'authentification du serveur LM Studio est activée, utilisez le token LM Studio réel à la place de la valeur factice.

!!! warning "Le modèle change, pas seulement l'endpoint"
    Claude Code conserve son interface agentique, mais les performances dépendent entièrement du modèle servi par LM Studio : tool calling, contexte, raisonnement, vitesse et respect des instructions doivent être évalués sur vos tâches réelles.

---

## API locale

LM Studio propose plusieurs surfaces :

| API | Usage |
|---|---|
| `/api/v1/*` | API native LM Studio v1 |
| `/v1/messages` | Compatibilité Anthropic / Claude Code |
| `/v1/responses` | Compatibilité OpenAI Responses |
| `/v1/chat/completions` | Compatibilité OpenAI Chat Completions |
| `/v1/embeddings` | Embeddings |

Pour les nouveaux développements LM Studio spécifiques, la documentation recommande l'API REST native v1. Pour Claude Code, utilisez la surface Anthropic-compatible.

---

## GUI, CLI et headless

Vous pouvez démarrer le serveur depuis l'onglet Developer de l'application ou via :

```bash
lms server start
```

LM Studio fournit également un mode headless (`llmster`) pour les machines sans GUI, les serveurs ou certains environnements automatisés.

---

## LM Link

LM Link permet de garder Claude Code sur un laptop tout en exécutant le modèle sur une machine plus puissante du réseau.

Cela peut être utile si :

- le poste développeur n'a pas assez de VRAM ;
- une station dédiée possède les modèles validés par l'équipe ;
- vous voulez centraliser l'inférence locale sans envoyer les données à un fournisseur cloud externe.

Appliquez malgré tout les règles réseau, authentification et contrôle d'accès adaptées.

---

## Sécurité du serveur local

Par défaut, gardez le serveur lié à `127.0.0.1`.

Si vous l'exposez sur le réseau :

- activez l'authentification ;
- limitez les interfaces et règles firewall ;
- n'utilisez pas `0.0.0.0` par simple commodité ;
- contrôlez les clients autorisés ;
- vérifiez ce que les logs conservent.

LM Studio avertit explicitement qu'un bind réseau ou CORS élargi augmente l'exposition.

---

## Dimensionner le contexte

Les agents de code consomment beaucoup de contexte. LM Studio recommande un contexte suffisamment grand pour Claude Code ; mais la valeur réellement viable dépend du modèle et de la mémoire disponible.

Mesurez :

- temps de chargement ;
- tokens/s ;
- Time To First Token ;
- mémoire GPU/RAM ;
- taux de réussite des tool calls ;
- réussite des tests après modification.

Ne choisissez pas un modèle sur la seule base de sa taille ou d'un benchmark général.

---

## LM Studio vs Ollama

| Besoin | LM Studio | Ollama |
|---|---|---|
| GUI riche | Oui | Plus minimal |
| CLI / API | Oui | Oui |
| Claude Code via API Anthropic | Oui | Oui |
| Gestion visuelle des modèles | Point fort | Secondaire |
| Automatisation simple CLI | Possible | Très naturel |
| Exécution distante LAN | LM Link / serveur | Serveur Ollama configurable |

Le choix dépend du workflow, pas d'un classement universel.

---

## Continue — référence legacy

Les anciennes versions de cette documentation recommandaient LM Studio + Continue pour connecter un modèle local à l'IDE. Ce montage reste possible dans une installation existante, mais **Continue n'est plus activement maintenu**. Pour un nouveau setup Claude-first, préférez la connexion directe Claude Code ↔ LM Studio.

---

## Sources

- [LM Studio — Claude Code](https://lmstudio.ai/docs/integrations/claude-code) — consulté le 2026-09-28
- [LM Studio — compatibilité Anthropic](https://lmstudio.ai/docs/developer/anthropic-compat) — consulté le 2026-09-28
- [LM Studio — serveur local](https://lmstudio.ai/docs/developer/core/server) — consulté le 2026-09-28
- [LM Studio — REST API](https://lmstudio.ai/docs/developer/rest) — consulté le 2026-09-28

## Prochaine étape

Utilisez les guides de stack uniquement après avoir choisi entre **Claude officiel**, **Ollama** et **LM Studio** selon sécurité, ressources machine et qualité mesurée.