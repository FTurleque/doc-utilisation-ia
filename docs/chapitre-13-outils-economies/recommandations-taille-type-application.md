# Recommandations pratiques par taille et type d'application

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-intellij">IntelliJ</span>

Cette page transforme le cadre du chapitre 13 en décisions concrètes. Tu y trouves quoi utiliser selon la taille de ton application et son type technique. Le but est de limiter les crédits IA sans ralentir l'équipe.

---

## Méthode de décision rapide

1. Évalue la **taille** de la codebase.
2. Identifie le **type d'application** dominant.
3. Applique la base : IntelliJ natif → automatisation sans IA → IA locale → Copilot premium.

!!! tip "Raccourci utile"
    Si une action est déterministe et répétable, privilégie IntelliJ + outils statiques. Garde Copilot pour les cas ambigus ou transverses.

---

## Recommandations par taille d'application

### Petite application (solo ou petite équipe)

- Priorité : rapidité d'exécution.
- Stack recommandée : IntelliJ natif + Copilot inline + Continue/Ollama pour le chat simple.
- Évite d'industrialiser trop tôt (pipeline lourd, règles excessives).

Actions immédiates :

- Active les inspections IntelliJ avec quick-fix.
- Utilise `rg` et `tree` avant chaque prompt.
- Réserve Copilot Chat aux tâches qui touchent plusieurs fichiers.

### Monolithe moyen

- Priorité : cohérence du code et qualité continue.
- Stack recommandée : IntelliJ natif + Qodana/Checkstyle/SpotBugs + Copilot ciblé.
- Ajoute RTK pour compresser les sorties terminal de test/build.

Actions immédiates :

- Crée un profil d'inspection partagé d'équipe.
- Automatise OpenRewrite sur les migrations mécaniques.
- Utilise Copilot après échec d'une passe inspection/refactor/test.

### Grand monorepo ou polyrepo

- Priorité : filtrage de contexte et gouvernance.
- Stack recommandée : RTK + ast-grep + Semgrep + ArchUnit + agents spécialisés cadrés.
- Travaille par sous-domaines pour éviter les prompts massifs.

Actions immédiates :

- Limite les prompts à un module/service à la fois.
- Utilise `jq/yq` pour réduire logs et configs avant envoi.
- Versionne les règles (OpenRewrite/Semgrep/ArchUnit) comme du code.

### Application legacy

- Priorité : sécuriser les refactorings.
- Stack recommandée : IntelliJ refactorings sûrs + tests de non-régression + Copilot pour plan de migration.
- Évite de demander "réécris tout" à un agent.

Actions immédiates :

- Lance d'abord les inspections et la hiérarchie d'usages.
- Écris/renforce les tests de caractérisation.
- Utilise Copilot pour proposer des micro-étapes validables.

---

## Recommandations par type d'application

| Type d'application | Priorité outillage | IntelliJ natif d'abord | Copilot quand ? |
|---|---|:---:|---|
| API backend (Java/Kotlin, Spring) | Inspections, refactorings, tests, SpotBugs | Oui | Quand le problème traverse plusieurs couches (controller/service/repo) |
| Frontend (React/Vue/Angular) | Lint, format, tests UI, snippets | Oui | Pour générer variantes UI, tests complexes ou migration framework |
| Data / ML | Préparation de données, scripts reproductibles, notebooks | Partiel | Pour expliquer résultats, prototyper pipelines, documenter expériences |
| Microservices | Contrats, observabilité, règles d'architecture | Oui | Pour analyser incidents multi-services et proposer plans de remédiation |

!!! info "Backend IntelliJ"
    Sur les projets JVM, IntelliJ couvre déjà une grande part des besoins d'analyse structurelle. C'est le meilleur levier d'économie avant IA.

---

## Quand utiliser IntelliJ natif vs Copilot

### Utiliser IntelliJ natif

- Correction de warnings connus.
- Refactoring mécanique.
- Recherche d'usages et impact local.
- Exécution et diagnostic de tests.

### Utiliser Copilot

- Arbitrage d'architecture.
- Debug multi-fichiers avec hypothèses.
- Génération de plan de migration.
- Explication rapide d'un sous-système inconnu.

=== "IntelliJ IDEA"
    Ordre recommandé : Inspections → Refactorings → Tests → Qodana/Semgrep → Copilot.

=== "Visual Studio Code"
    Ordre recommandé : Lint/Test/CLI → outils de recherche (`rg`, `ast-grep`) → Copilot/agent.

!!! warning "Signal de surconsommation"
    Si tu ouvres Copilot plusieurs fois pour des corrections que l'IDE automatise, tu consommes des crédits sans gain réel.

---

## Plan d'adoption en 30 jours

1. **Semaine 1** : imposer la préparation de contexte (`rg`, `tree`, `jq/yq`, RTK).
2. **Semaine 2** : standardiser inspections/refactorings IntelliJ en équipe.
3. **Semaine 3** : brancher Qodana/Semgrep/OpenRewrite en CI.
4. **Semaine 4** : formaliser la règle d'escalade vers Copilot premium.

!!! success "Résultat attendu"
    Moins de prompts longs, moins d'allers-retours, et une consommation IA concentrée sur les tâches complexes.

---

## Points clés à retenir

- La taille de la codebase change la stratégie de contexte.
- Le type d'application change le mix IntelliJ/automatisation/Copilot.
- Le meilleur ROI vient d'un ordre de traitement strict avant IA.

---

## Chapitres suivants

**[Veille IA](../chapitre-14-veille-ia/index.md)** : organiser une veille fiable sur les évolutions produits, modèles, sécurité et annonces officielles.

**[Hacker IA](../chapitre-15-hacker-ia/index.md)** : comprendre les risques offensifs/défensifs autour de l'IA et structurer une réponse opérationnelle.
