# Dev requirements

- The format and license header of codes must be well checked before merge to `main` branch. We have use a `Github Action` to ensure this rule.
- It is recommended to use `pre-commit` hook or run `./scripts/format.sh && ./scripts/add-license.sh` manually before daily submitting.
- All important classes and methods(e.g. abstract method) of newly submitted codes must have complete comments. The reviewer can refuse to pass the PR until sufficient comments are added.
