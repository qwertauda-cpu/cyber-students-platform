# دليل التنفيذ الكامل

## خطوات البدء السريع

### 1. إعداد قاعدة البيانات

```bash
# إنشاء قاعدة البيانات
mysql -u root -p
CREATE DATABASE cyber_students CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
EXIT;

# استيراد Schema
mysql -u root -p cyber_students < database/schema.sql
```

### 2. إعداد متغيرات البيئة

أنشئ ملف `.env` في جذر المشروع:

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=cyber_students
JWT_SECRET=your-super-secret-jwt-key-min-32-characters
NEXT_PUBLIC_API_URL=http://localhost:3000
```

### 3. تثبيت المتطلبات

```bash
npm install
```

### 4. تشغيل المشروع

```bash
npm run dev
```

---

## هيكلية الصفحات المطلوبة

### 1. صفحة الإعلانات (Announcements)

**المسار**: `/announcements`

**الصلاحيات**: 
- القراءة: الجميع
- الكتابة: Admin فقط

**المكونات المطلوبة**:
- قائمة الإعلانات
- زر "إضافة إعلان" (Admin فقط)
- فلترة حسب الأولوية
- تثبيت الإعلانات المهمة

### 2. صفحة الملازم والمحاضرات (Resources)

**المسار**: `/resources`

**الصلاحيات**:
- القراءة: الجميع
- الرفع: Admin فقط

**المكونات المطلوبة**:
- قائمة الملفات مع فلترة حسب الفئة
- زر "رفع ملف" (Admin فقط)
- عداد التحميلات
- زر التحميل لكل ملف

### 3. صفحة المجتمع (Community)

**المسار**: `/community`

**الصلاحيات**: الطلاب فقط

**المكونات المطلوبة**:
- Feed للمنشورات
- نموذج إنشاء منشور
- نظام الإعجابات
- نظام التعليقات
- النقر على اسم المستخدم يفتح `StudentProfileModal`

### 4. صفحة المشاريع (Projects)

**المسار**: `/projects`

**الصلاحيات**: 
- القراءة: الجميع
- الرفع: الطلاب فقط

**المكونات المطلوبة**:
- Grid للمشاريع
- نموذج رفع مشروع
- تفاصيل المشروع (Modal أو صفحة منفصلة)
- نظام الإعجابات

### 5. صفحة الدردشة (Chat)

**المسار**: `/chat/:userId?`

**الصلاحيات**: الطلاب فقط

**المكونات المطلوبة**:
- قائمة المحادثات
- نافذة الدردشة
- Real-time messaging (Socket.io)

---

## نظام الصلاحيات

### Middleware للتحقق من الصلاحيات

```tsx
// lib/middleware.ts
import { NextRequest, NextResponse } from 'next/server';
import { requireAuth, requireAdmin } from '@/lib/auth';

export function withAuth(handler: Function) {
  return async (req: NextRequest) => {
    try {
      const user = requireAuth(req);
      return handler(req, user);
    } catch (error) {
      return NextResponse.json(
        { success: false, error: 'غير مصرح' },
        { status: 401 }
      );
    }
  };
}

export function withAdmin(handler: Function) {
  return async (req: NextRequest) => {
    try {
      const user = requireAdmin(req);
      return handler(req, user);
    } catch (error) {
      return NextResponse.json(
        { success: false, error: 'صلاحيات Admin مطلوبة' },
        { status: 403 }
      );
    }
  };
}
```

### استخدام Middleware

```tsx
// app/api/announcements/route.ts
import { withAdmin } from '@/lib/middleware';

export const POST = withAdmin(async (req: NextRequest, user) => {
  // فقط Admin يمكنه الوصول هنا
  const body = await req.json();
  // ... إنشاء إعلان
});
```

---

## حماية حقل full_name

### في API Update User

```tsx
// app/api/users/[id]/route.ts
export async function PUT(req: NextRequest, { params }: { params: { id: string } }) {
  const user = requireAuth(req);
  const body = await req.json();
  
  // إزالة full_name من body إذا كان موجوداً
  const { full_name, ...updateData } = body;
  
  // تحديث البيانات (بدون full_name)
  await pool.execute(
    'UPDATE users SET bio = ?, avatar = ? WHERE id = ?',
    [updateData.bio, updateData.avatar, params.id]
  );
}
```

### في Frontend

```tsx
// عند تحديث الملف الشخصي
const updateProfile = async (data: { bio: string; avatar: string }) => {
  // لا ترسل full_name في الطلب
  await axios.put('/api/users/me', {
    bio: data.bio,
    avatar: data.avatar
    // لا ترسل full_name
  });
};
```

---

## إعداد Socket.io للدردشة

### Server Side

```tsx
// app/api/socket/route.ts (أو server.js منفصل)
import { Server } from 'socket.io';
import { createServer } from 'http';

