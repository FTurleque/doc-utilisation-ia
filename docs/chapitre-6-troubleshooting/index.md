# Troubleshooting — Résolution de Problèmes

Même bien configuré, GitHub Copilot peut rencontrer des dysfonctionnements. Ce chapitre couvre les problèmes les plus fréquents, leur diagnostic, et leurs solutions concrètes.

---

## Organisation du chapitre

<div class="grid cards" markdown>

-   :material-bug: **Problèmes courants**
    
    ---
    
    Les 10 problèmes les plus fréquents avec leur symptôme, cause et solution pas à pas.
    
    [Voir les problèmes →](problemes-courants.md)

-   :material-file-search: **Logs & Diagnostic**
    
    ---
    
    Comment activer et lire les logs Copilot dans VS Code et IntelliJ pour identifier la source d'un problème.
    
    [Accéder aux logs →](logs-diagnostic.md)

-   :material-compare: **Comparaison des problèmes**
    
    ---
    
    Tableau comparatif des problèmes spécifiques à chaque IDE et les différences de comportement.
    
    [Voir la comparaison →](comparaison-problemes.md)

</div>

---

## Diagnostic rapide — arbre de décision

```
Copilot ne fonctionne pas
    │
    ├── Authentification ?
    │       └── Vérifier : menu Copilot → Sign in / Sign out → Re-login
    │
    ├── Suggestions ne s'affichent pas ?
    │       ├── Extension/plugin activé ? → Vérifier dans les paramètres
    │       ├── Fichier dans .copilotignore ? → Ouvrir un autre fichier
    │       └── Délai trop long ? → Réduire le délai
    │
    ├── Suggestions de mauvaise qualité ?
    │       ├── Fichiers de contexte ouverts ? → Ouvrir les fichiers liés
    │       └── Instructions configurées ? → Voir Contexte & Personnalisation
    │
    └── Erreur réseau / serveur ?
            └── Vérifier : status.github.com
```

---

## Statut des services GitHub

Avant tout diagnostic, vérifiez l'état des services GitHub :

- **Status GitHub** : [https://www.githubstatus.com](https://www.githubstatus.com)

Si GitHub Copilot est signalé comme dégradé ou en interruption, attendez la résolution. Aucun diagnostic IDE n'est utile dans ce cas.

---

## Références croisées

| Problème | Chapitre |
|----------|----------|
| Installation échouée | [Installation](../chapitre-1-installation/index.md) |
| Paramètre introuvable | [Paramétrage](../chapitre-2-parametrage/index.md) |
| Contexte insatisfaisant | [Contexte & Personnalisation](../chapitre-3-contexte/index.md) |
| Code généré de mauvaise qualité | [Bonnes Pratiques](../chapitre-5-bonnes-pratiques/index.md) |
