# هيكل API - منصة مجتمع طلاب الأمن السيبراني

## Base URL
```
/api
```

## Authentication
جميع الطلبات (ما عدا Login/Register) تتطلب JWT Token في Header:
```
Authorization: Bearer <token>
```

---

## 1. Authentication Endpoints

### POST /api/auth/register
**التسجيل**
```json
Request Body:
{
  "email": "student@example.com",
  "password": "password123",
  "full_name": "أحمد محمد علي"
}

Response:
{
  "success": true,
  "token": "jwt_token_here",
  "user": {
    "id": 1,
    "email": "student@example.com",
    "full_name": "أحمد محمد علي",
    "role": "student"
  }
}
```

### POST /api/auth/login
**تسجيل الدخول**
```json
Request Body:
{
  "email": "student@example.com",
  "password": "password123"
}

Response:
{
  "success": true,
  "token": "jwt_token_here",
  "user": { ... }
}
```

### GET /api/auth/me
**الحصول على بيانات المستخدم الحالي**
```json
Response:
{
  "id": 1,
  "email": "student@example.com",
  "full_name": "أحمد محمد علي",
  "role": "student",
  "theme_preference": "dark",
  "avatar": "url",
  "bio": "..."
}
```

---

## 2. Theme Endpoints

### PUT /api/user/theme
**تحديث تفضيل الثيم**
```json
Request Body:
{
  "theme": "dark" | "light"
}

Response:
{
  "success": true,
  "theme": "dark"
}
```

---

## 3. Announcements Endpoints

### GET /api/announcements
**الحصول على جميع الإعلانات**
```json
Query Params:
- page?: number (default: 1)
- limit?: number (default: 10)
- pinned?: boolean

Response:
{
  "announcements": [
    {
      "id": 1,
      "title": "إعلان مهم",
      "content": "...",
      "priority": "high",
      "is_pinned": true,
      "admin": {
        "id": 1,
        "full_name": "Admin Name"
      },
      "created_at": "2024-01-01T00:00:00Z"
    }
  ],
  "total": 10,
  "page": 1,
  "limit": 10
}
```

### POST /api/announcements
**إنشاء إعلان (Admin فقط)**
```json
Request Body:
{
  "title": "عنوان الإعلان",
  "content": "محتوى الإعلان",
  "priority": "high" | "medium" | "low",
  "is_pinned": false
}

Response:
{
  "success": true,
  "announcement": { ... }
}
```

### PUT /api/announcements/:id
**تحديث إعلان (Admin فقط)**

### DELETE /api/announcements/:id
**حذف إعلان (Admin فقط)**

---

## 4. Resources Endpoints (الملازم والمحاضرات)

### GET /api/resources
**الحصول على جميع الموارد**
```json
Query Params:
- category?: string
- page?: number
- limit?: number

Response:
{
  "resources": [
    {
      "id": 1,
      "title": "ملازم الأسبوع الأول",
      "description": "...",
      "file_path": "/uploads/resource.pdf",
      "file_type": "pdf",
      "file_size": 1024000,
      "category": "ملازم",
      "download_count": 50,
      "created_at": "2024-01-01T00:00:00Z"
    }
  ],
  "total": 20
}
```

### POST /api/resources
**رفع مورد جديد (Admin فقط)**
```json
Request: multipart/form-data
- file: File
- title: string
- description?: string
- category?: string

Response:
{
  "success": true,
  "resource": { ... }
}
```

### GET /api/resources/:id/download
**تحميل مورد**
```json
Response: File download
```

### DELETE /api/resources/:id
**حذف مورد (Admin فقط)**

---

## 5. Community Posts Endpoints

### GET /api/posts
**الحصول على جميع المنشورات**
```json
Query Params:
- page?: number
- limit?: number
- user_id?: number (للحصول على منشورات مستخدم محدد)

Response:
{
  "posts": [
    {
      "id": 1,
      "content": "منشور تجريبي",
      "image_url": "url",
      "likes_count": 10,
      "comments_count": 5,
      "user": {
        "id": 1,
        "full_name": "أحمد محمد علي",
        "avatar": "url"
      },
      "is_liked": false,
      "created_at": "2024-01-01T00:00:00Z"
    }
  ],
  "total": 50
}
```

### POST /api/posts
**إنشاء منشور جديد**
```json
Request: multipart/form-data
- content: string (required)
- image?: File

Response:
{
  "success": true,
  "post": { ... }
}
```

