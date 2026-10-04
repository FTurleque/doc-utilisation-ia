# Comparaison — Claude Code dans VS Code et IntelliJ IDEA

<span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span>

## Présentation

Claude Code fonctionne dans les deux environnements, mais l'intégration n'est pas identique.

- **VS Code** : interface graphique Claude Code native recommandée, avec CLI embarquée pour le panneau.
- **JetBrains / IntelliJ** : plugin relié à la CLI `claude`, qui doit être installée séparément.

Les deux partagent le même socle projet : `CLAUDE.md`, `.claude/`, skills, subagents, hooks, permissions et MCP.

---

## Comparaison rapide

| Axe | VS Code | IntelliJ IDEA / JetBrains |
|---|---|---|
| Interface Claude dédiée | ✅ Panneau natif | ✅ Plugin + terminal/CLI |
| CLI standalone obligatoire | ❌ Pour le panneau ; ✅ pour `claude` dans le terminal | ✅ Oui |
| Sélection éditeur comme contexte | ✅ | ✅ |
| Références `@fichier` | ✅ | ✅ |
| Diff dans l'IDE | ✅ | ✅ |
| Diagnostics IDE partagés | ✅ | ✅ |
| Plan mode | ✅ Interface dédiée | ✅ Via Claude Code CLI |
| Sessions multiples | ✅ Très intégrées à l'UI | ⚠️ Principalement via sessions CLI |
| `CLAUDE.md` / `.claude/rules/` | ✅ | ✅ |
| Skills / subagents / hooks / MCP | ✅ | ✅ via le même moteur Claude Code |
| Forces particulières | Gestion visuelle des sessions et plans | Écosystème JVM, inspections et navigation JetBrains |

---

## Ce qui doit rester portable

Évitez de mettre les règles essentielles uniquement dans les réglages d'un IDE. La configuration d'équipe doit vivre dans le dépôt :

```text
CLAUDE.md
.claude/settings.json
.claude/rules/
.claude/skills/
.claude/agents/
.mcp.json                # si configuration MCP partagée
```

Ainsi, le même comportement suit l'équipe entre terminal, VS Code et JetBrains.

---

## VS Code : quand le privilégier

VS Code est particulièrement pratique si vous voulez :

- un panneau Claude natif ;
- réviser visuellement un plan avant implémentation ;
- gérer plusieurs conversations en onglets/fenêtres ;
- surveiller le contexte depuis l'interface ;
- gérer plugins et sessions depuis une UI dédiée.

Pour un nouvel utilisateur Claude Code qui travaille déjà dans VS Code, c'est le point d'entrée le plus simple.

---

## IntelliJ : quand le privilégier

IntelliJ/JetBrains reste naturel pour :

- Java, Kotlin et Spring ;
- projets Maven/Gradle complexes ;
- diagnostics et inspections JetBrains ;
- équipes qui veulent conserver leur IDE principal tout en utilisant Claude Code.

Le plugin partage avec Claude la sélection, le fichier actif et les diagnostics, tout en utilisant le diff viewer de l'IDE.

!!! warning "Ne confondez pas contexte IDE et instructions projet"
    La richesse d'un IDE ne remplace pas `CLAUDE.md` ou les rules. Les conventions métier importantes doivent être écrites et versionnées.

---

## Stratégie commune recommandée

Quel que soit l'IDE :

1. démarrer avec un `CLAUDE.md` concis ;
2. placer les règles ciblées dans `.claude/rules/` ;
3. utiliser des skills pour les procédures à la demande ;
4. utiliser des subagents pour l'exploration volumineuse ;
5. fournir une validation exécutable : tests, build, lint, captures ;
6. utiliser `/clear` entre tâches indépendantes ;
7. restreindre les permissions et MCP au strict nécessaire.

---

## Recommandation de maintenance de la documentation

Les pages génériques doivent décrire le **moteur Claude Code et ses fichiers versionnés**. Les différences d'IDE doivent se limiter à l'interface, au lancement, aux raccourcis et aux capacités d'intégration spécifiques.

Cette séparation évite de dupliquer les mêmes règles dans trois pages et facilite les futures mises à jour.

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-4-contexte.md#page-chapitre-4-contexte-comparaison-contexte).

## Prochaine étape

Poursuivez avec **[Prompt Engineering — Accueil](../chapitre-5-prompt-engineering/index.md)**, la page suivante dans le menu.

## Sources

- [Claude Code — VS Code](https://code.claude.com/docs/en/vs-code) — consulté le 2026-09-28
- [Claude Code — JetBrains](https://code.claude.com/docs/en/jetbrains) — consulté le 2026-09-28
- [Claude Code — Best practices](https://code.claude.com/docs/en/best-practices) — consulté le 2026-09-28
## Chapitre suivant

**[Prompt Engineering](../chapitre-5-prompt-engineering/index.md)** : appliquer ces mécanismes de contexte à des demandes plus précises, vérifiables et économiques.
