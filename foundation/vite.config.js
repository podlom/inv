import { defineConfig } from "vite";
import { minify } from "terser";
export default defineConfig({
  // other config options

  build: {
    minify: true,
    outDir: "../www/js/dist",
    assetsDir: "",
    rollupOptions: {
      input: "../www/app/common.js",
      output: {
        manualChunks: undefined,
        entryFileNames: `[name]-min.js`,
        chunkFileNames: `./[name].js`,
        assetFileNames: `./[name].[ext]`,

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
