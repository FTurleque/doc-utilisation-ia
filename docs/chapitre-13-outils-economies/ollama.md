# Ollama

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span>

Ollama permet d'exécuter des modèles de langage en local, via une CLI et une API HTTP.
C'est la base la plus simple pour une stratégie "local-first" sans coût API.

---

## À quoi sert Ollama

- Exécuter des LLM en local pour le chat et l'aide au code
- Exposer une API locale pour des outils comme Continue.dev
- Protéger les données sensibles en évitant l'envoi vers un service cloud

!!! success "Quand l'utiliser"
    Ollama est idéal pour les tâches légères à moyennes : explication de code, génération de brouillons, documentation, tests unitaires simples.

---

## Quand l'utiliser

- Quand tu veux une base 100% locale.
- Quand tu veux protéger des données sensibles.
- Quand tu veux alimenter Continue.dev avec un modèle local.

## Quand l'éviter

- Quand tu n'as pas assez de RAM pour le modèle choisi.
- Quand tu veux une solution purement GUI sans CLI.
- Quand tu as besoin d'un modèle cloud très spécialisé.

---

## Mise en œuvre

### Installation

=== "Windows"
    1. Télécharger l'installeur officiel sur ollama.com.
    2. Installer puis vérifier que la commande `ollama` fonctionne.
    3. Lancer un premier modèle.

=== "macOS / Linux"
    1. Suivre l'installation officielle.
    2. Lancer un modèle de test.

### Commandes de base

```powershell
ollama run mistral
ollama run qwen2.5-coder:7b
ollama serve
```

### Connexion avec d'autres outils

- **[Continue.dev](continue-dev.md)**: provider `ollama`, endpoint `http://localhost:11434`
- **RTK**: filtrer logs/tests avant de les soumettre au modèle
- Outils locaux scripts/CLI via API REST Ollama

---

## Cas d'usage pertinents

- **Chat technique local**: comprendre un message d'erreur ou un bout de code
- **Boilerplate**: générer des classes, DTO, scripts répétitifs
- **Refactoring assisté**: proposer une version plus lisible d'une méthode
- **Documentation interne**: produire une première version de sections Markdown

Cas moins adaptés:

- Raisonnement architecture très complexe
- Requêtes nécessitant des connaissances fraîches en ligne sans source fournie

---

## Exploiter son plein potentiel

1. **Choisir le bon modèle pour la tâche**
   - Petit modèle pour vitesse
   - Modèle code-spécialisé pour génération/refactoring
2. **Standardiser en équipe**
   - Définir 2 ou 3 modèles valides par cas d'usage
3. **Maîtriser le contexte**
   - Envoyer des extraits ciblés au lieu de fichiers entiers
4. **Mesurer la valeur**
   - Suivre le ratio "temps gagné / corrections manuelles"

!!! warning "Point de vigilance"
    La performance dépend fortement de la RAM/CPU/GPU et du modèle choisi. Toujours tester sur des prompts réels de l'équipe.

---

## Exemples concrets

```text
Prompt local:
"Explique cette fonction TypeScript et propose une version plus testable
sans changer la signature publique."
```

```powershell
# Extraire uniquement les erreurs de test avant analyse locale
rtk npm test
```

---

## Résumé

Ollama est la brique locale la plus simple pour transformer un poste de
développement en environnement IA hors cloud. Il devient encore plus utile
quand il alimente Continue.dev ou un autre client IDE.

---

## Sources

- Site officiel: [ollama.com](https://ollama.com/) (consulté le 2026-06-07)
- Installation officielle: [Download Ollama](https://ollama.com/download) (consulté le 2026-06-07)
- Bibliothèque de modèles: [Ollama Library](https://ollama.com/library) (consulté le 2026-06-07)
- Dépôt officiel: [ollama/ollama](https://github.com/ollama/ollama) (consulté le 2026-06-07)

---

## Prochaine étape

**[LM Studio](lm-studio.md)** : utiliser une interface graphique locale pour télécharger, tester et servir des modèles sans passer par la CLI.

Concepts clés couverts :

- **Interface graphique** - démarrage rapide pour débuter
- **Serveur local** - endpoint compatible outils IDE
- **Comparaison locale** - tester plusieurs modèles facilement
- **Workflow hybride** - combiner LM Studio avec Continue.dev
