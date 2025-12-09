/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  darkMode: 'class',
  theme: {
    extend: {
      fontFamily: {
        sans: ['var(--font-cairo)', 'system-ui', 'sans-serif'],
      },
      colors: {
        primary: {
          light: '#4f46e5',
          dark: '#6366f1',
        },
        cyber: {
          dark: '#0f172a',
          darker: '#020617',
          accent: '#10b981',
        },
      },
    },
  },
  plugins: [],
}

