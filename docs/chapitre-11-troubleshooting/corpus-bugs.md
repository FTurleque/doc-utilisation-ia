# Auditer et assainir un corpus de bugs

<span class="badge-intermediate">Intermédiaire</span> <span class="badge-expert">Expert</span>

Un backlog ancien finit souvent par mélanger de vrais bugs encore reproductibles, des doublons, des incidents déjà corrigés, des demandes d'évolution classées comme bugs, des problèmes liés à des versions abandonnées et des rapports trop incomplets pour être actionnables.

L'objectif n'est pas de « fermer le maximum de tickets ». Il est de produire un corpus **plus petit, plus fiable et plus utile** pour le développement, les tests, la documentation et les agents IA.

!!! danger "Première passe en lecture seule"
    Exportez et analysez le corpus avant toute modification. Produisez des décisions proposées, puis faites une revue humaine avant de renommer, fusionner, relabelliser ou fermer des tickets.

---

## À quoi ressemble un corpus sain ?

Chaque bug conservé devrait répondre à ces questions :

| Question | Preuve attendue |
|---|---|
| Le problème existe-t-il encore ? | reproduction sur une version supportée |
| Quel comportement est attendu ? | spec, test, contrat API ou documentation |
| Quel comportement est observé ? | logs, stack trace, capture ou sortie de test |
| Quel est le périmètre ? | version, module, OS et configuration |
| Est-ce un doublon ? | lien vers le ticket canonique |
| Quelle est la cause actuelle ? | diagnostic confirmé ou « inconnue » explicitement |
| Quel est l'impact ? | utilisateur, données, sécurité ou disponibilité |
| Quelle est la prochaine action ? | corriger, reproduire, fusionner, reclasser ou fermer |
| Qu'est-ce qui empêchera la régression ? | test, règle, monitoring ou ADR si pertinent |

Un ticket ancien sans preuve ne doit pas être considéré automatiquement comme une exigence encore active.

---

## Les décisions possibles

| Décision | Quand l'utiliser |
|---|---|
| **Conserver actif** | bug actuel, reproductible ou suffisamment prouvé, avec impact et prochaine action |
| **À confirmer** | signal plausible mais preuve ou reproduction insuffisante |
| **Fusionner / doublon** | même comportement et surtout même cause ou même correctif attendu |
| **Reclasser** | enhancement, dette technique, question, documentation, support ou tâche |
| **Promouvoir en test/règle** | bug corrigé dont la leçon doit empêcher une régression |
| **Fermer comme obsolète / non planifié** | version abandonnée, fonctionnalité supprimée ou cas non supporté |
| **Traiter hors backlog public** | vulnérabilité ou donnée sensible nécessitant un canal sécurité |

Un bug peut être **fermé tout en restant extrêmement utile** si sa valeur a été transférée vers un test de régression, une règle de validation, un runbook ou une documentation.

---

## Workflow global

~~~mermaid
flowchart TD
    A["Snapshot du corpus"] --> B["Normaliser les données"]
    B --> C["Reclasser les faux bugs"]
    C --> D["Regrouper les doublons"]
    D --> E["Vérifier sur la baseline actuelle"]
    E --> F{"Décision"}
    F -->|Actif| G["Bug canonique + prochaine action"]
    F -->|Doublon| H["Lien vers le canonique"]
    F -->|Corrigé utile| I["Test / règle / doc / ADR"]
    F -->|Obsolète| J["Fermer avec justification"]
    F -->|Preuve insuffisante| K["À confirmer"]
    G --> L["Revue humaine"]
    H --> L
    I --> L
    J --> L
    K --> L
~~~

---

## Étape 0 — définir la baseline

Avant de relire des centaines de tickets, définissez ce que signifie **« actuel »**.

Exemple :

~~~text
Branche de référence : main
Versions supportées : 3.x et 4.x
Java : 21
OS supportés : Linux + Windows
Base de données : PostgreSQL 16+
Fonctionnalités retirées : ancien moteur batch v1
Date de l'audit : 2026-10-15
~~~

Sans baseline, un bug ancien sur une version abandonnée peut sembler toujours pertinent alors qu'il n'existe plus aucun environnement supporté où il peut se produire.

---

## Étape 1 — faire un snapshot complet

### Dépôt GitHub

Avec GitHub CLI :

~~~bash
mkdir -p .audit

