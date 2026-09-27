# VS Code — Contexte & personnalisation avec Claude Code

<span class="badge-vscode">VS Code</span> <span class="badge-intermediate">Intermédiaire</span>

## Présentation

VS Code est aujourd'hui une des interfaces principales de Claude Code. L'extension officielle fournit un panneau natif avec diffs, plan mode, références `@`, historique de sessions et gestion du contexte.

!!! info "Extension et CLI : deux usages complémentaires"
    L'extension VS Code embarque sa propre CLI pour le panneau Claude. Vous n'avez besoin de la CLI standalone que si vous voulez aussi lancer `claude` depuis le terminal intégré.

---

## Le contexte dans VS Code

Claude peut recevoir du contexte depuis plusieurs sources :

- le texte sélectionné dans l'éditeur ;
- des fichiers ou dossiers référencés avec `@` ;
- `CLAUDE.md`, `AGENTS.md` et `.claude/rules/` ;
- les skills, subagents et MCP utilisés pendant la tâche ;
- l'historique de la session ;
- les sorties d'outils exécutés par Claude.

```text
Sélection / @fichier / @dossier
          +
CLAUDE.md + .claude/rules/
          +
Historique + outils + MCP
          ↓
Contexte de la session Claude
```

### Référencer précisément

Exemples :

```text
Explique @src/auth/session.ts.
Compare @src/auth/ avec @src/security/.
```

Une sélection de code dans l'éditeur est également visible par Claude. L'extension peut insérer une référence avec chemin et plages de lignes.

---

## Structure Claude-first recommandée

```text
mon-projet/
├── CLAUDE.md
├── AGENTS.md                       # optionnel, partagé multi-agents
├── .claude/
│   ├── settings.json
│   ├── rules/
│   │   ├── frontend.md
│   │   ├── tests.md
│   │   └── security.md
│   ├── skills/
│   │   └── code-review/SKILL.md
│   └── agents/
│       └── security-reviewer.md
├── .mcp.json                       # si MCP partagé au projet
├── .vscode/
│   ├── settings.json
│   └── extensions.json
└── src/
```

### Exemple de rule ciblée

```markdown
---
paths:
  - "src/**/*.{ts,tsx}"
---

# Frontend TypeScript

- TypeScript strict.
- Réutiliser les composants existants avant d'en créer de nouveaux.
- Exécuter les tests ciblés après modification.
```

---

## Plan mode et contrôle des modifications

L'extension VS Code propose plusieurs modes de permissions, dont :

- **Plan** : Claude explore et prépare un plan avant modification ;
- **Manual** : validation explicite avant les modifications/actions concernées ;
- **Edit automatically** / modes automatiques selon le plan et la configuration.

Pour les changements multi-fichiers ou mal définis, utilisez :

1. Explore ;
2. Plan ;
3. Implement ;
4. Verify.

Le plan peut être revu dans l'éditeur avant l'implémentation.

---

## Gérer le budget de contexte

Le panneau Claude affiche l'utilisation du contexte. Quelques réflexes :

- `/clear` entre deux tâches sans rapport ;
- `/compact` pour résumer une session longue ;
- utiliser des subagents pour les recherches volumineuses ;
- préférer `@fichier` ou `@dossier` ciblé à une exploration sans limites ;
- garder `CLAUDE.md` court et stable.

!!! tip "Question secondaire sans polluer la session"
    Les versions récentes proposent aussi `/btw` pour poser une question latérale sans l'ajouter à l'historique principal.

---

## Plusieurs sessions

VS Code permet d'ouvrir plusieurs conversations Claude dans des onglets ou fenêtres séparés. Chaque session conserve son propre historique et son propre contexte.

Utilisez cette séparation pour :

- implémentation principale ;
- investigation indépendante ;
- comparaison d'approches ;
- revue ou diagnostic sans polluer la session principale.

---

## MCP, plugins et outils externes

L'extension partage la configuration Claude Code avec le CLI :

- MCP pour les outils/sources externes ;
- plugins ;
- skills ;
- hooks ;
- permissions.

Les outils externes doivent rester minimaux : chaque serveur MCP ou outil supplémentaire augmente la surface d'action et peut ajouter du contexte.

---

## GitHub Copilot — référence conservée

Si Copilot reste installé dans VS Code, conservez ses fichiers propres :

```text
.github/
├── copilot-instructions.md
├── instructions/
├── prompts/
├── agents/
└── skills/
```

VS Code sait aujourd'hui gérer plusieurs formats de personnalisation selon le harness sélectionné : Copilot utilise notamment `.github/copilot-instructions.md` et `*.instructions.md`, tandis que Claude utilise `CLAUDE.md` et `.claude/rules/`.

!!! warning "Évitez les règles contradictoires"
    Si Claude et Copilot cohabitent, gardez les conventions métier communes alignées entre les deux arborescences.

---

## Sources

- [Claude Code — VS Code](https://code.claude.com/docs/en/vs-code) — consulté le 2026-09-28
- [Claude Code — Memory & rules](https://code.claude.com/docs/en/memory) — consulté le 2026-09-28
- [VS Code — Custom instructions](https://code.visualstudio.com/docs/agent-customization/custom-instructions) — consulté le 2026-09-28

## Prochaine étape

**[IntelliJ IDEA — Contexte Claude](intellij-contexte.md)** : adapter le même modèle Claude-first aux projets JetBrains, notamment Java/Kotlin.