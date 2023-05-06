# README

# 安装 mdBook 和 mdBook-i18n

你需要先安装 Rust 语言.

请参考这个文档 [this doc](https://www.rust-lang.org/learn/get-started).

使用 `cargo` 安装 mdBook 和 mdBook-i18n:

```bash
./scripts/install.sh
```

更多详情请阅读 [mdBook 文档](https://rust-lang.github.io/mdBook/format/summary.html)

# 编写文档

目录结构：
```text
docs/
  book/ -> 书的构建结果，会被 git 忽略
  src/
      en/ 英文翻译
          introduction/
            introduction.md -> 一个文档 
          SUMMARY.md -> 一个 markdown 文档，用于生成侧边菜单栏. 详情请参考 mdBook 文档。
      cn/ -> 中文翻译，与 en/ 有相同的目录结构。
```

使用 './scripts/serve.sh' 命令在 `localhost:3000` 部署一个 HTTP 服务器用于预览渲染结果。
```bash
./scripts/serve.sh
```

# 引用图片
你可以将图片放在 `docs/src/resources` 目录下。  
这个目录会被复制到最终的构建目录下。`resources` 目录一共会有3个副本，分别在：
1. docs/book/html/resources
2. docs/book/html/cn/resources
3. docs/book/html/en/resources

在任意一个 Markdown 文档里，你可以使用 `${dir_to_SUMMARY.md}/resources/${your_image}` 表达式来引用图片的地址。

例如：  
在 `docs/src/en/test/test-scenes.md` 里
```markdown
![scene-default deployment](../../resources/images/dev-guide/test/scene-default.jpg)
```

