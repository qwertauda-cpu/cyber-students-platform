import type { Metadata } from 'next';
import { Cairo } from 'next/font/google';
import './globals.css';
import ThemeToggle from '@/components/ThemeToggle';
import Navbar from '@/components/Navbar';

const cairo = Cairo({ 
  subsets: ['arabic', 'latin'],
  weight: ['300', '400', '500', '600', '700'],
  display: 'swap',
  variable: '--font-cairo',
});

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
      <body className={`${cairo.variable} font-sans antialiased`}>
        <ThemeToggle />
        <Navbar />
        {children}
      </body>
    </html>
  );
}

