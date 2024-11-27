import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import inject from "@rollup/plugin-inject";
import legacy from "@vitejs/plugin-legacy";
import vue from "@vitejs/plugin-vue";

export default defineConfig({
    plugins: [
        // inject({
        //     $: "jquery",
        //     Swal: "sweetalert2",
        // }),
        laravel({
            input: ["resources/js/app.js"],
            refresh: true,
        }),

        // legacy({
        //     targets: ["defaults", "not IE 11"],
        // }),

        vue({
            template: {
                transformAssetUrls: {
                    base: null,
                    includeAbsolute: false,
                },
            },
        }),
    ],

    resolve: {
        alias: {
            "~": "node_modules/",
        },
    },
});
