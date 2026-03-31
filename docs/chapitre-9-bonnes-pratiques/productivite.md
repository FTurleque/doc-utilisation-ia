# Productivité avec GitHub Copilot

<span class="badge-intermediate">Intermédiaire</span>

## Optimiser votre Workflow Copilot

### ⚡ Les 3 Modes de Suggestion

| Mode | Usage | Productivité | Qualité |
|------|-------|--------------|---------|
| **Inline Suggestions** | Auto-complétion en temps réel | Très rapide (2-5 sec/ligne) | 60-75% acceptable |
| **Inline Chat** | Question ciblée sur sélection | Rapide (10-20 sec) | 80-90% bon |
| **Chat Panel** | Architectural, multi-fichier, complex | Lent (30-60 sec) | 90-95% excellent |
| **Agents / Edits** | Modification auto-propagée | Très rapide (émulation) | Dépend setup |

**Recommandation** :
- Inline Suggestions : 60% du temps (autocomplétion simple)
- Inline Chat : 30% du temps (corrections, tests, refactor)
- Chat Panel : 10% du temps (architecture, design decisions)

---

## Raccourcis Essentiels par IDE

!!! info "Légende de fréquence"
    ⭐ = rarement utilisé · ⭐⭐⭐ = utile régulièrement · ⭐⭐⭐⭐⭐ = geste essentiel au quotidien

### Visual Studio Code

=== "Windows / Linux"

    | Action | Raccourci | Fréquence d'utilisation |
    |--------|-----------|:-----------------------:|
    | Accepter suggestion | ++tab++ | ⭐⭐⭐⭐⭐ |
    | Accepter mot par mot | ++ctrl+right++ | ⭐⭐⭐⭐ |
    | Suggestion suivante | ++alt+bracket-right++ | ⭐⭐⭐⭐ |
    | Suggestion précédente | ++alt+bracket-left++ | ⭐⭐⭐ |
    | Rejeter suggestion | ++escape++ | ⭐⭐⭐⭐⭐ |
    | Déclencher manuellement | ++alt+backslash++ | ⭐⭐⭐ |
    | 10 suggestions (panneau) | ++ctrl+enter++ | ⭐⭐ |
    | **Ouvrir Copilot Chat** | ++ctrl+alt+i++ | ⭐⭐⭐⭐⭐ |
    | **Inline Chat** | ++ctrl+i++ | ⭐⭐⭐⭐ |
    | Quick Chat | ++ctrl+shift+i++ | ⭐⭐⭐ |

=== "macOS"

    | Action | Raccourci | Fréquence d'utilisation |
    |--------|-----------|:-----------------------:|
    | Accepter suggestion | ++tab++ | ⭐⭐⭐⭐⭐ |
    | Accepter mot par mot | ++option+right++ | ⭐⭐⭐⭐ |
    | Suggestion suivante | ++option+bracket-right++ | ⭐⭐⭐⭐ |
    | Suggestion précédente | ++option+bracket-left++ | ⭐⭐⭐ |
    | Rejeter suggestion | ++escape++ | ⭐⭐⭐⭐⭐ |
    | Déclencher manuellement | ++option+backslash++ | ⭐⭐⭐ |
    | **Ouvrir Copilot Chat** | ++cmd+alt+i++ | ⭐⭐⭐⭐⭐ |
    | **Inline Chat** | ++cmd+i++ | ⭐⭐⭐⭐ |

### IntelliJ IDEA

=== "Windows / Linux"

    | Action | Raccourci | Fréquence d'utilisation |
    |--------|-----------|:-----------------------:|
    | Accepter suggestion | ++tab++ | ⭐⭐⭐⭐⭐ |
    | Accepter mot par mot | ++ctrl+right++ | ⭐⭐⭐⭐ |
    | Suggestion suivante | ++alt+bracket-right++ | ⭐⭐⭐⭐ |
    | Suggestion précédente | ++alt+bracket-left++ | ⭐⭐⭐ |
    | Rejeter suggestion | ++escape++ | ⭐⭐⭐⭐⭐ |
    | Déclencher manuellement | ++alt+backslash++ | ⭐⭐⭐ |
    | **Inline Chat** | ++ctrl+i++ | ⭐⭐⭐⭐ |
    | Expliquer (clic droit) | Clic droit → Explain This | ⭐⭐⭐ |

