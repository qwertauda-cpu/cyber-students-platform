'use client';

import { useState, useEffect } from 'react';
import { FiBook, FiDownload, FiFile, FiImage, FiVideo, FiFileText } from 'react-icons/fi';

interface Resource {
  id: number;
  title: string;
  description: string;
  file_type: 'pdf' | 'image' | 'video' | 'other';
  file_size: number;
  category: string;
  download_count: number;
  created_at: string;
}

export default function ResourcesPage() {
  const [resources, setResources] = useState<Resource[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedCategory, setSelectedCategory] = useState<string>('all');

  useEffect(() => {
    setTimeout(() => {
      setResources([
        {
          id: 1,
          title: 'ملازم الأسبوع الأول',
          description: 'ملازم دراسية للأسبوع الأول من الفصل الدراسي',
          file_type: 'pdf',
          file_size: 2048000,
          category: 'ملازم',
          download_count: 45,
          created_at: new Date().toISOString(),
        },
        {
          id: 2,
          title: 'محاضرة الأمن السيبراني',
          description: 'محاضرة شاملة عن أساسيات الأمن السيبراني',
          file_type: 'pdf',
          file_size: 5120000,
          category: 'محاضرات',
          download_count: 120,
          created_at: new Date().toISOString(),
        },
        {
          id: 3,
          title: 'صور توضيحية للشبكات',
          description: 'مجموعة صور توضيحية لشبكات الحاسوب',
          file_type: 'image',
          file_size: 1024000,
          category: 'صور',
          download_count: 30,
          created_at: new Date().toISOString(),
        },
      ]);
      setLoading(false);
    }, 500);
  }, []);

  const getFileIcon = (type: string) => {
    switch (type) {
      case 'pdf':
        return <FiFileText className="w-6 h-6 text-red-500" />;
      case 'image':
        return <FiImage className="w-6 h-6 text-green-500" />;
      case 'video':
        return <FiVideo className="w-6 h-6 text-blue-500" />;
      default:
        return <FiFile className="w-6 h-6 text-gray-500" />;
    }
  };

  const formatFileSize = (bytes: number) => {
    if (bytes < 1024) return bytes + ' B';
    if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(1) + ' KB';
    return (bytes / (1024 * 1024)).toFixed(1) + ' MB';
  };

  const categories = ['all', 'ملازم', 'محاضرات', 'صور', 'فيديو'];
  const filteredResources = selectedCategory === 'all' 
    ? resources 
    : resources.filter(r => r.category === selectedCategory);

  return (
    <main className="min-h-screen bg-white dark:bg-cyber-darker transition-colors duration-300">
      <div className="container mx-auto px-4 sm:px-6 py-4 sm:py-6 md:py-8">
        <div className="flex items-center gap-2 sm:gap-3 mb-4 sm:mb-6 md:mb-8">
          <FiBook className="w-6 h-6 sm:w-7 sm:h-7 md:w-8 md:h-8 text-cyber-accent flex-shrink-0" />
          <h1 className="text-2xl sm:text-3xl md:text-4xl font-bold text-gray-900 dark:text-white">
            الملازم والمحاضرات
          </h1>
        </div>

        {/* Category Filter */}
        <div className="flex gap-2 mb-4 sm:mb-6 flex-wrap">
          {categories.map((cat) => (
            <button
              key={cat}
              onClick={() => setSelectedCategory(cat)}
              className={`px-3 sm:px-4 py-2 rounded-lg transition-colors text-sm sm:text-base ${
                selectedCategory === cat
                  ? 'bg-cyber-accent text-white'
                  : 'bg-gray-200 dark:bg-gray-700 text-gray-700 dark:text-gray-300 hover:bg-gray-300 dark:hover:bg-gray-600'
              }`}
            >
              {cat === 'all' ? 'الكل' : cat}
            </button>
          ))}
        </div>

        {loading ? (
          <div className="flex items-center justify-center py-12">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-cyber-accent"></div>
          </div>
        ) : filteredResources.length === 0 ? (
          <div className="text-center py-12">
            <FiBook className="w-16 h-16 text-gray-400 mx-auto mb-4" />
            <p className="text-gray-600 dark:text-gray-400 text-lg">
              لا توجد موارد حالياً
            </p>
          </div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6">
            {filteredResources.map((resource) => (
              <div
                key={resource.id}
                className="bg-white dark:bg-gray-800 rounded-lg p-4 sm:p-5 md:p-6 shadow-lg hover:shadow-xl transition-all border border-gray-200 dark:border-gray-700"
              >
                <div className="flex items-start gap-3 sm:gap-4 mb-3 sm:mb-4">
                  <div className="flex-shrink-0">
                    {getFileIcon(resource.file_type)}
                  </div>
                  <div className="flex-1 min-w-0">
                    <h3 className="text-base sm:text-lg font-bold text-gray-900 dark:text-white mb-2">
                      {resource.title}
                    </h3>
                    <p className="text-xs sm:text-sm text-gray-600 dark:text-gray-400 mb-2 line-clamp-2">
                      {resource.description}
                    </p>
                    <div className="flex flex-wrap items-center gap-2 sm:gap-4 text-xs text-gray-500 dark:text-gray-400">
                      <span>{formatFileSize(resource.file_size)}</span>
                      <span className="hidden sm:inline">•</span>
                      <span>{resource.download_count} تحميل</span>
                      <span className="bg-cyber-accent/20 text-cyber-accent px-2 py-1 rounded text-xs">
                        {resource.category}
                      </span>
                    </div>
                  </div>
                </div>
                <button className="w-full flex items-center justify-center gap-2 bg-gradient-to-r from-cyber-accent to-blue-500 text-white py-2.5 px-4 rounded-lg hover:from-cyber-accent/90 hover:to-blue-600 transition-all text-sm sm:text-base">
                  <FiDownload className="w-4 h-4 sm:w-5 sm:h-5" />
                  <span>تحميل</span>
                </button>
              </div>
            ))}
          </div>
        )}
      </div>
    </main>
  );
}

