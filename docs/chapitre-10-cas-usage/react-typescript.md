# React & TypeScript avec Claude Code

<span class="badge-intermediate">Intermédiaire</span>

React évolue avec l'écosystème qui l'entoure. Claude Code doit donc lire `package.json`, le framework, le bundler et les conventions du dépôt avant de proposer un pattern. Cette page ne suppose plus automatiquement React 19, Next.js, Tailwind, Zustand ou un test runner particulier.

---

## 1. Identifier l'environnement réel

```text
Lis package.json et la configuration frontend.
Identifie :
- version React ;
- framework/build tool ;
- TypeScript ;
- routing ;
- rendu client/serveur ;
- state/data fetching ;
- styling ;
- tests ;
- lint/typecheck/build.
```

Une API ou un hook disponible dans une version récente n'est pas forcément utilisable dans ce projet.

---

## 2. `CLAUDE.md` frontend minimal

```markdown
## Frontend
- Run typecheck and component tests after behavior changes.
- Reuse existing component and data-fetching patterns.
- Preserve accessibility semantics.
- Do not introduce a new state-management or styling library without explicit need.
- Check the installed React/framework version before using version-specific APIs.
```

---

## 3. Composants : contrats explicites

```tsx
type UserCardProps = {
  user: User;
  onDelete?: (userId: string) => void;
};

export function UserCard({ user, onDelete }: UserCardProps) {
  return (
    <article>
      <h2>{user.displayName}</h2>
      {onDelete && (
        <button type="button" onClick={() => onDelete(user.id)}>
          Supprimer
        </button>
      )}
    </article>
  );
}
```

Préférez des props claires, HTML sémantique et comportements testables. Claude doit suivre les conventions locales (`function`, arrow component, export par défaut, etc.).

---

## 4. État et effets

Avant d'ajouter `useEffect`, demandez si le comportement est réellement un effet externe.

```text
Ce composant utilise trois useEffect.
Analyse-les avant de modifier :
- lequel synchronise avec un système externe ?
- lequel calcule seulement une valeur dérivée ?
- lequel duplique une logique de data-fetching existante ?
Propose le changement minimal et ajoute les tests pertinents.
```

Claude ne doit pas appliquer mécaniquement `useMemo`/`useCallback` comme optimisation sans mesure ou besoin structurel.

Avec `StrictMode`, React peut répéter les rendus et effectuer un cycle supplémentaire de setup/cleanup des effets **en développement** pour révéler des erreurs. Si une connexion ou un abonnement se duplique, vérifiez son cleanup et ses dépendances. Désactiver StrictMode ou ajouter un drapeau « déjà exécuté » peut masquer le défaut au lieu de le corriger ; ces vérifications ne décrivent pas le comportement normal de production.

---

## 5. Client vs serveur

Dans un framework avec rendu serveur :

- identifiez la frontière client/serveur existante ;
- ne déplacez pas de secret vers le client ;
- évitez d'importer un module serveur dans un bundle client ;
- testez le comportement de navigation et hydration si pertinent.

Les conventions dépendent du framework et de sa version : vérifiez la documentation officielle correspondante avant une migration.

---

## 6. Data fetching

Réutilisez la stratégie du projet : fetch natif, couche API, query library, server actions ou autre.

```text
Ajoute le chargement des commandes à cette page.
Trouve d'abord comment les pages voisines font le fetch, gèrent cache/loading/error et typent les réponses.
Réutilise ce pattern ; n'ajoute pas de nouvelle bibliothèque.
```

---

## 7. Accessibilité

Claude doit vérifier :

- éléments sémantiques ;
- label des champs ;
- navigation clavier ;
- focus lors des dialogues ;
- nom accessible des boutons/icônes ;
- erreurs de formulaire associées aux champs.

Demande utile :

```text
Revois ce composant uniquement pour l'accessibilité.
Utilise les tests/outils déjà présents dans le projet et signale les problèmes avec preuve.
```

---

## 8. Tests de composants

Testez le comportement visible plutôt que les détails d'implémentation.

```text
Ajoute des tests pour `UserCard` en suivant les tests voisins.
Couvre : rendu du nom, callback delete, état désactivé si applicable et navigation clavier pertinente.
Utilise les queries accessibles recommandées par la bibliothèque de tests installée.
```

Le framework de test vient du dépôt.

---

## 9. Performance frontend

Ne demandez pas « optimise React » sans métrique.

Workflow :

```text
1. reproduire le problème ;
2. mesurer (profiler, bundle, Web Vitals ou métrique projet) ;
3. identifier la cause ;
4. changer une chose ;
5. re-mesurer.
```

Lazy loading, mémoïsation et code splitting sont des outils, pas des objectifs en soi.

---

## 10. Styling

Tailwind, CSS Modules, styled components ou CSS classique peuvent tous être valides. Claude doit utiliser le système déjà adopté.

Évitez les changements de design system dans une feature fonctionnelle sauf demande explicite.

---

## 11. Migration React/framework

```text
Lis les versions installées.
Consulte les release notes/migration guides officiels actuels.
Liste les breaking changes qui concernent réellement ce repo.
Propose une migration par étapes avec tests et build à chaque jalon.
```

Ne copiez pas des recettes « React 19 » ou « Next X » dans un projet d'une autre version.

---

## Sources

- [React — contrôles de StrictMode en développement](https://react.dev/reference/react/StrictMode) — vérifié le 2026-10-03

- [React — documentation](https://react.dev/) — vérifier la version et le framework du projet
- [TypeScript — documentation](https://www.typescriptlang.org/docs/) — vérifier la version installée
- [Claude Code — VS Code](https://code.claude.com/docs/en/vs-code) — consulté le 2026-09-28

---

## Référence en annexe

[Copilot — archive de ce chapitre](../appendices/copilot/chapitre-10-cas-usage.md#page-chapitre-10-cas-usage-react-typescript).

## Prochaine étape

Poursuivez avec **[Python & FastAPI](python.md)**, la page suivante dans le menu.
