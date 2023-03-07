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
