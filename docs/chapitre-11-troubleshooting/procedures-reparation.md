# Procédures de réparation — Claude Code

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">JetBrains</span>

Cette page s'utilise après [Problèmes courants](problemes-courants.md) et [Logs & diagnostic](logs-diagnostic.md). Les procédures sont classées de la moins invasive à la plus invasive.

!!! warning "Ne commencez pas par supprimer des fichiers"
    `~/.claude.json`, `~/.claude/settings.json` et les données sous `~/.claude/` peuvent contenir authentification, préférences, plugins, transcriptions et historique. Isolez d'abord la cause.

---

## Niveau 1 — Diagnostic et correction intégrés

Dans Claude Code :

```text
/doctor
/status
/mcp
```

Si `/doctor` propose une correction, lisez-la avant validation.

Hors session :

```bash
claude --version
claude doctor
```

Cette étape suffit pour de nombreux problèmes d'installation ou de configuration.

---

## Niveau 2 — Isoler les customisations

Lancez :

```bash
claude --safe-mode
```

Si le problème disparaît, réactivez progressivement :

1. settings projet ;
2. hooks ;
3. skills/agents ;
4. plugins ;
5. MCP.

L'objectif est d'identifier **la première couche qui reproduit le problème**.

Safe mode conserve les settings, les permissions et l'authentification ; il ne neutralise pas les politiques ni les hooks gérés par l'organisation. Un problème qui persiste peut donc venir de ces couches, du réseau ou de l'installation. Il ne prouve pas à lui seul une corruption de la CLI.

---

## Niveau 3 — Réduire à une configuration minimale

Pour tester une configuration utilisateur vide **sans déplacer vos fichiers**, lancez Claude depuis un répertoire temporaire sans configuration projet, avec un autre répertoire de configuration. Exemple PowerShell qui restaure ensuite la variable et le répertoire de travail :

```powershell
Get-Command claude -ErrorAction Stop | Out-Null
$diagnosticRoot = Join-Path ([IO.Path]::GetTempPath()) ([Guid]::NewGuid().ToString())
$diagnosticProject = Join-Path $diagnosticRoot 'project'
$diagnosticConfig = Join-Path $diagnosticRoot 'config'
New-Item -ItemType Directory -Path $diagnosticProject, $diagnosticConfig | Out-Null
$previousClaudeConfig = $env:CLAUDE_CONFIG_DIR
try {
    $env:CLAUDE_CONFIG_DIR = $diagnosticConfig
    Push-Location -LiteralPath $diagnosticProject
    try { claude } finally { Pop-Location }
} finally {
    $env:CLAUDE_CONFIG_DIR = $previousClaudeConfig
}
```

Une nouvelle connexion peut être nécessaire. Les politiques gérées et les autres variables héritées (provider, proxy, clé API) restent actives : cette session isole les fichiers utilisateur/projet, pas toute la machine. Le répertoire temporaire contient les données de cette session de diagnostic ; gérez sa conservation selon votre politique.

Pour reconstruire ensuite une configuration projet minimale, gardez les éléments indispensables :

```text
CLAUDE.md                # court
.claude/settings.json    # permissions/settings nécessaires
```

Déplacez provisoirement les customisations non nécessaires hors du projet ou désactivez-les proprement, plutôt que de les supprimer définitivement.

Testez ensuite :

```bash
claude
```

Si la configuration minimale fonctionne, réintroduisez les fichiers un par un.

---

## Niveau 4 — Réauthentification

Dans Claude Code :

```text
/status
/login
```

Avant de conclure à un problème d'abonnement, vérifiez également :

```bash
# Linux/macOS
if [ -n "${ANTHROPIC_API_KEY:-}" ]; then echo "Clé API présente"; else echo "Clé API absente ou vide"; fi

# PowerShell
if ($env:ANTHROPIC_API_KEY) { 'Clé API présente' } else { 'Clé API absente ou vide' }
```

Une API key présente peut faire utiliser la facturation API au lieu de l'allocation de votre abonnement Claude.

Ne copiez jamais la valeur de la clé dans un ticket ou une capture.

---

## Niveau 5 — Réseau et TLS

### Symptômes typiques

- timeout ;
- handshake TLS ;
- connexion qui fonctionne sur un réseau mais pas sur un autre ;
- erreur uniquement derrière VPN/proxy d'entreprise.

Procédure :

