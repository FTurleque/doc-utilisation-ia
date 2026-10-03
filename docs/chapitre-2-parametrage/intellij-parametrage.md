# GitHub Copilot sur JetBrains — paramétrage

<span class="badge-intellij">IntelliJ IDEA</span> <span class="badge-intermediate">Intermédiaire</span>

!!! info "Référence Copilot conservée"
    Cette page documente GitHub Copilot pour JetBrains. Le parcours principal du dépôt est Claude Code ; ne transposez pas automatiquement les réglages Copilot vers `.claude/`.

Les écrans et options Copilot évoluent avec la version du plugin, le canal stable/preview, le plan et les politiques d'organisation. Cette page privilégie donc les **surfaces officiellement documentées** et renvoie à la feature matrix pour les fonctions en preview.

---

## Accéder aux réglages

Dans IntelliJ IDEA et les IDE JetBrains compatibles :

**Settings/Preferences → Tools → GitHub Copilot**

GitHub documente notamment les sections **General** et **Completions**. Des sections de personnalisation ou d'agent peuvent apparaître selon votre version.

---

## General

Utilisez cette section pour :

- vérifier le compte Copilot ;
- gérer les mises à jour du plugin ;
- choisir le canal de mise à jour lorsqu'il est disponible ;
- activer/désactiver certaines options générales.

Pour un environnement d'équipe, préférez le canal **Stable** sauf test explicite d'une fonction preview.

---

## Completions et langages

Copilot est activé par défaut pour les langages pris en charge. Vous pouvez modifier l'activation par langage dans :

**Settings → Tools → GitHub Copilot → Completions**

GitHub documente aussi le fichier `github-copilot.xml` et son `languageAllowList` pour ces réglages.

!!! warning "Ce n'est pas une politique de confidentialité"
    Désactiver Copilot pour un langage ou type de fichier ne remplace ni la classification des données, ni les contrôles DLP, ni une politique de secrets.

---

## Custom instructions

Le fichier de dépôt le plus portable reste :

```text
.github/copilot-instructions.md
```

Les versions JetBrains récentes proposent aussi un éditeur de **Customizations**. Le support de certaines formes avancées d'instructions, notamment path-specific, dépend de la version et peut être en preview.

Règle de maintenance :

- gardez `.github/copilot-instructions.md` court et stable ;
- placez les conventions métier durables dans une documentation commune lorsque possible ;
- vérifiez la page GitHub **Support for different types of custom instructions** avant d'introduire une convention JetBrains spécifique.

---

## Prompt files, agents et skills

La feature matrix 2026 indique dans JetBrains :

| Personnalisation | État courant général |
|---|---|
| Agent mode | Supporté |
| Custom agents | Preview |
| Prompt files | Preview |
| Agent skills | Preview sur les versions récentes |
| Custom instructions | Preview dans la matrice IDE |
| MCP | Supporté |

Ne présentez donc pas une option visible dans l'UI comme une API stable et universelle.

Pour les emplacements et formats Copilot, reportez-vous aux pages dédiées du chapitre **Contexte & Personnalisation** et au cheat sheet officiel GitHub.

---

## MCP

Le support MCP est présent dans les versions JetBrains Copilot récentes.

Avant d'activer un serveur :

1. identifiez précisément les tools/resources exposés ;
2. minimisez les permissions ;
3. gardez les secrets hors Git ;
4. vérifiez l'éditeur du serveur ;
5. testez sur un environnement non critique ;
6. conservez une procédure de révocation rapide.

Voir **[MCP — chapitre outils](../chapitre-13-outils-economies/mcps/index.md)**.

---

## Agents et actions automatiques

Le mode Agent est supporté, mais les contrôles exacts peuvent varier selon version et politiques.

Ne documentez pas une option UI telle que `Agent Max Requests`, `Thinking Budget`, `Enable Hooks` ou `Enable Subagent` comme comportement contractuel si elle n'est pas décrite dans la documentation GitHub correspondant à votre version.

Pour une équipe :

- activer progressivement ;
- garder les permissions minimales ;
- exiger un diff relu ;
- valider avec build/tests/CI ;
- journaliser les exceptions importantes.

---

## Raccourcis

Les raccourcis dépendent du keymap et des plugins.

**Settings → Keymap → rechercher `Copilot`**

C'est la référence locale à privilégier. N'imposez pas des raccourcis copiés d'une autre version ou d'un autre OS.

---

## Logs et diagnostic

Pour un problème de plugin :

1. vérifiez la compatibilité IDE/plugin dans le JetBrains Marketplace ;
2. mettez le plugin à jour ;
3. vérifiez le compte et les politiques GitHub ;
4. ouvrez **Help → Show Log in Explorer/Finder/Files Manager** ;
5. recherchez les entrées Copilot dans `idea.log` ;
6. testez sans autre plugin potentiellement conflictuel si nécessaire.

---

## Relation avec Claude Code

Dans cette documentation :

- **Claude** : `CLAUDE.md`, `.claude/rules/`, `.claude/skills/`, `.claude/agents/`, hooks Claude ;
- **Copilot** : `.github/copilot-instructions.md`, instructions/prompt files/agents selon support GitHub ;
- **commun** : conventions de build/test, architecture et règles métier documentées dans le dépôt.

Ne dupliquez pas une convention dans les deux écosystèmes si elle peut vivre dans une source commune.

---

## Sources

- [GitHub Docs — Configuring GitHub Copilot in your environment](https://docs.github.com/en/copilot/how-tos/configure-personal-settings/configure-in-ide) — consulté le 2026-09-28
- [GitHub Docs — Copilot feature matrix](https://docs.github.com/en/copilot/reference/copilot-feature-matrix) — consulté le 2026-09-28
- [GitHub Docs — Support for different types of custom instructions](https://docs.github.com/en/copilot/reference/custom-instructions-support) — consulté le 2026-09-28
- [GitHub Docs — Copilot customization cheat sheet](https://docs.github.com/en/copilot/reference/customization-cheat-sheet) — consulté le 2026-09-28

## Prochaine étape

Poursuivez avec **[Visual Studio Code](vscode-parametrage.md)**, la page suivante dans le menu.
