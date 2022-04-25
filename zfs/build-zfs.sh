#!/usr/bin/env bash

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos/_use_auto_optimization=cachyos-bore/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-v3
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-bore/_use_auto_optimization=cachyos-bmq/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-v3
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-bmq/_use_auto_optimization=cachyos-pds/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-v3
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-pds/_use_auto_optimization=cachyos-tt/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-v3
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-pds/_use_auto_optimization=cachyos-cacule/" {}
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg
docker run --name kernelbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache-kernel:/home/notroot/ccache pttrr/docker-makepkg-v3
