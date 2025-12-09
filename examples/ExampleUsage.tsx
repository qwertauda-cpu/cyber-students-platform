/**
 * مثال عملي على استخدام المكونات
 * يمكن استخدام هذا الملف كمرجع عند بناء الصفحات
 */

'use client';

import { useState } from 'react';
import StudentProfileModal from '@/components/StudentProfileModal';
import ThemeToggle from '@/components/ThemeToggle';

/**
 * مثال: صفحة المجتمع مع استخدام StudentProfileModal
 */
export default function CommunityExample() {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedUserId, setSelectedUserId] = useState<number | null>(null);

  // قائمة منشورات وهمية
  const posts = [
    {
      id: 1,
      content: 'منشور تجريبي من طالب',
      user: {
        id: 1,
        full_name: 'أحمد محمد علي',
        avatar: null,
      },
    },
    {
      id: 2,
      content: 'منشور آخر من طالب آخر',
      user: {
        id: 2,
        full_name: 'محمد أحمد خالد',
        avatar: null,
      },
    },
  ];

  // عند النقر على اسم المستخدم
  const handleUserClick = (userId: number) => {
    setSelectedUserId(userId);
    setIsModalOpen(true);
  };

  // عند النقر على زر الدردشة في الـ Modal
  const handleChatClick = (userId: number, userName: string) => {
    console.log(`فتح الدردشة مع ${userName} (ID: ${userId})`);
    // يمكنك هنا:
    // 1. الانتقال إلى صفحة الدردشة
    // router.push(`/chat/${userId}`);
    
    // 2. أو فتح نافذة منبثقة للدردشة
    // setChatUserId(userId);
    // setIsChatOpen(true);
  };

  return (
    <div className="min-h-screen bg-white dark:bg-cyber-darker transition-colors duration-300">
      {/* ThemeToggle يظهر تلقائياً من layout.tsx */}
      {/* لكن يمكنك إضافته هنا أيضاً إذا أردت */}
      
      <div className="container mx-auto px-4 py-8">
        <h1 className="text-3xl font-bold mb-6 text-gray-900 dark:text-white">
          مجتمع الطلاب
        </h1>

        {/* قائمة المنشورات */}
        <div className="space-y-4">
          {posts.map((post) => (
            <div
              key={post.id}
              className="bg-white dark:bg-gray-800 rounded-lg p-6 shadow-lg border border-gray-200 dark:border-gray-700"
            >
              {/* اسم المستخدم - قابل للنقر */}
              <div className="flex items-center gap-3 mb-4">
                <div
                  onClick={() => handleUserClick(post.user.id)}
                  className="cursor-pointer hover:underline group"
                >
                  <span className="font-semibold text-cyber-accent group-hover:text-cyber-accent/80 transition-colors">
                    {post.user.full_name}
                  </span>
                </div>
                <span className="text-sm text-gray-500 dark:text-gray-400">
                  {new Date().toLocaleDateString('ar-SA')}
                </span>
              </div>

              {/* محتوى المنشور */}
              <p className="text-gray-700 dark:text-gray-300 leading-relaxed">
                {post.content}
              </p>

              {/* أزرار التفاعل */}
              <div className="mt-4 flex items-center gap-4">
                <button className="text-gray-600 dark:text-gray-400 hover:text-red-500 transition-colors">
                  ❤️ إعجاب
                </button>
                <button className="text-gray-600 dark:text-gray-400 hover:text-blue-500 transition-colors">
                  💬 تعليق
                </button>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Student Profile Modal */}
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

/**
 * مثال: استخدام Theme Store مباشرة
 */
import { useThemeStore } from '@/store/themeStore';

export function ThemeExample() {
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

// ملاحظة: يجب استيراد useThemeStore
// import { useThemeStore } from '@/store/themeStore';

