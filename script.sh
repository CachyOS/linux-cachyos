#!/usr/bin/env bash
set -euo pipefail

run_kernelbuild() {
    local image="$1"
    local status

    if time docker run --name kernelbuild -e EXPORT_PKG=1 -e SYNC_DATABASE=1 -e CHECKSUMS=1 -v "$PWD":/pkg "$image"; then
        status=0
    else
        status=$?
    fi

    docker rm kernelbuild >/dev/null 2>&1 || true
    return "$status"
}

## Enable Generic
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_processor_opt:=/_processor_opt:=GENERIC/" {}
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_auto_optimization:=yes/_use_auto_optimization:=no/" {}
## Enable ZFS
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_build_zfs:=no/_build_zfs:=yes/" {}
## Enable Open NVIDIA module
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_build_nvidia_open:=no/_build_nvidia_open:=yes/" {}
## Enable r8125 module
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_build_r8125:=no/_build_r8125:=yes/" {}

files=$(find . -name "PKGBUILD")

for f in $files
do
    d=$(dirname $f)
    cd $d
    run_kernelbuild pttrr/docker-makepkg
    cd ..
done

echo "move kernels to the repo"
mv */*-x86_64.pkg.tar.zst* /home/ptr1337/.docker/build/nginx/www/repo/x86_64/cachyos/
RUST_LOG=trace repo-manage-util -p cachyos update
