# Prompt Files (.prompt.md)

<span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span> <span class="badge-expert">Expert</span>

## Présentation
Les fichiers `.prompt.md` sont des prompts réutilisables stockés dans votre projet. Ils permettent de **sauvegarder et partager** des prompts Copilot Chat complexes pour des tâches récurrentes, sans avoir à les réécrire à chaque fois.

---

## Qu'est-ce qu'un fichier .prompt.md ?

Un fichier `.prompt.md` est un fichier Markdown avec un frontmatter YAML qui définit un prompt standardisé. Une fois créé, vous pouvez l'invoquer depuis Copilot Chat via la commande `/` ou en le sélectionnant dans la liste des prompts.

**Emplacement :** `.github/prompts/`

```
mon-projet/
└── .github/
    └── prompts/
        ├── code-review.prompt.md         ← Revue de code
        ├── generate-tests.prompt.md      ← Génération de tests
        ├── generate-docs.prompt.md       ← Génération de documentation
        ├── refactor.prompt.md            ← Refactoring
        └── security-audit.prompt.md      ← Audit de sécurité
```

---

## Structure d'un fichier .prompt.md

```markdown
---
description: Description courte du prompt (affichée dans le picker)
mode: agent
tools:
  - codebase
  - editFiles
---

# Titre du Prompt

Votre prompt ici, en langage naturel.

Vous pouvez référencer des fichiers du projet :
- `src/models/User.ts`

Ou utiliser des variables de contexte :
- Le fichier sélectionné : ${file}
- La sélection courante : ${selection}
```

---

## Le frontmatter des prompt files

```yaml
---
description: Courte description (affichée dans le sélecteur de prompts)
mode: agent                    # agent | edit | ask
tools:                         # Outils disponibles pour ce prompt
  - codebase                   # Accès au workspace
  - editFiles                  # Modification de fichiers
  - terminalLastCommand        # Accès à la dernière commande terminal
disable-model-invocation: false  # true = désactive l'appel au modèle
---
```

### Tous les champs du frontmatter

| Champ | Valeurs | Description |
|-------|---------|-------------|
| `description` | texte | Affiché dans le picker lors de l'invocation |
| `mode` | `ask` \| `edit` \| `agent` | Mode d'exécution du prompt |
| `tools` | liste | Outils accessibles pendant l'exécution |
| `disable-model-invocation` | `true` \| `false` | Si `true`, le prompt n'appelle pas le modèle — utile pour des prompts de type "template" ou orchestration pure |

!!! tip "Quand utiliser `disable-model-invocation: true` ?"
    Utile lorsque le prompt sert à organiser le contexte ou déléguer à un agent sans produire de réponse LLM directe. Par exemple, un prompt qui prépare des variables et passe la main à un agent spécialisé.

### Le champ `mode`

| Mode | Description | Quand l'utiliser |
|------|-------------|-----------------|
| `ask` | Répond sans modifier de fichiers | Questions, explications, analyses |
| `edit` | Modifie des fichiers existants | Refactoring, corrections, améliorations |
| `agent` | Mode agent complet avec outils | Tâches complexes multi-fichiers |

### Les `tools` disponibles

| Tool | Description |
|------|-------------|
| `codebase` | Accès et recherche dans le workspace |
| `editFiles` | Création et modification de fichiers |
| `terminalLastCommand` | Accès à la sortie de la dernière commande |
| `githubRepo` | Accès aux informations GitHub du repo |
| `search` | Recherche web |

---

## Exemples complets

### Revue de code

```markdown
---
description: Revue de code complète selon les standards du projet
mode: ask
tools:
  - codebase
---

# Revue de Code

Effectue une revue de code approfondie du code sélectionné ou du fichier actuel.

Analyse les points suivants et fournis un rapport structuré :

## 1. Correctness
- Y a-t-il des bugs évidents ou des cas límites non gérés ?
- Les conditions d'erreur sont-elles toutes traitées ?

## 2. Sécurité (OWASP Top 10)
- Y a-t-il des risques d'injection (SQL, XSS, command injection) ?
- Les entrées utilisateur sont-elles validées et sanitisées ?
- Y a-t-il des données sensibles exposées ?

## 3. Performance
- Y a-t-il des requêtes N+1 ou des boucles inefficaces ?
- Les ressources sont-elles correctement fermées/libérées ?

## 4. Maintenabilité
- Le code respecte-t-il les conventions du projet (.github/copilot-instructions.md) ?
- Les noms sont-ils explicites et auto-documentés ?
- Y a-t-il de la duplication qui devrait être extraite ?

## 5. Tests
- Le code est-il testable ?
- Quels cas de test manquent ?

Fournis un rapport avec : ✅ Points positifs, ⚠️ Améliorations suggérées, ❌ Problèmes à corriger.
```

### Génération de tests unitaires

```markdown
---
description: Génère des tests unitaires Jest complets pour le code sélectionné
mode: edit
tools:
  - codebase
  - editFiles
---

# Génération de Tests Unitaires

Génère des tests unitaires Jest/TypeScript complets pour ${file}.

## Instructions
1. Crée le fichier de test `${fileBasenameNoExtension}.test.ts` dans le même dossier
2. Importe les dépendances nécessaires
3. Mock toutes les dépendances externes (DB, API, filesystem)

## Cas à couvrir systématiquement
- **Happy path** : comportement nominal avec des données valides
- **Edge cases** : valeurs limites (0, null, "", tableau vide, nombre max)
- **Error cases** : chaque exception/erreur que la fonction peut lever
- **Type validation** : si la fonction valide des types, tester les types invalides

## Format attendu
Respecte les conventions du projet définies dans `.github/instructions/tests.instructions.md`.

## Structure
```typescript
import { describe, it, expect, jest, beforeEach } from '@jest/globals';

