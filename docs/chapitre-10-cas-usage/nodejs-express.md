# Node.js & Express avec Claude Code

<span class="badge-intermediate">Intermédiaire</span>

Sur Node.js, Claude Code doit se fier au `package.json`, au lockfile et à la configuration TypeScript du dépôt. Les anciennes recommandations figées sur une version Node, Express, Prisma ou un test runner ont été retirées.

---

## 1. Lire le projet avant de coder

```text
Lis package.json, lockfile et tsconfig.
Identifie :
- version/runtime Node ;
- package manager ;
- ESM ou CommonJS ;
- framework HTTP et sa version ;
- validation runtime ;
- accès DB ;
- tests, lint, typecheck et build.
```

Utilisez les scripts existants :

```json
{
  "scripts": {
    "test": "...",
    "lint": "...",
    "typecheck": "...",
    "build": "..."
  }
}
```

---

## 2. `CLAUDE.md` Node minimal

```markdown
## Node / TypeScript
- Use the package manager and lockfile already present.
- Run `typecheck` after TypeScript changes.
- Validate all external input at the boundary.
- Follow the existing error middleware pattern.
- Do not add dependencies if the platform/project already provides the capability.
```

---

## 3. Route → validation → service

Exemple de séparation simple :

```typescript
router.post("/users", validate(createUserSchema), async (req, res, next) => {
  try {
    const user = await userService.create(req.body);
    res.status(201).json({ data: user });
  } catch (error) {
    next(error);
  }
});
```

Ce n'est pas un template universel : Express, son écosystème et les versions récentes peuvent offrir d'autres patterns de gestion async. Claude doit lire la version installée et le style existant avant de recopier une recette historique.

---

## 4. Validation runtime

TypeScript ne valide pas les données réseau au runtime.

```text
Trouve la bibliothèque de validation déjà utilisée.
Ajoute le schéma au même endroit que les autres endpoints.
Teste payload valide, champ absent, mauvais type et valeur interdite.
```

N'introduisez pas Zod/Joi/Valibot simplement parce qu'un exemple de documentation l'utilise si le projet possède déjà une solution.

---

## 5. Gestion des erreurs

Centralisez le mapping vers HTTP selon le pattern du projet :

```typescript
app.use((error: unknown, req, res, next) => {
  const response = toHttpError(error);
  res.status(response.status).json(response.body);
});
```

Ne retournez pas automatiquement `error.message`, stack traces ou erreurs DB au client.

---

## 6. Dépendances npm

Avant d'ajouter un package :

```text
1. vérifie si Node ou une dépendance existante couvre le besoin ;
2. vérifie le package officiel et sa compatibilité ;
3. installe avec le package manager du repo ;
4. laisse le lockfile être mis à jour par l'outil ;
5. exécute typecheck/tests/build.
```

Méfiez-vous des noms de packages plausibles mais inexistants ou non maintenus.

---

## 7. Base de données

Que le projet utilise Prisma, Drizzle, TypeORM, un driver SQL ou autre :

- respectez la transaction existante ;
- gardez les contraintes d'unicité en base lorsque nécessaire ;
- testez migrations ;
- évitez N+1 et requêtes non bornées ;
- utilisez requêtes paramétrées si SQL direct.

Claude ne doit pas migrer d'ORM pour simplifier une petite feature.

---

## 8. Tests HTTP

```text
Ajoute un test d'intégration pour POST /users.
Réutilise le client HTTP, les fixtures et le setup DB existants.
Couvre 201, payload invalide, conflit et erreur d'autorisation si applicable.
Exécute ce test avant la suite complète.
```

Le framework de test doit venir du dépôt : Vitest, Jest, Node test runner ou autre.

---

## 9. ESM / CommonJS

Ne « corrigez » pas les imports sans vérifier :

- `type` dans `package.json` ;
- `module` / `moduleResolution` TypeScript ;
- runtime cible ;
- bundler éventuel.

Les erreurs de modules sont souvent des incompatibilités de configuration, pas des imports à modifier au hasard.

---

## 10. Sécurité

Pour une API Node :

- validation des inputs ;
- auth/authz testées ;
- cookies/headers/CORS selon politique ;
- secrets hors logs et code ;
- timeouts et taille de payload bornés ;
- dépendances auditées selon l'outillage du projet.

---

## Copilot — référence

Les instructions `.github/copilot-instructions.md` et exemples Copilot Node restent dans le dépôt lorsque nécessaires. Claude utilise en priorité `CLAUDE.md`, rules et skills.

---

## Sources

- [Node.js — documentation](https://nodejs.org/docs/latest/api/) — vérifier la version réellement installée
- [Express — documentation](https://expressjs.com/) — vérifier la version du projet
- [Claude Code — VS Code](https://code.claude.com/docs/en/vs-code) — consulté le 2026-09-28

## Prochaine étape

**[React & TypeScript](react-typescript.md)** pour le frontend, ou **[Node.js & React](nodejs-react.md)** pour un workflow full-stack.
