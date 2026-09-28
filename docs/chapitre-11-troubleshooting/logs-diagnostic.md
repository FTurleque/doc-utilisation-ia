# Logs & diagnostic — Claude Code

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">JetBrains</span>

Un bon diagnostic commence par les **outils intégrés de Claude Code**, puis isole progressivement configuration, réseau, MCP, hooks et IDE. Évitez de supprimer des caches ou des credentials avant d'avoir identifié la couche fautive.

---

## 1. Diagnostic intégré

Dans une session Claude Code :

```text
/doctor
/status
/context
/mcp
```

Utilité :

| Commande | Diagnostic principal |
|---|---|
| `/doctor` | installation, configuration, extensions, contexte |
| `/status` | version, modèle, compte, connectivité |
| `/context` | répartition de l'usage de contexte |
| `/mcp` | connexions MCP et outils associés |

`/doctor` peut proposer des corrections. Relisez ce qui sera modifié avant de les accepter.

---

## 2. Diagnostic hors session

Si l'interface interactive ne démarre pas :

```bash
claude --version
claude doctor
```

Pour isoler les customisations :

```bash
claude --safe-mode
```

Si le problème disparaît en safe mode, la cause se situe probablement dans une customisation : settings, hooks, plugins ou MCP.

---

## 3. Activer le debug

Claude Code permet d'activer le debug depuis une session :

```text
/debug
```

Ou au lancement :

```bash
claude --debug
```

Utilisez le debug uniquement le temps de reproduire le problème. Conservez un extrait minimal et redacté pour un rapport de bug.

---

## 4. Données locales importantes

Claude Code conserve différentes données sous `~/.claude` et dans `~/.claude.json`.

Exemples :

```text
~/.claude/
├── settings.json
├── history.jsonl
├── projects/
│   └── <project>/
│       └── <session>.jsonl
└── debug/
```

Sur Windows, `~/.claude` correspond par défaut à `%USERPROFILE%\.claude`.

!!! danger "Les transcriptions sont sensibles"
    Les transcriptions de session peuvent contenir le texte des conversations, les résultats d'outils, des extraits de fichiers et toute valeur affichée par une commande. Les permissions du système de fichiers constituent la protection principale de ces données locales.

Évitez de publier :

- `~/.claude.json` ;
- transcriptions `.jsonl` complètes ;
- dumps mémoire ;
- fichiers contenant OAuth, API keys ou credentials MCP.

---

## 5. Diagnostic du contexte

Utilisez :

```text
/context
```

Cherchez notamment :

- `CLAUDE.md` trop volumineux ;
- sortie d'outil massive ;
- gros fichiers lus intégralement ;
- MCP apportant beaucoup d'outils ;
- historique devenu peu pertinent.

Actions possibles :

```text
/compact
/clear
```

Les subagents sont utiles pour garder les recherches volumineuses hors du contexte principal.

---

## 6. Diagnostic MCP

```text
/mcp
```

Pour chaque serveur, vérifiez :

- état de connexion ;
- scope ;
- authentification ;
- commande/URL ;
- outils exposés ;
- utilité réelle dans la tâche actuelle.

Un serveur MCP qui fonctionnait auparavant mais n'est plus accessible doit d'abord être vérifié ici avant de modifier `.mcp.json` au hasard.

---

## 7. Diagnostic de configuration

Emplacements à contrôler :

```text
CLAUDE.md
.claude/settings.json
.claude/settings.local.json
.claude/rules/
.claude/skills/
.claude/agents/
.mcp.json
~/.claude/settings.json
~/.claude.json
```

La précédence compte : des settings gérés par l'organisation ou des flags CLI peuvent prendre le dessus sur les settings projet.

!!! tip "Méthode d'isolation"
    Si le comportement est inexplicable, comparez une session normale et `claude --safe-mode`. Réactivez ensuite les couches une à une.

---

## 8. Réseau et service Anthropic

Avant une réinstallation :

1. consultez [status.anthropic.com](https://status.anthropic.com/) ;
2. vérifiez le proxy/VPN ;
3. vérifiez les certificats d'entreprise ;
4. testez depuis le même environnement que l'IDE ou le terminal concerné ;
5. notez le code d'erreur exact.

Les erreurs HTTP n'ont pas toutes la même cause :

| Famille | Interprétation probable |
|---|---|
| `401/403` | authentification, autorisation ou politique |
| `429` | limite d'usage/de débit |
| `5xx/529` | service ou capacité côté fournisseur possible |
| timeout / TLS | réseau, proxy, certificat ou service |

Consultez la référence d'erreurs actuelle avant de conclure.

---

## 9. VS Code

Si le problème n'apparaît que dans VS Code :

- mettez à jour VS Code et l'extension Claude ;
- rechargez la fenêtre ;
- vérifiez l'environnement du terminal intégré ;
- testez `claude --version` dans ce terminal si vous utilisez la CLI standalone ;
- comparez le comportement panneau Claude vs terminal.

Le panneau VS Code et la CLI standalone ne doivent pas être confondus pendant le diagnostic.

---

## 10. JetBrains

Si le problème n'apparaît que dans IntelliJ/PyCharm/etc. :

- vérifiez que `claude --version` fonctionne dans l'environnement local ;
- vérifiez la version du plugin ;
- redémarrez l'IDE après mise à jour ;
- contrôlez proxy et certificats de l'IDE ;
- vérifiez le PATH visible depuis JetBrains.

Le plugin JetBrains dépend de l'installation locale Claude Code.

---

## 11. Heap dump et diagnostic mémoire

Pour un cas mémoire avancé, Claude Code propose `/heapdump`.

!!! danger "Ne partagez pas un heap dump brut"
    Un `.heapsnapshot` peut contenir de la conversation et des credentials en mémoire. Traitez-le comme un artefact sensible. Préférez un diagnostic synthétique ou les données minimales demandées par le support.

---

## 12. Rapport reproductible

Avant d'ouvrir une issue, rassemblez :

```markdown
## Environnement
- OS :
- Claude Code : sortie de `claude --version`
- Surface : CLI / VS Code / JetBrains
- Auth : abonnement Claude / Console / Bedrock / Vertex / autre

## Symptôme
Description concise.

## Reproduction
1. ...
2. ...

## Diagnostic
- `/doctor` :
- `/status` :
- `claude --safe-mode` : même problème ?
- MCP impliqué : oui/non

## Erreur exacte
Message ou extrait de log redacté.
```

Ne joignez jamais de token, cookie, clé API ou transcription complète.

---

## GitHub Copilot — référence conservée

Les logs GitHub Copilot dans VS Code/JetBrains restent pertinents pour les utilisateurs Copilot, mais ils appartiennent à un autre produit et à une autre chaîne d'authentification. Utilisez la documentation GitHub pour ce diagnostic spécifique.

---

## Sources

- [Claude Code — Troubleshooting](https://code.claude.com/docs/en/troubleshooting) — consulté le 2026-09-28
- [Claude Code — Commands](https://code.claude.com/docs/en/commands) — consulté le 2026-09-28
- [Claude Code — `.claude/` directory](https://code.claude.com/docs/en/claude-directory) — consulté le 2026-09-28

## Prochaine étape

**[Comparaison des problèmes](comparaison-problemes.md)** : identifier si le problème vient de la CLI, de VS Code, de JetBrains ou d'une couche partagée.