=== "macOS"

    | Action | Raccourci | Fréquence |
    |--------|-----------|:---------:|
    | Accepter suggestion | ++tab++ | ⭐⭐⭐⭐⭐ |
    | Accepter mot par mot | ++option+right++ | ⭐⭐⭐⭐ |
    | Suggestion suivante | ++option+bracket-right++ | ⭐⭐⭐⭐ |
    | Rejeter suggestion | ++escape++ | ⭐⭐⭐⭐⭐ |
    | **Inline Chat** | ++cmd+i++ | ⭐⭐⭐⭐ |

---

## Workflows Optimisés

### Workflow 1 : Développement TDD avec Copilot

```
1. Écrire le test en premier (décrivez le comportement attendu)
   it('should return 404 when user not found', async () => {
       // Copilot va suggérer le setup du mock et la vérification

2. Laisser Copilot compléter le test
   → Accepter tab par tab, ajuster si nécessaire

3. Écrire la signature de la fonction à implémenter
   async findUserById(id: string): Promise<User> {
   // Copilot implémente en tenant compte du test existant

4. Exécuter les tests → Itérer avec Copilot si nécessaire
```

### Workflow 2 : Génération de boilerplate rapide

Pour des fichiers répétitifs (controllers, services, etc.) :

```
1. Créer un nouveau fichier
2. Commencer par un commentaire décrivant le module :
   // OrderController — REST API pour la gestion des commandes
   // CRUD standard : GET /orders, GET /orders/:id, POST, PUT, DELETE
   // Auth requise, rate limiting 100 req/min

3. Taper la première ligne de classe :
   export class OrderController {

4. Accepter les suggestions Copilot une par une
   → Copilot va générer un controller complet cohérent
```

### Workflow 3 : Refactoring assisté

```
1. Sélectionner le code à refactoriser
2. Ouvrir Inline Chat ++ctrl+i++ (++cmd+i++ macOS)
3. Taper : "Refactorise ce code pour [objectif précis]"
   Exemples :
   - "extraire la logique de validation dans une fonction séparée"
   - "remplacer la boucle for par un map/filter/reduce"
   - "simplifier ce switch-case avec un objet de mapping"
4. Copilot proposes les changements dans l'éditeur
5. Accepter, rejeter, ou modifier ligne par ligne
```

### Workflow 4 : Documentation accélérée

=== ":material-microsoft-visual-studio-code: VS Code"

    ```
    1. Positionner le curseur au-dessus d'une fonction
    2. Taper /** puis ++enter++ (déclenche le template JSDoc)
    3. Copilot complète automatiquement les @param et @returns
    4. Ajuster les descriptions si nécessaire
    ```

=== ":simple-intellijidea: IntelliJ"

    ```
    1. Taper /** au-dessus d'une méthode
    2. IntelliJ génère le squelette Javadoc de base
    3. Positionner le curseur sur une ligne @param
    4. Copilot complète la description
    ```

### Workflow 5 : Débogage avec Copilot Chat

```
Quand vous avez une erreur :

1. Copier le message d'erreur complet
2. Ouvrir Copilot Chat
3. Coller l'erreur + demander une explication :
   "J'ai cette erreur : [ERREUR]. 
    Voici le code : [CODE SÉLECTIONNÉ avec #selection]
    Qu'est-ce qui cause cette erreur et comment la corriger ?"

4. Copilot explique la cause racine et propose une correction
5. Utiliser l'Inline Chat ++ctrl+i++ pour appliquer la correction directement
```

---

## Intégration dans le développement quotidien

### Quand utiliser Copilot (ROI maximal)

| Tâche | Gain Copilot | Notes |
|-------|:------------:|-------|
| Boilerplate (CRUD, getters) | ⭐⭐⭐⭐⭐ | Gain de temps immense |
| Tests unitaires | ⭐⭐⭐⭐⭐ | Copilot excellent pour les cas de test |
| Documentation (JSDoc/KDoc/Javadoc) | ⭐⭐⭐⭐⭐ | Fastidieux manuellement |
| Regex complexe | ⭐⭐⭐⭐ | Toujours vérifier le résultat |
| Conversion de types/formats | ⭐⭐⭐⭐ | JSON→CSV, XML→JSON, etc. |
| Implémentations d'algorithmes connus | ⭐⭐⭐⭐ | Vérifier l'impl |
| Logique métier complexe | ⭐⭐⭐ | Vérification plus approfondie |
| Architecture du système | ⭐⭐ | Copilot suggère, vous décidez |

