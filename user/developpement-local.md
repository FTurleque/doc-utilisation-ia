# Développement local (notes internes)

Ce guide explique comment préparer un environnement local pour développer et tester la documentation MkDocs du projet (Windows).

> Note : ce fichier est stocké dans `user/` et n'est pas inclus dans le site publié.

## Vue d'ensemble
- Créer un environnement virtuel (`.venv`) pour isoler les dépendances.
- Installer les dépendances depuis `requirements.txt`.
- Deux modes pour visualiser le site : serveur de développement (rechargement auto) ou build statique.

## Étapes détaillées (Windows)

1) Créer le venv

PowerShell :
```powershell
py -3 -m venv .venv
```

Si `py` n'est pas installé, utiliser l'installateur Python et activer l'option "Install launcher".

2) Activer le venv

PowerShell :
```powershell
.\\.venv\\Scripts\\Activate.ps1
```

![Activation PowerShell](docs/assets/images/vscode/vscode-auth-github-01.png)

Invite de commandes (cmd) :
```cmd
.\\.venv\\Scripts\\activate.bat
```

3) Installer les dépendances

```powershell
py -m pip install --upgrade pip
py -m pip install -r requirements.txt
```

Remarque : si `py` n'est pas disponible, remplacez `py -m` par `.\\.venv\\Scripts\\python -m`.

## Lancer le site — deux façons

Mode A — Serveur de développement (preferé pour édition)

```powershell
py -m mkdocs serve
# ou si 'py' absent :
.\\.venv\\Scripts\\python -m mkdocs serve
```

Le site est accessible par défaut sur : `http://127.0.0.1:8000`.

Mode B — Build statique + serveur simple

```powershell
py -m mkdocs build
py -m http.server --directory site 8000
# ou :
.\\.venv\\Scripts\\python -m mkdocs build
.\\.venv\\Scripts\\python -m http.server --directory site 8000
```

Ce mode permet de vérifier le rendu final (fichiers générés dans `site/`).

## Dépannage

- `py` introuvable : utiliser `.\\.venv\\Scripts\\python -m` ou installer le launcher Python.
- PowerShell bloque l'exécution des scripts :
```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
```

![PowerShell Execution Policy](docs/assets/images/vscode/vscode-status-bar-icon.png)
- `mkdocs` manquant :
```powershell
py -m pip install mkdocs mkdocs-material
```

## Bonnes pratiques

- Ne pas committer le dossier `.venv/` — il doit être dans `.gitignore`.
- Mettre à jour `requirements.txt` quand on ajoute une dépendance :
```powershell
py -m pip freeze > requirements.txt
```

---

Ces notes sont destinées aux contributeurs et sont volontairement hors-site pour ne pas apparaître dans la documentation publiée.
