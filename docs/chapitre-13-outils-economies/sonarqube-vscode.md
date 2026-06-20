# SonarQube — Détecter et corriger sans gaspiller de crédits IA (VS Code)

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-vscode">VS Code</span>

Ce guide donne une version VS Code du workflow SonarQube orienté économie de
crédits IA. L'objectif est identique a la version IntelliJ : corriger d'abord
ce qui est déterministe, puis escalader vers Copilot seulement si nécessaire.

!!! info "Portée de cette page"
    Cette page couvre VS Code. Pour le workflow expert IntelliJ (plus détaillé),
    voir **[SonarQube — version IntelliJ](sonarqube.md)**.

---

## Prérequis

- VS Code installé
- Extension SonarQube for IDE installée
- Projet ouvrable dans VS Code (avec langage supporté)
- Accès SonarQube Cloud/Server et token utilisateur (si Connected Mode)
- RTK disponible pour filtrer les sorties terminal avant analyse IA

!!! tip "Ordre recommandé"
    Détection locale SonarQube -> correction déterministe -> test local ->
    Copilot ciblé en dernier recours.

---

## Étape 1 — Installer l'extension SonarQube for IDE

1. Ouvre le Marketplace des extensions dans VS Code.
2. Recherche `SonarQube for IDE`.
3. Vérifie l'éditeur `SonarSource`.
4. Installe l'extension puis recharge la fenêtre si nécessaire.
5. Ouvre un fichier du projet et vérifie qu'au moins une issue Sonar apparaît.

### Diagnostic rapide si aucune issue ne remonte

- Vérifie que le langage est pris en charge.
- Vérifie les exclusions du workspace.
- Vérifie les paramètres de l'extension.
- Vérifie les logs de l'extension dans VS Code.

---

## Étape 2 — Activer le Connected Mode (optionnel)

Active ce mode si tu veux aligner l'IDE avec les règles et profils qualité de
l'organisation.

1. Ouvre les paramètres de l'extension SonarQube for IDE.
2. Configure la connexion vers SonarQube Cloud ou SonarQube Server.
3. Utilise un token utilisateur avec les droits adaptés.
4. Lie le projet et vérifie la synchronisation des règles.

=== "SonarQube Cloud"
    - Connecte l'organisation SonarQube Cloud.
    - Vérifie que le projet est bien lié.

=== "SonarQube Server"
    - Renseigne l'URL du serveur.
    - Vérifie le bind et la synchronisation des profils.

!!! danger "Secrets"
    Ne stocke jamais de token dans Git, dans un prompt, ou dans une capture.

---

## Étape 3 — Workflow économique recommande

```text
Detecter sans IA
-> corriger sans IA
-> compiler/tester
-> escalader vers Copilot cible
```

### Niveau 0 — Détection locale

- Lire les issues Sonar dans l'éditeur.
- Prioriser par sévérité et par règle.
- Regrouper les corrections déterministes.

### Niveau 1 — Correction déterministe

- Utiliser les quick fixes VS Code/Sonar quand disponibles.
- Appliquer une correction minimale.
- Valider immédiatement avec build et tests.

### Niveau 2 — Copilot ciblé

- Limiter le périmètre a une règle, un fichier, une méthode.
- Donner le message Sonar exact.
- Interdire les modifications hors périmètre.

!!! warning "Signal de surconsommation"
    Si tu envoies des logs bruts ou des rapports complets au chat, le coût grimpe
    vite. Filtre d'abord avec RTK, `rg`, et des extraits ciblés.

---

## Matrice de décision rapide

| Situation | Premier reflexe | IA nécessaire ? | Action |
|---|---|---|---|
| Issue locale simple | Quick fix Sonar/éditeur | Non | Corriger puis tester |
| Même règle sur plusieurs fichiers | Lot borné par règle | Optionnelle | Corriger en petits lots |
| Cas ambigu métier | Copilot ciblé | Oui | Prompt minimal + validation |
| Multi-fichiers complexes | Copilot Agent/MCP borné | Oui | Planifier, valider à chaque étape |

---

## Limites et vigilance

- La couverture des règles varie selon langage, version et contexte.
- Le Connected Mode dépend de l'infrastructure d'équipe.
- L'usage Copilot (chat/agent/MCP) peut consommer des crédits selon le plan.

!!! info "Complémentarité"
    SonarQube cadre les problèmes qualité, RTK réduit le bruit terminal,
    Copilot intervient pour le reliquat complexe.

---

## Sources

- SonarQube for IDE: [Portail documentation](https://docs.sonarsource.com/sonarqube-for-ide/) (vérifié le 2026-06-15)
- SonarQube for IDE pour VS Code: [Documentation dédiée](https://docs.sonarsource.com/sonarqube-for-vs-code/) (vérifié le 2026-06-15)
- SonarQube MCP Server: [Documentation officielle](https://docs.sonarsource.com/sonarqube-mcp-server/) (vérifié le 2026-06-15)
- GitHub Copilot: [Use MCP in your IDE](https://docs.github.com/en/copilot/how-tos/provide-context/use-mcp-in-your-ide/extend-copilot-chat-with-mcp) (vérifié le 2026-06-15)

---

## Prochaine étape

**[RTK + SonarQube](rtk-sonar.md)** : combiner réduction de bruit terminal et sélection d'issues Sonar pour un flux IA ultra-ciblé.

Concepts clés couverts :

- **Détection d'abord** - réduire les prompts inutiles
- **Connected Mode** - aligner IDE et règles d'équipe
- **Escalade progressive** - VS Code natif puis Copilot ciblé
- **Coût maîtrisé** - contexte borné et validation locale
