# Sandbox Claude Code — isoler les commandes et intégrer le runtime

Un **sandbox** est une frontière technique appliquée par le système d'exploitation à un processus : elle limite les fichiers qu'il peut lire ou modifier et les destinations réseau qu'il peut atteindre. Même si une commande essaie de dépasser ces limites, le système la bloque.

Dans Claude Code, le sandbox intégré encadre les commandes shell et leurs processus enfants. Il complète les permissions de l'agent. Une instruction comme « ne lis pas mes secrets » guide le modèle ; une restriction du sandbox bloque effectivement la lecture par un processus concerné.

## Ce qui est protégé, et ce qui reste à protéger

| Élément | Sandbox shell intégré |
|---|---|
| Commandes lancées par les outils shell et leurs enfants | À l'intérieur de la frontière lorsque le sandbox est actif |
| Outils Read, Write et Edit | Hors de cette frontière ; soumis aux permissions Claude |
| WebFetch et WebSearch | Hors de cette frontière ; une liste de domaines du sandbox ne les filtre pas |
| Hooks, serveurs MCP locaux, serveurs LSP, commandes auxiliaires | Hors de cette frontière par défaut |
| Commandes exclues et reprises sans sandbox autorisées | Hors de cette frontière |

**Activer le sandbox ne rend donc pas un plugin ou un serveur MCP automatiquement isolé.** Pour les englober, il faut isoler leur propre processus, ou exécuter l'ensemble de Claude Code dans un environnement approprié : conteneur, VM ou runtime externe.

Un worktree Git sépare des fichiers de travail, mais ne restreint pas les accès système. Un conteneur peut offrir une frontière plus large, selon ses montages et ses droits. Monter le socket Docker, les clés SSH ou le dossier personnel peut annuler une partie du bénéfice recherché.

## Plateformes et prérequis

Le **sandbox intégré à Claude Code** est documenté sur macOS, Linux et WSL2. Il n'est pas pris en charge sur Windows natif : sur une machine Windows, utilisez Claude Code dans une distribution WSL2 pour ce mécanisme.

| Plateforme | Mécanisme / préparation |
|---|---|
| macOS | Seatbelt fourni par le système |
| Linux / WSL2 | `bubblewrap` et `socat` ; vérification des dépendances via `/sandbox` |
| Windows natif | Utiliser WSL2 pour le sandbox intégré |

Dans Ubuntu/Debian ou une distribution WSL2 correspondante :

```bash
sudo apt-get install bubblewrap socat
```

Redémarrez Claude Code après installation. `/sandbox` indique les dépendances manquantes. Sur Ubuntu récent, AppArmor ou une configuration de conteneur peut empêcher la création des namespaces : suivez le diagnostic officiel avant de modifier la politique système. Évitez de désactiver globalement une protection pour résoudre un problème local.

## Activer et utiliser le sandbox

1. Ouvrez Claude Code depuis le dépôt concerné.
2. Saisissez `/sandbox`.
3. Consultez les onglets **Mode**, **Overrides** et **Config**, ainsi que **Dependencies** lorsqu'il apparaît.
4. Choisissez le mode d'approbation et vérifiez les chemins et domaines effectivement autorisés.
5. Demandez à Claude d'exécuter un test ou un build, puis examinez les éventuels blocages.

Les deux modes utilisent la même frontière système. **Auto-allow** réduit les demandes d'approbation pour les commandes sandboxées ; **regular permissions** conserve les demandes ordinaires. Autoriser automatiquement une commande à l'intérieur du sandbox ne signifie pas lui ouvrir tout le système.

Les réglages sauvegardés par le panneau vont dans `.claude/settings.local.json`. Pour les partager, placez une configuration revue dans `.claude/settings.json`. Pour un usage personnel transversal, utilisez `~/.claude/settings.json`. Les politiques d'organisation passent par les settings gérés.

## Créer une configuration projet

Exemple à **fusionner** avec les settings existants, sans remplacer les autres réglages :

