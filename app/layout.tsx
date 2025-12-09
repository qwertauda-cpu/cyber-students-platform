import type { Metadata } from 'next';
import { Inter } from 'next/font/google';
import './globals.css';
import ThemeToggle from '@/components/ThemeToggle';
import Navbar from '@/components/Navbar';

const inter = Inter({ subsets: ['latin', 'latin-ext'] });

export const metadata: Metadata = {
  title: 'منصة مجتمع طلاب الأمن السيبراني',
  description: 'منصة تفاعلية لطلاب الأمن السيبراني',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="ar" dir="rtl">
      <body className={inter.className}>
        <ThemeToggle />
        <Navbar />
        {children}
      </body>
    </html>
  );
}

