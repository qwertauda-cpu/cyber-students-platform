# Push with GitHub Token
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Push to GitHub with Token" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$token = $env:GITHUB_TOKEN
if (-not $token) {
    Write-Host "GitHub Personal Access Token required." -ForegroundColor Yellow
    Write-Host "Get one from: https://github.com/settings/tokens" -ForegroundColor Cyan
    Write-Host "Required scope: repo" -ForegroundColor Gray
    Write-Host ""
    $secureToken = Read-Host "Enter your GitHub token" -AsSecureString
    if ($secureToken) {
        $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureToken)
        $token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    }
}

if ($token) {
    Write-Host ""
    Write-Host "Updating remote URL with token..." -ForegroundColor Cyan
    $repoUrl = "https://${token}@github.com/qwertauda/cyber-students-platform.git"
    git remote set-url origin $repoUrl
    
    Write-Host "Pushing changes..." -ForegroundColor Cyan
    git push -u origin main
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "Success! Changes pushed to GitHub." -ForegroundColor Green
        Write-Host "Repository: https://github.com/qwertauda/cyber-students-platform" -ForegroundColor Cyan
        
        # Remove token from URL for security
        git remote set-url origin https://github.com/qwertauda/cyber-students-platform.git
        Write-Host ""
        Write-Host "Token removed from remote URL for security." -ForegroundColor Gray
    } else {
        Write-Host ""
        Write-Host "Push failed. Check:" -ForegroundColor Red
        Write-Host "1. Token has 'repo' scope" -ForegroundColor Yellow
        Write-Host "2. Repository exists and you have access" -ForegroundColor Yellow
        Write-Host "3. Repository name is correct" -ForegroundColor Yellow
    }
} else {
    Write-Host ""
    Write-Host "No token provided. Cannot push." -ForegroundColor Red
    Write-Host ""
    Write-Host "Alternative: Use GitHub Desktop or Git Credential Manager" -ForegroundColor Cyan
}

