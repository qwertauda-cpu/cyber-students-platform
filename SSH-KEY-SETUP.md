# إعداد SSH Key للوصول المباشر

## الخطوات اليدوية (مرة واحدة فقط)

### الخطوة 1: الاتصال بالسيرفر
افتح PowerShell أو Terminal ونفّذ:

```bash
ssh -p 22 root@136.111.97.150
```

عند طلب كلمة المرور، أدخل: `1234qwer@@`

### الخطوة 2: إعداد SSH Key على السيرفر

بعد الاتصال، نفّذ الأوامر التالية على السيرفر:

```bash
# إنشاء مجلد .ssh
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# إضافة المفتاح العام
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDM9dDu48DRaOt4ARcRdDil1DiFUaCXjeGrf8PmjxDyRebvstl5u6FDhrfgWMCbzut85CIJy6A3mmpVcKFwBMPdZiP5Ix1t7vkIUTW7Dvdsx2uDtsPt8gaYxg4nAP4rsrLBiG3Yrh7QmMAK8UYccyROzpq7xsByzDCDXWKblNq2lMD914GxRIqN8SJ3MY3xKHWPN4SLhgiXJoN9fhZGD9WvCTFNhKto0eY3eRbqSfIRPc/z7TVCZ95+LpZc2CW+0AbVKIATQ1nYjNkHgD0BY8PS75Nrp85D9jTWY/D6LP0EBdV51oJI24Iu9G4JcysppSofzcP57EXhF7sqNael2gPp653xMXDEvjMjvCzBpmTe61lXBDuxsxPKNtuE5Q/GnF+MZEsS3I0IUZCpImd4XCkpgGP1VNe2UubXBWzM/yVU2zZR3jzRNQLskMW3oC+bMo6Kg7g4PHRJlWy7URYEeJvZVQ+2nucxwwkCWuh66NkMi47RmrRvmh12kwuD2aZS9d4UpMTGdKZDG0BeissFUif6cOuaP3Y+CF+zMd3+KQ8YSIuZKh0mdqc8W3ogVlMrrzlR0pwGRLGU8fZvQ9CdDkxZk8435nPgAnY0FXvAGmgg+X8a+9moY5XV42Y9F/O8wPnklbioksZlRf5YopPlEXPv6YVCOE1/jxwvEnXyTermHw== ftth@example.com' >> ~/.ssh/authorized_keys

# تعيين الصلاحيات الصحيحة
chmod 600 ~/.ssh/authorized_keys

# الخروج
exit
```

### الخطوة 3: اختبار الاتصال

من جهازك المحلي، نفّذ:

```bash
ssh -p 22 root@136.111.97.150 "echo 'SSH Key Works!'"
```

إذا نجح الأمر بدون طلب كلمة مرور، فالإعداد تم بنجاح! ✅

---

## بعد الإعداد - استخدام الأوامر

بعد إعداد SSH Key، يمكنك تنفيذ الأوامر مباشرة:

### الطريقة 1: استخدام السكريبت
```powershell
.\remote-exec.ps1 "pwd"
.\remote-exec.ps1 "ls -la"
.\remote-exec.ps1 "cd /var/www/html && ls"
```

### الطريقة 2: استخدام SSH مباشرة
```bash
ssh -p 22 root@136.111.97.150 "pwd"
ssh -p 22 root@136.111.97.150 "ls -la /var/www/html"
ssh -p 22 root@136.111.97.150 "npm --version"
```

### الطريقة 3: الاتصال التفاعلي
```bash
ssh -p 22 root@136.111.97.150
# ثم تنفيذ أي أوامر تريدها
```

---

## ملاحظات

- **مفتاحك العام موجود في:** `C:\Users\MK\.ssh\id_rsa.pub`
- بعد الإعداد، لن تحتاج لإدخال كلمة المرور مرة أخرى
- يمكنك الآن رفع الملفات وتنفيذ الأوامر بسهولة

---

## أمثلة على الأوامر المفيدة

```bash
# عرض المسار الحالي
ssh -p 22 root@136.111.97.150 "pwd"

# عرض الملفات
ssh -p 22 root@136.111.97.150 "ls -la"

# تثبيت Node.js
ssh -p 22 root@136.111.97.150 "curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && apt-get install -y nodejs"

# تشغيل npm install
ssh -p 22 root@136.111.97.150 "cd /var/www/html && npm install"

# تشغيل التطبيق
ssh -p 22 root@136.111.97.150 "cd /var/www/html && npm start"
```

