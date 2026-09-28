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

---

## Niveau 3 — Réduire à une configuration minimale

Conservez temporairement uniquement les éléments indispensables :

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
printenv ANTHROPIC_API_KEY

# PowerShell
Get-ChildItem Env:ANTHROPIC_API_KEY
```

Une API key présente peut faire utiliser la facturation API au lieu de l'allocation de votre abonnement Claude.

Ne copiez jamais la valeur de la clé dans un ticket ou une capture.

---

## Niveau 5 — Réseau, proxy et TLS

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

Claude Code propose une commande ciblée pour supprimer l'état qu'il maintient pour un projet :

```bash
claude project purge
```

Cette opération peut supprimer des transcriptions et de la mémoire automatique liées au projet. Elle n'est pas nécessaire pour un simple problème réseau ou d'authentification.

!!! warning "Conséquence"
    Vous pouvez perdre la capacité de reprendre certaines anciennes sessions ou d'utiliser leur mémoire. Utilisez cette procédure uniquement lorsqu'un état projet corrompu est raisonnablement suspecté.

---

## Niveau 11 — Diagnostic mémoire avancé

Pour un problème de mémoire réellement reproductible :

```text
/heapdump
```

Traitez le fichier produit comme **hautement sensible**. Il peut contenir conversation et credentials. Ne le joignez pas à une issue publique.

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

## GitHub Copilot — référence conservée

Les anciennes procédures de reset des extensions GitHub Copilot, caches `github.copilot`, login GitHub et logs Copilot appartiennent à un autre produit. Si vous utilisez encore Copilot, suivez sa documentation de troubleshooting ; n'appliquez pas ces suppressions de cache à Claude Code.

---

## Sources

- [Claude Code — Troubleshooting](https://code.claude.com/docs/en/troubleshooting) — consulté le 2026-09-28
- [Claude Code — Setup](https://code.claude.com/docs/en/setup) — consulté le 2026-09-28
- [Claude Code — `.claude/` directory](https://code.claude.com/docs/en/claude-directory) — consulté le 2026-09-28

## Chapitre suivant

**[Coûts & Gouvernance](../chapitre-12-couts-gouvernance/index.md)** : maîtriser l'usage Claude après avoir stabilisé l'environnement.