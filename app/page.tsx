'use client';

import { useEffect } from 'react';
import { useThemeStore } from '@/store/themeStore';
import Link from 'next/link';
import { FiBell, FiBook, FiUsers, FiFolder, FiMessageCircle, FiArrowLeft } from 'react-icons/fi';

export default function Home() {
  const theme = useThemeStore((state) => state.theme);

  useEffect(() => {
    const root = document.documentElement;
    if (theme === 'dark') {
      root.classList.add('dark');
    } else {
      root.classList.remove('dark');
    }
  }, [theme]);

  const sections = [
    {
      title: 'الإعلانات',
      description: 'تابع آخر الإعلانات والتحديثات من الإدارة',
      icon: FiBell,
      href: '/announcements',
      color: 'from-blue-500 to-cyan-500',
    },
    {
      title: 'الملازم والمحاضرات',
      description: 'احصل على جميع المواد التعليمية والملازم',
      icon: FiBook,
      href: '/resources',
      color: 'from-green-500 to-emerald-500',
    },
    {
      title: 'مجتمع الطلاب',
      description: 'تفاعل مع زملائك وشارك أفكارك',
      icon: FiUsers,
      href: '/community',
      color: 'from-purple-500 to-pink-500',
    },
    {
      title: 'مشاريع الطلاب',
      description: 'استعرض المشاريع البرمجية للطلاب',
      icon: FiFolder,
      href: '/projects',
      color: 'from-orange-500 to-red-500',
    },
    {
      title: 'الدردشة',
      description: 'تواصل مع زملائك مباشرة',
      icon: FiMessageCircle,
      href: '/chat',
      color: 'from-cyber-accent to-blue-500',
    },
  ];

  return (
    <main className="min-h-screen bg-white dark:bg-cyber-darker transition-colors duration-300">
      <div className="container mx-auto px-4 py-12">
        {/* Hero Section */}
        <div className="text-center mb-8 md:mb-16">
          <h1 className="text-2xl sm:text-3xl md:text-4xl lg:text-5xl font-bold text-gray-900 dark:text-white mb-3 md:mb-4 px-2">
            منصة مجتمع طلاب الأمن السيبراني
          </h1>
          <p className="text-base sm:text-lg md:text-xl text-gray-600 dark:text-gray-400 max-w-2xl mx-auto px-4">
            منصة شاملة تجمع طلاب الأمن السيبراني للتعلم والتواصل والتعاون
          </p>
        </div>

        {/* Features Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6 mb-8 md:mb-12">
          {sections.map((section) => {
            const Icon = section.icon;
            return (
              <Link
                key={section.href}
                href={section.href}
                className="group bg-white dark:bg-gray-800 rounded-xl p-6 shadow-lg hover:shadow-xl transition-all duration-300 border border-gray-200 dark:border-gray-700 hover:border-cyber-accent"
              >
                <div className={`w-12 h-12 rounded-lg bg-gradient-to-br ${section.color} flex items-center justify-center mb-4 group-hover:scale-110 transition-transform`}>
                  <Icon className="w-6 h-6 text-white" />
                </div>
                <h3 className="text-xl font-bold text-gray-900 dark:text-white mb-2">
                  {section.title}
                </h3>
                <p className="text-gray-600 dark:text-gray-400">
                  {section.description}
                </p>
                <div className="mt-4 flex items-center text-cyber-accent group-hover:translate-x-[-4px] transition-transform">
                  <span className="text-sm font-semibold">استكشف</span>
                  <FiArrowLeft className="w-4 h-4 mr-2" />
                </div>
              </Link>
            );
          })}
        </div>

        {/* Info Section */}
        <div className="bg-gradient-to-r from-cyber-accent/10 to-blue-500/10 rounded-xl p-4 sm:p-6 md:p-8 border border-cyber-accent/20">
          <h2 className="text-xl sm:text-2xl font-bold text-gray-900 dark:text-white mb-3 md:mb-4">
            مرحباً بك في المنصة
          </h2>
          <p className="text-sm sm:text-base text-gray-700 dark:text-gray-300 leading-relaxed mb-3 md:mb-4">
            هذه المنصة مصممة خصيصاً لطلاب الأمن السيبراني لتوفير بيئة تعليمية وتفاعلية شاملة.
            يمكنك من خلالها:
          </p>
          <ul className="list-disc list-inside space-y-1.5 sm:space-y-2 text-sm sm:text-base text-gray-700 dark:text-gray-300">
            <li>متابعة آخر الإعلانات والتحديثات من الإدارة</li>
            <li>تحميل الملازم والمحاضرات والمواد التعليمية</li>
            <li>التفاعل مع زملائك في المجتمع</li>
            <li>عرض مشاريعك البرمجية والإطلاع على مشاريع الآخرين</li>
            <li>التواصل المباشر مع زملائك عبر نظام الدردشة</li>
          </ul>
        </div>
      </div>
    </main>
  );
}

