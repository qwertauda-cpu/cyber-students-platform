# Create GitHub Repository and Push
param(
    [string]$Token = ""
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Create GitHub Repository & Push" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$repoName = "cyber-students-platform"
$username = "qwertauda"

# Get token if not provided
if (-not $Token) {
    $Token = $env:GITHUB_TOKEN
}

if (-not $Token) {
    Write-Host "GitHub Personal Access Token required." -ForegroundColor Yellow
    Write-Host "Get one from: https://github.com/settings/tokens" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Option 1: Set environment variable:" -ForegroundColor White
    Write-Host "  `$env:GITHUB_TOKEN = 'your-token-here'" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Option 2: Create repository manually:" -ForegroundColor White
    Write-Host "  1. Go to: https://github.com/new" -ForegroundColor Cyan
    Write-Host "  2. Name: $repoName" -ForegroundColor Cyan
    Write-Host "  3. Click Create repository" -ForegroundColor Cyan
    Write-Host "  4. Then run: git push -u origin main" -ForegroundColor Cyan
    Write-Host ""
    
    # Open browser
    Start-Process "https://github.com/new?name=$repoName"
    
    Write-Host "Opened GitHub in browser. After creating repository, press Enter to push..." -ForegroundColor Yellow
    Read-Host
    
    Write-Host ""
    Write-Host "Pushing changes..." -ForegroundColor Cyan
    git push -u origin main
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "Success! Changes pushed." -ForegroundColor Green
    }
    exit
}

# Create repository using API
Write-Host "Creating repository using GitHub API..." -ForegroundColor Cyan

$body = @{
    name = $repoName
    description = "Cybersecurity Student Community Platform"
    private = $false
} | ConvertTo-Json

$headers = @{
    "Authorization" = "Bearer $Token"
    "Accept" = "application/vnd.github.v3+json"
    "X-GitHub-Api-Version" = "2022-11-28"
}

try {
    $response = Invoke-RestMethod -Uri "https://api.github.com/user/repos" -Method Post -Headers $headers -Body $body -ContentType "application/json"
    Write-Host "Repository created successfully!" -ForegroundColor Green
    Write-Host "URL: $($response.html_url)" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "Pushing changes..." -ForegroundColor Cyan
    git push -u origin main
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "Success! All changes pushed to GitHub." -ForegroundColor Green
        Write-Host "Repository: $($response.html_url)" -ForegroundColor Cyan
    } else {
        Write-Host ""
        Write-Host "Repository created but push failed." -ForegroundColor Yellow
        Write-Host "Try manually: git push -u origin main" -ForegroundColor Cyan
    }
} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    
    if ($_.Exception.Response.StatusCode -eq 401) {
        Write-Host ""
        Write-Host "Invalid token. Please check your GitHub token." -ForegroundColor Yellow
    } elseif ($_.Exception.Response.StatusCode -eq 422) {
        Write-Host ""
        Write-Host "Repository might already exist. Attempting to push..." -ForegroundColor Yellow
        git push -u origin main
    } else {
        Write-Host ""
        Write-Host "Please create repository manually at: https://github.com/new" -ForegroundColor Yellow
        Start-Process "https://github.com/new?name=$repoName"
    }
}

