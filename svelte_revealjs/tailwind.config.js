/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./src/**/*.{html,js,svelte,ts}",
    "./node_modules/tw-elements/js/**/*.js",
  ],
  theme: {
    extend: {},
  },
  darkMode: "class",
  plugins: [require("tw-elements/plugin.cjs")],
}

