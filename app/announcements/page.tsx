'use client';

import { useState, useEffect } from 'react';
import { FiBell, FiBookmark, FiAlertCircle, FiInfo, FiCheckCircle } from 'react-icons/fi';

interface Announcement {
  id: number;
  title: string;
  content: string;
  priority: 'low' | 'medium' | 'high';
  is_pinned: boolean;
  created_at: string;
  admin: {
    full_name: string;
  };
}

export default function AnnouncementsPage() {
  const [announcements, setAnnouncements] = useState<Announcement[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Simulated data - replace with API call
    setTimeout(() => {
      setAnnouncements([
        {
          id: 1,
          title: 'إعلان مهم: بدء الفصل الدراسي الجديد',
          content: 'نود إعلامكم بأن الفصل الدراسي الجديد سيبدأ في الأسبوع القادم. يرجى متابعة الإعلانات للحصول على آخر التحديثات.',
          priority: 'high',
          is_pinned: true,
          created_at: new Date().toISOString(),
          admin: { full_name: 'الإدارة' },
        },
        {
          id: 2,
          title: 'تحديث جديد على المنصة',
          content: 'تم إضافة ميزات جديدة للمنصة. يمكنك الآن رفع المشاريع والتفاعل مع المجتمع.',
          priority: 'medium',
          is_pinned: false,
          created_at: new Date().toISOString(),
          admin: { full_name: 'الإدارة' },
        },
      ]);
      setLoading(false);
    }, 500);
  }, []);

  const getPriorityIcon = (priority: string) => {
    switch (priority) {
      case 'high':
        return <FiAlertCircle className="w-5 h-5 text-red-500" />;
      case 'medium':
        return <FiInfo className="w-5 h-5 text-yellow-500" />;
      default:
        return <FiCheckCircle className="w-5 h-5 text-green-500" />;
    }
  };

  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case 'high':
        return 'border-r-4 border-red-500 bg-red-50 dark:bg-red-900/20';
      case 'medium':
        return 'border-r-4 border-yellow-500 bg-yellow-50 dark:bg-yellow-900/20';
      default:
        return 'border-r-4 border-green-500 bg-green-50 dark:bg-green-900/20';
    }
  };

  return (
    <main className="min-h-screen bg-white dark:bg-cyber-darker transition-colors duration-300">
      <div className="container mx-auto px-4 sm:px-6 py-4 sm:py-6 md:py-8">
        <div className="flex items-center gap-2 sm:gap-3 mb-4 sm:mb-6 md:mb-8">
          <FiBell className="w-6 h-6 sm:w-7 sm:h-7 md:w-8 md:h-8 text-cyber-accent flex-shrink-0" />
          <h1 className="text-2xl sm:text-3xl md:text-4xl font-bold text-gray-900 dark:text-white">
            لوحة الإعلانات
          </h1>
        </div>

        {loading ? (
          <div className="flex items-center justify-center py-12">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-cyber-accent"></div>
          </div>
        ) : announcements.length === 0 ? (
          <div className="text-center py-12">
            <FiBell className="w-16 h-16 text-gray-400 mx-auto mb-4" />
            <p className="text-gray-600 dark:text-gray-400 text-lg">
              لا توجد إعلانات حالياً
            </p>
          </div>
        ) : (
          <div className="space-y-3 sm:space-y-4">
            {announcements.map((announcement) => (
              <div
                key={announcement.id}
                className={`bg-white dark:bg-gray-800 rounded-lg p-4 sm:p-5 md:p-6 shadow-lg ${getPriorityColor(announcement.priority)}`}
              >
                <div className="flex items-start gap-2 sm:gap-3 mb-3 sm:mb-4">
                  <div className="flex items-start gap-2 sm:gap-3 flex-wrap">
                    {announcement.is_pinned && (
                      <FiBookmark className="w-4 h-4 sm:w-5 sm:h-5 text-cyber-accent fill-current flex-shrink-0 mt-1" />
                    )}
                    <div className="flex-shrink-0 mt-1">
                      {getPriorityIcon(announcement.priority)}
                    </div>
                    <h2 className="text-lg sm:text-xl font-bold text-gray-900 dark:text-white flex-1 min-w-0">
                      {announcement.title}
                    </h2>
                  </div>
                </div>
                <p className="text-sm sm:text-base text-gray-700 dark:text-gray-300 mb-3 sm:mb-4 leading-relaxed">
                  {announcement.content}
                </p>
                <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-2 text-xs sm:text-sm text-gray-500 dark:text-gray-400">
                  <span>من: {announcement.admin.full_name}</span>
                  <span>
                    {new Date(announcement.created_at).toLocaleDateString('ar-SA')}
                  </span>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </main>
  );
}

