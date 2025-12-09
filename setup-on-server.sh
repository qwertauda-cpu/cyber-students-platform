#!/bin/bash
# سكريبت لإعداد SSH Key على السيرفر
# نفّذ هذا السكريبت على السيرفر

echo "Setting up SSH Key..."

# إنشاء مجلد .ssh
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# إضافة المفتاح العام
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDM9dDu48DRaOt4ARcRdDil1DiFUaCXjeGrf8PmjxDyRebvstl5u6FDhrfgWMCbzut85CIJy6A3mmpVcKFwBMPdZiP5Ix1t7vkIUTW7Dvdsx2uDtsPt8gaYxg4nAP4rsrLBiG3Yrh7QmMAK8UYccyROzpq7xsByzDCDXWKblNq2lMD914GxRIqN8SJ3MY3xKHWPN4SLhgiXJoN9fhZGD9WvCTFNhKto0eY3eRbqSfIRPc/z7TVCZ95+LpZc2CW+0AbVKIATQ1nYjNkHgD0BY8PS75Nrp85D9jTWY/D6LP0EBdV51oJI24Iu9G4JcysppSofzcP57EXhF7sqNael2gPp653xMXDEvjMjvCzBpmTe61lXBDuxsxPKNtuE5Q/GnF+MZEsS3I0IUZCpImd4XCkpgGP1VNe2UubXBWzM/yVU2zZR3jzRNQLskMW3oC+bMo6Kg7g4PHRJlWy7URYEeJvZVQ+2nucxwwkCWuh66NkMi47RmrRvmh12kwuD2aZS9d4UpMTGdKZDG0BeissFUif6cOuaP3Y+CF+zMd3+KQ8YSIuZKh0mdqc8W3ogVlMrrzlR0pwGRLGU8fZvQ9CdDkxZk8435nPgAnY0FXvAGmgg+X8a+9moY5XV42Y9F/O8wPnklbioksZlRf5YopPlEXPv6YVCOE1/jxwvEnXyTermHw== ftth@example.com' >> ~/.ssh/authorized_keys

# تعيين الصلاحيات
chmod 600 ~/.ssh/authorized_keys

echo "SSH Key setup complete!"
echo "You can now exit and test connection from your local machine."

