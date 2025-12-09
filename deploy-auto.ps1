# سكريبت رفع تلقائي على السيرفر
param(
    [string]$Username = "root",
    [string]$ServerIP = "136.111.97.150",
    [string]$Password = "1234qwer@@",
    [int]$Port = 22,
    [string]$RemotePath = "/var/www/html"
)

$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "رفع المشروع على السيرفر" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Server: $ServerIP" -ForegroundColor Green
Write-Host "Username: $Username" -ForegroundColor Green
Write-Host "Remote Path: $RemotePath" -ForegroundColor Green
Write-Host ""

# التحقق من وجود الملفات المطلوبة
if (-not (Test-Path ".next")) {
    Write-Host "⚠️  مجلد .next غير موجود. جاري البناء..." -ForegroundColor Yellow
    if (Test-Path "package.json") {
        npm install --silent
        npm run build
    }
}

# قائمة الملفات للرفع
$filesToUpload = @(
    "app",
    "components", 
    "lib",
    "store",
    "public",
    ".next",
    "package.json",
    "package-lock.json",
    "tsconfig.json",
    "tailwind.config.js",
    "next.config.js",
    "postcss.config.js"
)

Write-Host ""
Write-Host "بدء رفع الملفات..." -ForegroundColor Cyan
Write-Host ""

# استخدام plink (PuTTY) إذا كان متاحاً
$plinkPath = Get-Command plink -ErrorAction SilentlyContinue

if ($plinkPath) {
    Write-Host "استخدام plink..." -ForegroundColor Green
    
    # إنشاء ملف أوامر
    $commands = @"
cd $RemotePath
rm -rf *
mkdir -p $RemotePath
"@
    
    $commands | plink -ssh -P $Port -pw $Password $Username@$ServerIP
    
    # رفع الملفات
    foreach ($file in $filesToUpload) {
        if (Test-Path $file) {
            Write-Host "  رفع: $file" -ForegroundColor Gray
            $result = pscp -P $Port -pw $Password -r $file $Username@$ServerIP`:$RemotePath/ 2>&1
            if ($LASTEXITCODE -eq 0) {
                Write-Host "    ✓ تم رفع $file" -ForegroundColor Green
            } else {
                Write-Host "    ⚠️  تحذير في رفع $file" -ForegroundColor Yellow
            }
        }
    }
} else {
    # استخدام SCP مباشرة (سيطلب كلمة المرور)
    Write-Host "استخدام SCP..." -ForegroundColor Green
    Write-Host "سيتم طلب كلمة المرور: $Password" -ForegroundColor Yellow
    Write-Host ""
    
    # إنشاء ملف expect script للتعامل مع كلمة المرور
    $expectScript = @"
#!/usr/bin/expect -f
set timeout 300
spawn ssh -p $Port $Username@$ServerIP "mkdir -p $RemotePath && cd $RemotePath && rm -rf *"
expect "password:"
send "$Password\r"
expect eof
"@
    
    # محاولة رفع الملفات باستخدام SCP
    Write-Host "جارٍ رفع الملفات (سيُطلب منك إدخال كلمة المرور: $Password)..." -ForegroundColor Yellow
    Write-Host ""
    
    foreach ($file in $filesToUpload) {
        if (Test-Path $file) {
            Write-Host "  رفع: $file" -ForegroundColor Gray
            Write-Host "    استخدم كلمة المرور: $Password" -ForegroundColor Cyan
            Start-Process -FilePath "scp" -ArgumentList "-r", "-P", $Port, $file, "${Username}@${ServerIP}:${RemotePath}/" -NoNewWindow -Wait
        }
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "✓ اكتمل الرفع!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "الخطوات التالية على السيرفر:" -ForegroundColor Yellow
Write-Host "ssh -p $Port $Username@$ServerIP" -ForegroundColor White
Write-Host "cd $RemotePath" -ForegroundColor White
Write-Host "npm install" -ForegroundColor White
Write-Host "npm start" -ForegroundColor White
Write-Host ""

