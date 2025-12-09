# حل مشكلة Permission denied (publickey)

## المشكلة
السيرفر مُكوّن ليقبل **SSH Keys فقط** وليس كلمة المرور عبر SSH.

## الحلول المتاحة

### ✅ الحل 1: استخدام WinSCP (أسهل)

1. **حمّل WinSCP:** https://winscp.net/

2. **اتصل بالسيرفر:**
   - Host: `136.111.97.150`
   - Port: `22`
   - Username: `root`
   - Password: `1234qwer@@`
   - Protocol: **SFTP**

3. **أضف SSH Key:**
   - اذهب إلى: `/root/.ssh/`
   - إذا لم يكن المجلد موجوداً، أنشئه
   - أنشئ ملف `authorized_keys` (إذا لم يكن موجوداً)
   - افتح الملف وأضف هذا السطر:
     ```
     ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDM9dDu48DRaOt4ARcRdDil1DiFUaCXjeGrf8PmjxDyRebvstl5u6FDhrfgWMCbzut85CIJy6A3mmpVcKFwBMPdZiP5Ix1t7vkIUTW7Dvdsx2uDtsPt8gaYxg4nAP4rsrLBiG3Yrh7QmMAK8UYccyROzpq7xsByzDCDXWKblNq2lMD914GxRIqN8SJ3MY3xKHWPN4SLhgiXJoN9fhZGD9WvCTFNhKto0eY3eRbqSfIRPc/z7TVCZ95+LpZc2CW+0AbVKIATQ1nYjNkHgD0BY8PS75Nrp85D9jTWY/D6LP0EBdV51oJI24Iu9G4JcysppSofzcP57EXhF7sqNael2gPp653xMXDEvjMjvCzBpmTe61lXBDuxsxPKNtuE5Q/GnF+MZEsS3I0IUZCpImd4XCkpgGP1VNe2UubXBWzM/yVU2zZR3jzRNQLskMW3oC+bMo6Kg7g4PHRJlWy7URYEeJvZVQ+2nucxwwkCWuh66NkMi47RmrRvmh12kwuD2aZS9d4UpMTGdKZDG0BeissFUif6cOuaP3Y+CF+zMd3+KQ8YSIuZKh0mdqc8W3ogVlMrrzlR0pwGRLGU8fZvQ9CdDkxZk8435nPgAnY0FXvAGmgg+X8a+9moY5XV42Y9F/O8wPnklbioksZlRf5YopPlEXPv6YVCOE1/jxwvEnXyTermHw== ftth@example.com
     ```
   - احفظ الملف
   - من Terminal في WinSCP، نفّذ:
     ```bash
     chmod 700 /root/.ssh
     chmod 600 /root/.ssh/authorized_keys
     ```

4. **اختبر الاتصال:**
   ```bash
   ssh -p 22 root@136.111.97.150 "echo 'Success!'"
   ```

---

### ✅ الحل 2: تفعيل Password Authentication (يتطلب وصول)

إذا كان لديك وصول إلى السيرفر بطريقة أخرى (مثل console في VPS provider):

1. **اتصل عبر Console/VNC** (من لوحة تحكم VPS)

2. **عدّل إعدادات SSH:**
   ```bash
   nano /etc/ssh/sshd_config
   ```
   
3. **غيّر السطر:**
   ```
   PasswordAuthentication no
   ```
   إلى:
   ```
   PasswordAuthentication yes
   ```

4. **أعد تشغيل SSH:**
   ```bash
   systemctl restart sshd
   ```

5. **الآن يمكنك الاتصال بكلمة المرور:**
   ```bash
   ssh -p 22 root@136.111.97.150
   ```

---

### ✅ الحل 3: استخدام Web Terminal (إذا متاح)

إذا كان السيرفر يحتوي على:
- **cPanel** → Terminal
- **Plesk** → Terminal
- **Webmin** → Command Shell
- **VPS Console** → من لوحة التحكم

استخدمه لإضافة SSH key يدوياً.

---

## بعد إضافة SSH Key

بعد إضافة المفتاح بنجاح، يمكنك:

```powershell
# تنفيذ أوامر مباشرة
.\remote-exec.ps1 "pwd"
.\remote-exec.ps1 "ls -la"
.\remote-exec.ps1 "cd /var/www/html && npm install"

# أو استخدام SSH مباشرة
ssh -p 22 root@136.111.97.150 "any command"
```

---

## ملاحظة مهمة

إذا كان السيرفر VPS (مثل DigitalOcean, AWS, Azure)، يمكنك:
- استخدام **Console/VNC** من لوحة التحكم
- أو **Web-based Terminal** إذا كان متاحاً
- أو طلب من مدير السيرفر إضافة المفتاح

