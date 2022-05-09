#!/usr/bin/env bash

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_auto_optimization=y/_use_auto_optimization=/" {}
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_llvm_lto=/_use_llvm_lto=thin/" {}
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_thinlto_cachedir=/_thin_lto_cachedir=y/" {}

files=$(find . -name "PKGBUILD")

for f in $files
do
    d=$(dirname $f)
    cd $d
    docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
    docker rm kernelbuild
    cd ..
done

mv */*.tar.zst* /home/ptr1337/packages/

find . -name "config" | xargs -I {} sed -i 's/GENERIC_CPU=y/GENERIC_CPU3=y/' {}


files=$(find . -name "PKGBUILD")

for f in $files
do
    d=$(dirname $f)
    cd $d
    docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel-v3
    docker rm kernelbuild
    cd ..
done

mv */*.tar.zst* /home/ptr1337/packages/

find . -name "config" | xargs -I {} sed -i 's/GENERIC_CPU3=y/GENERIC_CPU=y/' {}
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_llvm_lto=thin/_use_llvm_lto=/" {}
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_thinlto_cachedir=y/_thin_lto_cachedir=/" {}

files=$(find . -name "PKGBUILD")

for f in $files
do
    d=$(dirname $f)
    cd $d
    docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
    docker rm kernelbuild
    cd ..
done

mv */*.tar.zst* /home/ptr1337/packages/

find . -name "config" | xargs -I {} sed -i 's/GENERIC_CPU=y/GENERIC_CPU3=y/' {}

files=$(find . -name "PKGBUILD")

for f in $files
do
    d=$(dirname $f)
    cd $d
    docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
    docker rm kernelbuild
    cd ..
done

mv */*.tar.zst* /home/ptr1337/packages/