### Quand être plus prudent

| Situation | Pourquoi | Action recommandée |
|-----------|----------|-------------------|
| Code de sécurité | Algorithmes de sécurité doivent être précis | Audit manuel + tests |
| Requêtes SQL complexes | Risque d'injection ou de requête inefficace | Review + EXPLAIN |
| Logique financière | Les erreurs coûtent cher | Tests exhaustifs, pair review |
| Code multi-thread | Race conditions difficiles à voir | Review approfondie |

### Copilot en pair programming

Copilot est particulièrement efficace quand vous expliquez à voix haute ce que vous faites — les commentaires que vous tapez naturellement pendant le pair programming deviennent d'excellents prompts.

```typescript
// "Ok, je vais créer une fonction qui va chercher tous les 
// produits en promotion pour cette catégorie et les trier par remise"

// → Typez ce commentaire et laissez Copilot faire le reste
```

---

## Raccourcis de productivité supplémentaires

### VS Code — Raccourcis utiles en contexte Copilot

| Action | Raccourci Windows | Raccourci macOS |
|--------|:-----------------:|:---------------:|
| Aller à la définition | ++f12++ | ++f12++ |
| Voir toutes les références | ++shift+f12++ | ++shift+f12++ |
| Renommer symbole | ++f2++ | ++f2++ |
| Quick fix | ++ctrl+period++ | ++cmd+period++ |
| Format document | ++shift+alt+f++ | ++shift+option+f++ |
| Toggle line comment | ++ctrl+slash++ | ++cmd+slash++ |
| Duplicate line | ++shift+alt+down++ | ++shift+option+down++ |

### IntelliJ — Raccourcis utiles en contexte Copilot

| Action | Raccourci Windows | Raccourci macOS |
|--------|:-----------------:|:---------------:|
| Complétion avancée | ++ctrl+shift+space++ | ++ctrl+shift+space++ |
| Voir documentation | ++ctrl+q++ | ++ctrl+j++ |
| Aller à la définition | ++ctrl+b++ | ++cmd+b++ |
| Refactoring menu | ++ctrl+alt+shift+t++ | ++ctrl+t++ |
| Générer (code) | ++alt+insert++ | ++cmd+n++ |
| Implémenter méthodes | ++ctrl+i++ | ++ctrl+i++ |
| Reformater code | ++ctrl+alt+l++ | ++cmd+option+l++ |

---

## Gestion de la Fenêtre de Contexte

La **fenêtre de contexte** est la quantité de texte que Copilot peut traiter en une seule fois pour générer une suggestion. Comprendre ce concept vous permet d'optimiser la pertinence des suggestions.

### Qu'est-ce que la context window ?

Imaginez que Copilot lit vos fichiers ouverts comme un développeur qui relit du code avant de suggérer quelque chose. Il a une **mémoire de travail limitée** : si vous lui donnez trop de texte, il doit choisir quoi lire — et peut rater l'information cruciale.

| Modèle Copilot (2025) | Context window approx. |
|-----------------------|------------------------|
| GPT-4o (Chat) | ~128 000 tokens (~100k mots) |
| Claude 3.5 Sonnet (Chat) | ~200 000 tokens (~150k mots) |
| Suggestions inline | Fenêtre réduite (fichier courant + contexte proche) |

### Stratégies pour rester dans la fenêtre

```
❌ Session peu efficace
   10 onglets ouverts dont 8 non pertinents
   2 fichiers de 1500 lignes
   Suggestions : génériques, hors contexte

✅ Session optimale
   3-4 onglets ciblés sur la tâche en cours
   Fichiers < 400 lignes bien nommés
   Suggestions : précises, cohérentes avec votre code
```

**Actions concrètes :**

1. **Fermer les onglets non pertinents** avant de démarrer une session de travail ciblée
2. **Ouvrir les fichiers liés** (service + types + tests) pour donner le bon contexte
3. **Utiliser `#file` ou `#selection`** dans Chat pour cibler précisément plutôt que d'utiliser `@workspace` systématiquement
4. **Splitter les gros fichiers** : au-delà de 500 lignes, envisagez de découper en modules

!!! tip "Signal d'une context window saturée"
    Quand Copilot commence à suggérer des noms de variables qui n'existent pas dans votre projet, ou répète du code que vous venez d'écrire — c'est souvent le signe que la fenêtre de contexte est saturée. Fermez des onglets et relancez.

---

## Workflows Avancés

