# Codeium / Windsurf

<span class="badge-beginner">Débutant</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span>

Codeium (et sa marque Windsurf selon le produit) est une alternative à Copilot pour la complétion et le chat.
Il est pertinent quand tu veux réduire le recours aux crédits IA pour les tâches simples.

---

## À quoi sert cet outil

- Complétion inline au quotidien
- Chat de développement pour questions courantes
- Génération de code répétitif (boilerplate, tests de base)

!!! info "Positionnement"
    Codeium/Windsurf est surtout fort en productivité de saisie et itération rapide. Pour les décisions d'architecture critiques, garde une validation humaine stricte.

---

## Quand l'utiliser

- Quand tu veux de la complétion inline gratuite ou peu coûteuse.
- Quand tu veux produire vite du code répétitif.
- Quand tu veux un chat simple pour des questions courantes.

## Quand l'éviter

- Quand plusieurs moteurs inline sont déjà actifs en même temps.
- Quand la tâche demande un raisonnement profond multi-fichiers.
- Quand des règles de gouvernance imposent un autre outil.

---

## Mise en œuvre

### Installation

=== "Visual Studio Code"
    1. Installer l'[extension officielle Codeium](https://marketplace.visualstudio.com/items?itemName=Codeium.codeium).
    2. Se connecter avec son compte.
    3. Activer complétion et chat selon le plan.

=== "IntelliJ IDEA"
    1. Ouvrir **Settings -> Plugins -> Marketplace**.
    2. Installer le [plugin Codeium officiel](https://plugins.jetbrains.com/plugin/12798-codeium).
    3. Se connecter puis activer les fonctionnalités.

### Éviter les conflits

Si Copilot, Supermaven et Codeium sont actifs en même temps,
les suggestions inline peuvent se chevaucher.

- Garder **un seul moteur inline principal**
- Utiliser les autres outils pour le chat ou des cas spécifiques

---

## Cas d'usage pertinents

- Complétion rapide sur code standard
- Génération de snippets répétitifs
- Aide syntaxique dans des langages connus
- Mode budget quand tu veux éviter de consommer des crédits IA inutilement

Cas moins adaptés :

- Débogage complexe multi-services
- Recommandations sécurité sans vérification externe

---

## Exploiter son plein potentiel

1. **Définir un mode principal par tâche**
   - Complétion: Codeium/Windsurf
   - Chat local: **[Continue.dev](continue-dev.md)** + **[Ollama](ollama.md)**
2. **Mettre des garde-fous qualité**
   - Tests automatiques
   - Linter/formatter en pré-commit
3. **Mesurer la productivité**
   - Latence moyenne
   - Taux d'acceptation des suggestions
   - Nombre de corrections post-génération

---

## Exemples concrets

```text
Exemple de demande chat:
"Génère un handler Express avec validation d'entrée, gestion d'erreurs,
et tests unitaires Jest de base."
```

```text
Exemple de flux hybride:
- Complétion: Codeium/Windsurf
- Questions de fond: Continue.dev + modèle local
- Cas critique: Copilot/Claude avec contexte filtré
```

---

## Résumé

Codeium / Windsurf est surtout un moteur de complétion et de chat rapide.
Il est utile pour les tâches quotidiennes, mais il prend toute sa valeur quand
il est combiné avec un chat local et une bonne discipline de validation.

---

## Sources

- Site officiel: [codeium.com](https://codeium.com/) (consulté le 2026-06-07)
- Site officiel Windsurf: [windsurf.com](https://windsurf.com/) (consulté le 2026-06-07)
- Documentation: [docs.codeium.com](https://docs.codeium.com/) (consulté le 2026-06-07)
- Tarification: [Codeium Pricing](https://codeium.com/pricing) (consulté le 2026-06-07)
- Sécurité: [Codeium Security](https://codeium.com/security) (consulté le 2026-06-07)

---

## Prochaine étape

**[Tabnine](tabnine.md)** : choisir une alternative orientée gouvernance et confidentialité pour les environnements entreprise.

Concepts clés couverts :

- **Confidentialité** - cadre de protection des données
- **Mode entreprise** - contrôles et politiques d'usage
- **Intégration IDE** - workflows VS Code et IntelliJ
- **Validation code IA** - revue et tests systématiques
