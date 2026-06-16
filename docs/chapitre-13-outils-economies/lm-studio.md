# LM Studio

<span class="badge-beginner">Débutant</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span>

LM Studio est une application desktop pour exécuter des LLM locaux avec une interface graphique.
C'est souvent le meilleur point d'entrée pour les équipes qui veulent éviter la ligne de commande.

---

## À quoi sert LM Studio

- Télécharger des modèles locaux depuis une interface visuelle
- Tester rapidement qualité, latence et taille de contexte
- Exposer un serveur local compatible API pour outils IDE

!!! info "Positionnement"
    LM Studio joue le rôle de "moteur local GUI". Pour l'usage direct dans l'IDE, il est souvent combiné avec **[Continue.dev](continue-dev.md)**.

---

## Quand l'utiliser

- Quand tu veux explorer des modèles locaux sans ligne de commande.
- Quand tu veux comparer rapidement plusieurs modèles.
- Quand tu veux une interface plus pédagogique qu'Ollama.

## Quand l'éviter

- Quand la machine est trop limitée en ressources.
- Quand tu veux un workflow automatisable en CLI d'abord.
- Quand ton équipe a besoin d'un standard plus minimaliste.

---

## Mise en œuvre

### Installation et premier démarrage

1. Télécharger LM Studio depuis le [site officiel](https://lmstudio.ai/download).
2. Installer l'application.
3. Ouvrir l'onglet de recherche de modèles et télécharger un modèle code/chat.
4. Démarrer le serveur local.

### Connexion dans l'IDE

=== "Visual Studio Code"
    1. Installer Continue.
    2. Configurer un provider compatible OpenAI/local vers l'URL de LM Studio.
    3. Tester un prompt simple sur un fichier.

=== "IntelliJ IDEA"
    1. Installer le plugin Continue.
    2. Pointer la configuration vers le serveur local LM Studio.
    3. Vérifier le retour sur un extrait de code.

---

## Cas d'usage pertinents

- Équipe débutante qui veut du local sans CLI
- Évaluation comparée de plusieurs modèles
- Démonstration interne (POC) sur poste développeur
- Assistance quotidienne faible coût sur code non critique

Cas moins adaptés :

- Machine limitée en RAM/GPU
- Besoin de standardisation stricte sans guide d'équipe

---

## Exploiter son plein potentiel

1. **Créer des presets par tâche**
   - Exemple: preset "doc" et preset "debug"
2. **Versionner la stratégie de modèle**
   - Documenter un modèle, taille de contexte, température
3. **Routage avec Continue.dev**
   - Chat simple sur modèle local
   - Escalade cloud uniquement si nécessaire
4. **Benchmark interne**
   - Mesurer un temps de réponse, qualité, taux de rework

!!! tip "Référence à d'autres outils"
    - **[Ollama](ollama.md)**: alternative CLI/API locale
    - **[RTK](rtk.md)**: compresser les sorties terminal avant envoi au chat

---

## Exemple concret

```text
Scénario:

- Tu hésites entre deux modèles locaux pour écrire des tests unitaires.

Méthode:

1) Même prompt sur 2 modèles dans LM Studio.
2) Mesure du temps de réponse.
3) Évaluation de la qualité (tests qui compilent, lisibilité, couverture).
4) Adoption du meilleur preset pour l'équipe.
```

---

## Résumé

LM Studio est la meilleure option pour démarrer visuellement avec des modèles
locaux. Il simplifie l'expérimentation, puis peut alimenter Continue.dev pour
un usage direct dans l'IDE.

---

## Sources

- Site officiel : [lmstudio.ai](https://lmstudio.ai/) (consulté le 2026-06-07)
- Téléchargement officiel : [LM Studio Download](https://lmstudio.ai/download) (consulté le 2026-06-07)
- Documentation officielle : [LM Studio Docs](https://lmstudio.ai/docs) (consulté le 2026-06-07)
- Actualités produit : [LM Studio Blog](https://lmstudio.ai/blog) (consulté le 2026-06-07)

---

## Prochaine étape

**[Stack prête en 15 min — VS Code](stack-prete-15-min-vscode.md)** : appliquer immédiatement une configuration locale-first complète et actionnable en quelques étapes.

Concepts clés couverts :

- **Complétion inline** - accélérer l'écriture de code répétitif
- **Cohabitation outils** - éviter les conflits avec Copilot
- **Cas d'usage budget** - stack productive à faible coût
- **Gouvernance** - valider les politiques de données