### DELETE /api/posts/:id
**حذف منشور (صاحب المنشور فقط)**

### POST /api/posts/:id/like
**إعجاب/إلغاء إعجاب بمنشور**
```json
Response:
{
  "success": true,
  "liked": true,
  "likes_count": 11
}
```

### GET /api/posts/:id/comments
**الحصول على تعليقات منشور**
```json
Response:
{
  "comments": [
    {
      "id": 1,
      "content": "تعليق تجريبي",
      "user": {
        "id": 2,
        "full_name": "محمد أحمد",
        "avatar": "url"
      },
      "created_at": "2024-01-01T00:00:00Z"
    }
  ]
}
```

### POST /api/posts/:id/comments
**إضافة تعليق**
```json
Request Body:
{
  "content": "نص التعليق"
}

Response:
{
  "success": true,
  "comment": { ... }
}
```

### DELETE /api/comments/:id
**حذف تعليق (صاحب التعليق فقط)**

---

## 6. Projects Endpoints

### GET /api/projects
**الحصول على جميع المشاريع**
```json
Query Params:
- page?: number
- limit?: number
- user_id?: number

Response:
{
  "projects": [
    {
      "id": 1,
      "title": "مشروع أمني",
      "description": "...",
      "github_url": "https://github.com/...",
      "demo_url": "https://demo.com",
      "image_url": "url",
      "technologies": ["React", "Node.js"],
      "views_count": 100,
      "likes_count": 20,
      "user": {
        "id": 1,
        "full_name": "أحمد محمد علي"
      },
      "is_liked": false,
      "created_at": "2024-01-01T00:00:00Z"
    }
  ],
  "total": 30
}
```

### POST /api/projects
**رفع مشروع جديد**
```json
Request: multipart/form-data
- title: string (required)
- description: string (required)
- github_url?: string
- demo_url?: string
- image?: File
- technologies?: string (JSON array)

Response:
{
  "success": true,
  "project": { ... }
}
```

### GET /api/projects/:id
**الحصول على تفاصيل مشروع**
```json
Response:
{
  "project": { ... },
  "related_projects": [ ... ]
}
```

### PUT /api/projects/:id
**تحديث مشروع (صاحب المشروع فقط)**

### DELETE /api/projects/:id
**حذف مشروع (صاحب المشروع فقط)**

### POST /api/projects/:id/like
**إعجاب/إلغاء إعجاب بمشروع**

---

## 7. User Profile Endpoints

### GET /api/users/:id
**الحصول على معلومات مستخدم**
```json
Response:
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

### PUT /api/users/:id
**تحديث الملف الشخصي**
```json
Request Body:
{
  "bio": "سيرة ذاتية جديدة",
  "avatar": "url"
  // ملاحظة: full_name لا يمكن تحديثه
}

Response:
{
  "success": true,
  "user": { ... }
}
```

---

## 8. Chat Endpoints

### GET /api/conversations
**الحصول على جميع المحادثات**
```json
Response:
{
  "conversations": [
    {
      "id": 1,
      "other_user": {
        "id": 2,
        "full_name": "محمد أحمد",
        "avatar": "url"
      },
      "last_message": {
        "content": "آخر رسالة",
        "created_at": "2024-01-01T00:00:00Z"
      },
      "unread_count": 2
    }
  ]
}
```

### GET /api/conversations/:id/messages
**الحصول على رسائل محادثة**
```json
Query Params:
- page?: number
- limit?: number

Response:
{
  "messages": [
    {
      "id": 1,
      "content": "مرحباً",
      "sender_id": 1,
      "is_read": false,
      "created_at": "2024-01-01T00:00:00Z"
    }
  ],
  "total": 50
}
```

### POST /api/conversations
**إنشاء محادثة جديدة أو الحصول على محادثة موجودة**
```json
Request Body:
{
  "user_id": 2
}

Response:
{
  "conversation_id": 1,
  "conversation": { ... }
}
```

### POST /api/conversations/:id/messages
**إرسال رسالة**
```json
Request Body:
{
  "content": "نص الرسالة"
}

Response:
{
  "success": true,
  "message": { ... }
}
```

### PUT /api/messages/:id/read
**تحديث حالة الرسالة كمقروءة**

---

## Error Responses

جميع الأخطاء تتبع هذا الشكل:
```json
{
  "success": false,
  "error": "Error message",
  "code": "ERROR_CODE"
}
```

### Status Codes:
- `200`: Success
- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden (Admin only)
- `404`: Not Found
- `500`: Internal Server Error

