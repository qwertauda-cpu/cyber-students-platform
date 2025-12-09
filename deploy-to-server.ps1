# Deploy to Server Script
param(
    [string]$ServerIP = "136.111.97.150",
    [string]$Username = "qwertauda",
    [string]$RemotePath = "/var/www/html",
    [int]$Port = 22
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Deploy to Server" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Server: $ServerIP" -ForegroundColor Green
Write-Host "Username: $Username" -ForegroundColor Green
Write-Host "Remote Path: $RemotePath" -ForegroundColor Green
Write-Host ""

# Check if .next exists
if (-not (Test-Path ".next")) {
    Write-Host "Building project..." -ForegroundColor Yellow
    npm run build
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Build failed!" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "Uploading files to server..." -ForegroundColor Cyan

# Files and directories to upload
$filesToUpload = @(
    ".next",
    "app",
    "components",
    "lib",
    "store",
    "public",
    "package.json",
    "package-lock.json",
    "next.config.js",
    "tailwind.config.js",
    "tsconfig.json",
    "postcss.config.js"
)

# Upload each file/directory
foreach ($item in $filesToUpload) {
    if (Test-Path $item) {
        Write-Host "Uploading: $item" -ForegroundColor Yellow
        
        if (Test-Path $item -PathType Container) {
            # Directory
            scp -r -P $Port "$item" ${Username}@${ServerIP}:${RemotePath}/
        } else {
            # File
            scp -P $Port "$item" ${Username}@${ServerIP}:${RemotePath}/
        }
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  OK $item uploaded" -ForegroundColor Green
        } else {
            Write-Host "  Failed to upload $item" -ForegroundColor Red
        }
    } else {
        Write-Host "  $item not found, skipping" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "Installing dependencies on server..." -ForegroundColor Cyan
ssh -p $Port ${Username}@${ServerIP} "cd $RemotePath; npm install --production"

Write-Host ""
Write-Host "Stopping old application..." -ForegroundColor Cyan
ssh -p $Port ${Username}@${ServerIP} "cd $RemotePath; pkill -f next"

Write-Host ""
Write-Host "Starting application..." -ForegroundColor Cyan
ssh -p $Port ${Username}@${ServerIP} "cd $RemotePath; nohup npm start > app.log 2>&1 &"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Deployment completed!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
$websiteUrl = "http://$ServerIP:3000"
Write-Host "Website should be available at: $websiteUrl" -ForegroundColor Cyan
