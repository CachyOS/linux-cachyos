#!/usr/bin/env bash
docker run --name kernelbuild-zfs-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg
docker rm kernelbuild-zfs
docker run --name kernelbuild-zfs-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg-v3
docker rm kernelbuild-zfs

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos/_pkgcore=cachyos-bore/" {}
docker run --name kernelbuild-zfs-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg
docker rm kernelbuild-zfs
docker run --name kernelbuild-zfs-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg-v3
docker rm kernelbuild-zfs

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-bore/_pkgcore=cachyos-bmq/" {}
docker run --name kernelbuild-zfs-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg
docker rm kernelbuild-zfs
docker run --name kernelbuild-zfs-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg-v3
docker rm kernelbuild-zfs

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-bmq/_pkgcore=cachyos-pds/" {}
docker run --name kernelbuild-zfs-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg
docker rm kernelbuild-zfs
docker run --name kernelbuild-zfs-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg-v3
docker rm kernelbuild-zfs

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-pds/_pkgcore=cachyos-tt/" {}
docker run --name kernelbuild-zfs-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg
docker rm kernelbuild-zfs
docker run --name kernelbuild-zfs-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg-v3
docker rm kernelbuild-zfs

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-tt/_pkgcore=cachyos-cacule/" {}
docker run --name kernelbuild-zfs-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg
docker rm kernelbuild-zfs
docker run --name kernelbuild-zfs-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg-v3
docker rm kernelbuild-zfs

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-cacule/_pkgcore=tt/" {}
docker run --name kernelbuild-zfs-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg
docker rm kernelbuild-zfs
docker run --name kernelbuild-zfs-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg-v3
docker rm kernelbuild-zfs

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=tt/_pkgcore=bore/" {}
docker run --name kernelbuild-zfs-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg
docker rm kernelbuild-zfs
docker run --name kernelbuild-zfs-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg-v3
docker rm kernelbuild-zfs

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=bore/_pkgcore=cacule/" {}
docker run --name kernelbuild-zfs-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg
docker rm kernelbuild-zfs
docker run --name kernelbuild-zfs-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg-v3
docker rm kernelbuild-zfs

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cacule/_pkgcore=cacule-rdb/" {}
docker run --name kernelbuild-zfs-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg
docker rm kernelbuild-zfs
docker run --name kernelbuild-zfs-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg-v3
docker rm kernelbuild-zfs
