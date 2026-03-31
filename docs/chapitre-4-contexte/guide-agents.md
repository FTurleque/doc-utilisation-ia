# Agents Copilot (.agent.md)

<span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span> <span class="badge-expert">Expert</span>

## Présentation
Les fichiers `.agent.md` permettent de créer des **agents Copilot personnalisés** avec des comportements, des outils et des instructions spécialisés. Un agent est une version de Copilot configurée pour un rôle spécifique : documentaliste, auditeur de sécurité, expert en refactoring, etc.

---

## Qu'est-ce qu'un agent custom ?

Un agent custom est défini par un fichier `.agent.md` dans `.github/agents/`. Il apparaît dans le sélecteur de mode de Copilot Chat et peut être invoqué à la demande. Chaque agent peut :

- Avoir un **nom et une description** propres
- **Restreindre les outils** disponibles (pour des raisons de sécurité ou de focus)
- Disposer d'**instructions permanentes** intégrées (différentes des `.instructions.md` globales)
- Cibler un **modèle IA spécifique**

```
mon-projet/
└── .github/
    └── agents/
        ├── documentation-writer.agent.md    ← Agent auteur de docs
        ├── security-auditor.agent.md         ← Agent auditeur sécurité
        ├── code-reviewer.agent.md            ← Agent revieweur de code
        ├── test-generator.agent.md           ← Agent générateur de tests
        └── refactor-expert.agent.md          ← Agent expert refactoring
```

---

## Structure d'un fichier .agent.md

```markdown
---
name: Nom de l'Agent
description: Description courte (affichée dans le sélecteur)
model: claude-3.5-sonnet    # Modèle IA à utiliser (optionnel)
tools:                       # Liste des outils autorisés
  - codebase
  - editFiles
---

# Instructions de l'Agent

Décrivez ici le rôle, le comportement et les règles de l'agent.
Ces instructions sont toujours injectées dans le contexte de cet agent.

## Identité
Tu es [rôle], spécialisé dans [domaine].

## Comportement
- Règle 1
- Règle 2

## Ce que tu ne dois PAS faire
- Restriction 1
```

---

## Frontmatter d'un agent

```yaml
---
name: Documentation Writer          # Nom affiché dans le sélecteur
description: Génère documentation technique, diagrammes et maintient la parité code/docs
model: gpt-4o                       # Modèle optionnel (défaut : modèle configuré par l'utilisateur)
tools:                              # Outils disponibles pour cet agent
  - codebase                        # Accès au workspace
  - editFiles                       # Modification de fichiers
  - githubRepo                      # Infos GitHub
---
```

### Champs avancés souvent utiles

!!! warning "Le champ `prompt` n'existe pas"
    Le prompt de l'agent est le **corps du fichier `.agent.md`** (après le frontmatter), pas un champ frontmatter. N'utilisez pas `prompt:` dans le frontmatter — il sera ignoré.

| Champ | Usage |
|-------|-------|
| `argument-hint` | Texte d'aide affiché dans le champ de saisie lors de l'invocation |
| `agents` | Liste des sous-agents autorisés (`*` pour tous, `[]` pour aucun) |
| `mcp-servers` | Serveurs MCP autorisés pour cet agent |
| `disable-model-invocation` | Empêche l'agent d'être invoqué comme sous-agent par d'autres agents |
| `user-invocable` | Masque l'agent dans le sélecteur (utile pour les agents purement en sous-agent) |
| `handoffs` | Transitions guidées vers d'autres agents (voir ci-dessous) |
| `target` | Environnement cible : `vscode` ou `github-copilot` |

!!! info "Le champ `infer` est déprécié"
    Remplacé par `user-invocable` + `disable-model-invocation` qui offrent un contrôle indépendant.

### Handoffs — transitions guidées entre agents

Les handoffs permettent de créer des **workflows séquentiels guidés**. Après qu'un agent termine sa réponse, des boutons de transition apparaissent pour passer à l'agent suivant.

```yaml
---
name: Planning Agent
description: Génère un plan d'implémentation détaillé
tools:
  - codebase
handoffs:
  - label: Démarrer l'implémentation
    agent: implementation
    prompt: Implémente maintenant le plan décrit ci-dessus.
    send: false
  - label: Revue de sécurité
    agent: security-auditor
---
```

