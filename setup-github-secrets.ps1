# Setup GitHub Secrets Helper Script
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "GitHub Secrets Setup Helper" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$repoUrl = "https://github.com/qwertauda-cpu/cyber-students-platform/settings/secrets/actions"

Write-Host "1. افتح هذا الرابط لإضافة Secrets:" -ForegroundColor Yellow
Write-Host $repoUrl -ForegroundColor Cyan
Write-Host ""

Write-Host "2. الأسرار المطلوبة:" -ForegroundColor Yellow
Write-Host ""
Write-Host "   SSH_PRIVATE_KEY" -ForegroundColor Green
Write-Host "   - احصل على المفتاح الخاص من:" -ForegroundColor Gray
Write-Host "     ~/.ssh/id_rsa أو ~/.ssh/id_ed25519" -ForegroundColor Gray
Write-Host ""

Write-Host "   SERVER_USER" -ForegroundColor Green
Write-Host "   - القيمة: qwertauda" -ForegroundColor Gray
Write-Host ""

Write-Host "   SERVER_IP" -ForegroundColor Green
Write-Host "   - القيمة: 136.111.97.150" -ForegroundColor Gray
Write-Host ""

Write-Host "   SERVER_PATH" -ForegroundColor Green
Write-Host "   - القيمة: /var/www/html" -ForegroundColor Gray
Write-Host ""

Write-Host "3. إضافة SSH Key إلى السيرفر:" -ForegroundColor Yellow
Write-Host ""
$sshKeyPath = "$env:USERPROFILE\.ssh\id_ed25519.pub"
if (Test-Path $sshKeyPath) {
    Write-Host "   المفتاح العام موجود في: $sshKeyPath" -ForegroundColor Green
    Write-Host "   انسخه وأضفه إلى السيرفر:" -ForegroundColor Gray
    Write-Host "   ssh -p 22 qwertauda@136.111.97.150 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'" -ForegroundColor Cyan
} else {
    Write-Host "   إنشاء SSH Key جديد:" -ForegroundColor Yellow
    Write-Host "   ssh-keygen -t ed25519 -C `"github-actions`"" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "بعد إعداد الأسرار، سيتم الرفع تلقائياً عند أي push!" -ForegroundColor Green

