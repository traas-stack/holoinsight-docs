#!/usr/bin/env bash
set -e

cd `dirname $0`/..

mdbook serve ./docs
