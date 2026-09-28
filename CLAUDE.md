@AGENTS.md

# Claude Code — instructions du projet

Ce dépôt contient une documentation MkDocs en français sur l'utilisation de l'IA pour le développement. **Claude Code est le parcours principal** ; GitHub Copilot reste conservé comme référence, comparaison, compatibilité et option future.

## Priorités

1. Présenter Claude Code en premier dans les pages génériques liées aux assistants/agents de développement.
2. Ne pas supprimer un contenu ou artefact GitHub Copilot uniquement parce qu'il est secondaire.
3. Distinguer explicitement Claude-only, Copilot-only et mécanismes communs.
4. Vérifier les faits évolutifs auprès de sources officielles avant publication.
5. Maintenir le **repo entier**, pas seulement `docs/`, lorsque des instructions, templates, scripts, agents ou workflows influencent la documentation.

## Artefacts Claude natifs

Le dépôt versionne désormais :

```text
.claude/
├── settings.json
├── rules/
│   └── documentation.md
├── agents/
│   ├── doc-writer.md
│   ├── doc-reviewer.md
│   ├── nav-maintainer.md
│   ├── official-doc-audit.md
│   └── official-doc-sync.md
└── skills/
    └── doc-writer/
        └── SKILL.md
```

Utilise ces artefacts pour les workflows Claude. Les fichiers `.github/agents`, `.github/instructions`, `.github/prompts`, `.github/skills` et `.github/hooks` restent les intégrations Copilot et ne sont pas interchangeables avec `.claude/`.

## Sources

Priorité :

- Claude Code : `https://code.claude.com/docs/`
- Claude Platform : `https://platform.claude.com/docs/`
- Anthropic : `https://www.anthropic.com/` et `https://claude.com/pricing`
- GitHub Copilot : documentation et changelog officiels GitHub
- outils tiers : documentation/dépôt officiels de l'éditeur

Évite les versions, prix, quotas, noms de modèles et raccourcis figés lorsqu'ils ne sont pas nécessaires. Lorsqu'une valeur exacte est importante, source-la et date sa vérification.

## Validation

Après modification du site :

```bash
python -m mkdocs build --strict
python scripts/validate-links.py
```

Corrige les erreurs plutôt que d'assouplir les validateurs.

## Git

- Ne jamais pousser directement sur `main`.
- Ne jamais merger automatiquement une Pull Request.
- Travailler sur une branche et passer par une PR.
- Le déploiement GitHub Pages intervient après intégration manuelle dans `main`.

## Sécurité

- Ne pas lire/committer `.env`, secrets, tokens ou credentials inutilement.
- `.claude/settings.local.json` est local et ne doit pas être versionné.
- Les hooks, skills et agents versionnés sont du code/configuration de confiance : les relire comme toute autre modification sensible.