| Champ handoff | Description |
|---------------|-------------|
| `label` | Texte du bouton de transition |
| `agent` | Identifiant de l'agent cible |
| `prompt` | Prompt pré-rempli envoyé à l'agent cible |
| `send` | `true` = envoie automatiquement ; `false` = pré-remplit seulement (défaut) |
| `model` | Modèle à utiliser lors de la transition (optionnel) |

### Outils disponibles

| Tool | Description | Cas d'usage |
|------|-------------|-------------|
| `codebase` | Recherche et lecture dans le workspace | Analyser le code existant |
| `editFiles` | Créer et modifier des fichiers | Agents qui écrivent du code |
| `terminalLastCommand` | Sortie de la dernière commande terminal | Corriger des erreurs de build |
| `githubRepo` | Infos sur le repo GitHub (issues, PRs) | Agents d'intégration GitHub |
| `search` | Recherche web | Documentation externe |
| `runCommands` | Exécuter des commandes terminal | Agents DevOps *(attention : dangereux)* |

!!! warning "Tool restrictions pour la sécurité"
    Limitez toujours les outils au strict nécessaire. Un agent documentaliste n'a pas besoin de `runCommands`. Moins d'outils = moins de risques d'actions non souhaitées.

---

## Exemples d'agents concrets

### Agent Documentaliste

```markdown
---
name: gem-documentation-writer
description: Génère documentation technique, diagrammes et maintient la parité code/docs
tools:
  - codebase
  - editFiles
---

# Documentation Writer

## Identité
Tu es un expert en documentation technique pour développeurs. Tu génères des docs précises, accessibles et toujours en parité avec le code.

## Ce que tu fais
- Générer des README, guides d'utilisation, références API
- Créer des diagrammes Mermaid (architecture, flux, séquence)
- Mettre à jour la documentation existante quand le code change
- Vérifier que la documentation reflète exactement le comportement du code

## Ce que tu NE fais PAS
- Implémenter du code (tu es documentaliste, pas développeur)
- Modifier du code existant
- Laisser des TODO ou TBD dans les documents finaux

## Format de sortie
- Markdown avec headers hiérarchiques
- Diagrammes Mermaid pour les architectures
- Exemples de code avec syntax highlighting approprié
- Tables pour les références de paramètres/options

## Processus
1. Analyser le code source (avec `codebase`)
2. Identifier les fonctions/classes publiques à documenter
3. Générer la documentation en vérifiant la cohérence avec le code
4. Proposer les fichiers à créer/modifier
```

### Agent Auditeur de Sécurité

```markdown
---
name: security-auditor
description: Analyse le code pour les vulnérabilités OWASP Top 10 et génère des rapports
tools:
  - codebase
---

# Security Auditor

## Identité
Tu es un expert en sécurité applicative spécialisé dans l'OWASP Top 10 et les bonnes pratiques de développement sécurisé.

## Ton rôle
- Analyser le code pour identifier les vulnerabilités de sécurité
- Générer des rapports de sécurité structurés
- Proposer des corrections concrètes pour chaque problème trouvé
- Ne jamais modifier le code directement (rôle consultatif uniquement)

## Framework d'analyse
Pour chaque analyse, couvrir systématiquement :
- A01 Broken Access Control
- A02 Cryptographic Failures
- A03 Injection (SQL, XSS, command)
- A04 Insecure Design
- A05 Security Misconfiguration
- A06 Vulnerable Components
- A07 Identification & Auth Failures
- A08 Software and Data Integrity Failures
- A09 Security Logging Failures
- A10 SSRF

## Format de rapport
```
## Rapport de Sécurité — [NomFichier]
Date : [date]
Niveau de risque global : ⚫ Critique | 🔴 Élevé | 🟠 Moyen | 🟡 Faible | 🟢 OK

### Vulnérabilités identifiées
| ID | Catégorie | Niveau | Description | Ligne |
|----|-----------|--------|-------------|-------|

### Corrections recommandées
[Code corrigé pour chaque vulnérabilité]

