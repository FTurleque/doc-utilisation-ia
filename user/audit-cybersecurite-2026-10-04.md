# Audit du chapitre Hacker & IA — 4 octobre 2026

Périmètre : les douze pages existantes de `docs/chapitre-15-hacker-ia/`, leur navigation et les liens vers les guides de sécurité, RAG, sandbox et outils. Les modifications antérieures des autres chapitres ont été conservées.

## Constats

- Socle défensif pertinent, mais nombreuses références limitées aux pages d'accueil des organismes.
- Confusion possible entre incidents effectivement rapportés et familles de scénarios ; chronologie et réserves ajoutées.
- Absence de guide transverse expliquant les frontières de confiance, permissions effectives et limites de la sandbox.
- Contrôles et réponse aux incidents trop déclaratifs : preuves de refus, reprise, révocation effective, caches et processus persistants à détailler.
- Risque de collecte excessive par la télémétrie ; événements et traces doivent être contrôlés séparément.

## Sources inspectées

- Claude Code : `security.md`, `sandboxing.md`, `monitoring-usage.md`, `vs-code.md`, `jetbrains.md` ; lecture ciblée des sections pertinentes via leurs versions Markdown officielles.
- Anthropic : Threat Intelligence, rapport du 10 septembre 2026 et publication de novembre 2025 sur une opération orchestrée avec Claude Code.
- OWASP : pages des éditions LLM 2026, agentique 2026, ACS et annonce de septembre 2026. Les PDF et catégories détaillées n'ont pas été recopiés ; aucun identifiant ou rang n'a été inféré à partir d'une édition antérieure.
- ANSSI : synthèse du 4 février 2026 et présentation des principes Zero Trust ANSSI/BSI du 11 août 2025.
- NIST : page officielle SP 800-61 Rev. 3, publiée en avril 2025, remplaçant la Rev. 2.
- MCP : guide de bonnes pratiques de sécurité draft, sections authentification, frontières et SSRF ; statut draft explicitement indiqué.

La recherche mcp-search-net était indisponible ; son fetch a fourni les contenus accessibles. Les recherches et pages OWASP ont été consultées avec le navigateur web en complément après échec d'extraction. La page Microsoft de février 2024 n'a fourni que des métadonnées avec l'extracteur ; aucun fait de son corps n'a été ajouté sur cette seule base.

## Modifications

- Deux nouvelles pages : sécurité des agents et tests défensifs avec données fictives.
- Douze pages existantes enrichies : sources précises, scénarios, indicateurs, reprise et modèles de preuve.
- Distinction entre contrôles proposés par le dépôt, comportements documentés du produit et observations des fournisseurs.
- Guides d'outils maintenus dans Outils ; renvois vers MCP, observabilité, analyse statique et sécurité du RAG.
- Trois diagrammes Mermaid : séquences d'autorisation et de test, états de réponse/reprise.
- Navigation et prochaines étapes synchronisées.

## Validation

Résultats après les dernières modifications :

- Compilation MkDocs stricte réussie.
- 195 pages de navigation vérifiées, aucune progression à corriger.
- 154 pages principales vérifiées, aucun passage Copilot hors annexe.
- 202 pages HTML et 54 910 liens internes vérifiés, aucun lien ni ancre cassé.
- Trois diagrammes analysés et rendus avec Mermaid 11 ; inspection visuelle réussie.
- `git diff --check` réussi ; fichiers temporaires de rendu supprimés.

Les scénarios de sécurité sont des propositions documentaires ; aucune cible ou configuration de production n'a été testée.
