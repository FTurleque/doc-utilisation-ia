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

    Prompts efficaces, quand accepter/refuser, itératives avec Copilot, diagrammes workflows

- :material-code-tags: **[Organisation du Code](organisation-code.md)**

    Nommage descriptif, typage explicite, séparation responsabilités, pyramide efficacité

- :material-lightning-bolt: **[Productivité](productivite.md)**

    Raccourcis essentiels, 3 modes (Inline/Chat/Panel), workflows optimisés

- :material-shield-check: **[Sécurité & Qualité](securite-qualite.md)**

    Checklist validation, vulnérabilités courantes, patterns validation (Zod/Pydantic)

- :material-speedometer: **[Performance & Ressources](performance.md)**

    Impact IDE, optimisation, throttling contextuel, désactivation sélective

</div>

---

## Principes Fondamentaux

| Principe | Impact | Détail |
|----------|--------|--------|
| **Context is King** | ⭐⭐⭐⭐⭐ | Code clair = suggestions parfaites |
| **Always Verify** | ⭐⭐⭐⭐⭐ | Vous êtes responsable du commit |
| **Type Everything** | ⭐⭐⭐⭐⭐ | Types = guide pour Copilot |
| **Tests First** | ⭐⭐⭐⭐ | TDD améliore qualité suggestions |
| **Security Review** | ⭐⭐⭐⭐ | SQL/Secrets/XSS check mandatory |

---

!!! tip "Par où commencer ?"
    **Débutant** → [Utilisation Effective](utilisation-effective.md)  
    **Intermédiaire** → [Organisation Code](organisation-code.md)  
    **Avancé** → [Sécurité & Qualité](securite-qualite.md)
