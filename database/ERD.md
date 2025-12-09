# مخطط قاعدة البيانات (ERD)

## العلاقات بين الجداول

```
users (المستخدمون)
├── 1:N announcements (الإعلانات)
├── 1:N resources (الملازم والمحاضرات)
├── 1:N posts (منشورات المجتمع)
├── 1:N comments (التعليقات)
├── 1:N projects (مشاريع الطلاب)
├── 1:N likes (إعجابات المنشورات)
├── 1:N project_likes (إعجابات المشاريع)
├── 1:N messages (الرسائل)
└── N:N conversations (المحادثات - عبر user1_id و user2_id)

announcements (الإعلانات)
└── N:1 users (admin_id)

resources (الملازم)
└── N:1 users (admin_id)

posts (المنشورات)
├── N:1 users (user_id)
├── 1:N likes (الإعجابات)
└── 1:N comments (التعليقات)

comments (التعليقات)
├── N:1 posts (post_id)
└── N:1 users (user_id)

likes (الإعجابات)
├── N:1 posts (post_id)
└── N:1 users (user_id)

projects (المشاريع)
├── N:1 users (user_id)
└── 1:N project_likes (إعجابات المشاريع)

conversations (المحادثات)
├── N:1 users (user1_id)
├── N:1 users (user2_id)
└── 1:N messages (الرسائل)

messages (الرسائل)
├── N:1 conversations (conversation_id)
└── N:1 users (sender_id)
```

## الحقول المهمة

### users
- `full_name`: الاسم الثلاثي - **للقراءة فقط بعد التسجيل**
- `role`: admin أو student
- `theme_preference`: light أو dark (افتراضي: dark)

### announcements
- فقط الـ Admin يمكنه الإنشاء
- `is_pinned`: لتثبيت الإعلانات المهمة

### resources
- فقط الـ Admin يمكنه الرفع
- `download_count`: عدد مرات التحميل

### posts, comments, likes
- الطلاب فقط يمكنهم التفاعل

### projects
- الطلاب فقط يمكنهم رفع المشاريع

### conversations & messages
- نظام محادثة ثنائية بين طالبين