### Points positifs
[Ce qui est bien fait]
```

## Ce que tu NE fais PAS
- Générer du code malveillant
- Exploiter des vulnérabilités
- Accéder à des ressources externes
```

### Agent Modernization Expert

```markdown
---
name: Modernization Agent
description: Assistant de modernisation pour analyser, documenter et planifier la modernisation complète d'un projet
tools:
  - codebase
  - editFiles
  - githubRepo
---

# Modernization Agent

## Identité
Tu es un expert en modernisation d'applications, spécialisé dans l'analyse de code legacy et la planification de migrations vers des architectures modernes.

## Workflow (9 étapes)
1. Identification du stack technologique
2. Analyse architecturale détaillée
3. Analyse de la logique métier (lire TOUS les fichiers)
4. Identification du but de l'application
5. Documentation par feature
6. Identifications des dettes techniques
7. Recommandations d'architecture cible
8. Plan de migration par phases
9. Génération du rapport final

## Contrainte critique
Tu DOIS lire chaque fichier service/repository/controller — l'exhaustivité est obligatoire.

## Output
- Analyse d'architecture dans `/modernization/architecture.md`
- Documentation par feature dans `/modernization/features/`
- Plan de migration dans `/modernization/migration-plan.md`
- README actualisé reflétant l'état actuel et l'état cible
```

---

## Agentes présents dans ce workspace

Ce workspace (`documentation-ia`) contient déjà plusieurs agents de référence dans `.github/agents/` :

| Agent | Fichier | Rôle |
|-------|---------|------|
| **Context7 Expert** | `context7.agent.md` | Documentation libraries via Context7 MCP |
| **gem-documentation-writer** | `gem-documentation-writer.agent.md` | Écriture de documentation technique |
| **Modernization Agent** | `modernization.agent.md` | Analyse et modernisation de projets |
| **Create PRD** | `prd.agent.md` | Génération de Product Requirements Documents |
| **Software Engineer** | `software-engineer-agent-v1.agent.md` | Implémentation de code production |

Ces agents servent de références excellentes pour créer vos propres agents.

---

## Invoquer un agent

Dans Copilot Chat :

1. Cliquez sur le **sélecteur de mode** (en haut du panneau Chat)
2. Choisissez votre agent dans la liste
3. Ou tapez `@nom-agent` directement dans le chat

!!! info "Nommage des agents"
    Les agents sont invocables via `@` suivi de leur `name` défini dans le frontmatter. Ex: `@security-auditor analyse ce fichier`.

---

## Différence entre Agent, Instruction et Prompt File

| Mécanisme | Persistance | Invocation | Rôle |
|-----------|:-----------:|:----------:|------|
| `.instructions.md` | Passif (toujours actif) | Automatique | Règles permanentes de contexte |
| `.prompt.md` | Passif (stocké) | Manuelle (`/`) | Tâche ponctuelle à exécuter |
| `.agent.md` | Actif (mode chat) | Manuelle (`@`) | Persona spécialisé persistant pour une session |

---

## Bonnes pratiques

1. **Un agent par rôle** — Ne pas créer un agent "fait tout" ; créez des agents spécialisés
2. **Restreindre les outils** — Donnez à chaque agent uniquement les outils dont il a besoin
3. **Instructions claires** — Définissez explicitement ce que l'agent FAIT et ne FAIT PAS
4. **Tester avant de partager** — Testez l'agent avec des cas réels avant de le committer
5. **Versionner dans Git** — Les fichiers `.agent.md` doivent être versionnés pour toute l'équipe

---

## Prochaine étape

**[Guide Skills (SKILL.md)](guide-skills.md)** : packager de l'expertise domaine réutilisable que les agents peuvent invoquer à la demande.

Concepts clés couverts :

- **Qu'est-ce qu'un SKILL.md** — Package de connaissance stable et réutilisable
- **Emplacement et URI** — `.github/skills/*/SKILL.md` et référençage via `copilot-skill://`
- **Différence Skills vs Instructions vs Agents** — Tableau comparatif clair
- **Exemples de skills** — API standards, modèle de domaine, patterns d'architecture
