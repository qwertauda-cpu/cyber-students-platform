# Create GitHub Repository Script
param(
    [string]$RepoName = "cyber-students-platform",
    [string]$Username = "qwertauda"
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Create GitHub Repository" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if GitHub token exists
$token = $env:GITHUB_TOKEN
if (-not $token) {
    Write-Host "Please enter GitHub Personal Access Token:" -ForegroundColor Yellow
    Write-Host "(Get it from: https://github.com/settings/tokens)" -ForegroundColor Gray
    $secureToken = Read-Host -AsSecureString
    if ($secureToken) {
        $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureToken)
        $token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    }
}

if (-not $token) {
    Write-Host ""
    Write-Host "Without token, create repository manually:" -ForegroundColor Yellow
    Write-Host "1. Open: https://github.com/new" -ForegroundColor Cyan
    Write-Host "2. Repository name: $RepoName" -ForegroundColor Cyan
    Write-Host "3. Choose Public or Private" -ForegroundColor Cyan
    Write-Host "4. Do NOT initialize with README or .gitignore" -ForegroundColor Cyan
    Write-Host "5. Click Create repository" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "After creation, press Enter to continue..." -ForegroundColor Yellow
    Read-Host
} else {
    Write-Host "Creating repository..." -ForegroundColor Cyan
    
    $body = @{
        name = $RepoName
        description = "Cybersecurity Student Community Platform"
        private = $false
    } | ConvertTo-Json

    $headers = @{
        "Authorization" = "token $token"
        "Accept" = "application/vnd.github.v3+json"
    }

    try {
        $response = Invoke-RestMethod -Uri "https://api.github.com/user/repos" -Method Post -Headers $headers -Body $body -ContentType "application/json"
        Write-Host "Repository created successfully!" -ForegroundColor Green
        Write-Host "URL: $($response.html_url)" -ForegroundColor Cyan
    } catch {
        Write-Host "Error creating repository:" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Red
        
        if ($_.Exception.Response.StatusCode -eq 401) {
            Write-Host ""
            Write-Host "Invalid token. Please create repository manually:" -ForegroundColor Yellow
            Write-Host "https://github.com/new" -ForegroundColor Cyan
        } elseif ($_.Exception.Response.StatusCode -eq 422) {
            Write-Host ""
            Write-Host "Repository already exists or invalid name." -ForegroundColor Yellow
        }
    }
}

Write-Host ""
Write-Host "Pushing changes..." -ForegroundColor Cyan
Write-Host ""

# Push to GitHub
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Changes pushed successfully!" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "Failed to push. Make sure:" -ForegroundColor Red
    Write-Host "1. Repository exists on GitHub" -ForegroundColor Yellow
    Write-Host "2. You have write permissions" -ForegroundColor Yellow
    Write-Host "3. Git is configured correctly" -ForegroundColor Yellow
}

