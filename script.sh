#!/usr/bin/env bash
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_auto_optimization=y/_use_auto_optimization=/" {}


files=$(find . -name "PKGBUILD")

for f in $files
do
  d=$(dirname $f)
  cd $d

  docker run --name dockerbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache:/home/notroot/ccache pttrr/docker-makepkg
  docker rm dockerbuild
  cd ..
done

mv */*.tar.zst* /home/ptr1337/packages/

find . -name "config" | xargs -I {} sed -i 's/GENERIC_CPU=y/GENERIC_CPU3=y/' {}

files=$(find . -name "PKGBUILD")

for f in $files
do
  d=$(dirname $f)
  cd $d

  docker run --name dockerbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache:/home/notroot/ccache pttrr/docker-makepkg-v3
  docker rm dockerbuild
  cd ..
done

mv */*.tar.zst* /home/ptr1337/packages/



find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_llvm_lto=/_use_llvm_lto==y/" {}


files=$(find . -name "PKGBUILD")

for f in $files
do
  d=$(dirname $f)
  cd $d
  docker run --name dockerbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache:/home/notroot/ccache pttrr/docker-makepkg-v3
  docker rm dockerbuild
  cd ..
done

mv */*.tar.zst* /home/ptr1337/packages/

find . -name "config" | xargs -I {} sed -i 's/GENERIC_CPU3=y/GENERIC_CPU=y/' {}

files=$(find . -name "PKGBUILD")

for f in $files
do
  d=$(dirname $f)
  cd $d
  docker run --name dockerbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache:/home/notroot/ccache pttrr/docker-makepkg
  docker rm dockerbuild
  cd ..
done

mv */*.tar.zst* /home/ptr1337/packages/
