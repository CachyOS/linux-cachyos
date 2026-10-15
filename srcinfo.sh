#!/usr/bin/env bash

files=$(find . -name "PKGBUILD")

for f in $files
do
  d=$(dirname "$f")
  (
    cd "$d" || exit 1
    updpkgsums
    makepkg --printsrcinfo > .SRCINFO
    rm -rf *.patch
  )
done
