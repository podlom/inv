import { defineConfig } from "vite";
import { minify } from "terser";
import autoprefixer from "autoprefixer";

export default defineConfig({
  // other config options

  css: {
    postcss: {
      plugins: [
        autoprefixer({ overrideBrowserslist: ["last 2 versions", "ie >= 9"] }),
      ],
    },
    devSourcemap: true,
  },

  build: {
    minify: true,
    outDir: "../www",
    assetsDir: "assets",
    rollupOptions: {
      input: {
        common: "../www/app/common.js",
        "style-v2": "../www/css/scss-v2/style-v2.scss",
      },
      output: {
        manualChunks: undefined,
        entryFileNames: `js/dist/[name]-min.js`,
        chunkFileNames: `js/dist/[name].js`,
        assetFileNames: (assetInfo) => {
          if (assetInfo.name.endsWith(".css")) {
            return "css/[name][extname]";
          }
          return `assets/[name].[ext]`;
        },

        plugins: [
          {
            name: "minify-js",
            renderChunk(code) {
              const minified = minify(code);
              if (minified.error) {
                console.error("Minification error:", minified.error);
                return code;
              }
              return minified.code;
            },
          },
        ],
      },
    },
  },
});
