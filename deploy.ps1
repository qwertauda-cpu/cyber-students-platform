# سكريبت رفع المشروع على السيرفر
# Server: 136.111.97.150

param(
    [string]$Username = "root",
    [string]$ServerIP = "136.111.97.150",
    [string]$Password = "123qwe@@",
    [int]$Port = 22,
    [string]$RemotePath = "/var/www/html"
)

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "رفع المشروع على السيرفر" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Server: $ServerIP" -ForegroundColor Green
Write-Host "Username: $Username" -ForegroundColor Green
Write-Host "Remote Path: $RemotePath" -ForegroundColor Green
Write-Host ""

# التحقق من Posh-SSH module
$poshSSH = Get-Module -ListAvailable -Name Posh-SSH

if (-not $poshSSH) {
    Write-Host "تثبيت Posh-SSH module..." -ForegroundColor Yellow
    try {
        Install-Module -Name Posh-SSH -Force -Scope CurrentUser -AllowClobber
        Import-Module Posh-SSH
        Write-Host "✓ تم تثبيت Posh-SSH" -ForegroundColor Green
    } catch {
        Write-Host "❌ فشل تثبيت Posh-SSH" -ForegroundColor Red
        Write-Host "جاري استخدام طريقة بديلة..." -ForegroundColor Yellow
    }
} else {
    Import-Module Posh-SSH
    Write-Host "✓ Posh-SSH متوفر" -ForegroundColor Green
}

# بناء المشروع
Write-Host ""
Write-Host "بناء المشروع..." -ForegroundColor Cyan
if (Test-Path "package.json") {
    Write-Host "تثبيت المتطلبات..." -ForegroundColor Yellow
    npm install --silent
    
    Write-Host "بناء المشروع..." -ForegroundColor Yellow
    npm run build
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ فشل بناء المشروع" -ForegroundColor Red
        exit 1
    }
    Write-Host "✓ تم بناء المشروع بنجاح" -ForegroundColor Green
}

# الاتصال بالسيرفر ورفع الملفات
Write-Host ""
Write-Host "الاتصال بالسيرفر..." -ForegroundColor Cyan

try {
    # إنشاء Credential
    $securePassword = ConvertTo-SecureString $Password -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential($Username, $securePassword)
    
    # الاتصال
    $session = New-SSHSession -ComputerName $ServerIP -Port $Port -Credential $credential -AcceptKey
    
    if ($session) {
        Write-Host "✓ تم الاتصال بالسيرفر" -ForegroundColor Green
        
        # إنشاء مجلد على السيرفر
        Write-Host "إعداد المجلد على السيرفر..." -ForegroundColor Yellow
        $createDirCmd = "mkdir -p $RemotePath && cd $RemotePath && rm -rf *"
        $result = Invoke-SSHCommand -SessionId $session.SessionId -Command $createDirCmd
        Write-Host "✓ تم إعداد المجلد" -ForegroundColor Green
        
        # قائمة الملفات للرفع
        $filesToUpload = @(
            "app",
            "components",
            "database",
            "docs",
            "lib",
            "store",
            "public",
            ".next",
            "package.json",
            "package-lock.json",
            "tsconfig.json",
            "tailwind.config.js",
            "next.config.js",
            "postcss.config.js",
            ".gitignore",
            "README.md"
        )
        
        # رفع الملفات
        Write-Host ""
        Write-Host "رفع الملفات..." -ForegroundColor Cyan
        
        foreach ($file in $filesToUpload) {
            if (Test-Path $file) {
                Write-Host "  رفع: $file" -ForegroundColor Gray
                
                if (Test-Path $file -PathType Container) {
                    # مجلد
                    Set-SCPItem -ComputerName $ServerIP -Port $Port -Credential $credential -Path $file -Destination "$RemotePath/" -Recurse
                } else {
                    # ملف
                    Set-SCPItem -ComputerName $ServerIP -Port $Port -Credential $credential -Path $file -Destination "$RemotePath/"
                }
                
                Write-Host "    ✓ تم رفع $file" -ForegroundColor Green
            }
        }
        
        # تثبيت المتطلبات على السيرفر
        Write-Host ""
        Write-Host "تثبيت المتطلبات على السيرفر..." -ForegroundColor Yellow
        $installCmd = "cd $RemotePath && npm install --production"
        $result = Invoke-SSHCommand -SessionId $session.SessionId -Command $installCmd
        if ($result.ExitStatus -eq 0) {
            Write-Host "✓ تم تثبيت المتطلبات" -ForegroundColor Green
        } else {
            Write-Host "⚠️  تحذير في تثبيت المتطلبات" -ForegroundColor Yellow
            Write-Host $result.Output -ForegroundColor Gray
        }
        
        # إغلاق الاتصال
        Remove-SSHSession -SessionId $session.SessionId | Out-Null
        
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host "✓ تم رفع المشروع بنجاح!" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "الخطوات التالية على السيرفر:" -ForegroundColor Yellow
        Write-Host "1. ssh -p $Port $Username@$ServerIP" -ForegroundColor White
        Write-Host "2. cd $RemotePath" -ForegroundColor White
        Write-Host "3. npm run build (إذا لم يتم البناء)" -ForegroundColor White
        Write-Host "4. npm start" -ForegroundColor White
        Write-Host "   أو استخدم PM2: pm2 start npm --name 'cyber-platform' -- start" -ForegroundColor Gray
        Write-Host ""
        
    } else {
        throw "فشل الاتصال بالسيرفر"
    }
    
} catch {
    Write-Host ""
    Write-Host "❌ خطأ: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "الطريقة البديلة - استخدام SCP يدوياً:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "# رفع الملفات:" -ForegroundColor White
    Write-Host "scp -r -P $Port app components database lib store package.json tsconfig.json $Username@$ServerIP:$RemotePath/" -ForegroundColor Gray
    Write-Host ""
    Write-Host "# أو استخدم WinSCP:" -ForegroundColor White
    Write-Host "  Host: $ServerIP" -ForegroundColor Gray
    Write-Host "  Port: $Port" -ForegroundColor Gray
    Write-Host "  Username: $Username" -ForegroundColor Gray
    Write-Host "  Password: $Password" -ForegroundColor Gray
    Write-Host ""
    exit 1
}
