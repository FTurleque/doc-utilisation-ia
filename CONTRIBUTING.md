# Guide de contribution

Ce document décrit les règles de collaboration Git pour ce projet.  
L'objectif principal est de **protéger la branche `main`** : aucun code ne doit y être poussé sans validation préalable.

---

## Règle fondamentale

> **Aucun push direct sur `main` n'est autorisé.**  
> Toute modification passe obligatoirement par une Pull Request (PR).  
> **@FTurleque** est le reviewer obligatoire sur tous les fichiers du dépôt.

| Contributeur | Peut merger sans approbation externe ? |
|---|---|
| @FTurleque (propriétaire) | ✅ Oui — bypass admin activé |
| Autre développeur | ❌ Non — approbation de @FTurleque requise |

---

## Stratégie de branches

```
main          ← branche protégée, toujours stable et déployable
  └── feature/nom-feature    ← nouvelle fonctionnalité ou nouvelle page
  └── fix/nom-du-correctif   ← correction d'erreur (typo, lien cassé…)
  └── docs/nom-du-sujet      ← ajout ou amélioration de contenu
  └── chore/nom-tache        ← maintenance (dépendances, CI/CD, config)
```

### Convention de nommage des branches

| Préfixe | Usage | Exemple |
|---|---|---|
| `feature/` | Nouvelle page ou fonctionnalité | `feature/chapitre-9-securite` |
| `fix/` | Correction d'un bug ou d'une erreur | `fix/lien-casse-chapitre-3` |
| `docs/` | Améliorations de contenu existant | `docs/ameliorer-intro-chapitre-1` |
| `chore/` | Maintenance (CI, dépendances, config) | `chore/mise-a-jour-mkdocs` |

---

## Workflow complet — étape par étape

### 1. Avant de commencer

```bash
# Mettre à jour ta copie locale de main
git checkout main
git pull origin main
```

### 2. Créer une branche dédiée

```bash
# Remplace le préfixe et le nom selon le tableau ci-dessus
git checkout -b feature/ma-nouvelle-page
```

### 3. Travailler et committer

```bash
# Vérifier le build avant de committer
py -m mkdocs build

# Ajouter les fichiers modifiés
git add docs/chapitre-X/ma-page.md mkdocs.yml

# Committer avec un message clair (voir conventions ci-dessous)
git commit -m "docs: ajout de la page sur la sécurité Copilot"
```

### 4. Pousser la branche

```bash
git push origin feature/ma-nouvelle-page
```

### 5. Ouvrir une Pull Request sur GitHub

1. Aller sur le dépôt GitHub → onglet **Pull requests** → **New pull request**
2. Sélectionner `base: main` ← `compare: feature/ma-nouvelle-page`
3. Remplir le template de PR (description, type de changement, checklist)
4. Soumettre — **@FTurleque sera automatiquement ajouté en reviewer** (via CODEOWNERS)

### 6. Revue et merge

- @FTurleque examine la PR, laisse des commentaires ou approuve
- Une fois approuvée, le merge est effectué dans `main`
- La branche source peut être supprimée après le merge

---

## Conventions de message de commit

Format : `type: description courte en français`

| Type | Usage |
|---|---|
| `docs` | Ajout ou modification de contenu documentaire |
| `feat` | Nouvelle fonctionnalité ou nouvelle page |
| `fix` | Correction d'erreur |
| `chore` | Maintenance (dépendances, CI/CD, config) |
| `refactor` | Restructuration sans changement de contenu |
| `style` | Mise en forme pure (CSS, indentation) |

**Exemples valides :**

```
docs: ajout du chapitre sur les hooks Copilot
fix: correction du lien cassé vers la page FAQ
chore: mise à jour de mkdocs-material en 9.6
feat: nouvelle page comparaison IntelliJ vs VS Code
```

---

## Configurer les Branch Protection Rules sur GitHub

> **Action manuelle requise une seule fois.** Ces règles ne peuvent pas être définies par un fichier — elles se configurent dans l'interface GitHub.

### Étapes

1. Aller sur **GitHub → dépôt → Settings → Branches**
2. Cliquer sur **Add branch protection rule** (ou **Add classic branch protection rule**)
3. Dans **Branch name pattern**, saisir : `main`
4. Activer les options suivantes :

