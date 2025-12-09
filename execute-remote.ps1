# Execute commands on remote server
Import-Module Posh-SSH -ErrorAction SilentlyContinue

$Username = "root"
$ServerIP = "136.111.97.150"
$Password = "1234qwer@@"
$Port = 22

Write-Host "Connecting to server..." -ForegroundColor Cyan

$securePassword = ConvertTo-SecureString $Password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($Username, $securePassword)

try {
    $session = New-SSHSession -ComputerName $ServerIP -Port $Port -Credential $credential -AcceptKey -ErrorAction Stop
    Write-Host "Connected successfully" -ForegroundColor Green
    Write-Host ""
    
    $Command = "pwd"
    if ($args.Count -gt 0) {
        $Command = $args[0]
    }
    
    Write-Host "Executing: $Command" -ForegroundColor Yellow
    $result = Invoke-SSHCommand -SessionId $session.SessionId -Command $Command
    
    Write-Host ""
    Write-Host "Output:" -ForegroundColor Cyan
    Write-Host $result.Output -ForegroundColor White
    
    if ($result.Error) {
        Write-Host ""
        Write-Host "Errors:" -ForegroundColor Red
        Write-Host $result.Error -ForegroundColor Red
    }
    
    Write-Host ""
    Write-Host "Exit Code: $($result.ExitStatus)" -ForegroundColor Gray
    
    Remove-SSHSession -SessionId $session.SessionId | Out-Null
    
} catch {
    Write-Host "Connection failed: $_" -ForegroundColor Red
    exit 1
}
