# منصة مجتمع طلاب الأمن السيبراني

منصة تفاعلية شاملة لطلاب الأمن السيبراني تشمل نظام إعلانات، ملازم، مجتمع تفاعلي، مشاريع طلابية، ونظام دردشة.

## 🚀 المميزات

### 1. نظام الثيمات (Theme Switcher)
- ✅ زر تبديل في **أعلى يسار الشاشة**
- ✅ الوضع الافتراضي: **Dark Mode**
- ✅ حفظ التفضيل في LocalStorage وقاعدة البيانات
- ✅ انتقال سلس بين الثيمات

### 2. نظام الصلاحيات
- **Admin**: نشر إعلانات، رفع ملازم ومحاضرات
- **Student**: التفاعل في المجتمع، رفع مشاريع، الدردشة

### 3. الصفحات الرئيسية
- **لوحة الإعلانات**: منشورات Admin فقط
- **الملازم والمحاضرات**: مكتبة ملفات (PDF, صور)
- **مجتمع الطلاب**: منشورات، تعليقات، إعجابات
- **مشاريع الطلاب**: معرض المشاريع البرمجية
- **نظام الدردشة**: محادثات مباشرة بين الطلاب

## 📋 المتطلبات التقنية

- **Frontend**: Next.js 14 + React 18 + TypeScript
- **Styling**: Tailwind CSS
- **Backend**: Next.js API Routes
- **Database**: MySQL
- **State Management**: Zustand
- **Animations**: Framer Motion
- **Icons**: React Icons
- **Real-time**: Socket.io (للدردشة)

## 🛠️ التثبيت والإعداد

### 1. تثبيت المتطلبات

```bash
npm install
```

### 2. إعداد قاعدة البيانات

1. قم بإنشاء قاعدة بيانات MySQL:
```sql
CREATE DATABASE cyber_students CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

2. قم بتشغيل ملف Schema:
```bash
mysql -u root -p cyber_students < database/schema.sql
```

### 3. إعداد متغيرات البيئة

انسخ ملف `.env.example` إلى `.env` واملأ القيم:

```bash
cp .env.example .env
```

عدّل الملف `.env`:
```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=cyber_students
JWT_SECRET=your-secret-key
```

### 4. تشغيل المشروع

```bash
# Development
npm run dev

# Production
npm run build
npm start
```

افتح المتصفح على: `http://localhost:3000`

## 📁 هيكلية المشروع

```
cyber/
├── app/                    # Next.js App Router
│   ├── api/               # API Routes
│   │   ├── auth/         # Authentication
│   │   └── user/         # User endpoints
│   ├── globals.css       # Global styles
│   ├── layout.tsx        # Root layout
│   └── page.tsx          # Home page
├── components/            # React Components
│   ├── ThemeToggle.tsx   # زر تبديل الثيم
│   └── StudentProfileModal.tsx  # Modal الملف الشخصي
├── database/              # Database files
│   ├── schema.sql        # Database schema
│   └── ERD.md           # Entity Relationship Diagram
├── docs/                 # Documentation
│   └── API_STRUCTURE.md  # API Documentation
├── lib/                  # Utilities
│   ├── db.ts            # Database connection
│   └── auth.ts          # Authentication helpers
├── store/                # State management
│   └── themeStore.ts    # Theme state (Zustand)
└── public/              # Static files
```

## 🎨 استخدام Theme Toggle

المكون `ThemeToggle` يظهر تلقائياً في أعلى يسار الشاشة عند إضافته في `layout.tsx`:

```tsx
import ThemeToggle from '@/components/ThemeToggle';

export default function Layout({ children }) {
  return (
    <html>
      <body>
        <ThemeToggle />
        {children}
      </body>
    </html>
  );
}
```

## 👤 استخدام Student Profile Modal

```tsx
import StudentProfileModal from '@/components/StudentProfileModal';
import { useState } from 'react';

function MyComponent() {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedUserId, setSelectedUserId] = useState<number | null>(null);

  const handleUserClick = (userId: number) => {
    setSelectedUserId(userId);
    setIsModalOpen(true);
  };

  const handleChatClick = (userId: number, userName: string) => {
    // فتح صفحة/نافذة الدردشة
    console.log(`Opening chat with ${userName} (ID: ${userId})`);
  };

  return (
    <>
      <button onClick={() => handleUserClick(1)}>
        عرض الملف الشخصي
      </button>
      
      <StudentProfileModal
        userId={selectedUserId || 0}
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        onChatClick={handleChatClick}
      />
    </>
  );
}
```

## 📊 قاعدة البيانات

راجع ملف `database/schema.sql` للحصول على مخطط قاعدة البيانات الكامل.

### الجداول الرئيسية:
- `users` - المستخدمون
- `announcements` - الإعلانات
- `resources` - الملازم والمحاضرات
- `posts` - منشورات المجتمع
- `comments` - التعليقات
- `likes` - الإعجابات
- `projects` - مشاريع الطلاب
- `conversations` - المحادثات
- `messages` - الرسائل

## 🔌 API Endpoints

راجع ملف `docs/API_STRUCTURE.md` للحصول على توثيق API الكامل.

### أمثلة:
- `POST /api/auth/login` - تسجيل الدخول
- `GET /api/announcements` - الحصول على الإعلانات
- `POST /api/posts` - إنشاء منشور
- `GET /api/users/:id` - معلومات مستخدم
- `PUT /api/user/theme` - تحديث الثيم

## 🔒 الأمان

- كلمات المرور مشفرة باستخدام bcrypt
- JWT Tokens للمصادقة
- التحقق من الصلاحيات في كل endpoint
- حقل `full_name` للقراءة فقط بعد التسجيل

## 📝 ملاحظات مهمة

1. **الاسم الثلاثي**: حقل `full_name` في جدول `users` للقراءة فقط بعد التسجيل - لا يمكن تعديله من الإعدادات.

2. **الوضع الافتراضي**: الثيم الافتراضي هو **Dark Mode** كما طُلب.

3. **الصلاحيات**: 
   - Admin فقط يمكنه نشر إعلانات ورفع ملازم
   - الطلاب فقط يمكنهم التفاعل في المجتمع ورفع مشاريع

## 🚧 التطوير المستقبلي

- [ ] إضافة Socket.io للدردشة المباشرة
- [ ] إضافة نظام الإشعارات
- [ ] إضافة البحث والفلترة
- [ ] إضافة نظام التقييمات للمشاريع
- [ ] إضافة Dashboard للإحصائيات

## 📄 الترخيص

هذا المشروع مخصص للاستخدام التعليمي.

## 👨‍💻 الدعم

للمساعدة أو الاستفسارات، يرجى فتح Issue في المستودع.

---

**تم البناء بواسطة:** Senior Full Stack Developer  
**التاريخ:** 2024

