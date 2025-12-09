# Remote command execution
$Username = "qwertauda"
$ServerIP = "136.111.97.150"
$Port = 22

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Remote Command Execution" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Testing SSH connection..." -ForegroundColor Yellow
$testResult = ssh -o BatchMode=yes -o ConnectTimeout=5 -p $Port $Username@$ServerIP "echo OK" 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "SSH key authentication works!" -ForegroundColor Green
    Write-Host ""
    
    $command = if ($args.Count -gt 0) { $args[0] } else { "pwd" }
    
    Write-Host "Executing: $command" -ForegroundColor Yellow
    Write-Host "----------------------------------------" -ForegroundColor Gray
    
    ssh -p $Port $Username@$ServerIP $command
    
    Write-Host "----------------------------------------" -ForegroundColor Gray
    
} else {
    Write-Host "SSH key authentication failed" -ForegroundColor Red
    Write-Host ""
    Write-Host "The server requires SSH key authentication." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "To execute commands, use:" -ForegroundColor Cyan
    Write-Host "1. WinSCP/FileZilla (SFTP with password)" -ForegroundColor White
    Write-Host "2. Setup SSH key first" -ForegroundColor White
    Write-Host ""
    Write-Host "Your public key location:" -ForegroundColor Yellow
    Write-Host "$env:USERPROFILE\.ssh\id_rsa.pub" -ForegroundColor Gray
}

Write-Host ""
