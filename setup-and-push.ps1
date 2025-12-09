# Setup and Push to GitHub
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "GitHub Repository Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Open GitHub to create repository
Write-Host "Opening GitHub to create repository..." -ForegroundColor Yellow
Write-Host "Repository name: cyber-students-platform" -ForegroundColor Cyan
Write-Host ""
Start-Process "https://github.com/new?name=cyber-students-platform&description=Cybersecurity+Student+Community+Platform"

Write-Host "Please create the repository on GitHub:" -ForegroundColor Yellow
Write-Host "1. Repository name: cyber-students-platform" -ForegroundColor White
Write-Host "2. Choose Public or Private" -ForegroundColor White
Write-Host "3. DO NOT initialize with README, .gitignore, or license" -ForegroundColor White
Write-Host "4. Click 'Create repository'" -ForegroundColor White
Write-Host ""
Write-Host "Waiting 30 seconds for you to create the repository..." -ForegroundColor Cyan
Start-Sleep -Seconds 30

Write-Host ""
Write-Host "Attempting to push..." -ForegroundColor Cyan
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Success! Changes pushed to GitHub." -ForegroundColor Green
    Write-Host ""
    Write-Host "Repository URL: https://github.com/qwertauda/cyber-students-platform" -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host "Push failed. Possible reasons:" -ForegroundColor Red
    Write-Host "1. Repository not created yet - please create it and run: git push -u origin main" -ForegroundColor Yellow
    Write-Host "2. Authentication required - you may need to use GitHub token" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "To push manually after creating repository:" -ForegroundColor Cyan
    Write-Host "  git push -u origin main" -ForegroundColor White
}

