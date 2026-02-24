module.exports = {
  content: [
    "./src/**/*.{js,jsx,ts,tsx}",
    "./public/index.html"
  ],
  theme: {
    extend: {
      colors: {
        boba: {
          50: '#FBF8F3',
          100: '#F5F0E6',
          200: '#E8DFD0',
          300: '#D4C4A8',
          400: '#C4A77D',
          500: '#A67C52',
          600: '#8B5A2B',
          700: '#5D4037',
          800: '#4E342E',
          900: '#3E2723',
        },
        matcha: {
          400: '#A8C686',
          500: '#8FBC8F',
          600: '#6B8E23',
        }
      },
      borderRadius: {
        '2xl': '1rem',
        '3xl': '1.5rem',
      }
    },
  },
  plugins: [],
}
