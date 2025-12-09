'use client';

import { useEffect } from 'react';
import { useThemeStore } from '@/store/themeStore';

export default function Home() {
  const theme = useThemeStore((state) => state.theme);

  useEffect(() => {
    // تطبيق الثيم عند تحميل الصفحة
    const root = document.documentElement;
    if (theme === 'dark') {
      root.classList.add('dark');
    } else {
      root.classList.remove('dark');
    }
  }, [theme]);

  return (
    <main className="min-h-screen bg-white dark:bg-cyber-darker transition-colors duration-300">
      <div className="container mx-auto px-4 py-8">
        <h1 className="text-4xl font-bold text-center text-gray-900 dark:text-white mb-8">
          منصة مجتمع طلاب الأمن السيبراني
        </h1>
        <p className="text-center text-gray-600 dark:text-gray-400">
          مرحباً بك في المنصة
        </p>
      </div>
    </main>
  );
}

