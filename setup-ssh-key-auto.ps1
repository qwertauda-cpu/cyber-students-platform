# Setup SSH Key for password-less access
$Username = "root"
$ServerIP = "136.111.97.150"
$Password = "1234qwer@@"
$Port = 22

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Setup SSH Key for Remote Access" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if SSH key exists
$sshKeyPath = "$env:USERPROFILE\.ssh\id_rsa"
$sshPubKeyPath = "$env:USERPROFILE\.ssh\id_rsa.pub"

if (-not (Test-Path $sshKeyPath)) {
    Write-Host "Generating SSH key..." -ForegroundColor Yellow
    ssh-keygen -t rsa -f $sshKeyPath -N '""' -q
    Write-Host "SSH key generated!" -ForegroundColor Green
}

# Read public key
$pubKey = Get-Content $sshPubKeyPath
Write-Host ""
Write-Host "Your public key:" -ForegroundColor Cyan
Write-Host $pubKey -ForegroundColor Gray
Write-Host ""

# Try to copy key to server using plink or manual method
Write-Host "Copying SSH key to server..." -ForegroundColor Yellow
Write-Host "This requires entering the password once: $Password" -ForegroundColor Yellow
Write-Host ""

# Method 1: Try using ssh with expect-like approach
# We'll create a temporary script to handle password input

$tempScript = @"
#!/usr/bin/expect -f
set timeout 10
spawn ssh-copy-id -p $Port -o StrictHostKeyChecking=no $Username@$ServerIP
expect {
    "password:" {
        send "$Password\r"
        exp_continue
    }
    "yes/no" {
        send "yes\r"
        exp_continue
    }
    eof
}
"@

# Since expect might not be available, we'll use a different approach
Write-Host "Attempting to add key to server..." -ForegroundColor Yellow

# Create a PowerShell script that uses Posh-SSH to add the key
$setupScript = @"
Import-Module Posh-SSH -ErrorAction SilentlyContinue

`$Username = "$Username"
`$ServerIP = "$ServerIP"
`$Password = "$Password"
`$Port = $Port
`$pubKey = @'
$pubKey
'@

`$securePassword = ConvertTo-SecureString `$Password -AsPlainText -Force
`$credential = New-Object System.Management.Automation.PSCredential(`$Username, `$securePassword)

try {
    `$session = New-SSHSession -ComputerName `$ServerIP -Port `$Port -Credential `$credential -AcceptKey -ErrorAction Stop
    
    # Create .ssh directory if it doesn't exist
    `$cmd1 = "mkdir -p ~/.ssh && chmod 700 ~/.ssh"
    Invoke-SSHCommand -SessionId `$session.SessionId -Command `$cmd1 | Out-Null
    
    # Add key to authorized_keys
    `$cmd2 = "echo '$pubKey' >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
    `$result = Invoke-SSHCommand -SessionId `$session.SessionId -Command `$cmd2
    
    if (`$result.ExitStatus -eq 0) {
        Write-Host "SSH key added successfully!" -ForegroundColor Green
    } else {
        Write-Host "Warning: Exit code `$(`$result.ExitStatus)" -ForegroundColor Yellow
    }
    
    Remove-SSHSession -SessionId `$session.SessionId | Out-Null
    
} catch {
    Write-Host "Error: `$_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Manual setup required:" -ForegroundColor Yellow
    Write-Host "1. Connect: ssh -p `$Port `$Username@`$ServerIP" -ForegroundColor White
    Write-Host "2. Run: mkdir -p ~/.ssh && chmod 700 ~/.ssh" -ForegroundColor White
    Write-Host "3. Run: echo '$pubKey' >> ~/.ssh/authorized_keys" -ForegroundColor White
    Write-Host "4. Run: chmod 600 ~/.ssh/authorized_keys" -ForegroundColor White
}
"@

$setupScript | Out-File -FilePath "temp-setup.ps1" -Encoding UTF8

Write-Host "Running setup script..." -ForegroundColor Yellow
powershell -ExecutionPolicy Bypass -File "temp-setup.ps1"

# Cleanup
Remove-Item "temp-setup.ps1" -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "Testing SSH connection..." -ForegroundColor Yellow
$testResult = ssh -o BatchMode=yes -o ConnectTimeout=5 -p $Port $Username@$ServerIP "echo 'SSH Key Works!'" 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "SUCCESS! SSH Key is now configured!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "You can now execute commands without password:" -ForegroundColor Green
    Write-Host "  .\remote-exec.ps1 'pwd'" -ForegroundColor Cyan
    Write-Host "  .\remote-exec.ps1 'ls -la'" -ForegroundColor Cyan
    Write-Host "  ssh -p $Port $Username@$ServerIP 'any command'" -ForegroundColor Cyan
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "SSH key setup may need manual configuration." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Manual steps:" -ForegroundColor Cyan
    Write-Host "1. ssh -p $Port $Username@$ServerIP" -ForegroundColor White
    Write-Host "2. mkdir -p ~/.ssh && chmod 700 ~/.ssh" -ForegroundColor White
    Write-Host "3. echo '$pubKey' >> ~/.ssh/authorized_keys" -ForegroundColor White
    Write-Host "4. chmod 600 ~/.ssh/authorized_keys" -ForegroundColor White
    Write-Host ""
}

