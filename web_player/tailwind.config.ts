import { type Config } from "tailwindcss";

export default {
  content: ["./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      fontFamily: {
        display: ["var(--font-sfrounded)"],
      },
      colors: {
        transparent: 'transparent',
        current: 'currentColor',
        "grey": {
          100: "#B4B5B9",
          200: "#656565",
          300: "#484848",
          400: "#242424",
          500: "#222222",
          600: "#1B191B",
          700: "#151317",
          800: "#0F0D10",
          900: "#070508"
        },
        "header": {
          100: "#F2E3E3",
          200: "#CBADB6",
          300: "#CBACB8",
        },
        "grad": {
          100: "#EE8131",
          200: "#EA336C",
          300: "#C127BF",
          400: "#21130D",
          500: "#601831",
          600: "#1C091C",
        },
        "secondary": {
          100: "#FC645D",
        }
      },

    },
  },
  plugins: [],
} satisfies Config;
