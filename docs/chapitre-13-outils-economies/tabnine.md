# Tabnine

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span>

Tabnine est un assistant de code qui met l'accent sur la confidentialité,
la gouvernance et l'adoption en contexte entreprise.

---

## À quoi sert Tabnine

- Complétion de code assistée
- Chat de développement selon les offres
- Cadre entreprise avec politiques de confiance

!!! info "Positionnement"
    Tabnine est souvent choisi quand l'enjeu prioritaire est la maîtrise des données et la conformité, plus que la performance brute sur les prompts complexes.

---

## Quand l'utiliser

- Quand la confidentialité et la gouvernance sont prioritaires
- Quand tu veux une complétion assistée dans un cadre entreprise
- Quand ton équipe a besoin d'un cadre d'usage explicite

## Quand l'éviter

- Quand tu cherches surtout un chat très riche pour l'architecture
- Quand aucune politique de données n'est encore définie
- Quand la tâche est mieux résolue par un outil local plus simple

---

## Mise en œuvre

### Installation

=== "Visual Studio Code"
    1. Installer l'extension Tabnine.
    2. Se connecter avec un compte utilisateur ou entreprise.

=== "IntelliJ IDEA"
    1. Ouvrir **Settings -> Plugins -> Marketplace**.
    2. Installer **Tabnine AI Code Completion**.
    3. Se connecter au compte.

### Paramétrage recommandé

- Définir qui peut activer quelles fonctions IA
- Documenter les types de données autorisées dans les prompts
- Intégrer la validation code (tests, linter, revue) dans la définition de done

---

## Cas d'usage pertinents

- Équipes soumises à des contraintes de conformité
- Projets contenant des données sensibles
- Besoin d'un cadre entreprise explicite

Cas moins adaptés:

- Exploration technique profonde sans vérification externe
- Équipes sans processus de revue qualité

---

## Exploiter son plein potentiel

1. **Politique équipe claire**
   - Ce qui peut être envoyé au chat
   - Ce qui doit rester local
2. **Workflow avec outils complémentaires**
   - **[RTK](rtk.md)** pour nettoyer les sorties terminal
   - **[Continue.dev](continue-dev.md)** + local pour les tâches non critiques
3. **Indicateurs de pilotage**
   - Taux d'acceptation des suggestions
   - Défauts post-merge
   - Temps moyen de revue

!!! warning "Vigilance"
    Les détails de fonctionnalités varient selon les plans. Vérifie toujours les engagements du plan choisi dans la documentation et la tarification officielles.

---

## Exemple concret

```text
Politique simple d'équipe:

- Code propriétaire sensible: pas d'envoi vers un modèle cloud non approuvé.
- Suggestions IA autorisées: uniquement avec revue obligatoire + tests CI verts.
- Extraits de logs: filtrés via RTK avant partage.
```

---

## Résumé

Tabnine est une option pertinente quand le contrôle des données prime sur
la recherche du maximum de puissance. Il devient intéressant dans les
équipes qui veulent formaliser une politique IA claire.

---

## Sources

- Site officiel: [tabnine.com](https://www.tabnine.com/) (consulté le 2026-06-07)
- Documentation: [Tabnine Docs](https://docs.tabnine.com/) (consulté le 2026-06-07)
- Tarification: [Tabnine Pricing](https://www.tabnine.com/pricing/) (consulté le 2026-06-07)
- Confiance et sécurité: [Tabnine Trust Center](https://www.tabnine.com/trust-center) (consulté le 2026-06-07)

---

## Prochaine étape

**[Amazon Q Developer](amazon-q-developer.md)** : tirer parti d'un assistant spécialisé AWS pour les projets cloud basés sur les services Amazon.

Concepts clés couverts:

- **Contexte AWS** - quand Amazon Q apporte plus de valeur
- **Intégration Toolkit** - installation dans VS Code et IntelliJ
- **Cas cloud** - Lambda, IAM, CDK, opérations
- **Quotas et coûts** - points à vérifier selon le plan
