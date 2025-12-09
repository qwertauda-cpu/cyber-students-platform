# Check SSH key setup
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Checking SSH Key Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Show local public key
Write-Host "Your local public key:" -ForegroundColor Yellow
$pubKey = Get-Content "$env:USERPROFILE\.ssh\id_rsa.pub" -ErrorAction SilentlyContinue
if ($pubKey) {
    Write-Host $pubKey -ForegroundColor Gray
    Write-Host ""
    Write-Host "This key should be in ~/.ssh/authorized_keys on the server" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host "ERROR: Public key not found!" -ForegroundColor Red
    exit 1
}

# Test connection
Write-Host "Testing connection..." -ForegroundColor Yellow
$test = ssh -o BatchMode=yes -o ConnectTimeout=5 -p 22 root@136.111.97.150 "echo OK" 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "SUCCESS! SSH Key is working!" -ForegroundColor Green
} else {
    Write-Host "FAILED! Connection still not working." -ForegroundColor Red
    Write-Host ""
    Write-Host "Please verify on the server:" -ForegroundColor Yellow
    Write-Host "1. cat ~/.ssh/authorized_keys" -ForegroundColor White
    Write-Host "   (Should show the key above)" -ForegroundColor Gray
    Write-Host ""
    Write-Host "2. ls -la ~/.ssh/" -ForegroundColor White
    Write-Host "   (authorized_keys should have permissions 600)" -ForegroundColor Gray
    Write-Host ""
    Write-Host "3. Make sure the key in authorized_keys matches exactly" -ForegroundColor White
    Write-Host "   (no extra spaces, no line breaks)" -ForegroundColor Gray
}

