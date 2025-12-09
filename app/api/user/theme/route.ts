import { NextRequest, NextResponse } from 'next/server';
import pool from '@/lib/db';
import { requireAuth } from '@/lib/auth';

export async function PUT(req: NextRequest) {
  try {
    const user = requireAuth(req);
    const { theme } = await req.json();

    if (!theme || (theme !== 'light' && theme !== 'dark')) {
      return NextResponse.json(
        { success: false, error: 'الثيم يجب أن يكون light أو dark' },
        { status: 400 }
      );
    }

    // تحديث تفضيل الثيم في قاعدة البيانات
    await pool.execute(
      'UPDATE users SET theme_preference = ? WHERE id = ?',
      [theme, user.userId]
    );

    return NextResponse.json({
      success: true,
      theme,
    });
  } catch (error: any) {
    if (error.message === 'Unauthorized') {
      return NextResponse.json(
        { success: false, error: 'غير مصرح' },
        { status: 401 }
      );
    }
    console.error('Theme update error:', error);
    return NextResponse.json(
      { success: false, error: 'حدث خطأ أثناء تحديث الثيم' },
      { status: 500 }
    );
  }
}

