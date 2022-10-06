#!/usr/bin/env bash
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_auto_optimization-y/_use_auto_optimization-/" {}
## Enable ZFS
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_build_zfs-/_build_zfs-y/" {}
#find . -name "PKGBUILD" | xargs -I {} sed -i "s/_bcachefs=/_bcachefs=y/" {} # breaks probably /proc/meminfo
## Enable Generic v3 
find . -name "config" | xargs -I {} sed -i 's/GENERIC_CPU=y/GENERIC_CPU3=y/' {}
## Dont compile linux-cacule linux-cacule-rdb into the repo
rm -rf linux-cacule linux-cacule-rdb

## GCC v3 Kernel

files=$(find . -name "PKGBUILD")

for f in $files
do
    d=$(dirname $f)
    cd $d
    time docker run --name kernelbuild -e EXPORT_PKG=1 -e SYNC_DATABASE=1 -e CHECKSUMS=1 -v /home/ptr1337/docker-makepkg/new/docker-makepkg/llvm:/home/notroot/llvm -v $PWD:/pkg -v /home/ptr1337/kernelbuild/ccache-kernel-v3:/home/notroot/.buildcache pttrr/docker-makepkg-v3
    docker rm kernelbuild
    cd ..
done

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_llvm_lto-/_use_llvm_lto-thin/" {}
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_lto_suffix-/_use_lto_suffix-y/" {}

## LLVM v3 Kernel

files=$(find . -name "PKGBUILD")

for f in $files
do
    d=$(dirname $f)
    cd $d
    time docker run --name kernelbuild -e EXPORT_PKG=1 -e SYNC_DATABASE=1 -e CHECKSUMS=1 -e LLVM_BOLT=1 -v /home/ptr1337/docker-makepkg/new/docker-makepkg/llvm:/home/notroot/llvm -v $PWD:/pkg -v /home/ptr1337/kernelbuild/ccache-kernel-llvm-v3:/home/notroot/.buildcache pttrr/docker-makepkg-v3
    docker rm kernelbuild
    cd ..
done

echo "move kernels to the repo"
mv */*-x86_64_v3.pkg.tar.zst* /home/ptr1337/.docker/build/nginx/www/repo/x86_64_v3/cachyos-v3/
repoctl update -P cachyos-v3


## LLVM Generic Kernel
find . -name "config" | xargs -I {} sed -i 's/GENERIC_CPU3=y/GENERIC_CPU=y/' {}

files=$(find . -name "PKGBUILD")

for f in $files
do
    d=$(dirname $f)
    cd $d
    time docker run --name kernelbuild -e EXPORT_PKG=1 -e SYNC_DATABASE=1 -e CHECKSUMS=1 -v /home/ptr1337/docker-makepkg/new/docker-makepkg/llvm:/home/notroot/llvm -v $PWD:/pkg -v /home/ptr1337/kernelbuild/ccache-kernel-llvm:/home/notroot/.buildcache pttrr/docker-makepkg
    docker rm kernelbuild
    cd ..
done

## Generic Kernel

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_llvm_lto-thin/_use_llvm_lto-/" {}
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_lto_suffix-y/_use_lto_suffix-/" {}

files=$(find . -name "PKGBUILD")

for f in $files
do
    d=$(dirname $f)
    cd $d
    time docker run --name kernelbuild -e EXPORT_PKG=1 -e SYNC_DATABASE=1 -e CHECKSUMS=1 -v /home/ptr1337/docker-makepkg/new/docker-makepkg/llvm:/home/notroot/llvm -v $PWD:/pkg -v /home/ptr1337/kernelbuild/ccache-kernel:/home/notroot/.buildcache pttrr/docker-makepkg
    docker rm kernelbuild
    cd ..
done

echo "move kernels to the repo"
mv */*-x86_64.pkg.tar.zst* /home/ptr1337/.docker/build/nginx/www/repo/x86_64/cachyos/
repoctl update -P cachyos


