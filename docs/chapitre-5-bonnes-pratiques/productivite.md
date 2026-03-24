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

## Top 5 des gestes à retenir

1. **++tab++** — Accepter une suggestion (universel, les deux IDEs)
2. **++ctrl+right++ / ++option+right++** — Accepter mot par mot pour garder le contrôle
3. **++ctrl+i++ / ++cmd+i++** — Inline Chat directement dans l'éditeur
4. **++alt+bracket-right++** — Parcourir les suggestions alternatives avant de rejeter
5. **++ctrl+alt+i++ / ++cmd+alt+i++** — Ouvrir Copilot Chat (VS Code)

---

## Prochaines étapes

- [Sécurité & Qualité](securite-qualite.md) — Vérifier le code généré par Copilot
- [Performance & Ressources](performance.md) — Optimiser les performances avec Copilot
