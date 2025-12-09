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
    <main className="min-h-screen bg-slate-50 dark:bg-slate-900 transition-colors duration-300">
      <div className="container mx-auto px-4 sm:px-6 lg:px-8 py-8 sm:py-12 lg:py-16">
        {/* Hero Section */}
        <div className="text-center mb-12 md:mb-20">
          <h1 className="text-3xl sm:text-4xl md:text-5xl lg:text-6xl font-bold text-slate-900 dark:text-slate-50 mb-4 md:mb-6 leading-tight">
            منصة مجتمع طلاب الأمن السيبراني
          </h1>
          <p className="text-lg sm:text-xl md:text-2xl text-slate-600 dark:text-slate-400 max-w-3xl mx-auto leading-relaxed">
            منصة شاملة تجمع طلاب الأمن السيبراني للتعلم والتواصل والتعاون
          </p>
        </div>

        {/* Features Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 sm:gap-8 mb-12 md:mb-16">
          {sections.map((section) => {
            const Icon = section.icon;
            return (
              <Link
                key={section.href}
                href={section.href}
                className="group bg-white dark:bg-slate-800 rounded-2xl p-6 sm:p-8 shadow-sm hover:shadow-md transition-all duration-300 border border-slate-200 dark:border-slate-700 hover:border-cyber-accent/50 hover:-translate-y-1"
              >
                <div className={`w-14 h-14 rounded-xl bg-gradient-to-br ${section.color} flex items-center justify-center mb-5 group-hover:scale-110 transition-transform shadow-lg`}>
                  <Icon className="w-7 h-7 text-white" />
                </div>
                <h3 className="text-xl sm:text-2xl font-semibold text-slate-900 dark:text-slate-50 mb-3 leading-tight">
                  {section.title}
                </h3>
                <p className="text-slate-600 dark:text-slate-400 text-base leading-relaxed mb-4">
                  {section.description}
                </p>
                <div className="flex items-center text-cyber-accent group-hover:translate-x-[-4px] transition-transform font-medium">
                  <span className="text-sm">استكشف</span>
                  <FiArrowLeft className="w-4 h-4 mr-2" />
                </div>
              </Link>
            );
          })}
        </div>

        {/* Info Section */}
        <div className="bg-gradient-to-br from-cyber-accent/5 to-blue-500/5 dark:from-cyber-accent/10 dark:to-blue-500/10 rounded-2xl p-6 sm:p-8 md:p-10 border border-slate-200 dark:border-slate-700">
          <h2 className="text-2xl sm:text-3xl font-bold text-slate-900 dark:text-slate-50 mb-4 md:mb-6">
            مرحباً بك في المنصة
          </h2>
          <p className="text-base sm:text-lg text-slate-700 dark:text-slate-300 leading-relaxed mb-6 md:mb-8">
            هذه المنصة مصممة خصيصاً لطلاب الأمن السيبراني لتوفير بيئة تعليمية وتفاعلية شاملة.
            يمكنك من خلالها:
          </p>
          <ul className="space-y-3 sm:space-y-4 text-base sm:text-lg text-slate-700 dark:text-slate-300">
            <li className="flex items-start gap-3">
              <span className="text-cyber-accent mt-1">•</span>
              <span>متابعة آخر الإعلانات والتحديثات من الإدارة</span>
            </li>
            <li className="flex items-start gap-3">
              <span className="text-cyber-accent mt-1">•</span>
              <span>تحميل الملازم والمحاضرات والمواد التعليمية</span>
            </li>
            <li className="flex items-start gap-3">
              <span className="text-cyber-accent mt-1">•</span>
              <span>التفاعل مع زملائك في المجتمع</span>
            </li>
            <li className="flex items-start gap-3">
              <span className="text-cyber-accent mt-1">•</span>
              <span>عرض مشاريعك البرمجية والإطلاع على مشاريع الآخرين</span>
            </li>
            <li className="flex items-start gap-3">
              <span className="text-cyber-accent mt-1">•</span>
              <span>التواصل المباشر مع زملائك عبر نظام الدردشة</span>
            </li>
          </ul>
        </div>
      </div>
    </main>
  );
}

