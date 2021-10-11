#!/usr/bin/env bash

find . -name "PKGBUILD" | xargs -I {} sed -i 's/arch=(x86_64)/arch=(x86_64_v3)/' {}

find . -name "PKGBUILD" | xargs -I {} sed -i "s/arch=('x86_64')/arch=('x86_64_v3')/" {}


files=$(find . -name "PKGBUILD")

for f in $files
do
        d=$(dirname $f)
        cd $d
        docker run --name dockerbuild -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg-v3:latest
        docker rm dockerbuild
        cd ..
done

mv */*.tar.zst* /home/ptr1337/packages/
