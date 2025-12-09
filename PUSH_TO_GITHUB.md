# خطوات رفع المشروع على GitHub

## الخطوة 1: إضافة Remote Repository

قم بتنفيذ الأمر التالي (استبدل `YOUR_USERNAME` و `REPO_NAME` بالقيم الصحيحة):

```bash
git remote add origin https://github.com/YOUR_USERNAME/REPO_NAME.git
```

**مثال:**
```bash
git remote add origin https://github.com/ahmed/cyber-students-platform.git
```

## الخطوة 2: تغيير اسم الفرع إلى main (إذا لزم الأمر)

```bash
git branch -M main
```

## الخطوة 3: رفع الملفات

```bash
git push -u origin main
```

أو إذا كان الـ repository يستخدم `master`:

```bash
git push -u origin master
```

---

## إذا كان لديك Repository موجود بالفعل

إذا كان الـ repository موجود وترغب في ربطه:

```bash
# إضافة Remote
git remote add origin https://github.com/YOUR_USERNAME/REPO_NAME.git

# رفع الملفات
git push -u origin main
```

---

## ملاحظات

- تأكد من أنك مسجل دخول في Git:
  ```bash
  git config --global user.name "Your Name"
  git config --global user.email "your.email@example.com"
  ```

- إذا طُلب منك اسم المستخدم وكلمة المرور، استخدم:
  - **Username**: اسم المستخدم على GitHub
  - **Password**: Personal Access Token (وليس كلمة المرور العادية)
  
  لإنشاء Personal Access Token:
  1. اذهب إلى GitHub Settings > Developer settings > Personal access tokens > Tokens (classic)
  2. اضغط "Generate new token"
  3. اختر الصلاحيات المطلوبة (repo على الأقل)
  4. انسخ الـ Token واستخدمه ككلمة مرور

---

## التحقق من الرفع

بعد الرفع، اذهب إلى صفحة الـ Repository على GitHub وتأكد من ظهور جميع الملفات.

