# Grands modèles de langage (LLM)

Les **grands modèles de langage** (ou *Large Language Models*, LLM) sont des systèmes d'IA entraînés sur d'immenses quantités de texte pour comprendre et générer du langage naturel.

## Comment fonctionnent-ils ?

Les LLM sont basés sur une architecture appelée **Transformer**, introduite en 2017 par des chercheurs de Google. Ils sont entraînés à prédire le mot (ou *token*) suivant dans une séquence de texte, sur des corpus de plusieurs milliards de mots.

Lors d'une conversation, le modèle prend en entrée l'ensemble de la conversation (appelée *contexte* ou *fenêtre de contexte*) et génère une réponse token par token.

## Principaux modèles disponibles

| Modèle | Éditeur | Accès |
|--------|---------|-------|
| ChatGPT (GPT-4o) | OpenAI | Payant / Gratuit limité |
| Gemini | Google | Gratuit / Payant |
| Claude | Anthropic | Gratuit / Payant |
| Llama | Meta | Open source |
| Mistral | Mistral AI | Open source / Payant |

## Forces et limites des LLM

### Forces
- Compréhension et génération de texte en langage naturel
- Polyvalence (résumé, traduction, code, rédaction…)
- Disponibilité via des interfaces simples

### Limites
- **Hallucinations** : le modèle peut produire des informations fausses avec confiance
- **Date de coupure** : les connaissances s'arrêtent à une date précise
- **Biais** : les modèles reflètent les biais présents dans leurs données d'entraînement
- **Absence de raisonnement** : ils ne « comprennent » pas au sens humain du terme

!!! warning "Attention aux hallucinations"
    Un LLM peut inventer des faits, des citations ou des références qui n'existent pas. Vérifiez toujours les informations importantes auprès de sources fiables.
