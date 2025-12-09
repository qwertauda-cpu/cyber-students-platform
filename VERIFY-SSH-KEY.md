# التحقق من إعداد SSH Key

## المشكلة
SSH Key لم يتم إضافته بشكل صحيح على السيرفر.

## الحل

### على السيرفر (بعد الاتصال):

1. **تحقق من وجود الملف:**
   ```bash
   ls -la ~/.ssh/
   cat ~/.ssh/authorized_keys
   ```

2. **إذا كان الملف فارغاً أو غير موجود، نفّذ:**
   ```bash
   mkdir -p ~/.ssh
   chmod 700 ~/.ssh
   ```

3. **أضف المفتاح (انسخ السطر بالكامل):**
   ```bash
   echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDM9dDu48DRaOt4ARcRdDil1DiFUaCXjeGrf8PmjxDyRebvstl5u6FDhrfgWMCbzut85CIJy6A3mmpVcKFwBMPdZiP5Ix1t7vkIUTW7Dvdsx2uDtsPt8gaYxg4nAP4rsrLBiG3Yrh7QmMAK8UYccyROzpq7xsByzDCDXWKblNq2lMD914GxRIqN8SJ3MY3xKHWPN4SLhgiXJoN9fhZGD9WvCTFNhKto0eY3eRbqSfIRPc/z7TVCZ95+LpZc2CW+0AbVKIATQ1nYjNkHgD0BY8PS75Nrp85D9jTWY/D6LP0EBdV51oJI24Iu9G4JcysppSofzcP57EXhF7sqNael2gPp653xMXDEvjMjvCzBpmTe61lXBDuxsxPKNtuE5Q/GnF+MZEsS3I0IUZCpImd4XCkpgGP1VNe2UubXBWzM/yVU2zZR3jzRNQLskMW3oC+bMo6Kg7g4PHRJlWy7URYEeJvZVQ+2nucxwwkCWuh66NkMi47RmrRvmh12kwuD2aZS9d4UpMTGdKZDG0BeissFUif6cOuaP3Y+CF+zMd3+KQ8YSIuZKh0mdqc8W3ogVlMrrzlR0pwGRLGU8fZvQ9CdDkxZk8435nPgAnY0FXvAGmgg+X8a+9moY5XV42Y9F/O8wPnklbioksZlRf5YopPlEXPv6YVCOE1/jxwvEnXyTermHw== ftth@example.com' >> ~/.ssh/authorized_keys
   ```

4. **تعيين الصلاحيات:**
   ```bash
   chmod 600 ~/.ssh/authorized_keys
   ```

5. **التحقق:**
   ```bash
   cat ~/.ssh/authorized_keys
   ```
   
   يجب أن ترى المفتاح مطبوعاً.

6. **الخروج:**
   ```bash
   exit
   ```

### من جهازك المحلي:

بعد الخروج من السيرفر، اختبر الاتصال:

```bash
ssh -p 22 root@136.111.97.150 "echo 'Success!'"
```

إذا نجح بدون طلب كلمة مرور، فالإعداد تم بنجاح! ✅

