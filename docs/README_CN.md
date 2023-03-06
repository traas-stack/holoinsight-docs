# README

# 安装 mdBook

从 [release page](https://github.com/rust-lang/mdBook/releases) 下载 mdBook，并将其放置在 `$PATH` 下.

验证 mdBook:
```bash
mdbook --version
```

输出:
```text
mdbook v0.4.26
```

阅读 [mdBook 文档](https://rust-lang.github.io/mdBook/format/summary.html)

# 编写文档

目录结构：
```text
docs/
  en/ 英文翻译
    src/
      introduction/
        introduction.md 一个文档 
      SUMMARY.md 一个 markdown 文档，用于生成侧边菜单栏. 详情请参考 mdBook 文档。
  zh/ 中文翻译，与 en/ 有相同的目录结构。
```

使用 'mdbook serve' 命令在 `localhost:3000` 部署一个 HTTP 服务器用于预览渲染结果。
```bash
mdbook serve ./docs/en
```
