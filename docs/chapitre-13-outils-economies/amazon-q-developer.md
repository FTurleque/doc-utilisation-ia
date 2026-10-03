# Amazon Q Developer — référence AWS en transition vers Kiro

<span class="badge-beginner">Débutant</span> <span class="badge-vscode">VS Code</span> <span class="badge-intellij">JetBrains</span>

Amazon Q Developer reste un assistant orienté développement et services AWS, mais sa trajectoire produit a changé : AWS annonce la **fin de support des plugins IDE Amazon Q Developer le 30 avril 2027** et oriente les utilisateurs vers **Kiro** pour les fonctions agentiques, chat et MCP les plus récentes.

Le **Q Developer CLI** a également été rebrandé en Kiro. Cette page est donc une référence de transition, pas un choix à considérer comme stable à long terme dans l'IDE.

---

## Quand Amazon Q reste pertinent

- diagnostic et développement fortement centrés sur AWS ;
- questions IAM, Lambda, S3, CDK ou opérations AWS ;
- équipes déjà équipées d'Amazon Q Developer Pro ;
- environnement où les workflows existants doivent être maintenus pendant la transition.

---

## IDE : anticiper la fin de support

AWS indique que les plugins Amazon Q Developer pour IDE cesseront d'être supportés le **30 avril 2027**.

Pour un nouveau déploiement, évaluez directement **Kiro** plutôt que de construire des procédures longues autour d'un plugin destiné à être retiré.

Pour une installation existante :

1. inventoriez les fonctions Q réellement utilisées ;
2. vérifiez leur équivalent Kiro ;
3. testez la migration sur un groupe pilote ;
4. documentez les différences de permissions, MCP et règles ;
5. retirez progressivement les dépendances au plugin Q.

---

## Amazon Q et Claude Code

Claude Code reste le parcours généraliste principal du dépôt. Amazon Q/Kiro peut être utile comme outil spécialisé AWS lorsque ses intégrations apportent un avantage mesurable.

Évitez une duplication systématique :

```text
Claude Code → développement général, dépôt, tests, MCP
AWS CLI / IaC / docs officielles → preuves
Amazon Q / Kiro → cas AWS où l'intégration spécialisée apporte une valeur réelle
```

---

## Sécurité AWS

Une suggestion IAM n'est jamais une validation de moindre privilège.

- testez les policies avec les outils AWS adaptés ;
- validez en environnement non-production ;
- ne collez pas de credentials dans le chat ;
- utilisez des rôles et sessions temporaires ;
- vérifiez région, compte et identité active avant toute commande destructive.

---

## Tarification et quotas

AWS fait évoluer les offres et quotas. Ne recopiez pas ici un nombre fixe de requêtes comme règle durable.

Avant une décision d'achat, vérifiez les pages officielles Amazon Q/Kiro et le périmètre exact : IDE, CLI, agent, transformations, organisation et compte AWS.

---

## Sources

- [Amazon Q Developer — IDE setup](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/q-in-IDE-setup.html) — consulté le 2026-09-28
- [Amazon Q Developer — fin de support IDE](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/q-developer-ide-end-of-support.html) — consulté le 2026-09-28
- [Amazon Q Developer — migration vers Kiro](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/upgrade-to-kiro.html) — consulté le 2026-09-28

## Prochaine étape

Poursuivez avec **[Supermaven (historique)](supermaven.md)**, la page suivante dans le menu.
