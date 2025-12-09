# إعداد الرفع التلقائي إلى السيرفر

## الخطوات المطلوبة:

### 1. إعداد SSH Key على GitHub

1. اذهب إلى: `https://github.com/qwertauda-cpu/cyber-students-platform/settings/secrets/actions`
2. أضف الأسرار التالية (Secrets):

#### SSH_PRIVATE_KEY
- احصل على المفتاح الخاص من: `~/.ssh/id_rsa` أو `~/.ssh/id_ed25519`
- إذا لم يكن موجوداً، أنشئه:
  ```bash
  ssh-keygen -t ed25519 -C "github-actions"
  ```
- انسخ المحتوى الكامل للمفتاح الخاص (بما في ذلك `-----BEGIN` و `-----END`)
- أضفه كـ Secret باسم: `SSH_PRIVATE_KEY`

#### إضافة المفتاح العام إلى السيرفر
```bash
ssh-copy-id -p 22 qwertauda@136.111.97.150
```

أو يدوياً:
```bash
cat ~/.ssh/id_ed25519.pub | ssh -p 22 qwertauda@136.111.97.150 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

### 2. إضافة Secrets الأخرى

أضف هذه الأسرار في GitHub Secrets:

- **SERVER_USER**: `qwertauda`
- **SERVER_IP**: `136.111.97.150`
- **SERVER_PATH**: `/var/www/html`

### 3. كيفية العمل

بعد إعداد الأسرار:
- عند أي `git push` إلى branch `main`
- GitHub Actions سيقوم تلقائياً بـ:
  1. بناء المشروع
  2. رفع الملفات إلى السيرفر
  3. تثبيت dependencies
  4. إعادة تشغيل التطبيق

### 4. التحقق من الرفع

- اذهب إلى: `https://github.com/qwertauda-cpu/cyber-students-platform/actions`
- ستجد workflow "Deploy to Server" يعمل تلقائياً

### 5. اختبار يدوي

يمكنك تشغيل الرفع يدوياً من:
- Actions tab → Deploy to Server → Run workflow

