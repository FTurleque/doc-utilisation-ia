# Troubleshooting Claude Code

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">JetBrains</span>

Ce chapitre couvre le diagnostic de **Claude Code** : installation, authentification, erreurs API, configuration, MCP, IDE, recherche, contexte et performance.

---

## Commencer par le diagnostic intégré

Si Claude Code démarre :

```text
/doctor
```

`/doctor` vérifie l'installation, les settings, extensions et l'usage du contexte, puis peut proposer des corrections à confirmer.

Si le shell affiche « commande introuvable », commencez par le **[PATH et l'installation standalone](problemes-courants.md#1-claude-est-introuvable-ou-ne-demarre-pas)**. Si l'exécutable est trouvé mais que l'interface ne démarre pas, lancez :

```bash
claude --version
claude doctor
```

Pour MCP :

```text
/mcp
```

La documentation officielle recommande ces points d'entrée avant les opérations plus invasives.

---

## Organisation du chapitre

<div class="grid cards" markdown>

- :material-bug: **[Problèmes courants](problemes-courants.md)**

    Installation, login, limites d'usage, contexte, MCP, recherche, IDE, hooks et performances.

- :material-file-search: **[Logs & diagnostic](logs-diagnostic.md)**

    `/doctor`, `claude doctor`, safe mode, debug de configuration, heap dump et rapport reproductible.

- :material-compare: **[Comparaison des problèmes](comparaison-problemes.md)**

    Différences CLI, VS Code, JetBrains, Windows/WSL et fournisseurs cloud.

- :material-wrench: **[Procédures de réparation](procedures-reparation.md)**

    Réparer progressivement : configuration minimale, mise à jour, auth, réseau, customisations et réinstallation.

</div>

---

## Arbre de décision rapide

```text
Claude Code ne fonctionne pas
│
├─ `claude` introuvable / ne démarre pas
│  └─ vérifier PATH/installation ; puis `claude --version` et `claude doctor`
│
├─ Claude démarre mais login/auth échoue
│  └─ `/login` + vérifier compte/organisation/provider
│
├─ Erreur API 5xx / 529 / 429
│  └─ consulter Error reference + status Anthropic + limites d'usage
│
├─ Settings / hooks / skills / MCP non chargés
│  ├─ `/context`, `/skills`, `/hooks`, `/doctor`
│  ├─ `/mcp`
│  └─ tester `claude --safe-mode`
│
├─ Recherche ne trouve pas les fichiers
│  └─ vérifier ripgrep, ignore files et WSL/filesystem
│
├─ Contexte saturé
│  ├─ `/compact`
│  ├─ lire les gros fichiers par portions
│  ├─ déplacer l'exploration dans un subagent
│  └─ `/clear` si la tâche précédente n'est plus utile
│
└─ IDE ne détecte pas Claude
   └─ suivre le diagnostic VS Code / JetBrains correspondant
```

---

## Avant un diagnostic avancé

- vérifiez la version avec `claude --version` ;
- lancez `/doctor` ou `claude doctor` ;
- vérifiez [status.anthropic.com](https://status.anthropic.com/) pour une panne de service ;
- reproduisez le problème dans un projet minimal si possible ;
- testez `claude --safe-mode` pour isoler plugins, MCP et hooks ;
- ne supprimez pas des fichiers de configuration ou credentials « au hasard » avant d'avoir identifié la couche fautive.

---

## Catégories d'erreurs actuelles

La référence officielle Claude Code distingue notamment :

| Catégorie | Exemples |
|---|---|
| Installation | `command not found`, PATH, TLS, téléchargement/update |
| Authentification | login expiré, API key invalide, organisation/policy |
| Usage | session/weekly limit, spend limit, 429 |
| Réseau | proxy, SSL, connexion API, stream interrompu |
| Requête | prompt trop long, contexte saturé, image/PDF trop volumineux |
| Configuration | settings invalides, workspace non trusted, MCP bloqué |
| IDE | CLI non trouvé, extension/plugin non connecté |
| Performance | CPU/mémoire, hang, recherche lente, compaction thrashing |
| Stockage local | `ENOSPC`, quota disque, transcript non sauvegardé |

Un disque ou répertoire temporaire plein peut empêcher la sauvegarde de la session. Vérifiez l'espace, le quota et les droits de l'emplacement indiqué ; protégez les sessions utiles avant tout nettoyage et évitez de purger globalement l'historique pour une panne de stockage ciblée.

---

## Performance et contexte

La documentation Claude actuelle recommande notamment :

- `/compact` pour réduire le contexte ;
- redémarrer entre grosses tâches ;
- exclure les gros dossiers générés ;
- `claude --safe-mode` pour identifier une customisation coûteuse ;
- `/heapdump` uniquement pour un diagnostic mémoire avancé.

!!! danger "Heap dump sensible"
    Un `.heapsnapshot` peut contenir la conversation complète et des credentials. Ne l'attachez jamais à une issue publique. La documentation recommande de partager uniquement le fichier diagnostics JSON lorsque nécessaire.

---

## Support

Pour un problème non résolu :

1. `/doctor` et `/mcp` ;
2. `/feedback` dans Claude Code ;
3. vérifier les issues du dépôt Claude Code ;
4. pour compte/facturation, passer par le support Anthropic depuis Claude/Console.

---

## Sources

- [Claude Code — installation et connexion](https://code.claude.com/docs/en/troubleshoot-install) — vérifié le 2026-10-03
- [Claude Code — diagnostic de configuration](https://code.claude.com/docs/en/debug-your-config) — vérifié le 2026-10-03
- [Claude Code — erreurs et sauvegarde des transcriptions](https://code.claude.com/docs/en/errors) — vérifié le 2026-10-03

- [Claude Code — Troubleshooting](https://code.claude.com/docs/en/troubleshooting) — consulté le 2026-09-28
- [Claude Code — Error reference](https://code.claude.com/docs/en/errors) — consulté le 2026-09-28
- [Claude Code — Advanced setup](https://code.claude.com/docs/en/setup) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-11-troubleshooting.md#page-chapitre-11-troubleshooting-index).

## Prochaine étape

Poursuivez avec **[Problèmes Courants](problemes-courants.md)**, la page suivante dans le menu.