1. consultez [status.anthropic.com](https://status.anthropic.com/) ;
2. vérifiez la configuration proxy officielle de votre environnement ;
3. vérifiez les certificats racine de l'entreprise ;
4. comparez le terminal et l'IDE ;
5. demandez à l'équipe réseau les domaines/flux autorisés si nécessaire.

!!! danger "Ne désactivez pas la validation TLS comme correctif permanent"
    Importez correctement le certificat de l'entreprise ou configurez le proxy selon la politique de sécurité. Une option équivalente à « ignorer SSL » masque le problème et affaiblit la sécurité.

---

## Niveau 6 — MCP

Si le problème concerne uniquement un serveur externe :

```text
/mcp
```

Puis :

- désactivez les autres MCP ;
- vérifiez la commande/URL du serveur ;
- vérifiez ses variables d'environnement ;
- vérifiez le scope de `.mcp.json` ;
- exécutez le serveur indépendamment de Claude si sa documentation le permet ;
- contrôlez les logs du serveur lui-même.

Ne réinstallez pas Claude Code pour une erreur propre à un serveur MCP.

---

## Niveau 7 — VS Code

Si la CLI fonctionne mais pas le panneau VS Code :

1. mettez à jour VS Code ;
2. mettez à jour l'extension Claude ;
3. rechargez la fenêtre ;
4. vérifiez le compte utilisé ;
5. comparez avec un workspace minimal ;
6. désactivez temporairement les extensions pouvant intervenir dans le même workflow.

Si `claude` ne fonctionne que dans un terminal externe, comparez PATH et variables d'environnement avec le terminal intégré VS Code.

---

## Niveau 8 — JetBrains

Si `claude --version` fonctionne mais que le plugin JetBrains échoue :

1. mettez à jour l'IDE et le plugin ;
2. redémarrez l'IDE ;
3. vérifiez le PATH visible par JetBrains ;
4. vérifiez proxy/TLS ;
5. testez depuis le terminal intégré ;
6. réduisez temporairement les plugins tiers pour isoler un conflit.

Ne lancez pas systématiquement « Invalidate Caches » : ce mécanisme JetBrains traite principalement les index IDE et n'est pas une réparation générique de Claude Code.

---

## Niveau 9 — Mise à jour ou réinstallation Claude Code

Si l'installation elle-même est endommagée, suivez la méthode d'installation officielle correspondant à votre système.

Avant réinstallation :

- notez `claude --version` ;
- sauvegardez uniquement les configurations dont vous avez besoin ;
- ne publiez pas les credentials ;
- identifiez votre méthode d'installation actuelle pour éviter deux installations concurrentes.

Après réinstallation :

```bash
claude --version
claude doctor
```

Puis testez d'abord sans customisations complexes.

---

## Niveau 10 — Purger uniquement l'état projet si nécessaire

**Depuis Claude Code 2.1.288**, la commande est `claude purge` ; auparavant elle s'appelait `claude project purge`. Vérifiez `claude --version` et l'aide de la commande correspondant à votre installation. Commencez par un aperçu sans suppression :

```bash
claude purge /chemin/vers/le-projet --dry-run
```

Pour une version antérieure à 2.1.288, utilisez `claude project purge /chemin/vers/le-projet --dry-run`. Remplacez le chemin d'exemple par celui du projet et relisez le plan. Pour supprimer, retirez `--dry-run` : la commande demande une confirmation. Évitez `--all` et `--yes` lors d'un diagnostic manuel.

La purge supprime les transcriptions et la mémoire automatique du projet, son historique de prompts, son entrée dans la configuration globale et les données de session associées (tasks, debug, checkpoints). Elle ne supprime pas le code applicatif. Les images et scratchpads temporaires, ainsi que les sauvegardes globales, ne sont pas tous effacés par cette opération : **ce n'est pas une procédure d'effacement complet de données sensibles**.

!!! warning "Conséquence"
    Vous pouvez perdre la capacité de reprendre certaines anciennes sessions ou d'utiliser leur mémoire. Utilisez cette procédure uniquement lorsqu'un état projet corrompu est raisonnablement suspecté.

---

## Niveau 11 — Diagnostic mémoire avancé

Pour un problème de mémoire réellement reproductible :

```text
/heapdump
```

Deux fichiers sont produits : un `.heapsnapshot` contenant potentiellement conversations et credentials, et un `-diagnostics.json` de statistiques. Ne publiez jamais le snapshot ; relisez le JSON avant de partager le diagnostic minimal demandé par le support.

---

## Ordre recommandé

```text
/doctor
  ↓
--safe-mode
  ↓
configuration minimale
  ↓
auth / réseau / MCP selon le symptôme
  ↓
intégration IDE
  ↓
mise à jour / réinstallation
  ↓
purge état projet ou heap dump uniquement en dernier recours
```

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-11-troubleshooting.md#page-chapitre-11-troubleshooting-procedures-reparation).

## Prochaine étape

Poursuivez avec **[Coûts & Gouvernance — Accueil](../chapitre-12-couts-gouvernance/index.md)**, la page suivante dans le menu.

## Sources

- [Claude Code — isolation et diagnostic de configuration](https://code.claude.com/docs/en/debug-your-config) — vérifié le 2026-10-03
- [Claude Code — purge, périmètre et changement de commande](https://code.claude.com/docs/en/claude-directory#clear-local-data) — vérifié le 2026-10-03
- [Claude Code — diagnostic mémoire](https://code.claude.com/docs/en/troubleshooting) — vérifié le 2026-10-03

- [Claude Code — Troubleshooting](https://code.claude.com/docs/en/troubleshooting) — consulté le 2026-09-28
- [Claude Code — Setup](https://code.claude.com/docs/en/setup) — consulté le 2026-09-28
- [Claude Code — `.claude/` directory](https://code.claude.com/docs/en/claude-directory) — consulté le 2026-09-28
