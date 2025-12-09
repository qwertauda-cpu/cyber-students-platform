# Auto Push Script
Write-Host "Checking repository..." -ForegroundColor Cyan

# Try to push
git push -u origin main 2>&1 | Out-String

if ($LASTEXITCODE -eq 0) {
    Write-Host "Success! Changes pushed." -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "Repository not found. Please create it first:" -ForegroundColor Yellow
    Write-Host "1. Go to: https://github.com/new" -ForegroundColor Cyan
    Write-Host "2. Name: cyber-students-platform" -ForegroundColor Cyan
    Write-Host "3. Create repository (don't add README)" -ForegroundColor Cyan
    Write-Host "4. Then run this script again" -ForegroundColor Cyan
    Write-Host ""
    Start-Process "https://github.com/new?name=cyber-students-platform"
}

