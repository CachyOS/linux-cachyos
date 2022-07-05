find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_llvm_lto=/_use_llvm_lto=thin/" {}
find . -name "config" | xargs -I {} sed -i 's/GENERIC_CPU=y/GENERIC_CPU3=y/' {}
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_auto_optimization=y/_use_auto_optimization=/" {}
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_build_zfs=/_build_zfs=y/" {}
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_build_bcachefs=/_build_bcachefs=y/" {}

files=$(find . -name "PKGBUILD")

for f in $files
do
    d=$(dirname $f)
    cd $d
    docker run --name kernelbuild -e LLVM_BOLT=1 -e EXPORT_PKG=1 -e SYNC_DATABASE=1 -v /tmp/docker-makepkg-v3:/tmp/makepkg -v $PWD:/pkg -v /home/ptr1337/kernelbuild/ccache-kernel-v3:/home/notroot/.buildcache pttrr/docker-makepkg-v3
    docker rm kernelbuild
    cd ..
done

find . -name "config" | xargs -I {} sed -i 's/GENERIC_CPU3=y/GENERIC_CPU=y/' {}

files=$(find . -name "PKGBUILD")

for f in $files
do
    d=$(dirname $f)
    cd $d
    docker run --name kernelbuild -e LLVM_BOLT=1 -e EXPORT_PKG=1 -e SYNC_DATABASE=1  -v /tmp/docker-makepkg:/tmp/makepkg -v $PWD:/pkg -v /home/ptr1337/kernelbuild/ccache-kernel:/home/notroot/.buildcache pttrr/docker-makepkg
    docker rm kernelbuild
    cd ..
done

mv */*-x86_64.pkg.tar.zst* /home/ptr1337/.docker/build/nginx/www/repo/x86_64/cachyos/
repoctl update -P cachyos

mv */*-x86_64_v3.pkg.tar.zst* /home/ptr1337/.docker/build/nginx/www/repo/x86_64_v3/cachyos-v3/
repoctl update -P cachyos-v3