describe('NomDeLaClasse/Fonction', () => {
  describe('nomDeLaMéthode', () => {
    it('should [comportement attendu] when [condition]', () => {
      // Arrange
      // Act  
      // Assert
    });
  });
});
```
```

### Audit de sécurité

```markdown
---
description: Audit de sécurité OWASP du code sélectionné
mode: ask
tools:
  - codebase
---

# Audit de Sécurité

Effectue un audit de sécurité du code en analysant les risques selon l'OWASP Top 10.

Pour chaque risque identifié, fournis :
- **Niveau de risque** : Critique / Élevé / Moyen / Faible / Info
- **Description** : Ce qui est vulnérable et pourquoi
- **Preuve** : La ligne de code exacte problématique
- **Correction recommandée** : Code corrigé ou pattern sécurisé

## Catégories à analyser

### A01 — Broken Access Control
- Vérification des autorisations avant chaque opération sensible
- Accès direct aux objets (IDOR)

### A02 — Cryptographic Failures  
- Stockage de données sensibles en clair
- Algorithmes de chiffrement faibles ou dépréciés

### A03 — Injection
- Concaténation de chaînes dans les requêtes SQL
- Injection de commandes shell
- XSS (interpolation non échappée dans HTML)

### A07 — Authentication Failures
- Mots de passe stockés en clair ou avec hash faible (MD5, SHA1)
- Tokens non révocables
- Absence de rate limiting sur les endpoints d'auth

### A09 — Security Logging
- Logging de données sensibles (mots de passe, tokens)
- Absence de logging sur les actions critiques

Termine par un résumé prioritaire des corrections à effectuer.
```

### Documentation automatique

```markdown
---
description: Génère la documentation complète d'un module/fichier
mode: edit
tools:
  - codebase
  - editFiles
---

# Génération de Documentation

Génère une documentation technique complète pour ${file}.

## Ce que tu dois produire

1. **JSDoc/TSDoc pour chaque fonction/méthode/classe publique** :
   - Description en français
   - `@param` pour chaque paramètre avec type et description
   - `@returns` avec type et description
   - `@throws` pour chaque exception possible
   - `@example` avec un exemple d'utilisation concret

2. **Commentaires de section** pour grouper le code logiquement

3. **README du module** si le fichier est un index ou un service principal
   - Rôle du module dans l'architecture
   - Comment l'utiliser
   - Dépendances importantes

## Format JSDoc attendu
```typescript
/**
 * Calcule le montant total d'une commande avec les taxes applicables.
 * 
 * @param items - Liste des articles de la commande
 * @param taxRate - Taux de taxe entre 0 et 1 (ex: 0.20 pour 20%)
 * @returns Montant total TTC arrondi à 2 décimales
 * @throws {ValidationError} Si taxRate est hors de la plage [0, 1]
 * @throws {EmptyOrderError} Si items est vide
 * @example
 * const total = calculateOrderTotal(cartItems, 0.20);
 * // => 120.00 (pour 100€ HT avec 20% de TVA)
 */
```

---

## Invoquer un prompt depuis Copilot Chat

### Méthode 1 — Slash command

Dans Copilot Chat, tapez `/` pour voir la liste des prompts disponibles :

```
/code-review
/generate-tests  
/security-audit
```

Cette méthode fonctionne **identiquement** sur VS Code et IntelliJ.

### Méthode 2 — Via le picker

=== "VS Code"
    1. Dans Copilot Chat, cliquez sur l'icône `📎` ou `⋯`
    2. Sélectionnez **"Use Prompt File"**
    3. Choisissez votre fichier `.prompt.md`

=== "IntelliJ IDEA"
    1. Dans la fenêtre Copilot Chat, cliquez sur le bouton `+` ou l'icône d'ajout de contexte
    2. Sélectionnez **"Prompt file"**
    3. Choisissez votre fichier `.prompt.md`

### Méthode 3 — Avec contexte sélectionné

=== "VS Code"
    1. Sélectionnez du code dans l'éditeur
    2. Ouvrez Copilot Chat (++ctrl+alt+i++)
    3. Tapez `/code-review` — le code sélectionné est automatiquement inclus comme contexte

=== "IntelliJ IDEA"
    1. Sélectionnez du code dans l'éditeur
    2. Ouvrez Copilot Chat (panneau latéral ou ++alt+shift+c++)
    3. Tapez `/code-review` — le code sélectionné est automatiquement inclus comme contexte

---

## Différence entre Prompt Files et Instructions

| Aspect | `.instructions.md` | `.prompt.md` |
|--------|-------------------|-------------|
| **Usage** | Passif — toujours actif | Actif — invoqué à la demande |
| **Déclenchement** | Automatique (dès que le fichier matche) | Manuel (commande `/` ou sélection) |
| **Contenu** | Règles et conventions | Tâche spécifique à exécuter |
| **Exemple** | "Toujours utiliser TypeScript strict" | "Génère des tests pour ce fichier" |

---

## Prochaine étape

**[Guide Agents (.agent.md)](guide-agents.md)** : créer des agents Copilot spécialisés avec comportements, outils et instructions dédiés.

Concepts clés couverts :

- **Qu'est-ce qu'un agent custom** — Persona IA avec rôle spécifié et outils restreints
- **Frontmatter d'agent** — `name`, `description`, `tools`, `model`
- **Restriction d'outils** — Limiter les capacités pour des raisons de sécurité ou focus
- **Exemples d'agents** — Documentation writer, security auditor, refactoring expert

