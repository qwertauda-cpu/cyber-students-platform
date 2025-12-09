# Setup SSH key on server for password-less access
$Username = "root"
$ServerIP = "136.111.97.150"
$Password = "1234qwer@@"
$Port = 22

Write-Host "Setting up SSH key on server..." -ForegroundColor Cyan

# Read public key
$pubKey = Get-Content "$env:USERPROFILE\.ssh\id_rsa.pub" -ErrorAction SilentlyContinue

if (-not $pubKey) {
    Write-Host "SSH public key not found. Generating new key..." -ForegroundColor Yellow
    ssh-keygen -t rsa -f "$env:USERPROFILE\.ssh\id_rsa" -N '""' -q
    $pubKey = Get-Content "$env:USERPROFILE\.ssh\id_rsa.pub"
}

Write-Host "Public key:" -ForegroundColor Green
Write-Host $pubKey -ForegroundColor Gray
Write-Host ""

# Try to copy key using ssh-copy-id (if available) or manual method
Write-Host "Copying key to server..." -ForegroundColor Yellow

# Method 1: Try ssh-copy-id
$sshCopyId = Get-Command ssh-copy-id -ErrorAction SilentlyContinue
if ($sshCopyId) {
    Write-Host "Using ssh-copy-id..." -ForegroundColor Green
    $env:SSH_ASKPASS_REQUIRE = "never"
    echo $Password | ssh-copy-id -p $Port -o StrictHostKeyChecking=no $Username@$ServerIP 2>&1
} else {
    Write-Host "ssh-copy-id not available. Manual setup required:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "1. Connect to server manually:" -ForegroundColor White
    Write-Host "   ssh -p $Port $Username@$ServerIP" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "2. On server, run:" -ForegroundColor White
    Write-Host "   mkdir -p ~/.ssh" -ForegroundColor Cyan
    Write-Host "   chmod 700 ~/.ssh" -ForegroundColor Cyan
    Write-Host "   echo '$pubKey' >> ~/.ssh/authorized_keys" -ForegroundColor Cyan
    Write-Host "   chmod 600 ~/.ssh/authorized_keys" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Or use WinSCP to manually add the key." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "After setup, you can execute commands without password:" -ForegroundColor Green
Write-Host "ssh -p $Port $Username@$ServerIP 'command'" -ForegroundColor Cyan

