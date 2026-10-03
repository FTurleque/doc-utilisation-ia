# TOON — Token-Oriented Object Notation

<span class="badge-intermediate">Intermédiaire</span>

**TOON** (*Token-Oriented Object Notation*) est un format texte orienté LLM qui encode le modèle de données JSON avec une syntaxe compacte : indentation pour les objets et représentation tabulaire pour les collections uniformes.

La spécification officielle est actuellement en **version 4.1**, datée du **26 juillet 2026**, avec le statut **Working Draft**. TOON doit donc être traité comme un format utile mais encore évolutif, pas comme un standard figé.

---

## Positionnement dans ce dépôt

TOON est intéressant surtout lorsque Claude Code ou un autre agent doit lire des **données structurées volumineuses et répétitives** : inventaires, séries tabulaires, résultats d'analyse, exports JSON uniformes.

Il ne remplace pas JSON comme format d'échange applicatif général. Une stratégie sûre consiste à garder JSON comme format canonique et à convertir vers TOON uniquement à la frontière LLM lorsque la mesure montre un bénéfice.

---

### JSON

```json
{
  "employees": [
    {"id": 1, "name": "Alice", "team": "Platform"},
    {"id": 2, "name": "Bob", "team": "Security"}
  ]
}
```

### TOON

```text
employees[2]{id,name,team}:
  1,Alice,Platform
  2,Bob,Security
```

Le tableau déclare sa longueur et ses champs une seule fois, ce qui peut réduire le nombre de tokens lorsque de nombreux objets partagent exactement la même structure.

---

## Ce que disent réellement les benchmarks actuels

Les benchmarks officiels comparent TOON, JSON, JSON compact, YAML, XML et CSV sur plusieurs jeux de données et plusieurs modèles. Les résultats ne permettent pas de dire que TOON est « toujours 40 % plus compact » ou « toujours plus précis ».

Les constats utiles sont plus nuancés :

- TOON est souvent très compact sur les collections d'objets uniformes ;
- CSV peut être encore plus petit sur des données purement tabulaires ;
- JSON compact peut être compétitif ou meilleur sur certaines structures imbriquées ;
- la précision varie selon le modèle, le dataset et le type de question ;
- les nombres de tokens dépendent du tokenizer utilisé ;
- la latence doit être mesurée séparément sur votre environnement.

!!! tip "Règle de décision"
    Convertissez un échantillon représentatif, mesurez les tokens et la qualité de restitution sur votre modèle réel, puis choisissez. Ne reprenez pas un pourcentage marketing comme invariant.

---

## Cas où TOON est pertinent

| Données | Positionnement |
|---|---|
| Grande liste d'objets aux mêmes champs | Très bon candidat |
| Données tabulaires plates | Comparer TOON à CSV |
| JSON semi-uniforme | Tester sur un échantillon |
| Arbre très imbriqué ou hétérogène | JSON peut rester préférable |
| Contrat API public / stockage | Garder JSON ou le format métier canonique |

---

## Utilisation avec Claude Code

La conversion peut rester explicite :

```bash
npx @toon-format/cli input.json -o input.toon
```

Puis demandez à Claude de lire le fichier `.toon` uniquement si le format apporte réellement un gain sur le volume transmis.

Pour un workflow récurrent, vous pouvez encapsuler la conversion dans un script ou un skill :

```text
1. générer les données JSON canoniques ;
2. convertir en TOON ;
3. vérifier que l'encodage/décodage est lossless ;
4. fournir uniquement le fichier TOON pertinent à l'agent ;
5. conserver JSON pour les interfaces et artefacts applicatifs.
```

---

### CLI

```bash
npx @toon-format/cli input.json -o output.toon
```

### TypeScript / JavaScript

```bash
npm install @toon-format/toon
```

L'organisation TOON référence également des implémentations dans plusieurs autres langages. Vérifiez leur statut et leur conformité à la spécification avant de les adopter en production.

---

## Sécurité et robustesse

TOON réduit la syntaxe, pas les risques liés aux données :

- un contenu externe reste non fiable même s'il est compact ;
- vérifiez la longueur déclarée et la structure avant consommation automatique ;
- ne laissez pas une conversion masquer des champs critiques ;
- validez le round-trip JSON → TOON → JSON si la fidélité est importante ;
- ne substituez pas TOON à un schéma ou à une validation métier.

---

## Sources

- [TOON — implémentation de référence](https://github.com/toon-format/toon) — consulté le 2026-09-28
- [TOON — spécification 4.1](https://github.com/toon-format/spec) — consulté le 2026-09-28
- [TOON — benchmarks](https://github.com/toon-format/toon/blob/main/benchmarks/README.md) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-13-outils-economies.md#page-chapitre-13-outils-economies-toon).

## Prochaine étape

Poursuivez avec **[OpenSkills](openskills.md)**, la page suivante dans le menu.
