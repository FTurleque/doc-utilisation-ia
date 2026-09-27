# IntelliJ IDEA — Contexte & intégration Claude Code

<span class="badge-intellij">IntelliJ IDEA</span> <span class="badge-intermediate">Intermédiaire</span>

## Présentation

Claude Code s'intègre aux IDE JetBrains via un plugin dédié. Contrairement à l'extension VS Code, le plugin JetBrains **n'embarque pas la CLI** : le binaire `claude` doit être installé et accessible.

L'intégration apporte notamment :

- lancement rapide depuis l'IDE ;
- diffs dans le viewer JetBrains ;
- partage de la sélection courante ;
- références de fichiers avec plages de lignes ;
- diagnostics IDE transmis à Claude ;
- connexion depuis un terminal externe avec `/ide`.

---

## Architecture de l'intégration

```text
IntelliJ / JetBrains
      ↕
Plugin Claude Code
      ↕
CLI `claude`
      ↕
CLAUDE.md + .claude/ + MCP + Git
```

Le plugin lance ou connecte la CLI et expose un serveur MCP IDE local utilisé pour les diffs, la sélection et les diagnostics.

!!! warning "CLI requise"
    Si `claude` n'est pas dans le `PATH`, le plugin ne peut pas fonctionner correctement. Configurez le chemin explicite dans **Settings → Tools → Claude Code** si nécessaire.

---

## Contexte partagé par l'IDE

Quand l'intégration est active, Claude peut recevoir automatiquement :

- la sélection courante ;
- le chemin du fichier actif ;
- les diagnostics de syntaxe/lint de l'IDE ;
- les références `@fichier#Lx-Ly` ;
- les instructions et règles Claude du projet.

### Protéger les fichiers sensibles

Le partage de sélection respecte les règles de permission `Read`. Pour un fichier sensible, utilisez une règle `deny` dans la configuration Claude plutôt que de compter uniquement sur l'indexation IDE.

Exemple :

```json
{
  "permissions": {
    "deny": [
      "Read(./.env)",
      "Read(./secrets/**)"
    ]
  }
}
```

---

## Structure projet recommandée

```text
mon-projet/
├── CLAUDE.md
├── .claude/
│   ├── settings.json
│   ├── rules/
│   │   ├── java.md
│   │   ├── tests.md
│   │   └── security.md
│   ├── skills/
│   └── agents/
├── pom.xml / build.gradle.kts
├── src/
│   ├── main/
│   └── test/
└── README.md
```

Pour les projets Java/Kotlin, une structure Maven/Gradle propre et des conventions explicites dans `CLAUDE.md` ou `.claude/rules/` donnent à Claude un contexte beaucoup plus fiable qu'une longue conversation implicite.

---

## Exemple de rule Java ciblée

```markdown
---
paths:
  - "src/main/java/**/*.java"
  - "src/test/java/**/*.java"
---

# Java / Spring

- Java 21 et Spring Boot 3.
- Injection par constructeur uniquement.
- DTOs aux frontières HTTP ; ne pas exposer directement les entités JPA.
- Tests JUnit 5.
- Exécuter les tests ciblés après chaque modification.
```

---

## Démarrer Claude dans IntelliJ

### Depuis le terminal intégré

```bash
cd mon-projet
claude
```

Lorsque Claude est lancé depuis le terminal intégré, les fonctions IDE sont activées automatiquement.

### Depuis un terminal externe

```text
claude
/ide
```

`/ide` connecte la session au JetBrains ouvert. Lancez Claude depuis la même racine de projet pour éviter les ambiguïtés de fichiers.

---

## Diff viewer et diagnostics

Une fois connecté :

- Claude peut afficher les changements dans le diff viewer JetBrains ;
- les erreurs de syntaxe et diagnostics IDE sont partagés comme contexte ;
- le raccourci de référence fichier permet d'insérer des références précises avec lignes.

Dans `/config`, le réglage **Diff tool** permet de choisir entre le viewer IDE et le terminal lorsque l'IDE est connecté.

---

## IntelliJ : avantage structurel sur les projets JVM

IntelliJ apporte une excellente compréhension locale des projets Java/Kotlin : modules, types, symboles, Maven/Gradle, inspections et diagnostics.

Claude ne doit toutefois pas être décrit comme lisant « tout l'index IntelliJ ». Ce qui est documenté explicitement est le partage de sélection, de fichier actif, de diagnostics et l'intégration via le serveur MCP IDE.

Le bon modèle mental : **IntelliJ améliore fortement votre environnement de travail ; les fichiers d'instructions et les références explicites restent la source de vérité pour Claude.**

---

## Sécurité

Anthropic recommande une prudence supplémentaire avec les modes d'acceptation automatique dans JetBrains, car Claude peut modifier des fichiers de configuration IDE susceptibles d'être exécutés ensuite.

Pour les dépôts sensibles :

- privilégier l'approbation manuelle ;
- restreindre `Read`, `Write`, `Bash` et MCP ;
- auditer `.idea/`, scripts et fichiers de build modifiés ;
- éviter de charger des prompts non fiables dans une session disposant de permissions larges.

---

## WSL et remote development

Quelques particularités :

- en Remote Development, le plugin doit être installé sur l'hôte distant ;
- avec WSL, configurez la commande Claude du plugin vers votre distribution si nécessaire ;
- `/ide` peut nécessiter un ajustement réseau/firewall en WSL2 si l'IDE Windows n'est pas détecté.

Ces détails évoluent : consultez la page JetBrains officielle Claude avant de déployer une configuration d'équipe.

---

## GitHub Copilot — référence conservée

Les équipes utilisant encore Copilot dans IntelliJ peuvent conserver :

- `.github/copilot-instructions.md` ;
- `.github/instructions/` ;
- `.github/prompts/` ;
- `.github/agents/` ;
- les agent skills supportés par leur version du plugin.

La matrice officielle GitHub doit être consultée pour distinguer les fonctions stables et celles en preview.

---

## Sources

- [Claude Code — JetBrains IDEs](https://code.claude.com/docs/en/jetbrains) — consulté le 2026-09-28
- [Claude Code — Memory & rules](https://code.claude.com/docs/en/memory) — consulté le 2026-09-28
- [GitHub Docs — Copilot feature matrix](https://docs.github.com/en/copilot/reference/copilot-feature-matrix) — consulté le 2026-09-28

## Prochaine étape

**[Comparaison des contextes IDE](comparaison-contexte.md)** : choisir le bon point d'entrée Claude selon votre stack et votre workflow.