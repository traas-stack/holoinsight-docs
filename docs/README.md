# README

# Install mdBook

Download mdBook from its [release page](https://github.com/rust-lang/mdBook/releases) and put it on your `$PATH`.

Verify mdBook:
```bash
mdbook --version
```

output:
```text
mdbook v0.4.26
```

Read [mdBook Documentation](https://rust-lang.github.io/mdBook/format/summary.html)

# Write documentations

Directory structure:
```text
docs/
  en/ English translation
    src/
      introduction/
        introduction.md A documentation 
      SUMMARY.md A markdown which generates the sidebar menu. Check the detail here https://rust-lang.github.io/mdBook/format/summary.html
  zh/ Chinese translation, has same directory structure as en/
```

The 'mdbook serve' command is used to preview a book by serving it via HTTP at `localhost:3000` by default:
```bash
mdbook serve ./docs/en
```
