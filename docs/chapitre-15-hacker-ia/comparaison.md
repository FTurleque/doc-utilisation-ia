# Comparaison — Sécurité IA pour développeurs (IntelliJ vs VS Code)

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span>

Cette page compare les réflexes de sécurité à appliquer dans les deux IDE quand tu utilises des assistants IA de code et des agents capables de modifier ton projet.

---

## Tableau comparatif

| Critère | IntelliJ IDEA | Visual Studio Code |
|---|---|---|
| Gouvernance des extensions | Marketplace JetBrains + politiques entreprise | Marketplace VS Code + politiques de workspace |
| Contrôle des actions agentiques | Dépend des plugins et politiques du poste | Très flexible, nécessite cadrage explicite |
| Durcissement du poste | Forte adoption en environnements entreprise | Très répandu, parfois plus hétérogène |
| Risque principal observé | Confiance excessive dans les suggestions | Multiplication d'extensions et permissions |
| Priorité sécurité | Revue de code et pipeline obligatoire | Permissions, isolation, confirmations et logs |

---

## Réglages défensifs recommandés

=== "IntelliJ IDEA"
    ### Baseline sécurité

    - Restreindre l'installation de plugins aux sources approuvées
    - Activer les inspections de sécurité et la quality gate CI
    - Exiger une revue humaine pour toute modification critique générée

    !!! tip "Pratique équipe"
        Formalise une checklist PR dédiée aux changements assistés par IA.

=== "Visual Studio Code"
    ### Baseline sécurité

    - Réduire le nombre d'extensions actives au strict nécessaire
    - Contrôler les permissions des agents et outils terminal
    - Activer les confirmations sur commandes à impact

    !!! tip "Pratique équipe"
        Standardise la configuration de sécurité via templates de workspace et politiques d'organisation.

---

## Bonnes pratiques communes

- Appliquer le principe du moindre privilège
- Ne jamais exposer de secrets dans le contexte IA
- Scanner dépendances et code généré avant fusion
- Garder des journaux d'audit des actions automatisées
- Simuler des scénarios d'ingénierie sociale tous les trimestres

---

## Quand choisir quoi

| Contexte | Recommandation |
|---|---|
| Équipe fortement standardisée, gouvernance stricte | IntelliJ peut être plus simple à homogénéiser |
| Équipe multi-outils, besoin d'agilité et d'automatisation | VS Code est puissant mais exige une politique de sécurité claire |
| Projet critique (finance, santé, infra) | Le choix de l'IDE compte moins que la discipline de revue et de contrôle |

!!! info "Décision pragmatique"
    Le niveau de sécurité final dépend davantage des garde-fous organisationnels que de l'IDE lui-même.

---

## Exemples concrets de décision

| Situation | Décision recommandée | Justification sécurité |
|---|---|---|
| Projet réglementé avec revue stricte | Standardiser un socle unique par équipe | Réduction des écarts de configuration |
| Forte rotation de contributeurs | Templates de workspace et checklists obligatoires | Réduction du risque humain et des oublis |
| Usage intensif d'agents IA | Permissions minimales + confirmations systématiques | Limiter l'impact des actions automatiques |
| Dépendances sensibles (supply chain) | Bloquer merge sans SCA et validation humaine | Contrôle de provenance et de qualité |

---

## Sources et provenance

- [OWASP Top 10 for LLM Applications](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
- [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)
- [MITRE ATLAS](https://atlas.mitre.org/)
- [CISA AI](https://www.cisa.gov/ai)
- [ANSSI](https://www.ssi.gouv.fr/)

!!! tip "Lecture rapide"
    Utilise OWASP pour les risques applicatifs, NIST pour la gouvernance, MITRE ATLAS pour la modélisation de menace et CISA/ANSSI pour les pratiques opérationnelles.

---

## Chapitres suivants

**[Appendices](../appendices/index.md)** : FAQ, raccourcis, et modèles prêts à l'emploi pour industrialiser tes pratiques.

**[Veille IA](../chapitre-14-veille-ia/index.md)** : reste à jour sur les évolutions sécurité, risques et vulnérabilités.
