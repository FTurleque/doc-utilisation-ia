# Problèmes courants — Claude Code

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">JetBrains</span>

Cette page couvre les symptômes les plus fréquents avec **Claude Code**.

!!! info "Premier réflexe"
    Si Claude Code démarre, lancez `/doctor`. Si `claude` est introuvable, vérifiez d'abord le PATH et l'installation standalone ; une commande introuvable ne peut pas exécuter `doctor`.

---

## 1. `claude` est introuvable ou ne démarre pas

Localisez d'abord l'exécutable dans le shell concerné :

```powershell
# Windows PowerShell
Get-Command claude -All
```

```bash
# macOS / Linux / WSL
command -v claude
```

L'installation native se trouve par défaut sous `%USERPROFILE%\.local\bin\claude.exe` sur Windows et `~/.local/bin/claude` sur macOS/Linux. Ouvrez un nouveau terminal après installation ou modification du PATH. L'extension VS Code embarque sa propre CLI mais ne rend pas `claude` disponible dans le terminal.

Une fois la commande trouvée, vérifiez :

```bash
claude --version
claude doctor
```

Causes fréquentes :

- installation incomplète ;
- PATH non actualisé ;
- shell non redémarré après installation ;
- installation ancienne ou multiple ;
- environnement Windows/WSL différent de celui où Claude a été installé.

Évitez de supprimer immédiatement `~/.claude` ou `~/.claude.json` : ces emplacements contiennent configuration, authentification et données de session.

---

## 2. Authentification ou compte incorrect

Dans Claude Code :

```text
/status
/login
```

`/status` permet notamment de vérifier le compte, le modèle et l'état de connexion.

!!! warning "API key prioritaire"
    Si `ANTHROPIC_API_KEY` est définie, Claude Code peut utiliser cette clé et facturer l'usage via l'API au lieu de l'allocation de votre abonnement Claude. Vérifiez vos variables d'environnement si le comportement de facturation semble inattendu.

---

## 3. Limite d'usage atteinte

Les limites d'usage Claude sont partagées entre plusieurs surfaces Claude selon le plan. La consommation dépend notamment de la longueur et de la complexité des conversations, du modèle, du niveau d'effort et des fonctionnalités utilisées.

Vérifiez :

```text
/status
/usage
```

Selon votre plan, vous pouvez :

- attendre la remise à zéro de la limite ;
- utiliser des usage credits si vous les avez activés ;
- changer de plan ;
- utiliser un compte Console/API distinct pour un besoin ponctuel intensif.

---

## 4. Contexte saturé ou réponses qui dérivent

Symptômes :

- Claude oublie le but initial ;
- les réponses deviennent moins ciblées ;
- la session compacte fréquemment ;
- des fichiers ou sorties anciennes occupent encore le contexte.

Actions :

```text
/context
/compact
```

Puis, si la tâche a changé :

```text
/clear
```

Pour une exploration lourde indépendante, préférez un **subagent** afin de garder son contexte isolé de la conversation principale.

---

## 5. `CLAUDE.md`, rules, skills ou agents non pris en compte

Vérifiez d'abord le contenu réellement chargé :

```text
/context
/memory
/skills
/doctor
```

Puis vérifiez les emplacements :

```text
CLAUDE.md
.claude/settings.json
.claude/settings.local.json
.claude/rules/*.md
.claude/skills/<skill>/SKILL.md
.claude/agents/*.md
```

Points fréquents :

- mauvais scope projet/global ;
- YAML/frontmatter invalide ;
- règle `paths` ne correspondant pas au fichier courant ;
- permission ou setting géré par l'organisation qui prend le dessus ;
- skill masqué ou description trop vague pour l'auto-invocation.

Les `CLAUDE.md` de sous-dossiers et les rules ciblées par `paths` se chargent lorsque Read, Write ou Edit accède aux fichiers concernés. Leur absence au tout début de la session n'est pas forcément une panne. Si la consigne est chargée mais ignorée, cherchez une contradiction ou une formulation ambiguë ; utilisez permissions/hooks pour les contraintes qui doivent être effectivement imposées.

---

## 6. Un serveur MCP ne fonctionne plus

Dans la session :

```text
/mcp
```

Vérifiez :

- que le serveur est connecté ;
- que sa commande ou URL est toujours valide ;
- que les credentials nécessaires sont disponibles ;
- que le scope de configuration est correct (`.mcp.json`, configuration utilisateur, etc.) ;
- qu'une politique d'entreprise ne bloque pas le serveur.

Désactivez les serveurs MCP inutiles pendant le diagnostic pour réduire les variables en jeu.

Un serveur projet défini dans `.mcp.json` doit être approuvé pour le projet via `/mcp`. Un chemin relatif dans `command` ou `args` est résolu depuis le répertoire de lancement de Claude, pas depuis le fichier de configuration. Si le serveur est connecté mais n'expose aucun outil, essayez **Reconnect**, puis inspectez ses logs avec `claude --debug=mcp`.

---

## 7. Hook qui bloque ou modifie le comportement

Un hook peut :

- bloquer un outil avant exécution ;
- ajouter du contexte ;
- lancer une commande après modification ;
- produire une erreur qui ressemble à un problème Claude.