gh issue list \
  --repo OWNER/REPO \
  --state all \
  --limit 1000 \
  --json number,title,state,stateReason,labels,body,createdAt,updatedAt,closedAt,url,comments \
  > .audit/issues-snapshot.json
~~~

Adaptez <code>--limit</code> à la taille réelle du dépôt et vérifiez que le nombre exporté correspond au corpus attendu.

Sous PowerShell, une seule ligne évite les problèmes d'échappement :

~~~powershell
New-Item -ItemType Directory -Force .audit | Out-Null
gh issue list --repo OWNER/REPO --state all --limit 1000 --json number,title,state,stateReason,labels,body,createdAt,updatedAt,closedAt,url,comments | Out-File -Encoding utf8 .audit/issues-snapshot.json
~~~

!!! warning "Données sensibles"
    Les corps et commentaires peuvent contenir des logs, chemins, tokens oubliés, données client ou informations personnelles. Le snapshot d'audit ne doit pas être automatiquement committé.

### Corpus local ou autre tracker

Pour Jira, Azure DevOps, CSV, Markdown ou autre source, construisez le même inventaire en conservant toujours :

- identifiant source ;
- titre et contenu originaux ;
- état original ;
- date de création et dernière mise à jour ;
- liens vers PR, commits et tests si disponibles.

Ne réécrivez pas encore le corpus.

---

## Étape 2 — créer un registre d'audit séparé

Ne mélangez pas l'analyse avec les données sources.

Exemple :

~~~text
.audit/
├── issues-snapshot.json
├── bug-audit.csv
└── bug-audit-report.md
~~~

Champs utiles :

~~~text
id
title
original_state
classification
current_repro_status
supported_version
duplicate_of
root_cause
impact
evidence
regression_test
decision
decision_reason
next_action
last_verified
reviewer
~~~

Utilisez des statuts bornés pour la reproduction :

~~~text
reproduced
not-reproduced
fixed-on-current
obsolete-environment
insufficient-evidence
not-a-bug
not-tested
~~~

Évitez « probablement corrigé » ou « semble obsolète » sans preuve.

---

## Étape 3 — séparer les vrais bugs du reste

Un bug décrit un **écart entre comportement attendu et comportement observé**.

| Contenu réel | Destination recommandée |
|---|---|
| nouvelle capacité souhaitée | enhancement / OpenSpec |
| refactoring sans défaut observable | dette technique |
| question d'utilisation | support / discussion / documentation |
| installation locale mal configurée | troubleshooting, sauf cause produit confirmée |
| alerte sécurité | processus sécurité privé |
| contrainte structurelle durable | ADR si un véritable arbitrage existe |

Cette passe réduit le bruit sans décider encore si les vrais bugs restants sont toujours valides.

---

## Étape 4 — regrouper les doublons par cause

Deux titres proches ne suffisent pas.

~~~text
"Timeout à l'enregistrement"
"Erreur 504 sur sauvegarde"
~~~

Ces tickets peuvent avoir la même cause ou deux causes totalement différentes.

Un doublon solide combine idéalement :

~~~text
même chemin d'exécution
+ même condition de déclenchement
+ même comportement observé
+ même cause ou même correctif
~~~

Si seule la similarité textuelle est connue, classez le groupe comme **candidat doublon**.

---

## Étape 5 — pré-trier avec Claude en lecture seule

Prompt recommandé :

~~~text
Tu analyses un snapshot de bugs en lecture seule.

Pour chaque ticket, retourne :
- id ;
- type probable : bug | enhancement | dette | support | sécurité | inconnu ;
- comportement attendu ;
- comportement observé ;
- environnement/version mentionnés ;
- preuve disponible ;
- information manquante ;
- doublons candidats ;
- statut de reproduction à vérifier ;
- action proposée ;
- justification courte.

Contraintes :
- ne ferme et ne modifie aucune issue ;
- n'invente jamais une cause historique ;
- distingue fait, hypothèse et absence d'information ;
- deux tickets ne sont doublons que si leur cause ou leur correctif peuvent réellement être communs ;
- un bug corrigé peut être conservé sous forme de test plutôt que comme issue ouverte.
~~~

Pour un gros corpus, traitez par sous-système : auth, paiement, persistence, messaging, UI, performance, installation, etc.

