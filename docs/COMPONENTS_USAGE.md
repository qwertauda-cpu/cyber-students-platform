# دليل استخدام المكونات

## 1. Theme Toggle Component

### الموقع
المكون يظهر تلقائياً في **أعلى يسار الشاشة** عند إضافته في `app/layout.tsx`.

### الميزات
- ✅ تبديل فوري بين Dark/Light Mode
- ✅ حفظ التفضيل في LocalStorage
- ✅ حفظ التفضيل في قاعدة البيانات (إذا كان المستخدم مسجل دخول)
- ✅ الوضع الافتراضي: **Dark Mode**

### الكود

```tsx
// app/layout.tsx
import ThemeToggle from '@/components/ThemeToggle';

export default function RootLayout({ children }) {
  return (
    <html lang="ar" dir="rtl">
      <body>
        <ThemeToggle />
        {children}
      </body>
    </html>
  );
}
```

### التخصيص

يمكنك تخصيص الألوان من `tailwind.config.js`:

```js
theme: {
  extend: {
    colors: {
      cyber: {
        dark: '#0a0e27',
        darker: '#050714',
        accent: '#00ff88',
      },
    },
  },
}
```

---

## 2. Student Profile Modal Component

### الاستخدام الأساسي

```tsx
'use client';

import { useState } from 'react';
import StudentProfileModal from '@/components/StudentProfileModal';

export default function CommunityPage() {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedUserId, setSelectedUserId] = useState<number | null>(null);

  // عند النقر على اسم طالب
  const handleUserClick = (userId: number) => {
    setSelectedUserId(userId);
    setIsModalOpen(true);
  };

  // عند النقر على زر الدردشة
  const handleChatClick = (userId: number, userName: string) => {
    // فتح صفحة الدردشة أو نافذة منبثقة
    console.log(`Opening chat with ${userName} (ID: ${userId})`);
    
    // مثال: الانتقال إلى صفحة الدردشة
    // router.push(`/chat/${userId}`);
    
    // أو فتح نافذة منبثقة للدردشة
    // setChatUserId(userId);
    // setIsChatOpen(true);
  };

  return (
    <div>
      {/* مثال: قائمة المستخدمين */}
      <div onClick={() => handleUserClick(1)}>
        <span>أحمد محمد علي</span>
      </div>

      {/* Modal */}
      {selectedUserId && (
        <StudentProfileModal
          userId={selectedUserId}
          isOpen={isModalOpen}
          onClose={() => {
            setIsModalOpen(false);
            setSelectedUserId(null);
          }}
          onChatClick={handleChatClick}
        />
      )}
    </div>
  );
}
```

### Props

| Prop | Type | Required | Description |
|------|------|----------|-------------|
| `userId` | `number` | ✅ | معرف المستخدم المراد عرض ملفه الشخصي |
| `isOpen` | `boolean` | ✅ | حالة فتح/إغلاق الـ Modal |
| `onClose` | `() => void` | ✅ | دالة يتم استدعاؤها عند إغلاق الـ Modal |
| `onChatClick` | `(userId: number, userName: string) => void` | ✅ | دالة يتم استدعاؤها عند النقر على زر الدردشة |

### الميزات
- ✅ عرض معلومات المستخدم (الاسم، البريد، السيرة الذاتية)
- ✅ عرض إحصائيات (عدد المشاريع والمنشورات)
- ✅ زر "بدء الدردشة" مع callback
- ✅ تصميم متجاوب مع Dark/Light Mode
- ✅ Animations سلسة باستخدام Framer Motion
- ✅ Loading state أثناء جلب البيانات
- ✅ Error handling

### API Endpoint المطلوب

المكون يستدعي:
```
GET /api/users/:id
```

يجب أن يعيد:
```json
{
  "id": 1,
  "email": "student@example.com",
  "full_name": "أحمد محمد علي",
  "role": "student",
  "avatar": "url",
  "bio": "...",
  "projects_count": 5,
  "posts_count": 10,
  "created_at": "2024-01-01T00:00:00Z"
}
```

---

## 3. مثال كامل: صفحة المجتمع

```tsx
'use client';

import { useState, useEffect } from 'react';
import StudentProfileModal from '@/components/StudentProfileModal';
import axios from 'axios';

interface Post {
  id: number;
  content: string;
  user: {
    id: number;
    full_name: string;
    avatar: string | null;
  };
  created_at: string;
}

export default function CommunityPage() {
  const [posts, setPosts] = useState<Post[]>([]);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedUserId, setSelectedUserId] = useState<number | null>(null);

  useEffect(() => {
    fetchPosts();
  }, []);

  const fetchPosts = async () => {
    try {
      const token = localStorage.getItem('token');
      const response = await axios.get('/api/posts', {
        headers: { Authorization: `Bearer ${token}` }
      });
      setPosts(response.data.posts);
    } catch (error) {
      console.error('Error fetching posts:', error);
    }
  };

  const handleUserClick = (userId: number) => {
    setSelectedUserId(userId);
    setIsModalOpen(true);
  };

  const handleChatClick = (userId: number, userName: string) => {
    // فتح الدردشة
    window.location.href = `/chat/${userId}`;
  };

  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-6 text-gray-900 dark:text-white">
        مجتمع الطلاب
      </h1>

      <div className="space-y-4">
        {posts.map((post) => (
          <div
            key={post.id}
            className="bg-white dark:bg-gray-800 rounded-lg p-6 shadow"
          >
            <div className="flex items-center gap-3 mb-4">
              <div
                onClick={() => handleUserClick(post.user.id)}
                className="cursor-pointer hover:underline"
              >
                <span className="font-semibold text-cyber-accent">
                  {post.user.full_name}
                </span>
              </div>
            </div>
            <p className="text-gray-700 dark:text-gray-300">{post.content}</p>
          </div>
        ))}
      </div>

      {selectedUserId && (
        <StudentProfileModal
          userId={selectedUserId}
          isOpen={isModalOpen}
          onClose={() => {
            setIsModalOpen(false);
            setSelectedUserId(null);
          }}
          onChatClick={handleChatClick}
        />
      )}
    </div>
  );
}
```

---

## 4. Theme Store (Zustand)

### الاستخدام المباشر

```tsx
import { useThemeStore } from '@/store/themeStore';

function MyComponent() {
  const { theme, toggleTheme, setTheme } = useThemeStore();

  return (
    <div>
      <p>الثيم الحالي: {theme}</p>
      <button onClick={toggleTheme}>تبديل الثيم</button>
      <button onClick={() => setTheme('dark')}>Dark Mode</button>
      <button onClick={() => setTheme('light')}>Light Mode</button>
    </div>
  );
}
```

### الحصول على الثيم فقط (بدون re-render)

```tsx
const theme = useThemeStore((state) => state.theme);
```

---

## ملاحظات مهمة

1. **Theme Toggle**: يظهر تلقائياً في أعلى يسار الشاشة - لا حاجة لإضافته يدوياً في كل صفحة.

2. **Student Profile Modal**: يجب أن يكون `userId` صحيحاً قبل فتح الـ Modal.

3. **API Authentication**: جميع طلبات API تتطلب JWT Token في Header:
   ```tsx
   headers: { Authorization: `Bearer ${token}` }
   ```

4. **Dark Mode**: تأكد من إضافة `dark:` classes في Tailwind CSS للعناصر التي تريد تخصيصها في الوضع الليلي.

