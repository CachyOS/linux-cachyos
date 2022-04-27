#!/usr/bin/env bash
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
docker rm kernelbuild
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel-v3
docker rm kernelbuild

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos/_pkgcore=cachyos-bore/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
docker rm kernelbuild
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel-v3
docker rm kernelbuild

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-bore/_pkgcore=cachyos-bmq/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
docker rm kernelbuild
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel-v3
docker rm kernelbuild

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-bmq/_pkgcore=cachyos-pds/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
docker rm kernelbuild
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel-v3
docker rm kernelbuild

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-pds/_pkgcore=cachyos-tt/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
docker rm kernelbuild
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel-v3
docker rm kernelbuild

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-tt/_pkgcore=cachyos-cacule/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
docker rm kernelbuild
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel-v3
docker rm kernelbuild

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-cacule/_pkgcore=tt/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
docker rm kernelbuild
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel-v3
docker rm kernelbuild

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=tt/_pkgcore=bore/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
docker rm kernelbuild
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel-v3
docker rm kernelbuild

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=bore/_pkgcore=cacule/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
docker rm kernelbuild
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel-v3
docker rm kernelbuild

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cacule/_pkgcore=cacule-rdb/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
docker rm kernelbuild
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel-v3
docker rm kernelbuild

## LTO ##
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cacule-rdb/_pkgcore=cachyos/" {}
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_llvm_lto=/_use_llvm_lto=thin/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
docker rm kernelbuild
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel-v3
docker rm kernelbuild

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos/_pkgcore=cachyos-bore/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
docker rm kernelbuild
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel-v3
docker rm kernelbuild

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-bore/_pkgcore=cachyos-bmq/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
docker rm kernelbuild
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel-v3
docker rm kernelbuild

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-bmq/_pkgcore=cachyos-pds/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
docker rm kernelbuild
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel-v3
docker rm kernelbuild

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-pds/_pkgcore=cachyos-tt/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
docker rm kernelbuild
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel-v3
docker rm kernelbuild

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-tt/_pkgcore=cachyos-cacule/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
docker rm kernelbuild
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel-v3
docker rm kernelbuild

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-cacule/_pkgcore=tt/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
docker rm kernelbuild
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel-v3
docker rm kernelbuild

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=tt/_pkgcore=bore/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
docker rm kernelbuild
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel-v3
docker rm kernelbuild

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=bore/_pkgcore=cacule/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
docker rm kernelbuild
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel-v3
docker rm kernelbuild

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cacule/_pkgcore=cacule-rdb/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel
docker rm kernelbuild
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-kernel-v3
docker rm kernelbuild
