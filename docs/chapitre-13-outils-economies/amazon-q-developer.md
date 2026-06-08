# Amazon Q Developer

<span class="badge-beginner">Débutant</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span>

Amazon Q Developer est l'assistant de développement d'AWS.
Il devient très pertinent quand ton code et ton exploitation sont fortement centrés sur les services AWS.

---

## À quoi sert Amazon Q Developer

- Aide au développement applicatif dans l'écosystème AWS
- Assistance sur services cloud (IAM, Lambda, S3, CDK, etc.)
- Support de bonnes pratiques et dépannage orienté AWS

!!! success "Quand l'utiliser"
    Si ton projet est majoritairement AWS, Amazon Q peut réduire fortement les allers-retours de recherche documentaire.

---

## Quand l'utiliser

- Quand le projet est principalement basé sur AWS
- Quand tu veux une aide spécialisée sur les services cloud Amazon
- Quand tu veux accélérer les diagnostics autour d'IAM, Lambda ou CDK

## Quand l'éviter

- Quand le projet n'a pas de dépendance forte à AWS
- Quand tu cherches une aide générique pour un autre cloud
- Quand tu n'as pas encore de contexte service/région clair

---

## Mise en œuvre

### Installation

=== "Visual Studio Code"
    1. Installer **AWS Toolkit** depuis le marketplace.
    2. Se connecter avec un compte compatible (ex: Builder ID selon mode d'accès).
    3. Ouvrir Amazon Q dans le panneau Toolkit.

=== "IntelliJ IDEA"
    1. Installer **AWS Toolkit** depuis le marketplace JetBrains.
    2. Se connecter au compte AWS/Builder ID.
    3. Activer Amazon Q depuis les outils AWS.

### Bon démarrage

- Donner le contexte exact : service AWS, région, contraintes IAM
- Demander des sorties vérifiables : checklists, commandes, étapes de test
- Valider les recommandations en sandbox avant production

---

## Cas d'usage pertinents

- Diagnostic d'erreurs AWS dans un projet existant
- L'aide à l'écriture de code SDK AWS
- Préparation de scripts d'infra et d'opérations cloud
- Revue de configurations IAM (avec vérification humaine)

Cas moins adaptés :

- Projet non AWS
- Demandes généralistes sans contexte service/région

---

## Exploiter son plein potentiel

1. **Prompts précis cloud**
   - Service + région + contrainte + objectif
2. **Couplage avec outils locaux**
   - **[RTK](rtk.md)** pour filtrer les logs
   - **[Continue.dev](continue-dev.md)** + local pour tâches de code génériques
3. **Garde-fous sécurité**
   - Revue humaine des politiques IAM
   - Tests de moindre privilège et validation en environnement non prod

!!! warning "Vigilance coût/quotas"
    Les quotas et options gratuites peuvent évoluer. Vérifie la page pricing officielle avant de formaliser une stratégie d'équipe.

---

## Exemple concret

```text
Prompt type:
"J'ai une Lambda Node.js en eu-west-1 qui échoue avec AccessDenied sur S3.
Propose un plan de diagnostic IAM en 6 étapes avec commandes de vérification."
```

---

## Résumé

Amazon Q Developer prend tout son intérêt quand le projet, les services et
les opérations sont centrés sur AWS. Il est alors plus utile qu'un assistant
généraliste pour les questions cloud ciblées.

---

## Sources

- Page officielle: [Amazon Q Developer](https://aws.amazon.com/q/developer/) (consultée le 2026-06-07)
- Documentation officielle: [Amazon Q Developer User Guide](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/what-is.html) (consultée le 2026-06-07)
- Tarification officielle: [Amazon Q Developer Pricing](https://aws.amazon.com/q/developer/pricing/) (consultée le 2026-06-07)
- VS Code Toolkit: [AWS Toolkit for VS Code](https://docs.aws.amazon.com/toolkit-for-vscode/latest/userguide/welcome.html) (consultée le 2026-06-07)
- JetBrains Toolkit: [AWS Toolkit for JetBrains](https://docs.aws.amazon.com/toolkit-for-jetbrains/latest/userguide/welcome.html) (consultée le 2026-06-07)

---

## Prochaine étape

**[Supermaven](supermaven.md)** : accélérer la complétion inline sur de gros contextes de code pour les phases d'écriture intensive.

Concepts clés couverts:

- **Complétion très rapide** - diminuer la latence perçue
- **Contexte long** - exploiter des fichiers plus larges
- **Coexistence outils** - un moteur inline principal
- **Mesure de gain** - acceptance rate et qualité PR
