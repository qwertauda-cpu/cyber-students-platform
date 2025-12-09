# Add SSH key via SFTP (if SFTP accepts password)
$Username = "root"
$ServerIP = "136.111.97.150"
$Password = "1234qwer@@"
$Port = 22

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Add SSH Key via SFTP" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Read public key
$pubKeyPath = "$env:USERPROFILE\.ssh\id_rsa.pub"
if (-not (Test-Path $pubKeyPath)) {
    Write-Host "SSH key not found. Generating..." -ForegroundColor Yellow
    ssh-keygen -t rsa -f "$env:USERPROFILE\.ssh\id_rsa" -N '""' -q
}

$pubKey = Get-Content $pubKeyPath
Write-Host "Your public key:" -ForegroundColor Green
Write-Host $pubKey -ForegroundColor Gray
Write-Host ""

Write-Host "Since SSH doesn't accept password, you have two options:" -ForegroundColor Yellow
Write-Host ""

Write-Host "Option 1: Use WinSCP (Recommended)" -ForegroundColor Cyan
Write-Host "----------------------------------------" -ForegroundColor Gray
Write-Host "1. Download WinSCP: https://winscp.net/" -ForegroundColor White
Write-Host "2. Connect with:" -ForegroundColor White
Write-Host "   Host: $ServerIP" -ForegroundColor Cyan
Write-Host "   Port: $Port" -ForegroundColor Cyan
Write-Host "   Username: $Username" -ForegroundColor Cyan
Write-Host "   Password: $Password" -ForegroundColor Cyan
Write-Host "   Protocol: SFTP" -ForegroundColor Cyan
Write-Host ""
Write-Host "3. Navigate to: /root/.ssh/" -ForegroundColor White
Write-Host "4. Create 'authorized_keys' file (if doesn't exist)" -ForegroundColor White
Write-Host "5. Add this line to the file:" -ForegroundColor White
Write-Host $pubKey -ForegroundColor Gray
Write-Host "6. Set permissions: chmod 600 authorized_keys" -ForegroundColor White
Write-Host ""

Write-Host "Option 2: Ask Server Admin" -ForegroundColor Cyan
Write-Host "----------------------------------------" -ForegroundColor Gray
Write-Host "Contact the server administrator to:" -ForegroundColor White
Write-Host "1. Enable password authentication in /etc/ssh/sshd_config" -ForegroundColor Gray
Write-Host "   Set: PasswordAuthentication yes" -ForegroundColor Gray
Write-Host "2. Restart SSH: systemctl restart sshd" -ForegroundColor Gray
Write-Host "3. Or manually add your public key to:" -ForegroundColor Gray
Write-Host "   /root/.ssh/authorized_keys" -ForegroundColor Gray
Write-Host ""

Write-Host "Option 3: Use Web-based Terminal (if available)" -ForegroundColor Cyan
Write-Host "----------------------------------------" -ForegroundColor Gray
Write-Host "If the server has a web-based terminal (like cPanel, Plesk, etc.)" -ForegroundColor White
Write-Host "you can access it and run the commands there." -ForegroundColor White
Write-Host ""

Write-Host "Your public key to add:" -ForegroundColor Yellow
Write-Host $pubKey -ForegroundColor Gray
Write-Host ""

