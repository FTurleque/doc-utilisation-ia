# Troubleshooting — Résolution de Problèmes

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">IntelliJ</span>

Même bien configuré, GitHub Copilot peut rencontrer des dysfonctionnements. Ce chapitre couvre les problèmes les plus fréquents, leur diagnostic, et leurs solutions concrètes.

---

## Organisation du chapitre

<div class="grid cards" markdown>

-   :material-bug: **Problèmes courants**
    
    ---
    
    Les 13 problèmes les plus fréquents avec leur symptôme, cause et solution pas à pas.
    
    [Voir les problèmes →](problemes-courants.md)

-   :material-file-search: **Logs & Diagnostic**
    
    ---
    
    Comment activer et lire les logs Copilot dans VS Code et IntelliJ pour identifier la source d'un problème.
    
    [Accéder aux logs →](logs-diagnostic.md)

-   :material-compare: **Comparaison des problèmes**
    
    ---
    
    Tableau comparatif des problèmes spécifiques à chaque IDE et les différences de comportement.
    
    [Voir la comparaison →](comparaison-problemes.md)

-   :material-wrench: **Procédures de réparation**
    
    ---
    
    Procédures graduées pour les cas persistants : reset complet, nettoyage du cache, réinstallation, proxy/SSL.
    
    [Réparer Copilot →](procedures-reparation.md)

</div>

---

## Avant de commencer

Avant de diagnostiquer l'IDE, validez ces 4 points en 30 secondes :

!!! info "Checklist pré-diagnostic"
    - [ ] **IDE et extension/plugin à jour** — VS Code : `Extensions → vérifier les mises à jour` | IntelliJ : `Settings → Plugins → Updates`
    - [ ] **Authentification valide** — L'icône Copilot dans la barre de statut n'est pas barrée/rouge
    - [ ] **Redémarrage effectué** — Si Copilot vient d'être installé ou mis à jour, redémarrez l'IDE
    - [ ] **Services GitHub opérationnels** — Vérifiez [githubstatus.com](https://www.githubstatus.com) avant tout diagnostic avancé

---

## Diagnostic rapide — arbre de décision

```
Copilot ne fonctionne pas
    │
    ├── Icône Copilot absente ou rouge → Problème d'authentification
    │       └── Se reconnecter : menu Copilot → Sign out → Sign in (flux OAuth)
    │
    ├── Suggestions absentes dans TOUS les fichiers
    │       ├── Extension/plugin activé ? → Vérifier dans les paramètres
    │       ├── Langage désactivé dans la liste d'exclusions ?
    │       │       └── Retirer le langage de la liste (Settings → Copilot)
    │       └── Conflit avec une autre extension d'autocomplétion ?
    │               └── Désactiver temporairement (Tabnine, Kite, IntelliCode…)
    │
    ├── Suggestions absentes uniquement sur UN fichier
    │       ├── Fichier dans .copilotignore ? → Vérifier .copilotignore à la racine
    │       └── Extension du fichier non reconnue ? → Vérifier les paramètres de langue
    │
    ├── Suggestions présentes dans certains langages mais pas d'autres
    │       └── Vérifier "github.copilot.enable" dans settings.json pour ce langage
    │
    ├── Chat IA répond mais suggestions inline absentes
    │       ├── editor.inlineSuggest.enabled = true ? → Vérifier les settings
    │       └── IntelliJ : Completions désactivées via status bar ?
    │               └── Cliquer icône Copilot → "Enable completions"
    │
    ├── Suggestions présentes mais lentes (> 3 secondes)
    │       ├── Problème réseau / proxy ? → Tester curl https://api.github.com
    │       └── IntelliJ en indexation ? → Attendre la fin (barre en bas)
    │
    ├── Suggestions de mauvaise qualité
    │       ├── Fichiers de contexte ouverts ? → Ouvrir les fichiers liés
    │       └── Instructions configurées ? → Voir Contexte & Personnalisation
    │
    ├── Problème intermittent / aléatoire
    │       ├── Rate limit ? → Vérifier les logs pour "429" ou "rate limit exceeded"
    │       └── Réseau instable ? → Tester sans VPN d'abord
    │
    └── Erreur réseau / serveur persistante
            └── Vérifier githubstatus.com → si OK, lire les logs (Logs & Diagnostic)
```

---

## Statut des services GitHub

Avant tout diagnostic, vérifiez l'état des services GitHub :

- **Status GitHub** : [https://www.githubstatus.com](https://www.githubstatus.com)

Si GitHub Copilot est signalé comme dégradé ou en interruption, attendez la résolution. Aucun diagnostic IDE n'est utile dans ce cas.

---

## Escalade — Quand contacter le support

Si les procédures de ce chapitre n'ont pas résolu le problème, voici les ressources d'escalade :

| Ressource | Lien | Cas d'usage |
|-----------|------|------------|
| Support GitHub | [support.github.com](https://support.github.com) | Problèmes de licence, d'authentification persistante, de quota |
| GitHub Community | [github.community](https://github.community) | Questions générales, partage d'expériences |
| Dépôt extension VS Code | [github.com/microsoft/vscode-copilot-release](https://github.com/microsoft/vscode-copilot-release) | Bugs reproductibles, suivi des issues connues |
| Plugin IntelliJ | [youtrack.jetbrains.com](https://youtrack.jetbrains.com/newissue?project=IDEA) | Bugs ProprioDB IntelliJ |

!!! tip "Préparer un rapport efficace"
    Avant de contacter le support, collectez : version IDE, version extension, OS, logs filtrés et étapes de reproduction. Voir [Logs & Diagnostic](logs-diagnostic.md#rapport-de-bug) pour le template.

---

## Références croisées

| Problème | Chapitre |
|----------|----------|
| Installation échouée | [Installation](../chapitre-1-installation/index.md) |
| Paramètre introuvable | [Paramétrage](../chapitre-2-parametrage/index.md) |
| Contexte insatisfaisant | [Contexte & Personnalisation](../chapitre-3-contexte/index.md) |
| Code généré de mauvaise qualité | [Bonnes Pratiques](../chapitre-5-bonnes-pratiques/index.md) |
