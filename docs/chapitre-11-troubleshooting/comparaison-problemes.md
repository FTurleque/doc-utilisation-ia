# Comparaison des problèmes — CLI, VS Code et JetBrains

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">JetBrains</span>

Le diagnostic Claude Code doit distinguer les problèmes **partagés** — compte, réseau, settings, MCP, contexte — des problèmes propres à la surface utilisée.

---

## Problèmes communs

| Symptôme | Cause possible | Premier contrôle |
|---|---|---|
| Authentification inattendue | mauvais compte ou API key active | `/status`, variables d'environnement |
| Limite atteinte | usage partagé du plan | `/usage`, `/status` |
| Réponses qui dérivent | contexte devenu trop chargé | `/context`, `/compact` |
| Skill/rule ignoré | scope, frontmatter, précédence | `/context`, `/skills`, `/doctor` |
| MCP indisponible | serveur/auth/config | `/mcp` |
| Comportement étrange après ajout de plugins/hooks | customisation | `claude --safe-mode` |
| Timeout / erreur réseau | proxy, TLS, service | status Anthropic + réseau |

---

## CLI

La CLI est le meilleur point de comparaison pour savoir si le problème vient réellement de Claude Code ou de l'intégration IDE.

Vérifications :

```bash
claude --version
claude doctor
claude --safe-mode
```

Si la CLI fonctionne mais pas l'IDE, concentrez le diagnostic sur l'intégration VS Code/JetBrains plutôt que de réinstaller Claude Code immédiatement.

---

## VS Code

Le panneau Claude Code VS Code fournit une expérience intégrée. La CLI standalone est séparée et n'est nécessaire que si vous souhaitez exécuter `claude` dans le terminal intégré.

| Symptôme | Vérification |
|---|---|
| panneau Claude absent | extension installée/activée, VS Code à jour |
| panneau fonctionne mais `claude` est introuvable dans le terminal | CLI standalone/PATH du terminal |
| extension bloquée après mise à jour | reload window, mise à jour extension |
| comportement différent du terminal externe | shell, PATH, variables d'environnement |
| auth différente | compte utilisé par l'extension vs variables/API key |

!!! tip "Test de séparation"
    Comparez le panneau Claude et `claude --version` dans le terminal intégré. Cela permet de savoir quelle couche est réellement en panne.

---

## JetBrains

Le plugin JetBrains utilise Claude Code installé localement. Une installation CLI fonctionnelle est donc un prérequis important du diagnostic.

| Symptôme | Vérification |
|---|---|
| plugin ne trouve pas Claude | `claude --version`, PATH visible par l'IDE |
| auth échoue uniquement dans l'IDE | proxy/TLS de l'IDE, compte |
| comportement après upgrade IDE | compatibilité/version du plugin |
| terminal externe fonctionne mais plugin non | environnement lancé par JetBrains |
| connexion lente | proxy, réseau, indexation IDE à distinguer de Claude |

Évitez d'attribuer automatiquement une lenteur IntelliJ à Claude : l'indexation, le build, les plugins et la JVM peuvent être des causes indépendantes.

---

## Windows et WSL

Un problème fréquent est d'installer Claude dans un environnement et de l'exécuter dans l'autre.

Vérifiez séparément :

```text
Windows PowerShell → `claude --version`
WSL              → `claude --version`
```

Les PATH, home directories, credentials et fichiers `~/.claude` ne sont pas nécessairement partagés.

!!! info "Choisir une frontière claire"
    Pour un projet Linux sous WSL, gardez de préférence outils, Git, dépendances et Claude Code dans le même environnement afin d'éviter les chemins hybrides.

---

## Providers cloud / Console

Claude Code peut être utilisé via différents modes d'authentification ou fournisseurs. Une erreur peut venir de :

- clé API ;
- permissions Console ;
- configuration Amazon Bedrock ;
- configuration Google Cloud's Agent Platform (documentation historiquement sous `google-vertex-ai`) ;
- configuration Microsoft Foundry ;
- configuration d'entreprise/gateway.

Quand un provider tiers est utilisé, séparez le diagnostic Claude Code du diagnostic IAM/région/quota du provider.

---

## Tableau de décision

| Test | Résultat | Conclusion probable |
|---|---|---|
| `claude --version` échoue partout | échec | installation/PATH |
| CLI fonctionne, IDE échoue | divergence | intégration IDE |
| normal échoue, `--safe-mode` fonctionne | divergence | customisation |
| `/mcp` montre un serveur en erreur | ciblé | MCP |
| plusieurs machines échouent simultanément | commun | service/réseau/politique |
| uniquement réseau d'entreprise | ciblé | proxy/TLS/firewall |
| `/context` montre saturation | ciblé | hygiène de contexte |

---

## Ce qui n'est plus présenté comme vérité générale

Les anciennes versions de cette page affirmaient par exemple qu'IntelliJ était systématiquement plus précis, que VS Code était toujours plus rapide, ou donnaient des seuils de taille de fichier et de mémoire prétendument universels. Ces affirmations dépendent trop du projet, de l'IDE, des extensions et des versions pour servir de diagnostic fiable.

Mesurez le symptôme réel et isolez la couche fautive.

---

## Sources

- [Claude Code — couches de configuration et commandes de diagnostic](https://code.claude.com/docs/en/debug-your-config) — vérifié le 2026-10-03
- [Claude Code — séparation extension VS Code et CLI](https://code.claude.com/docs/en/vs-code#vs-code-extension-vs-claude-code-cli) — vérifié le 2026-10-03
- [Claude Code — diagnostic des connexions et fournisseurs](https://code.claude.com/docs/en/troubleshoot-install) — vérifié le 2026-10-03

- [Claude Code — Troubleshooting](https://code.claude.com/docs/en/troubleshooting) — consulté le 2026-09-28
- [Claude Code — VS Code](https://code.claude.com/docs/en/vs-code) — consulté le 2026-09-28
- [Claude Code — JetBrains](https://code.claude.com/docs/en/jetbrains) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-11-troubleshooting.md#page-chapitre-11-troubleshooting-comparaison-problemes).

## Prochaine étape

Poursuivez avec **[Procédures de Réparation](procedures-reparation.md)**, la page suivante dans le menu.