Un subagent par domaine peut produire une synthèse, puis le contexte principal compare les clusters transverses.

---

## Étape 6 — vérifier chaque cluster contre le produit actuel

Pour chaque bug canonique :

1. identifier la version et le chemin concernés ;
2. chercher le code actuel ;
3. chercher les PR ou commits susceptibles de l'avoir corrigé ;
4. chercher un test existant ;
5. tenter une reproduction minimale sur la baseline actuelle ;
6. enregistrer la commande et le résultat.

Prompt utile :

~~~text
Bug #123 — analyse en lecture seule.

1. Trouve le code actuellement concerné.
2. Cherche les tests couvrant déjà ce comportement.
3. Cherche les changements reliés au problème si l'historique est disponible.
4. Propose une reproduction minimale sur la baseline supportée.
5. N'annonce "corrigé" que si tu as une preuve : test, reproduction négative pertinente ou changement clairement relié.
6. Retourne les inconnues explicitement.
~~~

### Si le bug se reproduit

Conservez-le avec :

- reproduction minimale ;
- impact ;
- test de régression à écrire ;
- propriétaire ou prochaine action.

### S'il ne se reproduit plus

Cherchez une preuve avant fermeture :

- test qui couvre le comportement ;
- commit ou PR de correction ;
- suppression du composant concerné ;
- version devenue non supportée.

Sans preuve suffisante, utilisez **À confirmer**.

---

## Étape 7 — transférer la connaissance utile hors du backlog

### Bug fonctionnel corrigé

~~~text
bug
→ test qui reproduit l'échec
→ correctif
→ test vert permanent
→ fermeture avec lien vers la preuve
~~~

### Bug architectural récurrent

Si plusieurs bugs proviennent de la même violation structurelle :

~~~text
plusieurs bugs
→ même cause structurelle confirmée
→ décision durable
→ ADR
→ règle Archgate / ArchUnit / linter
~~~

Ne créez pas un ADR pour un bug isolé. Il faut une contrainte durable ou un arbitrage à conserver.

Voir **[Archgate CLI](../chapitre-13-outils-economies/archgate.md)** et **[Gérer les ADR](../chapitre-9-bonnes-pratiques/adr-claude.md)**.

### Ambiguïté fonctionnelle

Transformez la connaissance en critère d'acceptation, spec OpenSpec, contrat API ou exemple documenté.

### Incident d'exploitation

Transformez-la en alerte, dashboard, runbook ou test de résilience.

Le backlog ne doit pas être votre seule mémoire technique.

---

## Étape 8 — choisir un ticket canonique

Le ticket canonique doit être le meilleur dossier technique, pas automatiquement le plus ancien.

Il doit idéalement contenir :

~~~text
symptôme
+ attendu / observé
+ reproduction
+ environnement
+ impact
+ cause connue ou état du diagnostic
+ liens PR/commit
+ test de régression
+ état actuel
~~~

Sur GitHub :

~~~bash
gh issue close 456 --duplicate-of 123
~~~

Ne supprimez pas le doublon : son historique et ses mots-clés restent utiles.

---

## Étape 9 — fermer avec une raison vérifiable

Exemple :

~~~text
Audit du 2026-10-15.

Décision : fermé comme obsolète.

Preuves :
- le problème concernait la branche 1.x, qui n'est plus supportée ;
- le composant a été supprimé dans la migration #987 ;
- aucun chemin équivalent n'existe sur la baseline 4.x.

Connaissance conservée :
- test de migration : <lien>
- documentation : <lien>

Si le symptôme réapparaît sur une version supportée, ouvrir un nouveau ticket avec reproduction minimale.
~~~

GitHub CLI permet de distinguer les motifs :

~~~bash
gh issue close 123 --reason completed
gh issue close 124 --reason "not planned"
gh issue close 125 --duplicate-of 123
~~~

Fermer n'efface donc pas l'historique.

---

## Étape 10 — améliorer les bugs conservés

Template recommandé :

~~~markdown
## Symptôme

## Comportement attendu

## Comportement observé

## Reproduction minimale
1.
2.
3.

## Environnement
- version :
- OS :
- runtime :
- configuration pertinente :

## Impact

## Preuves
- logs :
- stack trace :
- capture :
- test :

## Diagnostic actuel
### Faits
### Hypothèses
### Inconnues

## Régression
- test existant :
- test à ajouter :

