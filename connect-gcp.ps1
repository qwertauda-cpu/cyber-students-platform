# Connect to GCP instance
$Username = "root"
$ServerIP = "136.111.97.150"
$Password = "1234qwer@@"
$Port = 22
$InstanceName = "instance-20251208-181304"
$Zone = "us-central1-c"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "GCP Instance Connection" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Instance: $InstanceName" -ForegroundColor Green
Write-Host "Zone: $Zone" -ForegroundColor Green
Write-Host "External IP: $ServerIP" -ForegroundColor Green
Write-Host ""

# Check for gcloud CLI
$gcloud = Get-Command gcloud -ErrorAction SilentlyContinue

if ($gcloud) {
    Write-Host "Found gcloud CLI!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Try connecting with:" -ForegroundColor Yellow
    Write-Host "gcloud compute ssh $InstanceName --zone=$Zone" -ForegroundColor Cyan
    Write-Host ""
} else {
    Write-Host "gcloud CLI not found." -ForegroundColor Yellow
    Write-Host ""
}

Write-Host "Since SSH key authentication is not working," -ForegroundColor Yellow
Write-Host "you can use one of these methods:" -ForegroundColor Yellow
Write-Host ""
Write-Host "Method 1: Use WinSCP/FileZilla" -ForegroundColor Cyan
Write-Host "  Host: $ServerIP" -ForegroundColor White
Write-Host "  Port: $Port" -ForegroundColor White
Write-Host "  User: $Username" -ForegroundColor White
Write-Host "  Pass: $Password" -ForegroundColor White
Write-Host "  Protocol: SFTP" -ForegroundColor White
Write-Host ""
Write-Host "Method 2: Use GCP Console" -ForegroundColor Cyan
Write-Host "  1. Go to: https://console.cloud.google.com" -ForegroundColor White
Write-Host "  2. Navigate to Compute Engine > VM instances" -ForegroundColor White
Write-Host "  3. Click 'SSH' button next to the instance" -ForegroundColor White
Write-Host "  4. This opens a browser-based terminal" -ForegroundColor White
Write-Host ""
Write-Host "Method 3: Add SSH Key via GCP Console" -ForegroundColor Cyan
Write-Host "  1. Go to Compute Engine > Metadata > SSH Keys" -ForegroundColor White
Write-Host "  2. Add your public key there" -ForegroundColor White
Write-Host "  3. This applies to all instances" -ForegroundColor White
Write-Host ""

# Show public key
Write-Host "Your public key:" -ForegroundColor Yellow
$pubKey = Get-Content "$env:USERPROFILE\.ssh\id_rsa.pub" -ErrorAction SilentlyContinue
if ($pubKey) {
    Write-Host $pubKey -ForegroundColor Gray
    Write-Host ""
    Write-Host "Add this key to GCP Metadata > SSH Keys" -ForegroundColor Green
}

