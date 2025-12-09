'use client';

import { useEffect, useState } from 'react';
import { HiX } from 'react-icons/hi';
import { FiMessageCircle, FiMail, FiCalendar, FiUser } from 'react-icons/fi';
import axios from 'axios';
import { motion, AnimatePresence } from 'framer-motion';

interface UserData {
  id: number;
  email: string;
  full_name: string;
  role: string;
  avatar: string | null;
  bio: string | null;
  created_at: string;
  projects_count?: number;
  posts_count?: number;
}

interface StudentProfileModalProps {
  userId: number;
  isOpen: boolean;
  onClose: () => void;
  onChatClick: (userId: number, userName: string) => void;
}

/**
 * Student Profile Modal Component
 * نافذة منبثقة تعرض معلومات الطالب مع زر الدردشة
 */
export default function StudentProfileModal({
  userId,
  isOpen,
  onClose,
  onChatClick,
}: StudentProfileModalProps) {
  const [userData, setUserData] = useState<UserData | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (isOpen && userId) {
      fetchUserData();
    }
  }, [isOpen, userId]);

  const fetchUserData = async () => {
    setLoading(true);
    setError(null);
    try {
      const token = localStorage.getItem('token');
      const response = await axios.get(`/api/users/${userId}`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      setUserData(response.data);
    } catch (err: any) {
      setError(err.response?.data?.error || 'فشل تحميل بيانات المستخدم');
      console.error('Error fetching user data:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleChatClick = () => {
    if (userData) {
      onChatClick(userData.id, userData.full_name);
      onClose();
    }
  };

  if (!isOpen) return null;

  return (
    <AnimatePresence>
      {isOpen && (
        <>
          {/* Backdrop */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={onClose}
            className="fixed inset-0 bg-black/50 dark:bg-black/70 z-50 flex items-center justify-center p-4"
          >
            {/* Modal */}
            <motion.div
              initial={{ opacity: 0, scale: 0.9, y: 20 }}
              animate={{ opacity: 1, scale: 1, y: 0 }}
              exit={{ opacity: 0, scale: 0.9, y: 20 }}
              onClick={(e) => e.stopPropagation()}
              className="bg-white dark:bg-cyber-darker rounded-xl sm:rounded-2xl shadow-2xl max-w-md w-full max-h-[90vh] overflow-y-auto border border-gray-200 dark:border-gray-800 mx-2 sm:mx-0"
            >
              {/* Header */}
              <div className="sticky top-0 bg-white dark:bg-cyber-darker border-b border-gray-200 dark:border-gray-800 px-4 sm:px-6 py-3 sm:py-4 flex items-center justify-between z-10">
                <h2 className="text-lg sm:text-xl font-bold text-gray-900 dark:text-white">
                  الملف الشخصي
                </h2>
                <button
                  onClick={onClose}
                  className="p-1.5 sm:p-2 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-full transition-colors touch-manipulation"
                  aria-label="إغلاق"
                >
                  <HiX className="w-5 h-5 text-gray-600 dark:text-gray-400" />
                </button>
              </div>

              {/* Content */}
              <div className="p-4 sm:p-6">
                {loading ? (
                  <div className="flex items-center justify-center py-12">
                    <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-cyber-accent"></div>
                  </div>
                ) : error ? (
                  <div className="text-center py-12">
                    <p className="text-red-500 dark:text-red-400">{error}</p>
                  </div>
                ) : userData ? (
                  <>
                    {/* Avatar & Name */}
                    <div className="text-center mb-4 sm:mb-6">
                      <div className="inline-block relative">
                        {userData.avatar ? (
                          <img
                            src={userData.avatar}
                            alt={userData.full_name}
                            className="w-20 h-20 sm:w-24 sm:h-24 rounded-full object-cover border-3 sm:border-4 border-cyber-accent"
                          />
                        ) : (
                          <div className="w-20 h-20 sm:w-24 sm:h-24 rounded-full bg-gradient-to-br from-cyber-accent to-blue-500 flex items-center justify-center border-3 sm:border-4 border-cyber-accent">
                            <FiUser className="w-10 h-10 sm:w-12 sm:h-12 text-white" />
                          </div>
                        )}
                      </div>
                      <h3 className="mt-3 sm:mt-4 text-xl sm:text-2xl font-bold text-gray-900 dark:text-white">
                        {userData.full_name}
                      </h3>
                      <p className="mt-1 text-xs sm:text-sm text-gray-500 dark:text-gray-400 capitalize">
                        {userData.role === 'admin' ? 'مدير' : 'طالب'}
                      </p>
                    </div>

                    {/* Bio */}
                    {userData.bio && (
                      <div className="mb-4 sm:mb-6 p-3 sm:p-4 bg-gray-50 dark:bg-gray-900 rounded-lg">
                        <p className="text-gray-700 dark:text-gray-300 text-xs sm:text-sm leading-relaxed">
                          {userData.bio}
                        </p>
                      </div>
                    )}

                    {/* Info Cards */}
                    <div className="space-y-2 sm:space-y-3 mb-4 sm:mb-6">
                      <div className="flex items-center gap-2 sm:gap-3 p-2.5 sm:p-3 bg-gray-50 dark:bg-gray-900 rounded-lg">
                        <FiMail className="w-4 h-4 sm:w-5 sm:h-5 text-cyber-accent flex-shrink-0" />
                        <span className="text-xs sm:text-sm text-gray-600 dark:text-gray-400 break-all">
                          {userData.email}
                        </span>
                      </div>
                      <div className="flex items-center gap-2 sm:gap-3 p-2.5 sm:p-3 bg-gray-50 dark:bg-gray-900 rounded-lg">
                        <FiCalendar className="w-4 h-4 sm:w-5 sm:h-5 text-cyber-accent flex-shrink-0" />
                        <span className="text-xs sm:text-sm text-gray-600 dark:text-gray-400">
                          انضم في:{' '}
                          {new Date(userData.created_at).toLocaleDateString('ar-SA')}
                        </span>
                      </div>
                      {userData.projects_count !== undefined && (
                        <div className="flex items-center gap-2 sm:gap-3 p-2.5 sm:p-3 bg-gray-50 dark:bg-gray-900 rounded-lg">
                          <FiUser className="w-4 h-4 sm:w-5 sm:h-5 text-cyber-accent flex-shrink-0" />
                          <span className="text-xs sm:text-sm text-gray-600 dark:text-gray-400">
                            المشاريع: {userData.projects_count} | المنشورات:{' '}
                            {userData.posts_count || 0}
                          </span>
                        </div>
                      )}
                    </div>

                    {/* Chat Button */}
                    <button
                      onClick={handleChatClick}
                      className="w-full py-2.5 sm:py-3 px-4 bg-gradient-to-r from-cyber-accent to-blue-500 hover:from-cyber-accent/90 hover:to-blue-600 text-white font-semibold rounded-lg transition-all duration-300 flex items-center justify-center gap-2 shadow-lg hover:shadow-xl transform hover:scale-[1.02] text-sm sm:text-base touch-manipulation"
                    >
                      <FiMessageCircle className="w-4 h-4 sm:w-5 sm:h-5" />
                      <span>بدء الدردشة</span>
                    </button>
                  </>
                ) : null}
              </div>
            </motion.div>
          </motion.div>
        </>
      )}
    </AnimatePresence>
  );
}

