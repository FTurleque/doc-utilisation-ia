# Comparaison des Paramètres — IntelliJ vs VS Code

## Présentation
Cette page compare les options de configuration disponibles entre IntelliJ IDEA et Visual Studio Code pour GitHub Copilot. Les deux IDEs offrent des expériences similaires mais avec des différences notables dans la granularité des paramètres.

---

## Tableau comparatif général

| Paramètre / Fonctionnalité | IntelliJ IDEA | VS Code |
|---------------------------|:-------------:|:-------:|
| **Activer/Désactiver Copilot** | ✅ Settings UI | ✅ `github.copilot.enable` |
| **Désactiver par langage** | ✅ Liste dans Settings | ✅ Object par langage dans JSON |
| **Auto-complétion activée** | ✅ Case à cocher | ✅ `enableAutoCompletions` |
| **Délai de suggestion** | ✅ Paramètre en ms | ⚠️ Non exposé directement |
| **Nombre de suggestions inline** | ⚠️ Limité | ✅ `advanced.inlineSuggestCount` |
| **Langue du Chat** | ⚠️ Suit la langue de l'IDE | ✅ `chat.localeOverride` |
| **Code actions (ampoule IA)** | ✅ Activé par défaut | ✅ `enableCodeActions` |
| **Suggestions de renommage** | ⚠️ Automatique non configurable | ✅ `renameSuggestions.triggerAutomatically` |
| **Settings par workspace** | ✅ Via projet partagé JetBrains | ✅ `.vscode/settings.json` |
| **Export/partage de config** | ✅ Export IDE Settings | ✅ `settings.json` versionnable |
| **Niveau de logs** | ✅ Configurable | ⚠️ Via `debug.overrideLogLevels` |
| **Notifications** | ✅ Granularité par type | ⚠️ Limité aux notifications VS Code |

**Légende :** ✅ Bien supporté · ⚠️ Support partiel ou indirect · ❌ Non disponible

---

## Fonctionnalités exclusives à IntelliJ IDEA

| Fonctionnalité | Description |
|----------------|-------------|
| **Délai de suggestion configurable** | Paramètre précis en millisecondes directement dans l'UI |
| **Suggest Delay slider** | Interface graphique pour ajuster finement la réactivité |
| **Intégration native JetBrains** | Les suggestions tiennent compte du modèle sémantique complet de l'IDE (types, imports, PSI) |
| **Quick Documentation avec Copilot** | Copilot peut générer de la documentation dans le format natif de l'IDE (Javadoc, KDoc) |

---

## Fonctionnalités exclusives à VS Code

| Fonctionnalité | Description |
|----------------|-------------|
| **`github.copilot.enable` par langage** | Désactiver/activer avec une précision par langage individuel |
| **`chat.localeOverride`** | Forcer la langue du Chat indépendamment de la langue de l'IDE |
| **Fichiers `SKILL.md`** | Packages de connaissance domaine pour Copilot |
| **Hooks Copilot** | Automatisations déclenchées par des actions Copilot |
| **`.copilotignore`** | Exclure des fichiers du contexte Copilot |
| **Panneau "10 suggestions"** | ++ctrl+enter++ ouvre un panneau avec 10 variantes de suggestion |
| **`advanced.listCount`** | Configurer le nombre de suggestions dans le panneau |

!!! warning "Différence fondamentale"
    La personnalisation avancée via fichiers (`.instructions.md`, `.agent.md`, `.prompt.md`, `SKILL.md`) est une fonctionnalité **exclusive à VS Code**. Si vous avez besoin de cette personnalisation avancée dans votre workflow, VS Code est indispensable.

---

## Équivalences de paramètres

| Objectif | IntelliJ | VS Code (`settings.json`) |
|----------|----------|--------------------------|
| Désactiver Copilot | Settings → Décocher "Enable" | `"github.copilot.enable": {"*": false}` |
| Désactiver sur Markdown | Settings → Disabled Languages → markdown | `"github.copilot.enable": {"markdown": false}` |
| Mode manuel uniquement | Settings → Décocher "Auto-completions" | `"github.copilot.editor.enableAutoCompletions": false` |
| Ouvrir les Settings | ++ctrl+alt+s++ → GitHub Copilot | ++ctrl+comma++ → rechercher "copilot" |
| Désactiver temporairement | Icône barre d'état → Disable | Icône barre de statut → Disable |

---

## Comparaison de la qualité des suggestions

La qualité des suggestions Copilot dépend du contexte fourni à l'IA, pas uniquement de l'IDE. Cependant, certaines différences existent :

| Aspect | IntelliJ IDEA | VS Code |
|--------|:-------------:|:-------:|
| **Analyse sémantique du code** | Très profonde (PSI tree) | Bonne (Language Server) |
| **Complétion Java/Kotlin** | ⭐⭐⭐⭐⭐ Excellente | ⭐⭐⭐⭐ Très bonne |
| **Complétion JavaScript/TypeScript** | ⭐⭐⭐⭐ Très bonne | ⭐⭐⭐⭐⭐ Excellente |
| **Complétion Python** | ⭐⭐⭐⭐ Très bonne (PyCharm) | ⭐⭐⭐⭐⭐ Excellente (avec Pylance) |
| **Personnalisation du contexte** | ⭐⭐⭐ Bonne | ⭐⭐⭐⭐⭐ Excellente (instructions, agents) |
| **Qualité globale** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ |

---

## Recommandation

**Pour un usage standard** (suggestions inline + Chat) : les deux IDEs sont équivalents.

**Pour une personnalisation avancée** : VS Code est nettement supérieur grâce au système de fichiers `.github/`.

**Pour des projets Java/JVM** : IntelliJ offre une meilleure intégration grâce à son modèle sémantique plus riche.

---

## Prochaines étapes

- [Contexte & Personnalisation](../chapitre-3-contexte/index.md) — Explorer les mécanismes de personnalisation avancée (VS Code)
- [Bonnes Pratiques](../chapitre-8-bonnes-pratiques/index.md) — Tirer le meilleur des deux IDEs

