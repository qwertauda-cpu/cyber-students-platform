# سكريبت رفع تلقائي على السيرفر
Import-Module Posh-SSH -ErrorAction SilentlyContinue

$Username = "root"
$ServerIP = "136.111.97.150"
$Password = "1234qwer@@"
$Port = 22
$RemotePath = "/var/www/html"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "رفع المشروع على السيرفر" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# إنشاء Credential
$securePassword = ConvertTo-SecureString $Password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($Username, $securePassword)

# الاتصال بالسيرفر
Write-Host "الاتصال بالسيرفر..." -ForegroundColor Yellow
try {
    $session = New-SSHSession -ComputerName $ServerIP -Port $Port -Credential $credential -AcceptKey -ErrorAction Stop
    Write-Host "✓ تم الاتصال بالسيرفر" -ForegroundColor Green
} catch {
    Write-Host "❌ فشل الاتصال: $_" -ForegroundColor Red
    exit 1
}

# إعداد المجلد على السيرفر
Write-Host "إعداد المجلد على السيرفر..." -ForegroundColor Yellow
$setupCmd = "mkdir -p $RemotePath && cd $RemotePath && rm -rf *"
$result = Invoke-SSHCommand -SessionId $session.SessionId -Command $setupCmd
Write-Host "✓ تم إعداد المجلد" -ForegroundColor Green

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

# رفع الملفات
Write-Host ""
Write-Host "رفع الملفات..." -ForegroundColor Cyan
foreach ($file in $filesToUpload) {
    if (Test-Path $file) {
        Write-Host "  رفع: $file" -ForegroundColor Gray
        try {
            if (Test-Path $file -PathType Container) {
                Set-SCPItem -ComputerName $ServerIP -Port $Port -Credential $credential -Path $file -Destination "$RemotePath/" -Recurse
            } else {
                Set-SCPItem -ComputerName $ServerIP -Port $Port -Credential $credential -Path $file -Destination "$RemotePath/"
            }
            Write-Host "    ✓ تم رفع $file" -ForegroundColor Green
        } catch {
            Write-Host "    ⚠️  تحذير في رفع $file : $_" -ForegroundColor Yellow
        }
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
}

# إغلاق الاتصال
Remove-SSHSession -SessionId $session.SessionId | Out-Null

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "✓ تم رفع المشروع بنجاح!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "الخطوات التالية على السيرفر:" -ForegroundColor Yellow
Write-Host "ssh -p $Port $Username@$ServerIP" -ForegroundColor White
Write-Host "cd $RemotePath" -ForegroundColor White
Write-Host "npm start" -ForegroundColor White
Write-Host ""

