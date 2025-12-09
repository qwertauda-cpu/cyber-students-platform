# سكريبت رفع المشروع على GitHub
# قم بتعديل REPO_NAME باسم الـ repository الخاص بك

$REPO_NAME = "cyber-students-platform"  # غيّر هذا باسم الـ repository الخاص بك
$USERNAME = "qwertauda"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "رفع المشروع على GitHub" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# التحقق من وجود remote
$remoteExists = git remote -v 2>&1
if ($remoteExists -match "origin") {
    Write-Host "⚠️  Remote موجود بالفعل. هل تريد تحديثه؟" -ForegroundColor Yellow
    Write-Host "حذف remote الحالي..." -ForegroundColor Yellow
    git remote remove origin
}

# إضافة remote
Write-Host "إضافة remote repository..." -ForegroundColor Green
$repoUrl = "https://github.com/$USERNAME/$REPO_NAME.git"
git remote add origin $repoUrl
Write-Host "✓ تم إضافة remote: $repoUrl" -ForegroundColor Green

# تغيير اسم الفرع إلى main
Write-Host ""
Write-Host "تغيير اسم الفرع إلى main..." -ForegroundColor Green
git branch -M main
Write-Host "✓ تم تغيير اسم الفرع" -ForegroundColor Green

# عرض حالة Git
Write-Host ""
Write-Host "حالة Git الحالية:" -ForegroundColor Cyan
git status

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "الخطوة التالية:" -ForegroundColor Yellow
Write-Host "قم بتنفيذ الأمر التالي لرفع الملفات:" -ForegroundColor Yellow
Write-Host "git push -u origin main" -ForegroundColor White
Write-Host ""
Write-Host "ملاحظة: سيُطلب منك اسم المستخدم وكلمة المرور" -ForegroundColor Yellow
Write-Host "استخدم Personal Access Token ككلمة مرور" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan

