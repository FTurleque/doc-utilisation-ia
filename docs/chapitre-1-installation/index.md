# GitHub Copilot — Installation (référence)

Ce chapitre conserve les procédures d'installation de **GitHub Copilot** dans IntelliJ IDEA et Visual Studio Code.

!!! info "Parcours principal du dépôt"
    Le parcours recommandé est désormais **Claude Code**. Pour une nouvelle installation, commencez par [Installer Claude Code](../chapitre-3b-claude-code-migration-copilot/installation.md). Les pages ci-dessous restent maintenues comme référence Copilot, comparaison et solution de repli éventuelle.

---

## Prérequis Copilot

GitHub Copilot peut être utilisé avec un plan individuel gratuit ou payant, ou avec une licence fournie par une organisation.

Les offres GitHub documentées actuellement comprennent notamment :

- Copilot Free ;
- Copilot Student ;
- Copilot Pro ;
- Copilot Pro+ ;
- Copilot Max ;
- Copilot Business ;
- Copilot Enterprise.

!!! warning "Les offres et quotas changent"
    Ne vous fiez pas à un ancien nombre de requêtes ou de crédits copié dans cette page. Vérifiez la page officielle [Plans for GitHub Copilot](https://docs.github.com/en/copilot/get-started/plans) avant toute décision d'abonnement.

Prérequis généraux :

| Prérequis | Détail |
|---|---|
| Compte GitHub | Compte personnel ou compte d'organisation autorisé à utiliser Copilot |
| Plan Copilot | Free/Student ou offre payante compatible avec la fonctionnalité visée |
| Connexion Internet | Requise pour l'authentification et les appels au service |
| IDE | Utilisez une version stable récente et la dernière version du plugin/extension Copilot |

---

## Installer dans votre IDE

<div class="grid cards" markdown>

- :simple-intellijidea: **IntelliJ IDEA / JetBrains**

    Installation via **Settings / Preferences → Plugins → Marketplace**, puis recherche du plugin officiel GitHub Copilot.

    [Tutoriel IntelliJ →](intellij/tutoriel.md){ .md-button }

- :material-microsoft-visual-studio-code: **Visual Studio Code**

    Installation depuis le Marketplace d'extensions VS Code avec l'extension GitHub Copilot.

    [Tutoriel VS Code →](vscode/tutoriel.md){ .md-button }

</div>

---

## État des personnalisations Copilot

Les fonctionnalités ne sont pas strictement identiques entre les surfaces. La matrice GitHub actuelle indique notamment :

| Fonction | VS Code | JetBrains |
|---|:---:|:---:|
| Custom instructions | ✓ | Preview |
| Prompt files | ✓ | Preview |
| Custom agents | ✓ | Preview |
| Subagents | ✓ | Preview |
| Agent skills | ✓ | Preview |
| Hooks | Preview | ✗ |
| MCP | ✓ | ✓ |

Cette matrice évolue rapidement : utilisez la [Copilot customization cheat sheet](https://docs.github.com/en/copilot/reference/customization-cheat-sheet) comme source de vérité avant d'écrire une procédure multi-IDE.

!!! note "Skills interopérables"
    GitHub Copilot sait désormais charger des skills depuis `.github/skills`, `.claude/skills` ou `.agents/skills` sur certaines surfaces. Cette compatibilité est utile pour conserver des briques partagées pendant la migration vers Claude.

---

## Où aller ensuite ?

- **Nouveau poste / nouveau projet** : [Installer Claude Code](../chapitre-3b-claude-code-migration-copilot/installation.md)
- **Conserver Copilot** : choisir le tutoriel IntelliJ ou VS Code ci-dessus
- **Comparer les deux approches** : [Copilot vs Claude](../chapitre-3b-claude-code-migration-copilot/comparaison-copilot-claude.md)
- **Paramétrer Copilot** : [Paramétrage Copilot — référence](../chapitre-2-parametrage/index.md)

---

## Sources

Sources officielles consultées le **28 septembre 2026** :

- [GitHub Docs — Plans for GitHub Copilot](https://docs.github.com/en/copilot/get-started/plans)
- [GitHub Docs — Installing the GitHub Copilot extension](https://docs.github.com/en/copilot/how-tos/set-up/install-copilot-extension)
- [GitHub Docs — Copilot customization cheat sheet](https://docs.github.com/en/copilot/reference/customization-cheat-sheet)
- [GitHub Docs — Adding agent skills](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/customize-cloud-agent/add-skills)
