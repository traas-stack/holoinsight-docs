# README

# Install mdBook & mdBook-i18n

You should install `Rust lang` first.

Check [this doc](https://www.rust-lang.org/learn/get-started).

Then install mdBook & mdBook-i18n using `cargo`:

```bash
./scripts/install.sh
```

Read [mdBook Documentation](https://rust-lang.github.io/mdBook/format/summary.html) for more details.

# Write documentations

Directory structure:
```text
docs/
  book/ -> Build book result, ignored by git
  src/
    en/ -> English translation
      introduction/
        introduction.md -> A markdown
      SUMMARY.md -> A markdown which generates the sidebar menu. Check the detail here https://rust-lang.github.io/mdBook/format/summary.html
    cn/ -> Chinese translation. It has same directory structure as 'en/'.
    resources/ -> Static resources
```

The './scripts/serve.sh' command is used to preview a book by serving it via HTTP at `localhost:3000` by default:
```bash
./scripts/serve.sh
```

# Ref images
You can put images under `docs/src/resources` directory.  
This directory will copy into your final build directory. So there will have 3 copies of `resources` under:
1. docs/book/html/resources
2. docs/book/html/cn/resources
3. docs/book/html/en/resources

In any Markdown doc, you can ref images using `${dir_to_SUMMARY.md}/resources/${your_image}`.

For example:  
In `docs/src/en/test/test-scenes.md` we use 
```markdown
![scene-default deployment](../../resources/images/dev-guide/test/scene-default.jpg)
```