Testez le comportement avec les customisations désactivées :

```bash
claude --safe-mode
```

Si le problème disparaît, réactivez hooks, MCP et plugins progressivement afin d'isoler la cause.

`--safe-mode` désactive les customisations (instructions, skills, plugins, hooks, MCP, agents), mais conserve les outils natifs, l'authentification, les permissions et les settings. Les hooks et politiques gérés par l'organisation restent appliqués. Pour un hook absent, consultez `/hooks` et vérifiez que son `matcher` est une chaîne telle que `"Edit|Write"`, pas un tableau.

---

## 8. Recherche de fichiers incomplète ou lente

Vérifiez :

- les fichiers/dossiers ignorés par Git ;
- les gros répertoires générés (`node_modules`, `dist`, `target`, datasets, logs) ;
- la présence et le fonctionnement de `ripgrep` lorsque pertinent ;
- les différences de chemin entre Windows et WSL ;
- les permissions de lecture.

Un dépôt contenant de gros artefacts générés doit les exclure des recherches et du versioning quand ils ne sont pas nécessaires.

---

## 9. VS Code ne détecte pas Claude

Distinguez deux cas :

- **panneau Claude Code VS Code** : l'extension fournit son expérience intégrée ;
- **terminal intégré** : pour taper `claude`, la CLI standalone doit être disponible dans le PATH du terminal.

Vérifiez également que VS Code et l'extension sont à jour puis relancez la fenêtre si nécessaire.

---

## 10. JetBrains ne détecte pas Claude

Le plugin JetBrains s'appuie sur Claude Code installé localement. Vérifiez d'abord dans un terminal du même environnement :

```bash
claude --version
```

Puis contrôlez :

- version du plugin ;
- version de l'IDE ;
- PATH visible depuis l'IDE ;
- proxy/SSL de l'environnement ;
- redémarrage de l'IDE après installation ou mise à jour.

---

## 11. Erreurs réseau / API

Pour des erreurs `429`, `5xx`, `529`, timeouts ou streams interrompus :

1. consultez [status.anthropic.com](https://status.anthropic.com/) ;
2. vérifiez proxy, VPN et inspection TLS ;
3. utilisez `/status` et `/doctor` ;
4. reproduisez sur un réseau différent si votre politique le permet ;
5. vérifiez la référence d'erreurs Claude avant de modifier votre installation.

Un `429` peut correspondre à une limite d'usage ou de débit ; un `5xx/529` peut être côté service. Ne traitez pas automatiquement ces erreurs comme une corruption locale.

Une passerelle peut aussi retourner `429` pour un **plafond de dépense** : répéter la requête ne débloque pas ce budget. Distinguez ce cas d'un throttling temporaire. Claude effectue déjà des retries sur les erreurs transitoires ; une reprise manuelle d'une tâche ayant produit des effets externes exige de vérifier ce qui a été exécuté pour éviter les doublons.

---

## 12. Claude Code consomme beaucoup de CPU ou de mémoire

Commencez par :

- nouvelle session pour une nouvelle tâche ;
- `/compact` si la continuité est nécessaire ;
- `claude --safe-mode` pour tester sans customisations ;
- réduction des gros outputs et répertoires explorés ;
- désactivation temporaire des MCP inutiles.

`/heapdump` est réservé au diagnostic avancé.

Pour libérer la mémoire du processus tout en poursuivant le travail, quittez Claude puis lancez `claude --continue` dans le même projet. Si `/compact` répond `Not enough messages to compact`, un très gros collage avec peu de tours peut occuper le contexte sans fournir assez de messages à compacter : réduisez le contenu ou repartez avec une synthèse ciblée.

!!! danger "Données sensibles"
    Un heap dump ou une transcription locale peut contenir du contenu de conversation, des données lues par les outils et potentiellement des credentials. Ne partagez jamais ces fichiers bruts publiquement.

---

## Sources

- [Claude Code — installation, PATH et connexion](https://code.claude.com/docs/en/troubleshoot-install) — vérifié le 2026-10-03
- [Claude Code — diagnostic de configuration](https://code.claude.com/docs/en/debug-your-config) — vérifié le 2026-10-03
- [Claude Code — erreurs et retries](https://code.claude.com/docs/en/errors) — vérifié le 2026-10-03
- [Claude Code — performance et compaction](https://code.claude.com/docs/en/troubleshooting) — vérifié le 2026-10-03

- [Claude Code — Troubleshooting](https://code.claude.com/docs/en/troubleshooting) — consulté le 2026-09-28
- [Claude Code — Commands](https://code.claude.com/docs/en/commands) — consulté le 2026-09-28
- [Claude Code — `.claude/` directory](https://code.claude.com/docs/en/claude-directory) — consulté le 2026-09-28
- [Claude Help Center — Claude Code with Pro or Max](https://support.claude.com/en/articles/11145838-use-claude-code-with-your-pro-or-max-plan) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-11-troubleshooting.md#page-chapitre-11-troubleshooting-problemes-courants).

## Prochaine étape

Poursuivez avec **[Logs & Diagnostic](logs-diagnostic.md)**, la page suivante dans le menu.
