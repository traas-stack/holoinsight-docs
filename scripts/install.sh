#!/usr/bin/env bash
set -e

cargo install mdbook@0.4.25
cargo install mdbook-i18n --git https://github.com/chunshao90/mdbook-i18n.git --rev ca497cff369e0a5cedcd4024af6e1f05cc5050c5
