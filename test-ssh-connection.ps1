# Test SSH connection
$Username = "root"
$ServerIP = "136.111.97.150"
$Port = 22

Write-Host "Testing SSH connection..." -ForegroundColor Cyan
Write-Host ""

# Test with verbose output
$result = ssh -v -p $Port $Username@$ServerIP "echo 'Test'" 2>&1

Write-Host "SSH Output:" -ForegroundColor Yellow
Write-Host $result -ForegroundColor Gray

Write-Host ""
if ($LASTEXITCODE -eq 0) {
    Write-Host "SUCCESS! SSH Key is working!" -ForegroundColor Green
} else {
    Write-Host "FAILED! SSH Key not configured correctly." -ForegroundColor Red
    Write-Host ""
    Write-Host "Make sure you:" -ForegroundColor Yellow
    Write-Host "1. Added the public key to ~/.ssh/authorized_keys on server" -ForegroundColor White
    Write-Host "2. Set correct permissions: chmod 600 ~/.ssh/authorized_keys" -ForegroundColor White
    Write-Host "3. The key in authorized_keys matches your local public key" -ForegroundColor White
}

