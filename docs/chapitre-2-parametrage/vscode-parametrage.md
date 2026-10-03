# GitHub Copilot sur VS Code — paramétrage

<span class="badge-vscode">VS Code</span> <span class="badge-intermediate">Intermédiaire</span>

!!! info "Référence Copilot conservée"
    Cette page documente GitHub Copilot dans VS Code. Le parcours principal du dépôt est Claude Code ; les fichiers `.github/` Copilot restent toutefois conservés et maintenus.

Copilot et VS Code évoluent rapidement. Préférez les réglages documentés, la feature matrix et la palette Settings de votre version à des clés historiques recopiées d'une ancienne release.

---

## Accéder aux réglages

Dans VS Code :

- ouvrez **Settings** ;
- recherchez `Copilot`, `Chat`, `Agent`, `MCP` ou `inlineSuggest` ;
- utilisez **Open Settings (JSON)** uniquement lorsque vous connaissez la clé exacte et qu'elle est encore documentée.

!!! warning "Éviter les clés historiques"
    Ne conservez pas une clé `settings.json` uniquement parce qu'elle apparaît dans une ancienne documentation. Les options Copilot changent fréquemment et certaines sont renommées ou supprimées.

---

## Repository-wide custom instructions

Le fichier Copilot de dépôt principal est :

```text
.github/copilot-instructions.md
```

Il contient des instructions générales applicables dans le contexte du dépôt.

Bon contenu :

- commandes de build/test ;
- conventions d'architecture ;
- contraintes techniques importantes ;
- règles de validation.

Évitez les longues explications ou les informations qui devraient vivre dans la documentation métier.

---

## Instructions ciblées par chemin

VS Code prend en charge les instructions path-specific :

```text
.github/instructions/*.instructions.md
```

avec un frontmatter `applyTo`.

Exemple :

```markdown
---
applyTo: "**/*.ts,**/*.tsx"
---

Utiliser TypeScript strict.
Exécuter le typecheck et les tests concernés avant de conclure.
```

Ces fichiers complètent `.github/copilot-instructions.md` ; ils ne le remplacent pas.

---

## `AGENTS.md`

Copilot prend également en charge des **agent instructions** via `AGENTS.md` dans plusieurs surfaces. Le support exact dépend de la fonction Copilot concernée.

Dans ce dépôt, `AGENTS.md` est volontairement utilisable comme source commune de conventions agentiques lorsque cela évite de dupliquer les mêmes règles entre Claude et Copilot.

GitHub documente aussi l'usage de `CLAUDE.md` ou `GEMINI.md` pour certaines surfaces cloud/CLI. Cela ne signifie pas que toutes les surfaces VS Code traitent ces fichiers de façon identique : vérifiez la table officielle de support.

---

## Prompt files

Les prompt files sont stockés sous :

```text
.github/prompts/*.prompt.md
```

Ils servent de prompts réutilisables pour une tâche précise. Leur prise en charge dans VS Code est actuellement indiquée comme supportée dans les versions récentes, mais gardez la documentation GitHub comme source de vérité.

Voir **[Prompt Files Copilot](../chapitre-4-contexte/prompt-files.md)**.

---

## Custom agents et agent skills

Les versions VS Code récentes prennent en charge les custom agents et les agent skills. Les formats et capacités évoluent encore.

Utilisez le **Copilot customization cheat sheet** officiel pour vérifier :

- emplacement du fichier ;
- portée ;
- outils autorisés ;
- support par la surface Copilot utilisée.

Ne confondez pas :

- `.github/agents/` et mécanismes Copilot ;
- `.claude/agents/` pour Claude Code ;
- `.claude/skills/` pour les skills Claude.

---

## Personal instructions

Les **personal instructions** documentées par GitHub s'appliquent notamment au Copilot Chat sur GitHub.com et à certaines surfaces précises. Ne présentez pas un champ GitHub.com comme un réglage VS Code universel.

Pour VS Code, utilisez en priorité les instructions de dépôt et les mécanismes explicitement listés dans la page **Support for different types of custom instructions**.

---

## MCP

Copilot dans VS Code prend en charge MCP.

Un serveur MCP n'est pas un simple fichier de contexte : il peut exposer des outils et des données externes.

Checklist minimale :

- serveur provenant d'une source vérifiée ;
- permissions minimales ;
- secrets hors dépôt ;
- outils limités au besoin ;
- sorties non fiables traitées comme données externes ;
- désactivation possible rapidement.

Voir **[MCP — chapitre outils](../chapitre-13-outils-economies/mcps/index.md)**.

---

## Modèles et plans

La disponibilité des modèles dépend du plan Copilot, des politiques organisationnelles et des changements de GitHub.

Ne figez pas une liste de modèles dans cette page. Consultez :

- les plans GitHub Copilot ;
- la page de modèles et tarification ;
- la feature matrix ;
- le sélecteur de modèle disponible dans votre version.

---

## Raccourcis

Les raccourcis dépendent de votre keymap.

Ouvrez **Keyboard Shortcuts** et recherchez :

```text
Copilot
Chat
inlineSuggest
```

C'est plus fiable qu'une table statique copiée d'une version ancienne.

---

## Validation d'équipe

Avant de standardiser un réglage Copilot :

1. vérifier qu'il est documenté pour la version stable ;
2. identifier s'il est GA ou Preview ;
3. vérifier les politiques GitHub de l'organisation ;
4. tester sur un dépôt pilote ;
5. documenter la procédure de retour arrière ;
6. ne jamais considérer Copilot comme substitut aux tests/CI/revue.

---

## Relation avec Claude Code

La stratégie de ce dépôt est :

```text
Claude Code = parcours principal
GitHub Copilot = référence conservée / environnement optionnel
Documentation métier = source commune autant que possible
```

Les formats spécifiques restent séparés afin d'éviter de faire croire qu'ils sont interchangeables.

---

## Sources

- [GitHub Docs — Copilot feature matrix](https://docs.github.com/en/copilot/reference/copilot-feature-matrix) — consulté le 2026-09-28
- [GitHub Docs — Adding repository custom instructions](https://docs.github.com/en/copilot/how-tos/configure-custom-instructions-in-your-ide/add-repository-instructions-in-your-ide) — consulté le 2026-09-28
- [GitHub Docs — Support for different types of custom instructions](https://docs.github.com/en/copilot/reference/custom-instructions-support) — consulté le 2026-09-28
- [GitHub Docs — Copilot customization cheat sheet](https://docs.github.com/en/copilot/reference/customization-cheat-sheet) — consulté le 2026-09-28

## Prochaine étape

Poursuivez avec **[Paramétrage — Comparaison](comparaison-parametres.md)**, la page suivante dans le menu.
