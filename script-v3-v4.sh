#!/usr/bin/env bash
set -euo pipefail

build_pkg() {
    local image="$1"
    local dir="$2"
    shift 2
    time docker run --rm --name kernelbuild \
        -e EXPORT_PKG=1 -e SYNC_DATABASE=1 -e CHECKSUMS=1 \
        -e _build_zfs=yes \
        -e _build_nvidia_open=yes \
        -e _build_r8125=yes \
        "$@" \
        -v "$PWD/$dir:/pkg" \
        "$image"
}

docker_build() {
    local image="$1"
    local arch="$2"
    local lto="$3"

    local -a build_env=(
        -e "_processor_opt=${arch}"
        -e "_use_llvm_lto=${lto}"
    )

    # Build PKGBUILDs that still exist as separate packages.
    build_pkg "$image" linux-cachyos-lts "${build_env[@]}" -e _use_lto_suffix=yes -e _use_gcc_suffix=no
    build_pkg "$image" linux-cachyos-rc "${build_env[@]}" -e _use_lto_suffix=no -e _use_gcc_suffix=yes
    build_pkg "$image" linux-cachyos-hardened "${build_env[@]}" -e _use_lto_suffix=yes -e _use_gcc_suffix=no

    # Build linux-cachyos variants that replaced removed flavor PKGBUILDs.
    build_pkg "$image" linux-cachyos "${build_env[@]}" -e "_flavor=cachyos" -e "_use_llvm_lto=none" -e _package_suffix=gcc
    build_pkg "$image" linux-cachyos "${build_env[@]}" -e "_flavor=cachyos-eevdf" -e _package_suffix=lto
    build_pkg "$image" linux-cachyos "${build_env[@]}" -e "_flavor=cachyos-bore" -e _package_suffix=lto
    build_pkg "$image" linux-cachyos "${build_env[@]}" -e "_flavor=cachyos-bmq" -e _package_suffix=lto
    build_pkg "$image" linux-cachyos "${build_env[@]}" -e "_flavor=cachyos-rt-bore" -e _package_suffix=lto
    build_pkg "$image" linux-cachyos "${build_env[@]}" -e "_flavor=cachyos-server" -e _package_suffix=lto
    build_pkg "$image" linux-cachyos "${build_env[@]}" -e "_flavor=cachyos-deckify" -e _package_suffix=lto
}

## GCC v3 + LLVM ThinLTO v3
docker_build pttrr/docker-makepkg-v3 GENERIC_V3 none
docker_build pttrr/docker-makepkg-v3 GENERIC_V3 thin

echo "move kernels to the repo"
mv */*-x86_64_v3.pkg.tar.zst* /home/ptr1337/.docker/build/nginx/www/repo/x86_64_v3/cachyos-v3/
RUST_LOG=trace repo-manage-util -p cachyos-v3 update
## Ensure that repo-add/repoctl catches all new packages
RUST_LOG=trace repo-manage-util -p cachyos-v3 update

## GCC v4 + LLVM ThinLTO v4
docker_build pttrr/docker-makepkg-v4 GENERIC_V4 none
docker_build pttrr/docker-makepkg-v4 GENERIC_V4 thin

echo "move kernels to the repo"
mv */*-x86_64_v4.pkg.tar.zst* /home/ptr1337/.docker/build/nginx/www/repo/x86_64_v4/cachyos-v4/
RUST_LOG=trace repo-manage-util -p cachyos-v4 update
## Ensure that repo-add/repoctl catches all new packages
RUST_LOG=trace repo-manage-util -p cachyos-v4 update
