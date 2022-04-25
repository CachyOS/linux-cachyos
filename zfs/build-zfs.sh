#!/usr/bin/env bash
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-v3
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos/_pkgcore=cachyos-bore/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-v3
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-bore/_pkgcore=cachyos-bmq/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-v3
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-bmq/_pkgcore=cachyos-pds/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-v3
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-pds/_pkgcore=cachyos-tt/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-v3
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-pds/_pkgcore=cachyos-cacule/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-v3

## LTO ##
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-pds/_pkgcore=cachyos/" {}
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_llvm_lto=/_use_llvm_lto=thin/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-v3
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos/_pkgcore=cachyos-bore/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-v3
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-bore/_pkgcore=cachyos-bmq/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-v3
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-bmq/_pkgcore=cachyos-pds/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-v3
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-pds/_pkgcore=cachyos-tt/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-v3
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-pds/_pkgcore=cachyos-cacule/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-v3
