# Guide de déploiement — Documentation Claude Code & Copilot

Ce dépôt génère un site MkDocs Material. Claude Code est le parcours documentaire principal ; les pages GitHub Copilot restent publiées comme référence.

## Principe de déploiement

Le workflow normal est :

1. travailler sur une branche ;
2. valider la documentation ;
3. ouvrir une Pull Request vers `main` ;
4. merger **manuellement** après revue ;
5. laisser `.github/workflows/deploy.yml` publier le site après le push résultant sur `main`.

Aucun script de contribution ne doit pousser directement sur `main`.

## Architecture

```text
docs/                              sources publiées
mkdocs.yml                         configuration du site
requirements.txt                   dépendances Python
scripts/validate-links.py          contrôle des chemins et ancres internes
.github/workflows/validate-docs.yml validation des Pull Requests
.github/workflows/deploy.yml        publication après intégration dans main
site/                              sortie locale générée, ignorée par Git
```

## Développement et validation locale

```bash
python -m pip install -r requirements.txt
python -m mkdocs build --strict
python scripts/validate-links.py
python -m mkdocs serve
```

Sous Windows, `py -m` peut remplacer `python -m` si le launcher Python est utilisé.

Le serveur de développement écoute par défaut sur `http://127.0.0.1:8000/`.

## Validation des Pull Requests

`.github/workflows/validate-docs.yml` s'exécute sur les Pull Requests vers `main` et contrôle :

- l'installation des dépendances ;
- `mkdocs build --strict` ;
- les chemins internes du site généré ;
- les ancres HTML internes (`#fragment`).

Ce workflow dispose uniquement des permissions de lecture nécessaires et **ne déploie pas**.

## Déploiement GitHub Pages

`.github/workflows/deploy.yml` s'exécute après un push sur `main` et peut aussi être lancé manuellement via `workflow_dispatch`.

Le workflow :

1. récupère le dépôt ;
2. installe les dépendances ;
3. vérifie/configure GitHub Pages ;
4. publie avec `mkdocs gh-deploy --force` sur `gh-pages` ;
5. retire un éventuel `CNAME` afin de conserver l'hébergement prévu sur `fturleque.github.io`.

L'URL déclarée dans `mkdocs.yml` reste la source de vérité pour le chemin GitHub Pages du site.

## Déclencher une publication

Une contribution normale ne déclenche pas elle-même un déploiement. Poussez la branche de travail :

```bash
git push -u origin HEAD
```

Une fois la PR relue et intégrée manuellement dans `main`, le workflow de déploiement démarre automatiquement.

Pour republier le `main` actuel sans changement de contenu, utiliser **GitHub → Actions → Deploy MkDocs to GitHub Pages → Run workflow** plutôt que de créer un commit vide ou de pousser directement sur `main`.

## Déploiement local ou autre hébergeur

Pour produire le site statique :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```

Le dossier `site/` peut ensuite être servi par Nginx/Apache ou envoyé vers un hébergeur statique. Il est généré et ne doit pas être versionné.

### Exemple Docker local

```dockerfile
FROM python:3.13-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY docs/ docs/
COPY mkdocs.yml .
COPY scripts/ scripts/
RUN python -m mkdocs build --strict && python scripts/validate-links.py
EXPOSE 8000
CMD ["python", "-m", "http.server", "--directory", "site", "8000"]
```

Cet exemple construit puis sert la sortie statique ; il ne remplace pas le workflow GitHub Pages du dépôt.

## Diagnostic

### La validation PR échoue

1. lire le job `Validate MkDocs documentation` ;
2. reproduire localement avec :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```

3. corriger les erreurs sur la branche ;
4. repousser la branche.

### Le déploiement échoue après merge

1. vérifier le run `Deploy MkDocs to GitHub Pages` ;
2. confirmer que `requirements.txt` s'installe ;
3. confirmer que GitHub Pages et la branche `gh-pages` sont accessibles au workflow ;
4. ne pas contourner l'échec par un push manuel sur `main`.

### Le site ne reflète pas le dernier merge

- vérifier le dernier run de déploiement ;
- vérifier la branche `gh-pages` ;
- vérifier l'URL `site_url` dans `mkdocs.yml` ;
- tester sans cache navigateur si le déploiement est vert mais l'ancien contenu reste visible.

## Rollback

Le dossier `site/` n'est pas versionné : un rollback doit porter sur les **sources**.

Approche recommandée :

1. créer une branche depuis `main` ;
2. utiliser `git revert <commit>` ou restaurer les fichiers concernés ;
3. exécuter le build strict et le validateur ;
4. ouvrir une PR de rollback ;
5. merger manuellement après revue.

Le merge du rollback dans `main` déclenche ensuite une nouvelle publication GitHub Pages.

## Sécurité

Ne jamais committer :

- clés API ou tokens ;
- secrets d'organisation ;
- credentials cloud ;
- données personnelles utilisées seulement pour les captures ou exemples.

Les secrets nécessaires à un workflow doivent être fournis via les mécanismes GitHub prévus à cet effet. Les workflows de PR provenant de contenu non fiable ne doivent pas recevoir de secret inutile.

## Fichiers associés

- `CONTRIBUTING.md` — workflow de contribution ;
- `.github/workflows/validate-docs.yml` — validation PR ;
- `.github/workflows/deploy.yml` — publication ;
- `scripts/validate-links.py` — validation des liens/ancres internes ;
- `MAINTENANCE_SCHEDULE.md` — veille et maintenance du dépôt.
