# Développement local — notes internes

Ce guide décrit l'environnement local minimal pour développer et valider la documentation MkDocs. Il est stocké dans `user/` et n'est pas publié dans le site.

## Windows PowerShell

```powershell
py -3 -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

Une fois le venv activé, utiliser `python -m ...` afin d'exécuter les outils avec l'interpréteur de l'environnement virtuel.

Si PowerShell refuse l'activation du venv, ajuster la politique uniquement si la politique de votre poste l'autorise :

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

## macOS / Linux

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

## Développer le site

Serveur avec rechargement automatique :

```bash
python -m mkdocs serve
```

Le site est accessible par défaut sur `http://127.0.0.1:8000/`.

## Validation complète

Avant un push :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```

Le second contrôle s'exécute sur le dossier `site/` produit par MkDocs et vérifie les chemins et ancres internes.

## Dépendances

`requirements.txt` est volontairement minimal. N'utilisez pas `pip freeze > requirements.txt` depuis un environnement de travail complet : cette commande peut y ajouter des dépendances transitives ou étrangères au projet.

Lorsqu'une dépendance directe devient nécessaire, ajoutez-la explicitement à `requirements.txt`, puis vérifiez l'installation dans un venv propre.

## Git

- `.venv/` et `site/` sont ignorés par Git.
- Ne poussez jamais directement sur `main`.
- Travaillez sur une branche, puis poussez-la avec `git push -u origin HEAD` et ouvrez une Pull Request.

Le script `scripts/push-and-deploy.ps1` porte un nom historique : il valide et pousse uniquement la branche courante ; le déploiement réel se produit après merge manuel dans `main` via GitHub Actions.
