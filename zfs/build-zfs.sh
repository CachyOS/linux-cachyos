#!/usr/bin/env bash
docker run --name kernelbuild-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg
docker rm kernelbuild-zfs
docker run --name kernelbuild-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg-v3
docker rm kernelbuild-zfs

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos/_pkgcore=cachyos-bore/" {}
docker run --name kernelbuild-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg
docker rm kernelbuild-zfs
docker run --name kernelbuild-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg-v3
docker rm kernelbuild-zfs

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-bore/_pkgcore=cachyos-bmq/" {}
docker run --name kernelbuild-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg
docker rm kernelbuild-zfs
docker run --name kernelbuild-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg-v3
docker rm kernelbuild-zfs

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-bmq/_pkgcore=cachyos-pds/" {}
docker run --name kernelbuild-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg
docker rm kernelbuild-zfs
docker run --name kernelbuild-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg-v3
docker rm kernelbuild-zfs

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-pds/_pkgcore=cachyos-cacule/" {}
docker run --name kernelbuild-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg
docker rm kernelbuild-zfs
docker run --name kernelbuild-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg-v3
docker rm kernelbuild-zfs

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cachyos-cacule/_pkgcore=bore/" {}
docker run --name kernelbuild-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg
docker rm kernelbuild-zfs
docker run --name kernelbuild-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg-v3
docker rm kernelbuild-zfs

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=bore/_pkgcore=cacule/" {}
docker run --name kernelbuild-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg
docker rm kernelbuild-zfs
docker run --name kernelbuild-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg-v3
docker rm kernelbuild-zfs

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cacule/_pkgcore=cacule-rdb/" {}
docker run --name kernelbuild-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg
docker rm kernelbuild-zfs
docker run --name kernelbuild-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg-v3
docker rm kernelbuild-zfs

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=cacule-rdb/_pkgcore=tt/" {}
docker run --name kernelbuild-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg
docker rm kernelbuild-zfs
docker run --name kernelbuild-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg-v3
docker rm kernelbuild-zfs

find . -name "PKGBUILD" | xargs -I {} sed -i "s/_pkgcore=tt/_pkgcore=cachyos-tt/" {}
docker run --name kernelbuild-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg
docker rm kernelbuild-zfs
docker run --name kernelbuild-zfs -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg-v3
docker rm kernelbuild-zfs

mv *-x86_64.pkg.tar.zst* /home/ptr1337/.docker/build/nginx/www/repo/x86_64/cachyos/
repoctl update -P cachyos

mv *-x86_64_v3.pkg.tar.zst* /home/ptr1337/.docker/build/nginx/www/repo/x86_64_v3/cachyos-v3/
repoctl update -P cachyos-v3
