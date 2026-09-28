# Supermaven — référence historique

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">JetBrains</span>

Supermaven a été un assistant particulièrement connu pour sa complétion inline rapide. Son statut a cependant changé : l'équipe a rejoint **Cursor** en novembre 2024, puis a annoncé le **sunset de Supermaven en novembre 2025**.

Cette page est donc conservée comme **référence historique** pour les utilisateurs existants. Elle ne doit plus servir de recommandation pour un nouveau déploiement d'équipe.

---

## État du produit

L'annonce officielle de sunset indique notamment :

- remboursement des abonnements existants au moment de l'annonce ;
- maintien gratuit de l'autocomplétion pour les clients existants « for the foreseeable future » ;
- arrêt des conversations agentiques Supermaven ;
- recommandation aux utilisateurs VS Code de migrer vers Cursor.

La durée du maintien de l'autocomplétion n'est pas un engagement pérenne : vérifiez le statut du service avant de dépendre de Supermaven dans un workflow critique.

---

## Pour une installation existante

Si Supermaven est encore actif dans votre IDE :

1. gardez un seul moteur de complétion inline actif pour éviter les collisions ;
2. ne construisez pas de nouveau processus d'équipe spécifique à Supermaven ;
3. documentez une solution de remplacement ;
4. testez la migration avant une mise à jour IDE importante ;
5. conservez tests, lint et revue comme validation du code accepté.

---

## Migration dans le contexte de ce dépôt

Le parcours principal reste :

```text
Claude Code
→ instructions projet / skills / MCP
→ tests et outils déterministes
→ backend Claude officiel ou local selon le besoin
```

Si votre besoin est uniquement la **complétion inline**, évaluez un moteur actuellement maintenu dans votre IDE plutôt que d'ajouter une dépendance à Supermaven.

Si vous cherchez une plateforme agentique complète, comparez Claude Code, Windsurf, Tabnine, Kiro, GitHub Copilot ou d'autres solutions actuelles selon vos contraintes réelles ; ne considérez pas Supermaven comme une option active équivalente.

---

## Sources

- [Supermaven — Sunsetting Supermaven](https://supermaven.com/blog/sunsetting-supermaven) — consulté le 2026-09-28
- [Supermaven — équipe rejoignant Cursor](https://supermaven.com/blog/cursor-announcement) — consulté le 2026-09-28

## Prochaine étape

**[Comparaison des outils](comparaison.md)** pour choisir une combinaison actuellement maintenue selon l'agent principal, l'IDE, la gouvernance et le besoin de modèles locaux.