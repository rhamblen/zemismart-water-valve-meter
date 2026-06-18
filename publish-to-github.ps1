# publish-to-github.ps1
# Run this once from the zemismart-water-valve-meter folder to push v1.0.0 to GitHub.
# Your stored Windows Credential Manager credentials will be used automatically.

$ErrorActionPreference = "Stop"
$repo = "https://github.com/rhamblen/zemismart-water-valve-meter.git"

Set-Location $PSScriptRoot

Write-Host "Initialising git repo..." -ForegroundColor Cyan
git init
git remote add origin $repo 2>$null
if ($LASTEXITCODE -ne 0) {
    git remote set-url origin $repo
}

Write-Host "Staging files..." -ForegroundColor Cyan
git add .

Write-Host "Committing..." -ForegroundColor Cyan
git commit -m "release: v1.0.0 - initial release"

Write-Host "Tagging v1.0.0..." -ForegroundColor Cyan
git tag -a v1.0.0 -m "v1.0.0 - initial release"

Write-Host "Pushing to GitHub..." -ForegroundColor Cyan
git push -u origin main --tags

Write-Host ""
Write-Host "Done! Repo pushed to $repo" -ForegroundColor Green
Write-Host "Next: go to https://github.com/rhamblen/zemismart-water-valve-meter/releases/new" -ForegroundColor Yellow
Write-Host "  - Tag: v1.0.0" -ForegroundColor Yellow
Write-Host "  - Title: v1.0.0 - Initial Release" -ForegroundColor Yellow
Write-Host "  - Body: paste contents of releases/v1.0.0/RELEASE_NOTES.md" -ForegroundColor Yellow
Write-Host "  - Attach: releases/v1.0.0/card.yaml" -ForegroundColor Yellow