const httpServer = createServer();
const io = new Server(httpServer, {
  cors: { origin: '*' }
});

io.on('connection', (socket) => {
  socket.on('join-room', (conversationId) => {
    socket.join(`conversation-${conversationId}`);
  });

  socket.on('send-message', async (data) => {
    // حفظ الرسالة في قاعدة البيانات
    // إرسال الرسالة للمستخدم الآخر
    io.to(`conversation-${data.conversationId}`).emit('new-message', data);
  });
});
```

### Client Side

```tsx
// hooks/useChat.ts
import { useEffect, useState } from 'react';
import { io } from 'socket.io-client';

export function useChat(conversationId: number) {
  const [socket, setSocket] = useState<any>(null);
  const [messages, setMessages] = useState([]);

  useEffect(() => {
    const newSocket = io('http://localhost:3001');
    newSocket.emit('join-room', conversationId);
    setSocket(newSocket);

    newSocket.on('new-message', (message) => {
      setMessages((prev) => [...prev, message]);
    });

    return () => newSocket.close();
  }, [conversationId]);

  const sendMessage = (content: string) => {
    socket.emit('send-message', {
      conversationId,
      content,
      senderId: getCurrentUserId(),
    });
  };

  return { messages, sendMessage };
}
```

---

## رفع الملفات

### إعداد Multer

```tsx
// lib/upload.ts
import multer from 'multer';
import path from 'path';
import fs from 'fs';

const uploadDir = './public/uploads';

if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

export const upload = multer({
  storage: multer.diskStorage({
    destination: (req, file, cb) => {
      cb(null, uploadDir);
    },
    filename: (req, file, cb) => {
      const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
      cb(null, uniqueSuffix + path.extname(file.originalname));
    },
  }),
  limits: { fileSize: 10 * 1024 * 1024 }, // 10MB
});
```

### استخدامه في API Route

```tsx
// app/api/resources/route.ts
import { upload } from '@/lib/upload';

export async function POST(req: NextRequest) {
  const user = requireAdmin(req);
  
  // استخدام Next.js FormData
  const formData = await req.formData();
  const file = formData.get('file') as File;
  
  // حفظ الملف
  const bytes = await file.arrayBuffer();
  const buffer = Buffer.from(bytes);
  const filename = `${Date.now()}-${file.name}`;
  const filepath = `./public/uploads/${filename}`;
  
  fs.writeFileSync(filepath, buffer);
  
  // حفظ في قاعدة البيانات
  await pool.execute(
    'INSERT INTO resources (admin_id, title, file_path, file_type, file_size) VALUES (?, ?, ?, ?, ?)',
    [user.userId, formData.get('title'), `/uploads/${filename}`, file.type, file.size]
  );
}
```

---

## نصائح مهمة

1. **الأمان**: 
   - استخدم HTTPS في الإنتاج
   - قم بتشفير كلمات المرور
   - تحقق من الصلاحيات في كل endpoint

2. **الأداء**:
   - استخدم Pagination للقوائم الطويلة
   - استخدم Caching حيثما أمكن
   - قم بتحسين الصور قبل الرفع

3. **UX**:
   - أضف Loading states
   - أضف Error handling
   - استخدم Animations سلسة

4. **RTL Support**:
   - استخدم `dir="rtl"` في HTML
   - استخدم Tailwind RTL classes عند الحاجة

---

## الخطوات التالية

1. ✅ Database Schema - مكتمل
2. ✅ API Structure - مكتمل
3. ✅ Theme Toggle - مكتمل
4. ✅ Student Profile Modal - مكتمل
5. ⏳ بناء صفحات المنصة الرئيسية
6. ⏳ إعداد Socket.io للدردشة
7. ⏳ إضافة نظام الإشعارات
8. ⏳ إضافة البحث والفلترة

