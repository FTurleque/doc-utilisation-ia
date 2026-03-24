# push-and-deploy.ps1
# Builds the MkDocs site, stages changes, commits, and pushes to origin/main.
# Usage: Open PowerShell in repository root and run: .\push-and-deploy.ps1

# Stop on errors
$ErrorActionPreference = "Stop"

Write-Host "1/4 - Building MkDocs site..."
py -m mkdocs build

Write-Host "2/4 - Staging all changes..."
git add -A

$commitMessage = "Déplacer sections CLI/plugins → chapitre CLI; supprimer references; corriger liens et images; ajout chapitre-7 CLI modes"

# Only commit if there are staged changes
if (-not (git diff --cached --quiet)) {
    Write-Host "3/4 - Committing..."
    git commit -m $commitMessage
} else {
    Write-Host "No staged changes to commit. Skipping commit."
}

Write-Host "4/4 - Pushing to origin/main..."
git push origin main

Write-Host "Done. If your CI deploys on push, deployment should start now."