## Liens
- tickets similaires :
- PR/commits :
- ADR/spec :
~~~

Ne mettez jamais une hypothèse dans la section « Faits ».

---

## Étape 11 — séparer priorité et qualité de preuve

~~~text
qualité de la preuve
≠ sévérité
≠ priorité produit
≠ fréquence
~~~

| Axe | Questions |
|---|---|
| Impact | perte de données, blocage, sécurité, contournement ? |
| Fréquence | systématique, fréquent, rare, inconnu ? |
| Portée | tous les utilisateurs ou configuration particulière ? |
| Preuve | reproduction fiable, partielle ou absente ? |
| Effort | correctif local, migration ou changement architectural ? |

Évitez les scores pseudo-précis si vous ne disposez pas de données comparables.

---

## Étape 12 — très gros corpus

Pour plusieurs centaines ou milliers de bugs :

~~~text
Phase A — métadonnées
  reclassification évidente + état/version

Phase B — clusters
  doublons candidats par domaine

Phase C — clusters prioritaires
  reproduction + recherche de cause

Phase D — promotion
  tests / règles / docs / specs

Phase E — nettoyage du tracker
  uniquement après revue humaine
~~~

Commencez par les bugs ouverts, récents, impactants, fortement dupliqués et concernant du code encore supporté.

Les anciens tickets fermés peuvent ensuite être relus pour extraire les tests ou règles manquants.

---

## Exemple de registre de décision

| ID | Repro actuelle | Doublon | Valeur durable | Décision |
|---|---|---|---|---|
| #101 | oui | non | test manquant | conserver + corriger + test |
| #102 | oui | #101 | aucune supplémentaire | fermer doublon |
| #103 | non, version retirée | non | aucune | fermer obsolète |
| #104 | inconnu | candidat #101 | logs utiles | demander preuve |
| #105 | corrigé | non | cause architecturale récurrente | test + ADR/règle puis fermer |
| #106 | n/a | non | demande produit | reclasser enhancement |

---

## Quand Archgate devient pertinent

Bon candidat :

~~~text
5 bugs différents
→ même dépendance interdite entre domaine et infrastructure
→ correction répétée
→ décision durable de séparation
→ ADR + règle automatique
~~~

Mauvais candidat :

~~~text
un NullPointerException local
→ condition oubliée dans une méthode
→ test de régression suffit
~~~

Archgate intervient **après le diagnostic**, quand une leçon devient une contrainte architecturale durable.

---

## Definition of Done de l'audit

- [ ] snapshot d'origine conservé ;
- [ ] chaque ticket a une décision ou reste explicitement « à confirmer » ;
- [ ] les doublons pointent vers un canonique ;
- [ ] les bugs actifs ont une prochaine action ;
- [ ] les bugs corrigés à forte valeur ont un test, une règle ou une documentation durable ;
- [ ] les tickets obsolètes sont fermés avec justification ;
- [ ] les problèmes de sécurité ont quitté le canal public si nécessaire ;
- [ ] aucune cause historique n'a été inventée par l'IA ;
- [ ] les modifications du tracker ont été revues humainement.

---

## Entretien après le grand nettoyage

À chaque bug corrigé :

~~~text
reproduction
→ test de régression
→ correctif minimal
→ test vert
→ vérifier si une règle ou doc durable manque
→ fermer avec liens vers la preuve
~~~

Périodiquement, recherchez les tickets sans reproduction, les doublons non reliés, les bugs corrigés sans test et les issues « bug » qui sont en réalité des demandes produit.

---

## Sources

Sources vérifiées le **15 octobre 2026** :

- [GitHub CLI — gh issue list](https://cli.github.com/manual/gh_issue_list)
- [GitHub CLI — gh issue view](https://cli.github.com/manual/gh_issue_view)
- [GitHub CLI — gh issue close](https://cli.github.com/manual/gh_issue_close)
- [Workflows IA complets](../chapitre-9-bonnes-pratiques/workflows-ia.md)
- [Archgate CLI](../chapitre-13-outils-economies/archgate.md)
- [ADR avec Claude Code et OpenSpec](../chapitre-9-bonnes-pratiques/adr-claude.md)

---

## Prochaine étape

Poursuivez avec **[Comparaison des Problèmes](comparaison-problemes.md)**, la page suivante dans le menu.
