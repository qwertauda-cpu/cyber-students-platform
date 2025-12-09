# إعداد GitHub - خطوة بخطوة

## ✅ تم إعداد Git المحلي بنجاح!

المشروع جاهز للرفع. الآن تحتاج إلى إنشاء الـ Repository على GitHub.

---

## الخطوة 1: إنشاء Repository على GitHub

1. اذهب إلى: https://github.com/new
2. املأ التفاصيل:
   - **Repository name**: `cyber-students-platform` (أو أي اسم تريده)
   - **Description**: `منصة مجتمع طلاب الأمن السيبراني - Cyber Security Students Community Platform`
   - **Visibility**: اختر **Public** أو **Private**
   - **⚠️ مهم**: **لا** تضع علامة على:
     - ❌ Add a README file
     - ❌ Add .gitignore
     - ❌ Choose a license
   
   (لأننا أضفناها بالفعل في المشروع)

3. اضغط **"Create repository"**

---

## الخطوة 2: رفع الملفات

بعد إنشاء الـ Repository، نفّذ الأمر التالي:

```bash
git push -u origin main
```

**إذا طُلب منك اسم المستخدم وكلمة المرور:**

### اسم المستخدم:
```
qwertauda
```

### كلمة المرور:
استخدم **Personal Access Token** (وليس كلمة المرور العادية)

#### كيفية إنشاء Personal Access Token:

1. اذهب إلى: https://github.com/settings/tokens
2. اضغط **"Generate new token"** > **"Generate new token (classic)"**
3. املأ:
   - **Note**: `Cyber Students Platform`
   - **Expiration**: اختر المدة (مثلاً 90 يوم)
   - **Select scopes**: ✅ **repo** (كامل)
4. اضغط **"Generate token"**
5. **انسخ الـ Token فوراً** (لن تتمكن من رؤيته مرة أخرى)
6. استخدمه ككلمة مرور عند `git push`

---

## الخطوة 3: التحقق

بعد الرفع:
1. اذهب إلى: https://github.com/qwertauda/cyber-students-platform
2. تأكد من ظهور جميع الملفات

---

## إذا كان لديك Repository موجود بالفعل

إذا كان لديك repository باسم مختلف، غيّر الـ remote:

```bash
git remote set-url origin https://github.com/qwertauda/YOUR_REPO_NAME.git
git push -u origin main
```

---

## الأوامر السريعة (بعد إنشاء Repository)

```bash
# رفع الملفات
git push -u origin main

# للرفع في المستقبل (بعد التعديلات)
git add .
git commit -m "وصف التغييرات"
git push
```

---

## ✅ الحالة الحالية

- ✅ Git initialized
- ✅ جميع الملفات committed
- ✅ Remote configured: `https://github.com/qwertauda/cyber-students-platform.git`
- ✅ Branch: `main`
- ⏳ **الخطوة التالية**: إنشاء Repository على GitHub ثم `git push -u origin main`

