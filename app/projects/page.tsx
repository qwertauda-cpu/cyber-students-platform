'use client';

import { useState, useEffect } from 'react';
import { FiFolder, FiGithub, FiExternalLink, FiEye, FiHeart } from 'react-icons/fi';

interface Project {
  id: number;
  title: string;
  description: string;
  github_url?: string;
  demo_url?: string;
  image_url?: string;
  technologies: string[];
  views_count: number;
  likes_count: number;
  user: {
    full_name: string;
  };
  created_at: string;
  is_liked: boolean;
}

export default function ProjectsPage() {
  const [projects, setProjects] = useState<Project[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setTimeout(() => {
      setProjects([
        {
          id: 1,
          title: 'نظام كشف التسلل',
          description: 'نظام متقدم لكشف محاولات التسلل على الشبكات باستخدام تقنيات الذكاء الاصطناعي',
          github_url: 'https://github.com/example/intrusion-detection',
          demo_url: 'https://demo.example.com',
          technologies: ['Python', 'TensorFlow', 'React', 'Node.js'],
          views_count: 245,
          likes_count: 32,
          user: { full_name: 'أحمد محمد' },
          created_at: new Date().toISOString(),
          is_liked: false,
        },
        {
          id: 2,
          title: 'أداة تحليل الثغرات',
          description: 'أداة شاملة لتحليل الثغرات الأمنية في التطبيقات الويب',
          github_url: 'https://github.com/example/vulnerability-scanner',
          technologies: ['JavaScript', 'Node.js', 'Express'],
          views_count: 189,
          likes_count: 28,
          user: { full_name: 'محمد أحمد' },
          created_at: new Date().toISOString(),
          is_liked: true,
        },
      ]);
      setLoading(false);
    }, 500);
  }, []);

  return (
    <main className="min-h-screen bg-white dark:bg-cyber-darker transition-colors duration-300">
      <div className="container mx-auto px-4 sm:px-6 py-4 sm:py-6 md:py-8">
        <div className="flex items-center gap-2 sm:gap-3 mb-4 sm:mb-6 md:mb-8">
          <FiFolder className="w-6 h-6 sm:w-7 sm:h-7 md:w-8 md:h-8 text-cyber-accent flex-shrink-0" />
          <h1 className="text-2xl sm:text-3xl md:text-4xl font-bold text-gray-900 dark:text-white">
            مشاريع الطلاب
          </h1>
        </div>

        {loading ? (
          <div className="flex items-center justify-center py-12">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-cyber-accent"></div>
          </div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6">
            {projects.map((project) => (
              <div
                key={project.id}
                className="bg-white dark:bg-gray-800 rounded-lg overflow-hidden shadow-lg hover:shadow-xl transition-all border border-gray-200 dark:border-gray-700"
              >
                <div className="p-4 sm:p-5 md:p-6">
                  <h3 className="text-lg sm:text-xl font-bold text-gray-900 dark:text-white mb-2">
                    {project.title}
                  </h3>
                  <p className="text-sm sm:text-base text-gray-600 dark:text-gray-400 mb-3 sm:mb-4 line-clamp-3">
                    {project.description}
                  </p>
                  
                  <div className="flex flex-wrap gap-1.5 sm:gap-2 mb-3 sm:mb-4">
                    {project.technologies.map((tech) => (
                      <span
                        key={tech}
                        className="px-2 py-1 bg-cyber-accent/20 text-cyber-accent text-xs rounded"
                      >
                        {tech}
                      </span>
                    ))}
                  </div>

                  <div className="flex flex-wrap items-center gap-2 sm:gap-4 text-xs sm:text-sm text-gray-500 dark:text-gray-400 mb-3 sm:mb-4">
                    <span className="flex items-center gap-1">
                      <FiEye className="w-3 h-3 sm:w-4 sm:h-4" />
                      {project.views_count}
                    </span>
                    <span className="flex items-center gap-1">
                      <FiHeart className="w-3 h-3 sm:w-4 sm:h-4" />
                      {project.likes_count}
                    </span>
                    <span className="w-full sm:w-auto">من: {project.user.full_name}</span>
                  </div>

                  <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-2">
                    {project.github_url && (
                      <a
                        href={project.github_url}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="flex items-center justify-center gap-2 px-3 sm:px-4 py-2 bg-gray-200 dark:bg-gray-700 text-gray-700 dark:text-gray-300 rounded-lg hover:bg-gray-300 dark:hover:bg-gray-600 transition-colors text-sm sm:text-base"
                      >
                        <FiGithub className="w-4 h-4 sm:w-5 sm:h-5" />
                        <span>GitHub</span>
                      </a>
                    )}
                    {project.demo_url && (
                      <a
                        href={project.demo_url}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="flex items-center justify-center gap-2 px-3 sm:px-4 py-2 bg-gradient-to-r from-cyber-accent to-blue-500 text-white rounded-lg hover:from-cyber-accent/90 hover:to-blue-600 transition-all text-sm sm:text-base"
                      >
                        <FiExternalLink className="w-4 h-4 sm:w-5 sm:h-5" />
                        <span>عرض</span>
                      </a>
                    )}
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </main>
  );
}

