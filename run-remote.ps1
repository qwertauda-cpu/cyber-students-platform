# Execute commands on remote server using Posh-SSH
Import-Module Posh-SSH -ErrorAction Stop

$Username = "root"
$ServerIP = "136.111.97.150"
$Password = "1234qwer@@"
$Port = 22

$securePassword = ConvertTo-SecureString $Password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($Username, $securePassword)

Write-Host "Connecting to $ServerIP..." -ForegroundColor Cyan

try {
    $session = New-SSHSession -ComputerName $ServerIP -Port $Port -Credential $credential -AcceptKey -ErrorAction Stop
    Write-Host "Connected! Session ID: $($session.SessionId)" -ForegroundColor Green
    
    # Get command from argument or use default
    $command = if ($args.Count -gt 0) { $args[0] } else { "pwd && ls -la" }
    
    Write-Host ""
    Write-Host "Executing: $command" -ForegroundColor Yellow
    Write-Host "----------------------------------------" -ForegroundColor Gray
    
    $result = Invoke-SSHCommand -SessionId $session.SessionId -Command $command
    
    Write-Host $result.Output -ForegroundColor White
    
    if ($result.Error) {
        Write-Host ""
        Write-Host "Errors:" -ForegroundColor Red
        Write-Host $result.Error -ForegroundColor Red
    }
    
    Write-Host "----------------------------------------" -ForegroundColor Gray
    Write-Host "Exit Status: $($result.ExitStatus)" -ForegroundColor Gray
    
    Remove-SSHSession -SessionId $session.SessionId | Out-Null
    
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "The server may require:" -ForegroundColor Yellow
    Write-Host "1. SSH key authentication (not password)" -ForegroundColor White
    Write-Host "2. Password authentication enabled in sshd_config" -ForegroundColor White
    Write-Host "3. Or use WinSCP/FileZilla for file operations" -ForegroundColor White
}