### Workflow 6 : Session Copilot Edits Multi-Fichiers

**Objectif** : Modifier une fonctionnalité qui touche plusieurs fichiers en une seule session cohérente.

```
Scénario : Ajouter un champ `phone` optionnel au modèle User
(impacts : types, service, controller, tests, migration DB)

1. Ouvrir Copilot Edits (++ctrl+shift+alt+i++ / ++cmd+shift+alt+i++)

2. Constituer le Working Set :
   + src/types/User.ts          ← Type User
   + src/services/UserService.ts ← Logique métier
   + src/controllers/UserController.ts ← Routes
   + src/__tests__/UserService.test.ts ← Tests
   + prisma/schema.prisma        ← Schéma DB

3. Rédiger la demande :
   "Ajoute un champ `phone?: string` au modèle User.
    - Validation : format E.164 (+33612345678) avec Zod
    - Exposé dans les réponses API
    - Index unique dans Prisma si phone est fourni
    - Mets à jour les tests existants"

4. Reviewer les modifications proposées fichier par fichier :
   ✓ User.ts — Accepter l'ajout du type
   ✓ UserController.ts — Accepter la validation Zod mise à jour
   ? UserService.ts — Vérifier la logique d'update
   ✓ tests — Accepter les nouveaux cas de test

5. Committer le Working Set validé
```

!!! warning "Gardez le Working Set minimal"
    Résistez à la tentation d'ajouter tous les fichiers du projet. Un Working Set de 4-6 fichiers est optimal. Au-delà, les suggestions deviennent moins cohérentes et plus difficiles à reviewer.

### Workflow 7 : Agent Mode Autonome

**Objectif** : Déléguer une tâche bien définie à Copilot en mode entièrement autonome.

!!! info "Prérequis"
    Le mode Agent nécessite **GitHub Copilot Pro+** (ou Business/Enterprise). Il est accessible dans VS Code depuis le menu Copilot Edits → bouton **Agent**.

```
Scénario : Migrer tous les callbacks async vers async/await dans un module

1. Préparer une instruction claire et vérifiable :
   "Dans src/legacy/, convertis tous les callbacks Node.js style (err, result)
    en async/await. Garde la même signature publique des fonctions.
    Exécute les tests après chaque fichier modifié pour valider."

2. Activer le mode Agent dans Copilot Edits

3. Copilot va :
   → Analyser les fichiers ciblés
   → Proposer les modifications fichier par fichier
   → Exécuter `npm test` pour vérifier
   → Itérer si des tests échouent

4. Monitorer la progression dans le panel Agent :
   → Vous pouvez interrompre à tout moment avec "Stop"
   → Reviewer chaque modification dans le diff

5. Valider le résultat final avant commit
```

**Tâches idéales pour l'Agent :**
- Migrations de syntaxe (callbacks → async/await, CommonJS → ESM)
- Ajout systématique de gestion d'erreurs manquante
- Conversion de tests (Jest → Vitest, unittest → pytest)
- Génération de documentation pour tous les modules d'un dossier

**Tâches à éviter pour l'Agent :**
- Logique métier complexe avec règles implicites
- Refactoring d'architecture (trop risqué sans supervision étroite)
- Code touchant la sécurité (auth, crypto)

---

## Top 5 des gestes à retenir

1. **++tab++** — Accepter une suggestion (universel, les deux IDEs)
2. **++ctrl+right++ / ++option+right++** — Accepter mot par mot pour garder le contrôle
3. **++ctrl+i++ / ++cmd+i++** — Inline Chat directement dans l'éditeur
4. **++alt+bracket-right++** — Parcourir les suggestions alternatives avant de rejeter
5. **++ctrl+shift+alt+i++ / ++cmd+shift+alt+i++** — Ouvrir Copilot Edits (multi-fichiers)

---

## Prochaine étape

**[Sécurité & Qualité](securite-qualite.md)** : valider et sécuriser le code généré pour éviter les pièges courants de la génération IA.

Concepts clés couverts :

- **Injection SQL, secrets hardcodés, XSS** — les vulnérabilités que Copilot peut générer sans le signaler
- **Hallucinations d'API** — packages inventés, méthodes inexistantes, versions fantômes
- **Checklist avant commit** — validation sécurité en 5 points pour tout code généré
- **`.copilotignore`** — exclure les fichiers sensibles de l'analyse Copilot
- **Tests obligatoires** — aucun code généré ne va en production sans tests
