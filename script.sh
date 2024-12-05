#!/usr/bin/env bash
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_auto_optimization-y/_use_auto_optimization-/" {}
## Enable ZFS
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_build_zfs-/_build_zfs-y/" {}
## Enable NVIDIA module
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_build_nvidia-/_build_nvidia-y/" {}
## Enable Open NVIDIA module
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_build_nvidia_open-/_build_nvidia_open-y/" {}
## Force autofdo off to ensure that kernels are being compiled with GCC
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_autofdo-y/_autofdo-/" {}

files=$(find . -name "PKGBUILD")

for f in $files
do
    d=$(dirname $f)
    cd $d
    time docker run --name kernelbuild -e EXPORT_PKG=1 -e SYNC_DATABASE=1 -e CHECKSUMS=1 -v $PWD:/pkg pttrr/docker-makepkg
    docker rm kernelbuild
    cd ..
done

echo "move kernels to the repo"
mv */*-x86_64.pkg.tar.zst* /home/ptr1337/.docker/build/nginx/www/repo/x86_64/cachyos/
RUST_LOG=trace repo-manage-util -p cachyos update
