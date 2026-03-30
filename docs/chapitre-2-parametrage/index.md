# Paramétrage Détaillé & Options Avancées

Une fois GitHub Copilot installé, la configuration par défaut est fonctionnelle mais générique. Ce chapitre vous guide à travers tous les paramètres disponibles sur chaque IDE, avec des explications concrètes et des profils de configuration adaptés à votre contexte.

---

## Pourquoi paramétrer Copilot ?

La configuration par défaut de Copilot est conçue pour être universelle, mais elle n'est pas optimale pour tous les contextes :

- **Trop de suggestions ?** Ajustez la fréquence et les délais
- **Pas de suggestions dans certains fichiers ?** Activez/désactivez par langage
- **Vous travaillez en équipe ?** Standardisez les paramètres via un fichier partagé
- **Performances dégradées ?** Optimisez les paramètres de ressources

---

## Ce que vous trouverez dans ce chapitre

<div class="grid cards" markdown>

- :simple-intellijidea: **[IntelliJ — Paramétrage](intellij-parametrage.md)**

    Accès aux settings, chaque paramètre expliqué, 4 profils de configuration (débutant, expert, équipe, minimaliste)

- :material-microsoft-visual-studio-code: **[VS Code — Paramétrage](vscode-parametrage.md)**

    `settings.json` complet, tous les paramètres `github.copilot.*`, 4 profils prêts à copier

- :material-compare: **[Comparaison des paramètres](comparaison-parametres.md)**

    Tableau croisé IntelliJ ↔ VS Code, fonctionnalités exclusives à chaque IDE

</div>

---

## Les 4 profils de configuration

Tout au long de ce chapitre, vous trouverez ces 4 profils prêts à l'emploi :

| Profil | Pour qui ? | Caractéristiques |
|--------|-----------|-----------------|
| 🟢 **Débutant** | Découverte de Copilot | Suggestions fréquentes, délais courts, chat activé |
| 🔴 **Expert** | Développeurs expérimentés | Contrôle manuel, suggestions à la demande |
| 👥 **Équipe** | Travail collaboratif | Standardisé, cohérent entre tous les membres |
| ⚡ **Minimaliste** | Peu de distractions | Suggestions rares, désactivé sur plusieurs langages |

---

## Prochaines étapes

Après avoir configuré vos paramètres, explorez :

- [Contexte & Personnalisation](../chapitre-4-contexte/index.md) pour aller encore plus loin avec les instructions, agents et skills

