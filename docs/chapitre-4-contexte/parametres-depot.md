# Paramètres du Dépôt

<span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span> <span class="badge-intermediate">Intermédiaire</span>

Les paramètres du dépôt vivent dans le code source et sont partagés avec toute l'équipe.
Ils priment sur les réglages individuels quand Copilot construit son contexte de travail.

---

## Couches de personnalisation

Pensez la personnalisation Copilot comme un système en couches :

- Instructions : garde-fous persistants
- Skills : expertise réutilisable à la demande
- Agents : persona spécialisé avec outils dédiés

En combinant les trois, vous obtenez :

- onboarding plus cohérent ;
- moins de changements de contexte sur les tâches répétitives ;
- workflows spécialisés par domaine.

---

## Ce qui se configure au niveau dépôt

Personnalisations courantes :

- instructions de conventions de code.
- skills réutilisables.
- agents spécialisés par workflow.
- règles de contexte et d'exclusion (`.copilotignore`, `.gitignore`).

### Arborescence recommandée

```text
.github/
  copilot-instructions.md
  instructions/
    *.instructions.md
  prompts/
    *.prompt.md
  agents/
    *.agent.md
  skills/
    <skill-name>/SKILL.md
AGENTS.md
```

---

## Fichier AGENTS.md à la racine

Vous pouvez ajouter un fichier `AGENTS.md` à la racine pour référencer :

- les agents disponibles.
- les skills de référence.
- les conventions d'orchestration (quand utiliser quel agent).

Exemple minimal :

```markdown
# Catalogue d'agents

## Agents disponibles
- @security-auditor : audit de sécurité
- @gem-documentation-writer : rédaction docs
- @software-engineer : implémentation code

## Skills recommandés
- copilot-skill://agent-customization/SKILL.md
- copilot-skill://api-standards/SKILL.md
```

---

## Priorité pratique des fichiers

Ordre de priorité conseillé pour éviter les conflits :

1. `copilot-instructions.md` : règles globales stables
2. `*.instructions.md` : règles ciblées par type de fichier
3. `*.agent.md` : comportement de session
4. `SKILL.md` : contexte riche invoqué à la demande

---

## Prochaine étape

**[IntelliJ IDEA — Configuration Contexte](intellij-contexte.md)** : exploiter l'analyse sémantique profonde (PSI) d'IntelliJ pour offrir à Copilot un contexte ultra-riche et des suggestions précises.

Concepts clés couverts :

- **Analyse PSI native** — Avantage unique d'IntelliJ pour les langages JVM
- **Structure de projet recommandée** — Maven, Gradle, multi-modules
- **Marquage des dossiers** — Sources, Tests, Resources, Excluded
- **Fichiers importants** — `pom.xml`, `build.gradle`, `application.yml`, Javadoc

**[VS Code — Configuration Contexte](vscode-contexte.md)** : structurer votre projet VS Code pour offrir à Copilot le meilleur contexte possible et la meilleure expérience utilisateur.

Concepts clés couverts :

- **Instructions personnelles et par repository** — Personal-level vs Repository-level
- **Arborescence optimale** — Structurer `.github/`, `src/`, composants pour VS Code
- **Custom instructions officielles** — Niveaux de configuration et priorités
- **Exemple complet** — Projet MERN avec instructions, patterns et conventions