```json
{
  "sandbox": {
    "enabled": true,
    "autoAllowBashIfSandboxed": true,
    "allowUnsandboxedCommands": false,
    "failIfUnavailable": true,
    "filesystem": {
      "denyRead": ["~/.ssh", "~/.aws", ".env", "secrets"],
      "denyWrite": ["data/reference"]
    },
    "network": {
      "allowedDomains": ["registry.npmjs.org"]
    }
  },
  "permissions": {
    "deny": ["Read(./.env)", "Read(./secrets/**)"]
  }
}
```

Cet exemple vise un projet Node qui a besoin du registre npm : adaptez les destinations à votre projet. Les chemins relatifs du sandbox sont résolus selon le fichier de settings qui les définit ; ici ils concernent le projet. Leur syntaxe diffère de celle des règles Read/Edit : ne transposez pas leurs préfixes sans vérifier la référence.

- `enabled` active la frontière.
- `allowUnsandboxedCommands: false` ferme la reprise d'une commande hors du sandbox.
- `failIfUnavailable: true` fait échouer le démarrage si le sandbox ne peut pas être fourni ; sans ce réglage, une plateforme ou dépendance indisponible peut conduire à exécuter sans sandbox.
- `denyRead` protège contre les lectures **par les commandes sandboxées**. Les règles `permissions.deny` traitent séparément les outils de fichiers Claude.
- `denyWrite` protège des données de référence, même lorsqu'elles se trouvent dans une zone normalement accessible en écriture.

Par défaut, l'écriture est permise dans le répertoire de travail, certains répertoires temporaires et les répertoires ajoutés à la session. **La lecture reste large par défaut**, et les variables d'environnement sont héritées : il faut traiter explicitement les secrets. Les options de protection des credentials et de filtrage d'environnement sont documentées dans la référence officielle.

Pour autoriser un cache nécessaire, ajoutez uniquement son chemin précis dans `filesystem.allowWrite`, par exemple `~/.cache/mon-outil`. Évitez d'exclure tout l'outil du sandbox. Certaines configurations et zones exécutables de Claude sont protégées en écriture indépendamment de vos autorisations : vérifiez **Config** pour voir les limites résolues.

## Vérifier que la frontière fonctionne

Demandez **à Claude** d'exécuter une commande de vérification ; la taper vous-même avec `!` n'est pas un test fiable, car ce mode peut exécuter hors sandbox.

```text
Vérifie que le sandbox est actif : tente de créer ~/sandbox-probe,
puis d'accéder directement à https://example.com avec
curl --noproxy '*'. Rapporte les erreurs, sans reprise hors sandbox.
```

Si votre dossier personnel n'est pas une zone autorisée en écriture, la première tentative doit être refusée. La connexion directe doit échouer, puisque le trafic doit passer par le proxy du sandbox. Si le fichier est créé, retirez ce fichier de test puis revérifiez la configuration. Utilisez des fichiers factices pour les tests de lecture de secrets.

Testez également une opération qui **doit réussir** : un sandbox qui bloque toute la chaîne de build n'est pas correctement adapté à votre workflow.

## Diagnostiquer un blocage sans supprimer la protection

| Symptôme | Vérification / correction ciblée |
|---|---|
| Écriture de cache refusée | Repérer le chemin réel et autoriser seulement ce cache |
| Téléchargement impossible | Vérifier le domaine demandé, le proxy et les éventuelles redirections |
| `Operation not permitted` au démarrage | Vérifier dépendances, namespaces et politique du système hôte |
| Modification de configuration refusée | Vérifier les chemins protégés ; ne pas désactiver tout le filesystem pour contourner |
| Un hook accède à un secret malgré le sandbox | Le hook est hors de la frontière shell : isoler son processus et revoir ses permissions |

Évitez les exclusions larges, `allowAllUnixSockets` ou l'accès au socket Docker sans comprendre les accès qu'ils ouvrent. Un domaine autorisé peut servir des scripts ou dépendances malveillants : le sandbox limite leurs accès, mais ne certifie pas leur contenu.

## Intégrer un sandbox aux outils que vous créez

