#!/usr/bin/env bash
set -e

echo "ready to move files"
cp -r ../i18n/cn ../html/cn
cp -r ../i18n/en ../html/en
cp -r ../../src/resources ../../book/html/resources
cp -r ../../src/resources ../../book/html/cn/resources
cp -r ../../src/resources ../../book/html/en/resources
echo "copy done"
