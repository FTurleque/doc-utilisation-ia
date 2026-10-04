# Copilot — archives : Cybersécurité & IA

Extraits déplacés du parcours principal le **3 octobre 2026**. Les affirmations, exemples et dates de vérification sont ceux des pages d’origine ; ils ne constituent pas une nouvelle validation des fonctionnalités Copilot. Les passages comparatifs peuvent aussi citer Claude afin de conserver leur sens.


## Plan 90 jours — Passer à l'action { #page-chapitre-15-hacker-ia-plan-90-jours }

Origine : [chapitre-15-hacker-ia/plan-90-jours.md](../../chapitre-15-hacker-ia/plan-90-jours.md).

<!-- Extrait original : chapitre-15-hacker-ia/plan-90-jours.md:23 ; tableau comparatif -->

| Action | Preuve attendue |
|---|---|
| Inventorier agents, IDE, MCP, plugins, skills et backends | registre avec owner |
| Identifier les credentials accessibles aux agents | cartographie des scopes |
| Revoir `CLAUDE.md`, `.claude/`, `.mcp.json` et configurations Copilot | PR/revue documentée |
| Retirer les secrets des instructions et exemples | scan + diff |
| Vérifier MFA et comptes privilégiés | rapport IAM |
| Tester la révocation d'un token | exercice documenté |
| Mettre à jour le playbook incident | version approuvée |


## Comparaison { #page-chapitre-15-hacker-ia-comparaison }

Origine : [chapitre-15-hacker-ia/comparaison.md](../../chapitre-15-hacker-ia/comparaison.md).

<!-- Extrait original : chapitre-15-hacker-ia/comparaison.md:95 ; section dédiée -->

#### GitHub Copilot — référence conservée

Copilot existe dans VS Code et JetBrains avec des capacités et paramètres qui évoluent. Les pages Copilot dédiées de ce dépôt restent la référence pour ses instructions, agents, prompt files et options IDE.

Ne transposez pas automatiquement une permission ou configuration Claude vers Copilot : vérifiez le mécanisme du client réellement utilisé.

---

---

## Prochaine étape

Vous avez atteint la fin de l'annexe. Retrouvez les parcours recommandés dans **[Accueil](../../index.md)**.
