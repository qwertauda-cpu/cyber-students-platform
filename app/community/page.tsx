'use client';

import { useState, useEffect } from 'react';
import { FiUsers, FiHeart, FiMessageCircle, FiSend } from 'react-icons/fi';
import StudentProfileModal from '@/components/StudentProfileModal';

interface Post {
  id: number;
  content: string;
  image_url?: string;
  likes_count: number;
  comments_count: number;
  user: {
    id: number;
    full_name: string;
    avatar?: string;
  };
  created_at: string;
  is_liked: boolean;
}

export default function CommunityPage() {
  const [posts, setPosts] = useState<Post[]>([]);
  const [loading, setLoading] = useState(true);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedUserId, setSelectedUserId] = useState<number | null>(null);

  useEffect(() => {
    setTimeout(() => {
      setPosts([
        {
          id: 1,
          content: 'شاركنا تجربتك في مشروع الأمن السيبراني الأخير! ما هي التحديات التي واجهتها وكيف تغلبت عليها؟',
          likes_count: 15,
          comments_count: 8,
          user: {
            id: 1,
            full_name: 'أحمد محمد علي',
          },
          created_at: new Date().toISOString(),
          is_liked: false,
        },
        {
          id: 2,
          content: 'هل يعرف أحد مصادر جيدة لتعلم penetration testing؟ أبحث عن موارد عملية.',
          likes_count: 22,
          comments_count: 12,
          user: {
            id: 2,
            full_name: 'محمد أحمد خالد',
          },
          created_at: new Date().toISOString(),
          is_liked: true,
        },
      ]);
      setLoading(false);
    }, 500);
  }, []);

  const handleUserClick = (userId: number) => {
    setSelectedUserId(userId);
    setIsModalOpen(true);
  };

  const handleChatClick = (userId: number, userName: string) => {
    console.log(`Opening chat with ${userName} (ID: ${userId})`);
    // Navigate to chat page
  };

  return (
    <main className="min-h-screen bg-white dark:bg-cyber-darker transition-colors duration-300">
      <div className="container mx-auto px-4 sm:px-6 py-4 sm:py-6 md:py-8">
        <div className="flex items-center gap-2 sm:gap-3 mb-4 sm:mb-6 md:mb-8">
          <FiUsers className="w-6 h-6 sm:w-7 sm:h-7 md:w-8 md:h-8 text-cyber-accent flex-shrink-0" />
          <h1 className="text-2xl sm:text-3xl md:text-4xl font-bold text-gray-900 dark:text-white">
            مجتمع الطلاب
          </h1>
        </div>

        {loading ? (
          <div className="flex items-center justify-center py-12">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-cyber-accent"></div>
          </div>
        ) : (
          <div className="space-y-4 sm:space-y-6">
            {posts.map((post) => (
              <div
                key={post.id}
                className="bg-white dark:bg-gray-800 rounded-lg p-4 sm:p-5 md:p-6 shadow-lg border border-gray-200 dark:border-gray-700"
              >
                <div className="flex flex-col sm:flex-row sm:items-center gap-2 sm:gap-3 mb-3 sm:mb-4">
                  <div
                    onClick={() => handleUserClick(post.user.id)}
                    className="cursor-pointer hover:underline group"
                  >
                    <span className="font-semibold text-cyber-accent group-hover:text-cyber-accent/80 transition-colors text-sm sm:text-base">
                      {post.user.full_name}
                    </span>
                  </div>
                  <span className="text-xs sm:text-sm text-gray-500 dark:text-gray-400">
                    {new Date(post.created_at).toLocaleDateString('ar-SA')}
                  </span>
                </div>

                <p className="text-sm sm:text-base text-gray-700 dark:text-gray-300 leading-relaxed mb-3 sm:mb-4">
                  {post.content}
                </p>

                <div className="flex items-center gap-2 sm:gap-4 pt-3 sm:pt-4 border-t border-gray-200 dark:border-gray-700">
                  <button
                    className={`flex items-center gap-1.5 sm:gap-2 px-3 sm:px-4 py-2 rounded-lg transition-colors text-sm sm:text-base ${
                      post.is_liked
                        ? 'text-red-500 bg-red-50 dark:bg-red-900/20'
                        : 'text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700'
                    }`}
                  >
                    <FiHeart className={`w-4 h-4 sm:w-5 sm:h-5 ${post.is_liked ? 'fill-current' : ''}`} />
                    <span>{post.likes_count}</span>
                  </button>
                  <button className="flex items-center gap-1.5 sm:gap-2 px-3 sm:px-4 py-2 rounded-lg text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700 transition-colors text-sm sm:text-base">
                    <FiMessageCircle className="w-4 h-4 sm:w-5 sm:h-5" />
                    <span>{post.comments_count}</span>
                  </button>
                  <button className="flex items-center gap-1.5 sm:gap-2 px-3 sm:px-4 py-2 rounded-lg text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700 transition-colors text-sm sm:text-base">
                    <FiSend className="w-4 h-4 sm:w-5 sm:h-5" />
                    <span className="hidden sm:inline">مشاركة</span>
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}

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
    </main>
  );
}

