# Bonnes Pratiques avec GitHub Copilot

Installer et configurer Copilot, c'est bien. L'utiliser efficacement au quotidien, c'est mieux. Ce chapitre rassemble les bonnes pratiques pour tirer le maximum de GitHub Copilot tout en maintenant qualité, sécurité et productivité.

---

## Pyramide d'Efficacité Copilot

```
                        ▲
                       ╱ ╲  Nommage + Typage
                      ╱   ╱ + Structure claire
                     ╱───╱  + Commentaires
                    ╱   ╱   + Custom Instructions
                   ╱───╱    + Validation Tests
                  ╱   ╱     + IDE Optimisé
                 ╱───╱
```

À chaque niveau, l'efficacité Copilot +20-30%. **Sans base** : 40% accuracy. **Avec base solide** : 95%+ accuracy.

---

## Pages du Chapitre

<div class="grid cards" markdown>

- :material-comment-text: **[Utilisation Effective](utilisation-effective.md)**

    Prompts efficaces, slash commands, variables de contexte (`#file`, `@workspace`), NES, Copilot Edits

- :material-code-tags: **[Organisation du Code](organisation-code.md)**

    Nommage descriptif, typage explicite, `COPILOT.md`, `copilot-instructions.md`, gestion de la context window

- :material-lightning-bolt: **[Productivité](productivite.md)**

    Raccourcis essentiels, context window, Workflow Edits multi-fichiers, Agent mode autonome

- :material-shield-check: **[Sécurité & Qualité](securite-qualite.md)**

    Checklist validation, hallucinations d'API, packages inventés, sur-ingénierie silencieuse

- :material-speedometer: **[Performance & Ressources](performance.md)**

    Impact IDE, optimisation, throttling contextuel, désactivation sélective

- :material-routes: **[Workflows IA Complets](workflows-ia.md)**

    PRD-Driven Dev, TDD assisté, sprint planning, code review, refactoring progressif, débogage

</div>

---

## Principes Fondamentaux

| Principe | Impact | Détail |
|----------|--------|--------|
| **Context is King** | ⭐⭐⭐⭐⭐ | Code clair = suggestions parfaites |
| **Always Verify** | ⭐⭐⭐⭐⭐ | Vous êtes responsable du commit |
| **Type Everything** | ⭐⭐⭐⭐⭐ | Types = guide pour Copilot |
| **Tests First** | ⭐⭐⭐⭐ | TDD améliore qualité suggestions |
| **Security Review** | ⭐⭐⭐⭐ | SQL/Secrets/XSS/hallucinations check mandatory |
| **Context Config** | ⭐⭐⭐⭐ | `copilot-instructions.md` + `COPILOT.md` = contexte persistant |
| **Iterate Fast** | ⭐⭐⭐⭐ | Tours courts + validation à chaque étape = meilleur résultat |

---

!!! tip "Par où commencer ?"
    **Débutant** → [Utilisation Effective](utilisation-effective.md) — Slash commands, PRD, variables de contexte  
    **Intermédiaire** → [Organisation du Code](organisation-code.md) — Configurer le contexte IA du projet  
    **Avancé** → [Workflows IA Complets](workflows-ia.md) — Cycles de développement bout en bout  
    **Sécurité** → [Sécurité & Qualité](securite-qualite.md) — Hallucinations et risques spécifiques à l'IA
