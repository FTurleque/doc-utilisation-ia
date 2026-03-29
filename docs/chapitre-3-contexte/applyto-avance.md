# applyTo Avancé

<span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span> <span class="badge-expert">Expert</span>

Guide pratique pour écrire des motifs `applyTo` robustes dans les fichiers `.instructions.md`.

---

## Rappels rapides

- `*` : correspond à des caractères dans un seul niveau
- `**` : récursif sur plusieurs niveaux
- `**/*.ext` : tous les fichiers d'une extension partout

---

## Exemples réels de front matter

```yaml
---
applyTo: ['*']
description: "Comprehensive best practices for adopting new Java 25 features since the release of Java 21."
---
```

```yaml
---
description: 'Guidance for CentOS administration, RHEL-compatible tooling, and SELinux-aware operations.'
applyTo: '**'
---
```

```yaml
---
description: 'Guidelines for creating high-quality Agent Skills for GitHub Copilot'
applyTo: '**/.github/skills/**/SKILL.md, **/.claude/skills/**/SKILL.md'
---
```

```yaml
---
description: 'Step-by-step guide for converting Spring Boot JPA applications to use Azure Cosmos DB with Spring Data Cosmos'
applyTo: '**/*.java,**/pom.xml,**/build.gradle,**/application*.properties'
---
```

```yaml
---
applyTo: '**.cs, **.csproj'
description: 'This file provides guidance on building C# applications using GitHub Copilot SDK.'
name: 'GitHub Copilot SDK C# Instructions'
---
```

---

## Motifs utiles par cas

| Objectif | Pattern |
|----------|---------|
| Tout le repo | `**` |
| Tous les YAML | `**/*.yaml` |
| Tous les Java | `**/*.java` |
| Tous les tests TS | `**/*.test.ts,**/*.spec.ts` |
| Modules API | `src/api/**` |
| Skills uniquement | `**/.github/skills/**/SKILL.md` |

---

## Points d'attention

- Combinez plusieurs motifs avec des virgules.
- Les dotfiles peuvent nécessiter des motifs explicites.
- La casse peut varier selon l'OS/outillage.
- Préférez toujours `/` comme séparateur.
- Vérifiez le comportement sur un petit lot de fichiers avant généralisation.

---

## Erreurs fréquentes

1. Pattern trop large (`**`) pour une règle spécifique
2. Oubli d'une extension (`.tsx` oubliée dans un projet React)
3. Espaces mal placés dans la liste des motifs
4. Règles contradictoires entre global et ciblé

---

## Stratégie recommandée

1. Commencer avec une règle ciblée
2. Tester sur 2-3 fichiers représentatifs
3. Élargir progressivement si le résultat est stable
4. Documenter le but de chaque pattern dans `description`

---

## Prochaines étapes

- [Prompt Files (.prompt.md)](prompt-files.md) — Prompts réutilisables pour des tâches récurrentes
- [Guide Agents (.agent.md)](guide-agents.md) — Agents IA custom avec comportements spécialisés
- [Guide Skills (SKILL.md)](guide-skills.md) — Packages de connaissance domaine pour les agents
