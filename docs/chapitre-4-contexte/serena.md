# Serena — code intelligence sémantique pour les agents

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span>

**Serena** est un toolkit de code intelligence orienté agents. Il expose des opérations proches de celles d'un IDE — recherche de symboles, références, édition symbolique, refactoring et diagnostics — et peut être connecté à Claude Code via **MCP**.

Sa place principale dans cette documentation est **Contexte & Personnalisation** : Serena sert surtout à fournir à l'agent un contexte de code plus précis et des opérations sémantiques plus sûres que des recherches textuelles ou des remplacements par lignes.

!!! info "Vérifié le 1er octobre 2026"
    Cette page s'appuie sur le dépôt et la documentation officiels Serena. Le projet déconseille explicitement les commandes d'installation copiées depuis certains marketplaces MCP et recommande de suivre son Quick Start officiel.

---

## Ce que Serena apporte

Serena travaille au niveau des **symboles et relations de code** plutôt qu'au niveau de simples lignes de texte.

Fonctions principales documentées par le projet :

- retrouver un symbole et obtenir une vue d'ensemble d'un fichier ;
- retrouver les symboles qui référencent un élément ;
- naviguer vers déclarations et implémentations selon les capacités du backend ;
- remplacer le corps d'un symbole ou insérer du code avant/après celui-ci ;
- renommer des symboles ;
- supprimer des éléments avec des opérations adaptées au code ;
- exploiter diagnostics et inspections ;
- mémoriser des informations de projet entre sessions si ce mécanisme est activé.

Le backend gratuit par défaut repose sur des **language servers / LSP**. Serena propose aussi un plugin JetBrains payant qui exploite les capacités d'analyse et de refactoring de l'IDE.

---

## Architecture avec Claude Code

```text
Claude Code
    │
    ├── outils natifs : fichiers, recherche, shell
    │
    └── MCP
         └── Serena
              ├── LSP / language servers
              └── ou plugin JetBrains
                    ↓
              symboles / références / refactorings
```

Claude reste responsable du raisonnement et de l'orchestration. Serena fournit les **outils sémantiques**.

---

## Installation actuelle

Le projet recommande `uv` puis l'installation de `serena-agent` :

```bash
uv tool install -p 3.13 serena-agent
serena init
```

L'initialisation configure par défaut le backend language server. Des dépendances supplémentaires peuvent être nécessaires selon les langages utilisés.

Pour Claude Code, utilisez ensuite la procédure client/MCP maintenue par Serena plutôt qu'une configuration recopiée depuis un marketplace tiers.

!!! warning "Ne figez pas une commande MCP trouvée ailleurs"
    Serena indique que certains marketplaces contiennent des commandes obsolètes. Vérifiez le Quick Start et la page de configuration des clients au moment de l'installation.

---

## Serena, Semble ou Graphify ?

Ces trois outils sont complémentaires plutôt qu'interchangeables.

| Besoin | Outil le plus naturel |
|---|---|
| recherche sémantique très rapide de snippets | [Semble](semble.md) |
| opérations IDE/symboles/références/refactoring | **Serena** |
| cartographier des relations sous forme de knowledge graph | [Graphify](graphify.md) |
| recherche textuelle exacte | `rg`, IDE ou recherche native |

### Exemple

Pour une question « où est gérée l'authentification ? » :

- **Semble** peut retrouver rapidement les snippets les plus pertinents ;
- **Serena** peut ensuite naviguer vers les symboles et leurs références ou effectuer un refactoring précis ;
- **Graphify** est utile si vous devez comprendre les relations entre plusieurs composants, documents ou configurations.

---

## Quand Serena est particulièrement utile

- monorepo ou codebase volumineuse ;
- refactorings multi-fichiers ;
- navigation de symboles difficile à reproduire avec `grep` ;
- besoin de rechercher les références avant modification ;
- agent connecté à un langage disposant d'un bon language server ;
- workflow JetBrains où les inspections et refactorings IDE sont importants.

Pour une modification triviale dans un fichier connu, les outils natifs de Claude Code peuvent suffire. Ajouter Serena n'est pas une obligation.

---

## Sécurité et gouvernance

Serena peut exposer des outils qui **modifient le code** et, selon la configuration, des utilitaires supplémentaires.

Bonnes pratiques :

1. n'activez que les outils nécessaires au workflow ;
2. conservez Git comme source de vérité et relisez le diff ;
3. exécutez tests, build et analyse statique après un refactoring ;
4. versionnez uniquement la configuration projet qui doit être partagée ;
5. vérifiez la provenance et la licence des language servers utilisés ;
6. n'accordez pas de capacités shell supplémentaires si Claude Code les fournit déjà et qu'elles ne sont pas nécessaires.

---

## Sources

Sources consultées le **1er octobre 2026** :

- [Serena — dépôt officiel](https://github.com/oraios/serena)
- [Serena — documentation](https://oraios.github.io/serena/)
- [Serena — outils](https://oraios.github.io/serena/01-about/035_tools.html)
- [Serena — configuration des clients](https://oraios.github.io/serena/02-usage/030_clients.html)

## Prochaine étape

Poursuivez avec **[Graphify — Knowledge Graph](graphify.md)**, la page suivante dans le menu.
