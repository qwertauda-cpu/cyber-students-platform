'use client';

import { useState } from 'react';
import { FiMessageCircle, FiSend } from 'react-icons/fi';

export default function ChatPage() {
  const [conversations] = useState([
    {
      id: 1,
      user: { name: 'أحمد محمد', avatar: null },
      lastMessage: 'مرحباً، كيف حالك؟',
      unreadCount: 2,
      time: '10:30 ص',
    },
    {
      id: 2,
      user: { name: 'محمد أحمد', avatar: null },
      lastMessage: 'شكراً على المساعدة',
      unreadCount: 0,
      time: 'أمس',
    },
  ]);

  return (
    <main className="min-h-screen bg-white dark:bg-cyber-darker transition-colors duration-300">
      <div className="container mx-auto px-4 sm:px-6 py-4 sm:py-6 md:py-8">
        <div className="flex items-center gap-2 sm:gap-3 mb-4 sm:mb-6 md:mb-8">
          <FiMessageCircle className="w-6 h-6 sm:w-7 sm:h-7 md:w-8 md:h-8 text-cyber-accent flex-shrink-0" />
          <h1 className="text-2xl sm:text-3xl md:text-4xl font-bold text-gray-900 dark:text-white">
            الدردشة
          </h1>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-4 sm:gap-6">
          {/* Conversations List */}
          <div className="lg:col-span-1 bg-white dark:bg-gray-800 rounded-lg shadow-lg border border-gray-200 dark:border-gray-700">
            <div className="p-3 sm:p-4 border-b border-gray-200 dark:border-gray-700">
              <h2 className="text-base sm:text-lg font-bold text-gray-900 dark:text-white">
                المحادثات
              </h2>
            </div>
            <div className="divide-y divide-gray-200 dark:divide-gray-700 max-h-[400px] lg:max-h-none overflow-y-auto">
              {conversations.map((conv) => (
                <div
                  key={conv.id}
                  className="p-3 sm:p-4 hover:bg-gray-50 dark:hover:bg-gray-700 cursor-pointer transition-colors"
                >
                  <div className="flex items-center gap-2 sm:gap-3">
                    <div className="w-10 h-10 sm:w-12 sm:h-12 rounded-full bg-gradient-to-br from-cyber-accent to-blue-500 flex items-center justify-center text-white font-bold text-sm sm:text-base flex-shrink-0">
                      {conv.user.name.charAt(0)}
                    </div>
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center justify-between mb-1">
                        <h3 className="font-semibold text-gray-900 dark:text-white truncate text-sm sm:text-base">
                          {conv.user.name}
                        </h3>
                        <span className="text-xs text-gray-500 dark:text-gray-400 flex-shrink-0 mr-2">
                          {conv.time}
                        </span>
                      </div>
                      <p className="text-xs sm:text-sm text-gray-600 dark:text-gray-400 truncate">
                        {conv.lastMessage}
                      </p>
                    </div>
                    {conv.unreadCount > 0 && (
                      <span className="bg-cyber-accent text-white text-xs rounded-full w-5 h-5 sm:w-6 sm:h-6 flex items-center justify-center flex-shrink-0 text-xs">
                        {conv.unreadCount}
                      </span>
                    )}
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* Chat Area */}
          <div className="lg:col-span-2 bg-white dark:bg-gray-800 rounded-lg shadow-lg border border-gray-200 dark:border-gray-700 flex flex-col h-[400px] sm:h-[500px] lg:h-[600px]">
            <div className="p-3 sm:p-4 border-b border-gray-200 dark:border-gray-700">
              <h2 className="text-base sm:text-lg font-bold text-gray-900 dark:text-white">
                اختر محادثة للبدء
              </h2>
            </div>
            <div className="flex-1 flex items-center justify-center text-gray-500 dark:text-gray-400">
              <div className="text-center px-4">
                <FiMessageCircle className="w-12 h-12 sm:w-16 sm:h-16 mx-auto mb-3 sm:mb-4 opacity-50" />
                <p className="text-sm sm:text-base">اختر محادثة من القائمة للبدء</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
  );
}

