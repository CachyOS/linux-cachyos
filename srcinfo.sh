#!/usr/bin/env bash

set -euo pipefail

repo_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)

reuse_release_sources() {
  local package_dir=$1
  local source_name cached_source

  while IFS= read -r source_name; do
    [[ -e "$package_dir/$source_name" ]] && continue

    cached_source=$(find "$repo_root" \
      -mindepth 2 -maxdepth 2 \
      -type f -name "$source_name" \
      -print -quit)

    if [[ -n $cached_source ]]; then
      ln -- "$cached_source" "$package_dir/$source_name"
      printf 'Reusing %s from %s\n' "$source_name" "${cached_source%/*}"
    fi
  done < <(
    cd -- "$package_dir"
    makepkg --printsrcinfo |
      sed -nE 's#^[[:space:]]*source = .*/(cachyos-[^/]+\.tar\.gz(\.asc)?)$#\1#p'
  )
}

while IFS= read -r -d '' pkgbuild; do
  package_dir=${pkgbuild%/*}
  reuse_release_sources "$package_dir"

  (
    cd -- "$package_dir"
    updpkgsums
    makepkg --printsrcinfo > .SRCINFO
    rm -f -- ./*.patch
  )
done < <(find "$repo_root" -mindepth 2 -maxdepth 2 -name PKGBUILD -print0)
