# Test SSH connection with password
$Username = "root"
$ServerIP = "136.111.97.150"
$Password = "1234qwer@@"
$Port = 22

Write-Host "Testing SSH connection..." -ForegroundColor Cyan
Write-Host "Server: $ServerIP" -ForegroundColor Green
Write-Host "Username: $Username" -ForegroundColor Green
Write-Host ""

# Try using ssh with password via expect-like approach
Write-Host "Note: The server may require SSH key authentication." -ForegroundColor Yellow
Write-Host "If password authentication is disabled, you need to:" -ForegroundColor Yellow
Write-Host "1. Generate SSH key: ssh-keygen -t rsa" -ForegroundColor White
Write-Host "2. Copy key to server: ssh-copy-id -p $Port $Username@$ServerIP" -ForegroundColor White
Write-Host ""

# Alternative: Try plink if available
$plink = Get-Command plink -ErrorAction SilentlyContinue
if ($plink) {
    Write-Host "Trying with plink..." -ForegroundColor Yellow
    $cmd = "echo 'test'"
    $result = echo y | plink -ssh -P $Port -pw $Password $Username@$ServerIP $cmd 2>&1
    Write-Host $result
} else {
    Write-Host "plink not found. Install PuTTY for password-based SSH." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "To execute commands, you can:" -ForegroundColor Cyan
Write-Host "1. Use WinSCP to connect and execute commands" -ForegroundColor White
Write-Host "2. Generate SSH key and copy it to server" -ForegroundColor White
Write-Host "3. Use plink (PuTTY) for password authentication" -ForegroundColor White

