Before you run the front-end code, you need to have a running HoloInsight backend, you can refer to [this document](../test/README.md#deployment-for-testing) to start a backend.

Suppose the address of the backend is `http://xx.xx.xx.xx:12345`, you need to configure `./front/config/config.ts`:

```ts
export default defineConfig({
  ...
  proxy: {
    '/webapi/': {
      target: 'http://xx.xx.xx.xx:12345',
      changeOrigin: true,
    },
  }
  ...
});
```

Run front dev server:
```bash
cd front/ && yarn run dev
```

Example output:
```text
$yarn run dev
yarn run v1.22.19
$ max dev
info  - Umi v4.0.68
info  - Preparing...
info  - MFSU eager strategy enabled
[HPM] Proxy created: /webapi/  -> http://xx.xx.xx.xx:12345
event - [MFSU][eager] start build deps
info  - [MFSU] buildDeps since cacheDependency has changed
        ╔════════════════════════════════════════════════════╗
        ║ App listening at:                                  ║
        ║  >   Local: http://localhost:8000                  ║
ready - ║  > Network: http://xx.xx.xx.xx:8000                ║
        ║                                                    ║
        ║ Now you can open browser with the above addresses↑ ║
        ╚════════════════════════════════════════════════════╝
info  - [MFSU][eager] worker init, takes 562ms
...
```

Visit the front pages at `http://xx.xx.xx.xx:8000`.