**Oui : Anthropic publie le runtime open source `@anthropic-ai/sandbox-runtime`**, utilisable sans Claude Code. Vous pouvez envelopper une commande de votre outil avec sa CLI `srt`, ou intégrer la bibliothèque à un lanceur Node/TypeScript.

Ce sont deux configurations distinctes : le runtime autonome utilise notamment `~/.srt-settings.json` ou un fichier passé à `srt --settings`. Il ne suffit pas de copier le bloc `sandbox` de Claude Code dans votre application et de supposer qu'il sera appliqué.

### Option 1 : envelopper une commande

Après installation du paquet et des dépendances de votre plateforme :

```bash
npm install -g @anthropic-ai/sandbox-runtime
srt --settings ./sandbox-runtime.json npm test
```

Exemple de fichier `sandbox-runtime.json` :

```json
{
  "network": {
    "allowedDomains": [],
    "deniedDomains": []
  },
  "filesystem": {
    "denyRead": ["~/.ssh", "~/.aws"],
    "allowWrite": [".", "/tmp"],
    "denyWrite": [".env"]
  }
}
```

Cet exemple Linux/macOS autorise des sorties de test dans le projet et `/tmp`, et aucune destination réseau. Pour un serveur MCP local, le lanceur pourrait démarrer son processus via `srt` : **ce processus et ses enfants** seraient alors isolés. Les autres outils Claude et les services distants appelés ne deviennent pas sandboxés pour autant. Vérifiez le protocole stdio, les journaux et les accès réellement nécessaires.

### Option 2 : intégrer la bibliothèque

```typescript
import { SandboxManager } from '@anthropic-ai/sandbox-runtime';
import { spawn } from 'node:child_process';

await SandboxManager.initialize({
  network: { allowedDomains: [], deniedDomains: [] },
  filesystem: {
    denyRead: ['~/.ssh', '~/.aws'],
    allowWrite: ['.', '/tmp'],
    denyWrite: ['.env'],
  },
});

try {
  // Commande fixe : ne pas interpoler une saisie utilisateur dans le shell.
  const wrapped = await SandboxManager.wrapWithSandbox('npm test');
  await new Promise<void>((resolve, reject) => {
    const child = spawn(wrapped, { shell: true, stdio: 'inherit' });
    child.once('error', reject);
    child.once('close', code => {
      if (code === 0) resolve();
      else reject(new Error(`Tests terminés avec le code ${code}`));
    });
  });
} finally {
  await SandboxManager.reset();
}
```

Le **processus lanceur** garde ses propres droits ; seuls les processus lancés par le chemin enveloppé reçoivent cette frontière. Votre outil doit imposer ce chemin à toutes les exécutions concernées, refuser de continuer si l'initialisation échoue, et définir ses propres limites de durée et de ressources. Le sandbox n'est pas une garantie de disponibilité face à un calcul sans fin.

Pour plusieurs utilisateurs non fiables, étudiez une isolation plus forte et des comptes séparés. Ne présentez pas cet exemple comme un service complet d'exécution de code arbitraire.

### Particularité Windows du runtime autonome

Le dépôt du runtime documente désormais un backend Windows natif avec un compte dédié, un filtrage réseau WFP et une étape d'installation élevée. **Cela ne signifie pas que le sandbox intégré à Claude Code prend déjà en charge Windows natif.** Vérifiez la version publiée du runtime, ses exigences et ses limitations avant une intégration Windows ; les exemples ci-dessus ciblent Linux/macOS et WSL2.

---

## Prochaine étape

Poursuivez avec **[Agents Claude](guide-agents.md)**, la page suivante dans le menu.

## Sources

Sources officielles consultées le **3 octobre 2026** :

- [Claude Code — Sandboxing](https://code.claude.com/docs/en/sandboxing)
- [Claude Code — Référence des settings](https://code.claude.com/docs/en/settings-reference)
- [Claude Code — Environnements d'isolation](https://code.claude.com/docs/en/sandbox-environments)
- [Anthropic — Sandbox Runtime : CLI, bibliothèque et plateformes](https://github.com/anthropics/sandbox-runtime)
