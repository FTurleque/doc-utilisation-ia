# Supermaven

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span>

Supermaven est un assistant principalement orienté complétion inline rapide.
Il vise à fluidifier l'écriture continue dans l'éditeur, avec une latence faible.

---

## À quoi sert Supermaven

- Complétion inline à haute fréquence
- Accélération des tâches de code répétitives
- Support des gros contextes selon les capacités produit du moment

!!! info "Positionnement"
    Supermaven est surtout un moteur de complétion. Pour le chat outillé, combine-le avec d'autres briques comme **[Continue.dev](continue-dev.md)**.

---

## Quand l'utiliser

- Quand tu veux de la complétion inline très rapide
- Quand tu écris beaucoup de code standard ou répétitif
- Quand tu veux un moteur principal de saisie avec faible friction

## Quand l'éviter

- Quand tu as déjà plusieurs moteurs inline actifs
- Quand la tâche est surtout du chat ou du raisonnement
- Quand ton processus impose un autre outil standardisé

---

## Mise en œuvre

### Installation

=== "Visual Studio Code"
    1. Installer l'extension Supermaven.
    2. Se connecter au compte.
    3. Activer la complétion inline.

=== "IntelliJ IDEA"
    1. Installer le plugin Supermaven depuis le marketplace.
    2. Se connecter.
    3. Activer la complétion et tester sur un fichier de projet.

### Règle de cohabitation

Pour éviter les collisions de suggestions:

- Un moteur inline principal (Supermaven **ou** Copilot **ou** Codeium)
- Les autres outils restent actifs pour des usages chat ponctuels

---

## Cas d'usage pertinents

- Écriture rapide de code standard
- Complétion dans de gros fichiers
- Maintenance quotidienne avec faible friction

Cas moins adaptés:

- Analyse architecture lourde
- Recommandations sécurité sans audit complémentaire

---

## Exploiter son plein potentiel

1. **Mesurer avant/après**
   - Temps d'écriture
   - Taux d'acceptation
   - Rework en revue de code
2. **Définir une hygiène de prompt/vérification**
   - Même avec forte vitesse, garder tests et revue
3. **Stack hybride recommandée**
   - Complétion: Supermaven
   - Chat local: **[Ollama](ollama.md)** + **[Continue.dev](continue-dev.md)**
   - Cas complexe: outil premium avec contexte filtré

---

## Exemple concret

```text
Scénario:
- Tu dois produire rapidement des DTO, mappers et tests de base.

Approche:
1) Supermaven pour la complétion inline.
2) Continue.dev local pour expliquer/refactorer les zones ambigües.
3) Tests automatiques avant commit.
```

---

## Résumé

Supermaven se positionne comme un moteur de complétion rapide à grand volume.
Il est idéal pour les phases d'écriture continue, à condition de garder une
seule source principale de suggestions inline.

---

## Sources

- Site officiel: [supermaven.com](https://supermaven.com/) (consulté le 2026-06-07)
- Documentation officielle: [Supermaven Docs](https://docs.supermaven.com/) (consulté le 2026-06-07)
- Tarification officielle: [Supermaven Pricing](https://supermaven.com/pricing) (consulté le 2026-06-07)
- Politique de confidentialité: [Supermaven Privacy](https://supermaven.com/privacy) (consulté le 2026-06-07)

---

## Prochaine étape

**[Comparaison des Outils](comparaison.md)** : choisir la meilleure combinaison selon ton IDE, ton budget, ton niveau de confidentialité et la complexité de tes tâches.

Concepts clés couverts:

- **Tableau comparatif** - vue transversale des solutions
- **Choix par contrainte** - offline, AWS, entreprise, budget
- **Économies estimées** - impact par stack d'outils
- **Décision rapide** - arborescence actionnable en pratique
