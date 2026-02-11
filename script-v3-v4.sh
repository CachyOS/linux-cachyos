#!/usr/bin/env bash
## Enable ZFS
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_build_zfs:=no/_build_zfs:=yes/" {}
## Enable Generic v3
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_processor_opt:=/_processor_opt:=GENERIC_V3/" {}
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_auto_optimization:=yes/_use_auto_optimization:=no/" {}
## Enable Open NVIDIA module
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_build_nvidia_open:=no/_build_nvidia_open:=yes/" {}
## Disable clang-LTO
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_llvm_lto:=thin/_use_llvm_lto:=none/" {}

## GCC v3 Kernel

files=$(find . -name "PKGBUILD")

for f in $files
do
    d=$(dirname $f)
    cd $d
    time docker run --name kernelbuild -e EXPORT_PKG=1 -e SYNC_DATABASE=1 -e CHECKSUMS=1 -v $PWD:/pkg pttrr/docker-makepkg-v3
    docker rm kernelbuild
    cd ..
done

echo "move kernels to the repo"
mv */*-x86_64_v3.pkg.tar.zst* /home/ptr1337/.docker/build/nginx/www/repo/x86_64_v3/cachyos-v3/
RUST_LOG=trace repo-manage-util -p cachyos-v3 update
## Ensure that repo-add/repoctl catches all new packages
RUST_LOG=trace repo-manage-util -p cachyos-v3 update

## GCC v4 Kernel
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_processor_opt:=GENERIC_V3/_processor_opt:=GENERIC_V4/" {}

files=$(find . -name "PKGBUILD")

for f in $files
do
    d=$(dirname $f)
    cd $d
    time docker run --name kernelbuild -e EXPORT_PKG=1 -e SYNC_DATABASE=1 -e CHECKSUMS=1 -v $PWD:/pkg pttrr/docker-makepkg-v4
    docker rm kernelbuild
    cd ..
done

echo "move kernels to the repo"
mv */*-x86_64_v4.pkg.tar.zst* /home/ptr1337/.docker/build/nginx/www/repo/x86_64_v4/cachyos-v4/
RUST_LOG=trace repo-manage-util -p cachyos-v4 update
## Ensure that repo-add/repoctl catches all new packages
RUST_LOG=trace repo-manage-util -p cachyos-v4 update
