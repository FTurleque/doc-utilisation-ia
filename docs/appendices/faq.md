# FAQ — Questions Fréquentes

## Installation & Abonnement

??? question "Faut-il payer pour utiliser GitHub Copilot ?"
    GitHub Copilot est un service payant pour la plupart des utilisateurs. Plusieurs plans sont disponibles :
    
    - **Copilot Free** : limité (2000 complétions/mois, 50 messages Chat/mois) — disponible depuis fin 2024
    - **Copilot Individual** : ~10$/mois ou 100$/an, usage illimité
    - **Copilot Business** : ~19$/utilisateur/mois, fonctionnalités avancées, politiques organisationnelles
    - **Copilot Enterprise** : tarification négociée, intégration GitHub Enterprise
    
    Les **étudiants et mainteneurs open source** peuvent obtenir Copilot gratuitement via [GitHub Education](https://education.github.com/) ou le programme [GitHub for Open Source](https://github.com/github-community/community/discussions).

??? question "Puis-je utiliser Copilot sur plusieurs machines avec le même compte ?"
    Oui. Votre abonnement GitHub Copilot est lié à votre compte GitHub, pas à une machine. Vous pouvez l'utiliser sur autant de machines que vous souhaitez avec la même authentification. Les sessions simultanées sont supportées.

??? question "Copilot fonctionne-t-il hors ligne ?"
    Non. GitHub Copilot nécessite une connexion Internet pour envoyer le contexte aux serveurs GitHub et recevoir les suggestions. Il n'existe pas de mode hors ligne officiel.
    
    En cas de connexion intermittente, les suggestions deviennent indisponibles jusqu'au rétablissement.

---

## Confidentialité & Sécurité

??? question "Mon code est-il envoyé à GitHub ? Est-il utilisé pour entraîner le modèle ?"
    **Copilot Individual** : par défaut, GitHub peut utiliser les snippets pour améliorer le modèle. Vous pouvez désactiver cela dans **github.com/settings/copilot** → "Allow GitHub to use my code snippets from the code editor for product improvements."
    
    **Copilot Business et Enterprise** : les snippets ne sont **jamais** utilisés pour l'entraînement du modèle. C'est une garantie contractuelle de GitHub.
    
    Dans tous les cas, des métadonnées non-code (telemetry) sont envoyées. Consultez la [politique de confidentialité GitHub Copilot](https://docs.github.com/fr/site-policy/privacy-policies/github-general-privacy-statement) pour les détails.

??? question "Copilot peut-il générer du code sous copyright ?"
    Il existe un risque théorique que Copilot génère des séquences de code identiques à du code sous licence restrictive (GPL, AGPL, etc.). Pour réduire ce risque :
    
    1. Dans **github.com/settings/copilot**, activez **"Block suggestions matching public code"**
    2. En Copilot Business/Enterprise, ce filtrage est disponible en tant que politique organisationnelle
    
    Ce paramètre n'élimine pas totalement le risque mais le réduit significativement.

??? question "Peut-on utiliser Copilot pour des projets confidentiels ?"
    Avec **Copilot Business ou Enterprise**, GitHub s'engage contractuellement à ne pas utiliser votre code pour entraîner le modèle. Le code est traité comme des données confidentielles.
    
    Pour les projets hautement sensibles (défense, données médicales, etc.), vérifiez les informations sous-traitants et certifications de conformité de GitHub auprès de votre DPO.

---

## Fonctionnalités & Utilisation

??? question "Quelle est la différence entre les suggestions inline et Copilot Chat ?"
    - **Suggestions inline** : suggestions "ghost text" qui apparaissent directement dans l'éditeur pendant que vous tapez. Idéal pour compléter des fonctions, des lignes, du boilerplate.
    - **Copilot Chat** : interface conversationnelle dans un panneau dédié. Idéal pour expliquer du code, générer des tests, refactoriser, poser des questions sur le projet.
    
    Les deux fonctionnent de manière complémentaire. La plupart des développeurs utilisent les deux selon le contexte.

??? question "Copilot Chat peut-il analyser tout mon projet ?"
    Avec la variable `@workspace` dans Copilot Chat (VS Code), Copilot effectue une recherche sémantique dans votre projet avant de répondre. Il ne "lit" pas tout le projet d'un coup, mais indexe et retrouve les fichiers pertinents.
    
    La qualité de l'analyse dépend de la taille et de la clarté de la structure du projet.

??? question "Comment améliorer la qualité des suggestions Copilot ?"
    Les leviers principaux, par ordre d'impact :
    
    1. **Types explicites** — annotez partout, Copilot comprend votre modèle de données
    2. **Noms descriptifs** — `getUsersByActiveStatus()` >> `query()`
    3. **Fichiers liés ouverts** — ouvrez les types, interfaces, et dépendances dans des onglets
    4. **Instructions contextuelles** — configurez `.github/copilot-instructions.md`
    5. **Commentaires de description** — écrivez l'intention en commentaire avant la fonction
    6. **Curseur positionné intelligemment** — juste après du code existant plutôt qu'en fichier vide

??? question "Copilot peut-il générer des tests automatiquement ?"
    Oui, c'est l'une de ses utilisations les plus efficaces. Deux approches :
    
    1. **Inline** : écrivez `// Test pour la fonction getUserById` et Copilot complète
    2. **Chat** : `Génère les tests Jest pour cette fonction, couvre les cas nominaux et les cas d'erreur`
    
    La qualité est bonne mais nécessite toujours une revue : Copilot peut manquer des cas limites ou générer des assertions trop permissives.

??? question "Quelle est la différence entre `.instructions.md`, `.prompt.md`, `.agent.md` et `SKILL.md` ?"
    | Fichier | Rôle |
    |---------|------|
    | `.instructions.md` | Règles permanentes appliquées automatiquement selon le type de fichier (`applyTo`) |
    | `.prompt.md` | Prompts pré-configurés invocables manuellement depuis le Chat (`/prompt-name`) |
    | `.agent.md` | Définit un agent personnalisé avec des outils spécifiques et un comportement dédié |
    | `SKILL.md` | Regroupe un ensemble de comportements et connaissances invocables via URI `copilot-skill://` |
    
    Voir [Contexte & Personnalisation](../chapitre-3-contexte/index.md) pour le guide complet.

---

## IDE & Compatibilité

??? question "IntelliJ et VS Code offrent-ils les mêmes fonctionnalités Copilot ?"
    Non. VS Code dispose de fonctionnalités exclusives :
    
    - `.instructions.md` (instruction files)
    - `.prompt.md` (prompt files)
    - `.agent.md` et agents custom
    - `SKILL.md`
    - Mode Agent dans Chat (ask/edit/agent)
    - Copilot Edits (édition multi-fichiers)
    - `.copilotignore`
    
    IntelliJ offre une meilleure **analyse sémantique** du code Java/Kotlin via PSI, mais moins de fonctionnalités de personnalisation.
    
    Voir la [Comparaison des problèmes](../chapitre-6-troubleshooting/comparaison-problemes.md) pour la matrice complète.

??? question "Copilot fonctionne-t-il avec tous les langages ?"
    Copilot supporte la grande majorité des langages de programmation. La qualité varie :
    
    - **Excellent** : Python, JavaScript, TypeScript, Java, C#, Go, Ruby
    - **Bon** : C++, C, PHP, Swift, Kotlin, Rust, Scala
    - **Partiel** : langages de niche, DSLs spécifiques
    
    Pour les langages peu représentés dans le code public, la qualité des suggestions est moindre. Des types explicites et des commentaires descriptifs compensent en partie.

??? question "Comment désactiver Copilot temporairement ?"
    === ":material-microsoft-visual-studio-code: VS Code"
        - Barre de statut → clic sur l'icône Copilot → **Disable Completions**
        - Ou : palette de commandes ++ctrl+shift+p++ → **"GitHub Copilot: Disable Completions"**
        
    === ":simple-intellijidea: IntelliJ"
        - Clic sur l'icône Copilot dans la status bar → **"Disable GitHub Copilot"**

---

## Troubleshooting

??? question "Pourquoi Copilot ne génère-t-il pas de suggestions dans un fichier ?"
    Causes fréquentes par ordre de probabilité :
    
    1. **Authentification expirée** → se reconnecter
    2. **Extension/plugin désactivé** → vérifier les paramètres
    3. **Fichier dans `.copilotignore`** (VS Code) → vérifier le fichier
    4. **Langage désactivé** dans les paramètres pour ce type de fichier
    5. **`editor.inlineSuggest.enabled: false`** (VS Code)
    6. **Mode Power Save actif** (IntelliJ)
    
    Voir [Problèmes courants](../chapitre-6-troubleshooting/problemes-courants.md) pour les solutions détaillées.

??? question "Comment lire les logs Copilot ?"
    === ":material-microsoft-visual-studio-code: VS Code"
        **Affichage → Sortie** (++ctrl+shift+u++) → sélectionnez **"GitHub Copilot"** dans le dropdown
        
    === ":simple-intellijidea: IntelliJ"
        **Help → Show Log in Explorer** → filtrez `idea.log` avec grep "copilot"
    
    Voir [Logs & Diagnostic](../chapitre-6-troubleshooting/logs-diagnostic.md) pour le guide complet.
