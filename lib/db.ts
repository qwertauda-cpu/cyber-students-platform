import mysql from 'mysql2/promise';

// إعدادات الاتصال بقاعدة البيانات
const dbConfig = {
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'cyber_students',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
};

// إنشاء Connection Pool
const pool = mysql.createPool(dbConfig);

export default pool;

// Helper function للاستعلامات
export async function query(sql: string, params?: any[]) {
  try {
    const [results] = await pool.execute(sql, params);
    return results;
  } catch (error) {
    console.error('Database query error:', error);
    throw error;
  }
}

