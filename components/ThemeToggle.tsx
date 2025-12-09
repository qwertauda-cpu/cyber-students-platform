'use client';

import { useEffect, useState } from 'react';
import { HiMoon, HiSun } from 'react-icons/hi';
import { useThemeStore } from '@/store/themeStore';
import axios from 'axios';

/**
 * Theme Toggle Component
 * زر التحويل بين الوضع الليلي والنهاري
 * يظهر في أعلى يسار الشاشة
 */
export default function ThemeToggle() {
  const { theme, toggleTheme } = useThemeStore();
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
    // تطبيق الثيم عند تحميل الصفحة
    const savedTheme = localStorage.getItem('theme') || 'dark';
    if (savedTheme !== theme) {
      useThemeStore.setState({ theme: savedTheme as 'light' | 'dark' });
    }
    applyTheme(savedTheme);
  }, []);

  useEffect(() => {
    if (mounted) {
      applyTheme(theme);
      localStorage.setItem('theme', theme);
      
      // حفظ التفضيل في قاعدة البيانات (إذا كان المستخدم مسجل دخول)
      saveThemePreference(theme);
    }
  }, [theme, mounted]);

  const applyTheme = (newTheme: string) => {
    const root = document.documentElement;
    if (newTheme === 'dark') {
      root.classList.add('dark');
    } else {
      root.classList.remove('dark');
    }
  };

  const saveThemePreference = async (newTheme: string) => {
    try {
      const token = localStorage.getItem('token');
      if (token) {
        await axios.put('/api/user/theme', { theme: newTheme }, {
          headers: { Authorization: `Bearer ${token}` }
        });
      }
    } catch (error) {
      console.error('Failed to save theme preference:', error);
    }
  };

  const handleToggle = () => {
    toggleTheme();
  };

  if (!mounted) {
    return null; // تجنب hydration mismatch
  }

  return (
    <button
      onClick={handleToggle}
      className="fixed top-3 left-3 sm:top-4 sm:left-4 z-50 p-2.5 sm:p-3 rounded-full bg-gray-200 dark:bg-cyber-darker hover:bg-gray-300 dark:hover:bg-gray-800 transition-all duration-300 shadow-lg hover:shadow-xl border border-gray-300 dark:border-gray-700 touch-manipulation"
      aria-label="تبديل الثيم"
      title={theme === 'dark' ? 'التبديل إلى الوضع النهاري' : 'التبديل إلى الوضع الليلي'}
    >
      {theme === 'dark' ? (
        <HiSun className="w-5 h-5 sm:w-6 sm:h-6 text-yellow-500" />
      ) : (
        <HiMoon className="w-5 h-5 sm:w-6 sm:h-6 text-gray-700" />
      )}
    </button>
  );
}

