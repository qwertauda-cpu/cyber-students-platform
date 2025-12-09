# دليل حل المشاكل

## مشاكل شائعة وحلولها

### 1. مشكلة persist middleware في Zustand

**المشكلة**: 
```
Error: Cannot find module 'zustand/middleware'
```

**الحل**:
تأكد من تثبيت zustand بشكل صحيح:
```bash
npm install zustand
```

إذا استمرت المشكلة، استخدم localStorage مباشرة:

```tsx
// store/themeStore.ts (بدون persist)
import { create } from 'zustand';

interface ThemeState {
  theme: 'light' | 'dark';
  toggleTheme: () => void;
  setTheme: (theme: 'light' | 'dark') => void;
}

export const useThemeStore = create<ThemeState>((set) => ({
  theme: (typeof window !== 'undefined' && localStorage.getItem('theme') as 'light' | 'dark') || 'dark',
  toggleTheme: () =>
    set((state) => {
      const newTheme = state.theme === 'dark' ? 'light' : 'dark';
      if (typeof window !== 'undefined') {
        localStorage.setItem('theme', newTheme);
      }
      return { theme: newTheme };
    }),
  setTheme: (theme) => {
    if (typeof window !== 'undefined') {
      localStorage.setItem('theme', theme);
    }
    set({ theme });
  },
}));
```

---

### 2. مشكلة Hydration Mismatch

**المشكلة**:
```
Warning: Text content did not match. Server: "dark" Client: "light"
```

**الحل**:
استخدم `useState` و `useEffect` لتأخير تطبيق الثيم:

```tsx
// components/ThemeToggle.tsx
const [mounted, setMounted] = useState(false);

useEffect(() => {
  setMounted(true);
}, []);

if (!mounted) {
  return null; // أو return placeholder
}
```

---

### 3. مشكلة الاتصال بقاعدة البيانات

**المشكلة**:
```
Error: connect ECONNREFUSED 127.0.0.1:3306
```

**الحل**:
1. تأكد من تشغيل MySQL:
```bash
# Windows
net start MySQL80

# Linux/Mac
sudo systemctl start mysql
```

2. تحقق من إعدادات `.env`:
```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=cyber_students
```

3. اختبر الاتصال:
```bash
mysql -u root -p -e "SHOW DATABASES;"
```

---

### 4. مشكلة JWT Token

**المشكلة**:
```
Error: jwt malformed
```

**الحل**:
1. تأكد من إرسال Token في Header:
```tsx
headers: {
  Authorization: `Bearer ${token}`
}
```

2. تحقق من JWT_SECRET في `.env`:
```env
JWT_SECRET=your-super-secret-key-min-32-characters
```

3. تأكد من عدم انتهاء صلاحية Token (افتراضي: 7 أيام)

---

### 5. مشكلة رفع الملفات

**المشكلة**:
```
Error: ENOENT: no such file or directory
```

**الحل**:
1. أنشئ مجلد uploads:
```bash
mkdir -p public/uploads
```

2. تأكد من الصلاحيات:
```bash
chmod 755 public/uploads
```

3. في Next.js، استخدم `public` folder للملفات الثابتة

---

### 6. مشكلة Dark Mode لا يعمل

**المشكلة**: الثيم لا يتغير

**الحل**:
1. تأكد من إضافة `darkMode: 'class'` في `tailwind.config.js`:
```js
module.exports = {
  darkMode: 'class',
  // ...
}
```

2. تأكد من إضافة class `dark` في HTML:
```tsx
<html lang="ar" dir="rtl" className={theme === 'dark' ? 'dark' : ''}>
```

3. استخدم `dark:` prefix في Tailwind classes:
```tsx
<div className="bg-white dark:bg-gray-800">
```

---

### 7. مشكلة React Icons

**المشكلة**:
```
Error: Cannot find module 'react-icons/hi'
```

**الحل**:
1. تأكد من تثبيت react-icons:
```bash
npm install react-icons
```

2. استخدم الاستيراد الصحيح:
```tsx
import { HiMoon, HiSun } from 'react-icons/hi';
import { FiMessageCircle } from 'react-icons/fi';
```

---

### 8. مشكلة Socket.io

**المشكلة**: الدردشة لا تعمل

**الحل**:
1. تأكد من تشغيل Socket.io server منفصل أو استخدام Next.js API route
2. تحقق من CORS settings
3. استخدم نفس origin للاتصال

---

### 9. مشكلة RTL (Right-to-Left)

**المشكلة**: النصوص لا تظهر بشكل صحيح

**الحل**:
1. أضف `dir="rtl"` في HTML:
```tsx
<html lang="ar" dir="rtl">
```

2. استخدم Tailwind RTL classes عند الحاجة:
```tsx
<div className="text-right rtl:text-left">
```

---

### 10. مشكلة TypeScript

**المشكلة**: أخطاء TypeScript

**الحل**:
1. تأكد من تثبيت types:
```bash
npm install --save-dev @types/node @types/react @types/react-dom
```

2. تحقق من `tsconfig.json`:
```json
{
  "compilerOptions": {
    "strict": true,
    "paths": {
      "@/*": ["./*"]
    }
  }
}
```

---

## نصائح عامة

1. **افحص Console**: دائماً افحص console المتصفح والخادم للأخطاء
2. **افحص Network Tab**: تأكد من نجاح طلبات API
3. **استخدم TypeScript**: يساعد في اكتشاف الأخطاء مبكراً
4. **افحص Logs**: راجع server logs للأخطاء
5. **اختبر بشكل تدريجي**: اختبر كل مكون على حدة

---

## الحصول على المساعدة

إذا استمرت المشكلة:
1. راجع ملفات التوثيق في `docs/`
2. افحص أمثلة الكود في `components/`
3. راجع `README.md` للتعليمات الأساسية

