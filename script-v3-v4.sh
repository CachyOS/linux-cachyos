#!/usr/bin/env bash
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_auto_optimization-y/_use_auto_optimization-/" {}
## Enable ZFS
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_build_zfs-/_build_zfs-y/" {}
## Enable Generic v3
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_processor_opt-/_processor_opt-GENERIC_V3/" {}
## Enable NVIDIA module
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_build_nvidia-/_build_nvidia-y/" {}
## Enable Open NVIDIA module
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_build_nvidia_open-/_build_nvidia_open-y/" {}
## Disable clang-LTO
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_llvm_lto-thin/_use_llvm_lto-none/" {}
## Force autofdo off to ensure that kernels are being compiled with GCC
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_autofdo-y/_autofdo-/" {}

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

## LLVM ThinLTO v3 Kernel
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_llvm_lto-none/_use_llvm_lto-thin/" {}
find linux-cachyos linux-cachyos-rc -name "PKGBUILD" | xargs -I {} sed -i "s/_autofdo-/_autofdo-y/" {}

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
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_llvm_lto-thin/_use_llvm_lto-none/" {}
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_processor_opt-GENERIC_V3/_processor_opt-GENERIC_V4/" {}
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_autofdo-y/_autofdo-/" {}

files=$(find . -name "PKGBUILD")

for f in $files
do
    d=$(dirname $f)
    cd $d
    time docker run --name kernelbuild -e EXPORT_PKG=1 -e SYNC_DATABASE=1 -e CHECKSUMS=1 -v $PWD:/pkg pttrr/docker-makepkg-v4
    docker rm kernelbuild
    cd ..
done

## LLVM ThinLTO v4 Kernel
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_llvm_lto-none/_use_llvm_lto-thin/" {}
find linux-cachyos linux-cachyos-rc -name "PKGBUILD" | xargs -I {} sed -i "s/_autofdo-/_autofdo-y/" {}

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
