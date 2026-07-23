#!/usr/bin/env bash
set -euo pipefail

build_pkg() {
    local dir="$1"
    shift 1
    time docker run --rm --name kernelbuild \
        -e EXPORT_PKG=1 -e SYNC_DATABASE=1 -e CHECKSUMS=1 \
        -e _processor_opt=zen4 \
        -e _build_zfs=yes \
        -e _build_nvidia_open=yes \
        -e _build_r8125=yes \
        "$@" \
        -v "$PWD/$dir:/pkg" \
        pttrr/docker-makepkg-znver4
}

# Build PKGBUILDs that still exist as separate packages.
build_pkg linux-cachyos-lts -e _use_lto_suffix=yes -e _use_gcc_suffix=no
build_pkg linux-cachyos-rc -e _use_lto_suffix=no -e _use_gcc_suffix=yes
build_pkg linux-cachyos-hardened -e _use_lto_suffix=yes -e _use_gcc_suffix=no

# Build linux-cachyos variants that replaced removed flavor PKGBUILDs.
build_pkg linux-cachyos -e "_features=cachy o3" -e "_cpusched=cachyos" -e _package_suffix=gcc
build_pkg linux-cachyos -e "_features=cachy o3" -e "_cpusched=eevdf" -e _package_suffix=lto
build_pkg linux-cachyos -e "_features=cachy o3" -e "_cpusched=bore" -e _package_suffix=lto
build_pkg linux-cachyos -e "_features=cachy o3" -e "_cpusched=bmq" -e _package_suffix=lto
build_pkg linux-cachyos -e "_features=cachy o3 rt" -e "_cpusched=bore" -e _package_suffix=lto
build_pkg linux-cachyos -e "_features=server o3" -e "_cpusched=cachyos" -e _package_suffix=lto
build_pkg linux-cachyos -e "_features=cachy o3 handheld" -e "_cpusched=bore" -e _package_suffix=lto

echo "move kernels to the repo"
mv */*-x86_64_v4.pkg.tar.zst* /home/ptr1337/.docker/build/nginx/www/repo/x86_64_v4/cachyos-znver4/
RUST_LOG=trace repo-manage-util -p cachyos-znver4 update
## Ensure that repo-add/repoctl catches all new packages
RUST_LOG=trace repo-manage-util -p cachyos-znver4 update
