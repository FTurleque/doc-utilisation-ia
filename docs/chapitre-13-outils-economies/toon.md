# TOON — Token-Oriented Object Notation

<span class="badge-intermediate">Intermédiaire</span>

**TOON** ([GitHub](https://github.com/toon-format/toon) · [Spécification](https://github.com/toon-format/spec/blob/main/SPEC.md) · [Playground](https://toon-format.github.io/playground)) est un **format de données compact**, lisible par l'humain, qui réduit la consommation de tokens de **40 % par rapport à JSON**. Il combine la structure indentée de YAML avec un format tabulaire style CSV pour les arrays uniformes.

TOON est *lossless* : toute donnée JSON peut être convertie en TOON et reconvertie sans perte.

---

## Pourquoi TOON réduit les premium requests

Quand tu fournis des données à Copilot — configuration, logs, inventaire, données métier — chaque token compte dans la fenêtre de contexte. TOON compacte ces données **sans perte d'information** :

```
JSON (4 587 tokens)  →  TOON (2 759 tokens)  =  -40 % de tokens
```

Moins de tokens dans le contexte = plus de place pour le code, les instructions et les réponses du modèle. Sur des sessions longues avec beaucoup de données, l'économie est significative.

---

## Le format en 2 minutes

### Avant — JSON

```json
{
  "context": {
    "task": "Nos randonnées préférées",
    "location": "Grenoble"
  },
  "hikes": [
    {"id": 1, "name": "Lac Bleu", "distance": 7.5, "companion": "ana"},
    {"id": 2, "name": "Crête du Vercors", "distance": 9.2, "companion": "luis"}
  ]
}
```

### Après — TOON (-40 % de tokens)

```
context:
  task: Nos randonnées préférées
  location: Grenoble
hikes[2]{id,name,distance,companion}:
  1,Lac Bleu,7.5,ana
  2,Crête du Vercors,9.2,luis
```

### Règles de base

| Élément | Syntaxe |
|---------|---------|
| Objets | Indentation (style YAML) |
| Arrays uniformes | `champ[N]{col1,col2,...}:` puis une ligne par item |
| Strings | Sans guillemets (sauf si elles contiennent une `,`) |
| Nombres / booléens | Valeurs directes |

!!! info "Quand `[N]` et `{fields}` brillent"
    La notation `[N]{fields}` permet au LLM de **valider la structure** : il sait qu'il y a exactement N lignes avec ces colonnes. Cela améliore la fiabilité du parsing par rapport à du JSON brut.

---

## Benchmarks

### Tokens et précision LLM

Mesuré sur 209 questions, 4 modèles :

| Format | Tokens | Précision LLM | Gain tokens |
|--------|--------|:--------------:|:-----------:|
| **TOON** | 2 759 | 76,4 % | **-40 %** |
| JSON compact | 3 104 | 73,7 % | -32 % |
| YAML | 3 749 | 74,5 % | -18 % |
| JSON | 4 587 | 75,0 % | — |

!!! success "TOON bat JSON sur les deux axes"
    Moins de tokens **et** meilleure précision LLM. La structure explicite `[N]{fields}` aide les modèles à mieux comprendre les données tabulaires.

### Datasets testés

- Enregistrements employés uniformes (100 items)
- Commandes e-commerce imbriquées (50 items)
- Séries temporelles analytics (60 jours)
- Repositories GitHub (100 repos)
- Logs d'événements semi-uniformes (75 items)
- Configurations profondément imbriquées

---

## Installation

### CLI (sans installation permanente)

```bash
# Convertir un fichier JSON en TOON
npx @toon-format/cli input.json -o output.toon

# Depuis stdin
echo '{"name": "Ada", "role": "dev"}' | npx @toon-format/cli
```

### SDK TypeScript / JavaScript

```bash
npm install @toon-format/toon
# ou
pnpm add @toon-format/toon
```

### Autres langages

| Langage | Package |
|---------|---------|
| TypeScript / JavaScript | `@toon-format/toon` (officiel) |
| Python | `toon-format` |
| Go | `go-toon` |
| Rust | `toon-rs` |
| .NET | `Toon.CSharp` |

---

## Utilisation avec GitHub Copilot

### Stratégie : convertir tes données avant de les passer à Copilot

Quand tu travailles avec Copilot Chat ou Copilot Agent et que tu dois fournir des **données tabulaires** (utilisateurs, logs, configurations, inventaire…), convertis-les en TOON avant de les coller dans le prompt.

#### Étape 1 — Convertir

```bash
# Depuis un fichier JSON
npx @toon-format/cli data.json -o data.toon

# Depuis le clipboard (PowerShell)
Get-Clipboard | npx @toon-format/cli
```

#### Étape 2 — Utiliser dans le prompt Copilot

Au lieu de coller du JSON brut dans le chat Copilot, colle le TOON :

```
Analyse ces données et identifie les employés Engineering avec un salaire > 80000 :

employees[100]{id,name,department,salary,yearsExp,active}:
  1,Alice,Engineering,95000,5,true
  2,Bob,Sales,75000,3,true
  3,Carol,Engineering,105000,8,true
  ...
```

!!! tip "Astuce Copilot Chat"
    Tu peux créer un fichier `.toon` dans ton projet et le référencer avec `#file` dans Copilot Chat. Copilot lira le contenu et bénéficiera de la compacité du format.

### Utilisation programmatique avec Copilot

Dans un projet TypeScript, tu peux utiliser le SDK pour convertir des données avant de les injecter dans un prompt :

```typescript
import { stringify } from '@toon-format/toon';

// Tes données métier
const employees = [
  { id: 1, name: "Alice", department: "Engineering", salary: 95000 },
  { id: 2, name: "Bob", department: "Sales", salary: 75000 },
  // ...
];

// Conversion en TOON pour injection dans un prompt
const toonData = stringify({ employees });
console.log(toonData);
// employees[2]{id,name,department,salary}:
//   1,Alice,Engineering,95000
//   2,Bob,Sales,75000
```

!!! info "Copilot comprend le TOON"
    Les LLMs sous-jacents de Copilot (GPT-4o, Claude 3.5 Sonnet, o3…) n'ont pas besoin d'instructions spéciales pour lire du TOON. Le format est suffisamment explicite pour être compris naturellement.

### Créer un prompt file dédié

Tu peux créer un prompt file `.github/prompts/analyze-toon.prompt.md` pour standardiser l'utilisation :

```markdown
---
description: "Analyser des données au format TOON"
---

Analyse les données TOON suivantes.
Le format TOON utilise `[N]{fields}:` pour déclarer N lignes avec les colonnes indiquées.
Chaque ligne contient les valeurs séparées par des virgules.

Données :
```

---

## Quand utiliser TOON

| Situation | Recommandation |
|-----------|---------------|
| Arrays uniformes de 10+ items | ✅ **Utiliser TOON** — sweet spot : 50-1000 items |
| Données tabulaires (logs, users, repos…) | ✅ **Utiliser TOON** |
| Structures profondément imbriquées (5+ niveaux) | ❌ Garder JSON |
| Données très hétérogènes | ❌ Garder JSON |
| Données plates pures | ❌ CSV est plus simple |
| Prompt avec peu de données | ❌ Le gain en tokens ne justifie pas la conversion |

---

## Options CLI

```bash
npx @toon-format/cli input.json [options]

--format [json|toon|yaml]   # Format cible
--output FILE               # Fichier de sortie
--pretty                    # Indentation lisible
--minify                    # Format compact
```

---

## Pièges à éviter

!!! warning "Attention aux virgules dans les valeurs"
    Les valeurs contenant une `,` doivent être entourées de guillemets dans le format TOON. Vérifie tes données avant conversion.

!!! warning "Ne pas forcer TOON sur des données non uniformes"
    Sur des structures hétérogènes, TOON peut être **pire** que JSON en termes de lisibilité et de tokens. Utilise-le uniquement sur des arrays où chaque élément a la même structure.

!!! danger "Vérifier le count `[N]`"
    Si le nombre réel de lignes ne correspond pas à `[N]`, le LLM peut faire des erreurs d'interprétation. Assure-toi que le count est exact.

---

## Résumé

| Aspect | Détail |
|--------|--------|
| Type | Format de données (open source, MIT) |
| GitHub | [toon-format/toon](https://github.com/toon-format/toon) |
| Spécification | [SPEC.md v3.0](https://github.com/toon-format/spec/blob/main/SPEC.md) |
| Installation | `npx @toon-format/cli` (aucune install permanente) |
| Gratuit | Oui, entièrement |
| Économie mesurée | -40 % de tokens vs JSON |
| Précision LLM | +1,4 % vs JSON (76,4 % contre 75,0 %) |
| Meilleur pour | Arrays uniformes de 10+ items dans les prompts |

!!! success "Recommandation"
    Utilise TOON chaque fois que tu dois passer des **tableaux de données uniformes** à Copilot (Chat ou Agent). La conversion est instantanée via `npx` et l'économie de 40 % de tokens se cumule rapidement sur des sessions longues.

---

## Prochaine étape

**[OpenSkills](openskills.md)** : un installateur universel de skills pour agents IA — standardise et partage des capacités entre Copilot, Claude Code, Cursor et d'autres agents.
