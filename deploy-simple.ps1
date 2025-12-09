# Deploy Script
param(
    [string]$Username = "root",
    [string]$ServerIP = "136.111.97.150",
    [string]$Password = "123qwe@@",
    [int]$Port = 22,
    [string]$RemotePath = "/var/www/html"
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Deploy to Server" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Server: $ServerIP" -ForegroundColor Green
Write-Host "Username: $Username" -ForegroundColor Green
Write-Host "Remote Path: $RemotePath" -ForegroundColor Green
Write-Host ""

if (Test-Path "package.json") {
    Write-Host "Building project..." -ForegroundColor Cyan
    npm install
    npm run build
    Write-Host "Build complete" -ForegroundColor Green
}

Write-Host ""
Write-Host "Upload instructions:" -ForegroundColor Yellow
Write-Host "1. Use WinSCP:" -ForegroundColor White
Write-Host "   Host: $ServerIP" -ForegroundColor Cyan
Write-Host "   Port: $Port" -ForegroundColor Cyan
Write-Host "   Username: $Username" -ForegroundColor Cyan
Write-Host "   Password: $Password" -ForegroundColor Cyan
Write-Host ""
Write-Host "2. Or use SCP commands:" -ForegroundColor White
Write-Host "   scp -r -P $Port app components lib store public .next package.json ${Username}@${ServerIP}:${RemotePath}/" -ForegroundColor Cyan
Write-Host ""
