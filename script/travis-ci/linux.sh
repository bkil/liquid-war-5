#!/bin/sh -e

autoconf

PREFIX="$HOME/install/liquid-war-5"

./configure \
  --prefix="$PREFIX" \
  --enable-extra-warnings \
  --enable-doc-php3 \
  --enable-doc-uwc \
  --disable-host-opt

make

make install

make dist

make check > /dev/null # unusable for now, but should not fail
git diff --color=always |
cat

