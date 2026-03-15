# Rédiger de bons prompts

Un **prompt** est l'instruction ou la question que vous soumettez à un modèle d'IA. La qualité du prompt a un impact direct sur la qualité de la réponse obtenue.

## Les principes d'un bon prompt

### 1. Être précis et spécifique

Évitez les instructions vagues. Plus votre demande est précise, plus la réponse sera pertinente.

!!! example "Exemple"
    ❌ `Explique-moi Python.`

    ✅ `Explique-moi les listes en Python avec des exemples de code pour un débutant.`

### 2. Donner du contexte

Fournissez les informations dont le modèle a besoin pour répondre correctement.

!!! example "Exemple"
    ❌ `Corrige ce texte.`

    ✅ `Corrige ce texte en français en améliorant la clarté et le style, sans en changer le sens : [votre texte]`

### 3. Préciser le format de sortie souhaité

Si vous avez besoin d'un format particulier, demandez-le explicitement.

!!! example "Exemple"
    `Donne-moi une liste à puces des 5 avantages du télétravail.`

    `Réponds sous forme de tableau avec deux colonnes : Avantage et Description.`

### 4. Assigner un rôle au modèle

Demander au modèle d'adopter un rôle ou une expertise peut améliorer la qualité des réponses.

!!! example "Exemple"
    `Tu es un expert en cybersécurité. Explique les bonnes pratiques pour sécuriser un mot de passe.`

### 5. Itérer et affiner

Le *prompting* est un processus itératif. Si la première réponse n'est pas satisfaisante, reformulez votre demande ou demandez des précisions.

## Structure type d'un prompt efficace

```
[Rôle] Tu es un expert en [domaine].
[Contexte] Je travaille sur [description de la situation].
[Tâche] Je voudrais que tu [action précise].
[Format] Réponds sous la forme [format souhaité].
[Contraintes] Limite ta réponse à [contrainte éventuelle].
```

## Techniques avancées

### Few-shot prompting
Fournissez des exemples de ce que vous attendez pour guider le modèle.

### Chain of thought
Demandez au modèle de raisonner étape par étape : `Réfléchis étape par étape avant de répondre.`

### Role prompting
Assignez un persona précis pour obtenir un style ou une expertise spécifique.
