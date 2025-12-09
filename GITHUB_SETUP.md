# دليل رفع المشروع على GitHub

## الخطوات

### 1. إنشاء Repository جديد على GitHub

1. اذهب إلى [GitHub](https://github.com)
2. اضغط على زر **"New"** أو **"+"** في أعلى الصفحة
3. اختر **"New repository"**
4. املأ التفاصيل:
   - **Repository name**: `cyber-students-platform` (أو أي اسم تريده)
   - **Description**: `منصة مجتمع طلاب الأمن السيبراني - Cyber Security Students Community Platform`
   - **Visibility**: اختر Public أو Private
   - **لا تقم** بتهيئة README أو .gitignore (لأننا أضفناها بالفعل)
5. اضغط **"Create repository"**

### 2. ربط المشروع المحلي بـ GitHub

بعد إنشاء الـ Repository، ستظهر لك تعليمات. قم بتنفيذ الأوامر التالية:

```bash
# إضافة Remote (استبدل YOUR_USERNAME و REPO_NAME بالقيم الصحيحة)
git remote add origin https://github.com/YOUR_USERNAME/REPO_NAME.git

# أو إذا كنت تستخدم SSH:
git remote add origin git@github.com:YOUR_USERNAME/REPO_NAME.git

# تغيير اسم الفرع إلى main (إذا كان GitHub يستخدم main بدلاً من master)
git branch -M main

# رفع الملفات
git push -u origin main
```

### 3. إذا كان لديك Repository موجود بالفعل

إذا كان لديك Repository موجود وترغب في ربطه:

```bash
# إضافة Remote
git remote add origin https://github.com/YOUR_USERNAME/REPO_NAME.git

# رفع الملفات
git push -u origin main
```

### 4. التحقق من الرفع

بعد الرفع، اذهب إلى صفحة الـ Repository على GitHub وتأكد من ظهور جميع الملفات.

---

## ملاحظات مهمة

### ⚠️ لا ترفع ملف .env

ملف `.env` موجود في `.gitignore` ولن يتم رفعه. تأكد من:

1. إنشاء ملف `.env.example` في الـ Repository (موجود بالفعل)
2. إضافة تعليمات في README حول كيفية إعداد `.env`

### 📝 معلومات إضافية للـ Repository

يمكنك إضافة:
- **Topics/Tags**: `cybersecurity`, `nextjs`, `react`, `typescript`, `mysql`, `arabic`
- **Website**: إذا كان لديك موقع منشور
- **License**: اختر الرخصة المناسبة

---

## الأوامر السريعة

```bash
# إضافة جميع التغييرات
git add .

# عمل Commit
git commit -m "وصف التغييرات"

# رفع التغييرات
git push origin main
```

---

## إعدادات إضافية (اختياري)

### إضافة Badges في README

يمكنك إضافة badges في بداية README.md:

```markdown
![Next.js](https://img.shields.io/badge/Next.js-14-black)
![TypeScript](https://img.shields.io/badge/TypeScript-5.3-blue)
![MySQL](https://img.shields.io/badge/MySQL-8.0-orange)
![License](https://img.shields.io/badge/License-MIT-green)
```

### إضافة GitHub Actions

تم إضافة ملف `.github/workflows/ci.yml` للتحقق التلقائي من الكود عند الرفع.

---

## المساعدة

إذا واجهت أي مشاكل:
1. تأكد من أنك مسجل دخول في Git:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

2. تأكد من صحة رابط الـ Repository

3. راجع ملف `TROUBLESHOOTING.md` للمزيد من المساعدة