| Option | Valeur | Effet |
|---|---|---|
| **Require a pull request before merging** | ✅ Activé | Bloque les push directs sur `main` |
| **Required number of approvals** | `1` | 1 approbation requise avant le merge |
| **Dismiss stale pull request approvals when new commits are pushed** | ✅ Recommandé | Re-demande l'approbation si des commits sont ajoutés |
| **Require review from Code Owners** | ✅ Activé | Force la revue de @FTurleque (défini dans CODEOWNERS) |
| **Do not allow bypassing the above settings** | ❌ Désactivé | Laisse les admins (toi) contourner les règles |

5. Cliquer sur **Create** / **Save changes**

### Pourquoi "Do not allow bypassing" doit rester désactivé ?

Si cette option est **désactivée**, les utilisateurs avec le rôle **Admin** sur le dépôt (i.e. @FTurleque) peuvent merger leurs propres PRs sans attendre l'approbation d'un tiers.  
Si elle était **activée**, même @FTurleque devrait se faire approuver par quelqu'un d'autre — ce qui n'est pas le comportement souhaité.

---

## Vérification du dispositif

Après la configuration des Branch Protection Rules, valider avec ces tests :

```bash
# Test 1 — push direct bloqué (d'un autre dev)
git checkout main
echo "test" >> README.md
git add README.md
git commit -m "test: push direct"
git push origin main
# ➜ doit être rejeté avec : "remote: error: GH006: Protected branch update failed"

# Test 2 — @FTurleque peut merger sa propre PR sans blocage
# ➜ ouvrir une PR depuis feature/test-bypass → main
# ➜ merger directement sans approbation tierce
# ➜ doit réussir grâce au bypass admin
```

---

## Fichiers de gouvernance Git

| Fichier | Rôle |
|---|---|
| `.github/CODEOWNERS` | Désigne @FTurleque comme reviewer obligatoire |
| `.github/pull_request_template.md` | Checklist pré-remplie à chaque nouvelle PR |
| `CONTRIBUTING.md` | Ce fichier — workflow et conventions |

---

## Questions ou problèmes ?

Ouvrir une issue avec le label `question` sur le dépôt GitHub.

---

## Développement local

But : exécuter et tester le site MkDocs localement pour éditer la documentation avant commit.

Remarque : le dossier `.venv/` est local et ne doit pas être versionné. Utilisez `requirements.txt` pour partager les dépendances.

Prérequis
- Python 3 installé (ou le launcher `py`) et `pip`.

Créer et préparer l’environnement (Windows)

PowerShell :
```powershell
py -3 -m venv .venv
.\.venv\Scripts\Activate.ps1
py -m pip install --upgrade pip
py -m pip install -r requirements.txt
```

Invite de commandes (cmd) :
```cmd
py -3 -m venv .venv
.\.venv\Scripts\activate.bat
py -m pip install --upgrade pip
py -m pip install -r requirements.txt
```

Remarque : si la commande `py` n'est pas disponible, remplacez `py -m` par `.\.venv\Scripts\python -m`.

Deux façons de lancer le site
- Mode A — Serveur de développement (rechargement automatique) — recommandé pour édition active :
```powershell
py -m mkdocs serve
# ou si 'py' absent :
.\\.venv\\Scripts\\python -m mkdocs serve
```
Ouvrir http://127.0.0.1:8000

- Mode B — Build statique + serveur simple — utile pour tester le site construit :
```powershell
py -m mkdocs build
py -m http.server --directory site 8000
# ou :
.\\.venv\\Scripts\\python -m mkdocs build
.\\.venv\\Scripts\\python -m http.server --directory site 8000
```

Dépannage rapide
- Erreur « py : introuvable » → utiliser `.\.venv\Scripts\python -m ...` ou installer le launcher Python depuis python.org (cocher "Install launcher").
- PowerShell bloque l'exécution des scripts → exécuter :
```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
```
- Si `mkdocs` absent → `py -m pip install mkdocs mkdocs-material`.

Suggestion
- Pour plus de détails et exemples, voir la page dédiée `docs/appendices/developpement-local.md`.
 - Pour plus de détails et exemples, voir la page dédiée `user/developpement-local.md`.
