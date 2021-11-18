# Maintainer: Peter Jung <admin@ptr1337.dev>
# Maintainer: Andreas Radke <andyrtr@archlinux.org>
# NUMA is optimized for multi-socket motherboards.
# A single multi-core CPU actually runs slower with NUMA enabled.
# See, https://bugs.archlinux.org/task/31187
_NUMAdisable=y
# Enable fsync
_fsync=y
#enable futex2
_futex2=y
### Set performance governor as default
_per_gov=y
### Disable Deadline I/O scheduler
_deadline_disable=y
### Disable Kyber I/O scheduler
_kyber_disable=y
### Running with a 2000 HZ, 1000HZ or 500HZ tick rate
_2k_HZ_ticks=
_1k_HZ_ticks=y
_750_HZ_ticks=
_500_HZ_ticks=
### Enable protect file mappings under memory pressure
_mm_protect=y
pkgbase=linux-cachyos-cacule-lts
pkgver=5.10.80
pkgrel=1
pkgdesc='LTS Linux'
url="https://www.kernel.org/"
arch=(x86_64 x86_64_v3)
license=(GPL2)
makedepends=(
  bc kmod libelf pahole cpio perl tar xz
  xmlto python-sphinx python-sphinx_rtd_theme graphviz imagemagick
)
options=('!strip')
_srcname=linux-$pkgver
_patchsource="https://raw.githubusercontent.com/ptr1337/kernel-patches/master/5.10"
_caculepatches="https://raw.githubusercontent.com/ptr1337/kernel-patches/master/CacULE"
source=(
  https://cdn.kernel.org/pub/linux/kernel/v${pkgver%%.*}.x/${_srcname}.tar.xz
  config
  "${_patchsource}/arch-patches-v14/0001-arch-patches.patch"
  "${_caculepatches}/v5.10/cacule-5.10.patch"
  "${_patchsource}/cpu-patches-v2/0001-cpu-patches.patch"
  "${_patchsource}/futex-trunk-patches-v2/0001-futex-resync-from-gitlab.collabora.com.patch"
  "${_patchsource}/futex2-trunk-patches-v3/0001-futex2-resync-from-gitlab.collabora.com.patch"
  #  "${_patchsource}/zen-patches/0001-zen-patches.patch"
  "${_patchsource}/ll-patches/0001-LL-kconfig-add-750Hz-timer-interrupt-kernel-config-o.patch"
  "${_patchsource}/ll-patches/0003-sched-core-nr_migrate-256-increases-number-of-tasks-.patch"
  "${_patchsource}/ll-patches/0004-mm-set-8-megabytes-for-address_space-level-file-read.patch"
  "${_patchsource}/lqx-patches-v4/0001-lqx-patches.patch"
  #  "${_patchsource}/fixes-miscellaneous-v11/0001-fixes-miscellaneous.patch"
  "${_patchsource}/bbr2-patches-v3/0001-bbr2-5.10-introduce-BBRv2.patch"
#  "${_patchsource}/android-patches/0001-android-patches.patch"
  "${_patchsource}/pf-patches-v11/0001-pf-patches.patch"
  "${_patchsource}/le9db_patches/le9db1-5.10.patch"
  #  "${_patchsource}/ntfs3-patches-v7/0001-ntfs3-patches.patch"
  "${_patchsource}/zstd-upstream-patches/0001-zstd-upstream-patches.patch"
  #  "${_patchsource}/ksm-patches/0001-ksm-patches.patch"
  #  "${_patchsource}/v4l2loopback-patches-v2/0001-v4l2loopback-patches.patch"
)
sha256sums=('477ce8f7624263e4346c0fc25ffc334af06bcac4d6bebdd5a7fe4681557fdb39'
            '0122c24ac89b05d3e1f278ec33fcb17997ad6b3e5b6fcd0da70c18ef1b899232'
            '9ec9ac50a8bdd645c456feab4a0ca9b7ffe6dcd0933a89ba96112f8bdedbf0ae'
            '3d4a0602425000d18162fdd45c6f13dd1c5ef78ef3b5b7f19365a8b0cf030c3a'
            '152e251586eec29990fa4cc30c561b7e49acb765434b70634501b398e4c1fe2e'
            '239307e0018ab2405b9afaa7d315ee3352b83819a3c75b65951749b52a3247d2'
            '5822e657656278e3bd223f0036e35b4b3d04785874473b60955a03a3c46d757b'
            '2bb3453e3d7bd3111f8bce4366b19ecb5f02db18e4084815f7e75ce3edc84a30'
            '331dd459a21a4afd65e2c59848666b9dd420f87f4ad01ec3012b47f3acc992ef'
            '77ff83080ce0b83c81bc085a0e276b08db572aed725dacc5a1b804c9d0f36733'
            '9657bca3947ee6ab31a1921d26859f83250d278c42908544b0c6816b2c338086'
            '167d1732e57601dece7eec95d22bcbc43b1b2815fd73182933c1757abe7189b7'
            '5dcbaf27074975eedd1ba93edaee9ffe59fdbd8af5cd3d848fd5c3873d451462'
            '56cc0ffee3005fc81b0488348861ceea035ebd1356eec1512c53e786e206ff06'
            '137811c7d916c608f9ebb7e4d82ec93ea7592d99fe6394cf908c0e12e9881a7d')

export KBUILD_BUILD_HOST=archlinux
export KBUILD_BUILD_USER=$pkgbase
export KBUILD_BUILD_TIMESTAMP="$(date -Ru${SOURCE_DATE_EPOCH:+d @$SOURCE_DATE_EPOCH})"

prepare() {
  cd $_srcname

  echo "Setting version..."
  scripts/setlocalversion --save-scmversion
  echo "-$pkgrel" > localversion.10-pkgrel
  echo "${pkgbase#linux}" > localversion.20-pkgname

  local src
  for src in "${source[@]}"; do
    src="${src%%::*}"
    src="${src##*/}"
    [[ $src = *.patch ]] || continue
    echo "Applying patch $src..."
    patch -Np1 < "../$src"
  done

  ### Setting config
  echo "Setting config..."
  cp "${srcdir}"/config .config
  make olddefconfig
  ### CPU_ARCH SCRIPT ##
  source "${startdir}"/configure

  cpu_arch
  ### Optionally set tickrate to 2000HZ
  if [ -n "$_2k_HZ_ticks" ]; then
    echo "Setting tick rate to 2k..."
    scripts/config --disable CONFIG_HZ_300
    scripts/config --enable CONFIG_HZ_2000
    scripts/config --set-val CONFIG_HZ 2000
  fi

  ### Optionally set tickrate to 1000
  if [ -n "$_1k_HZ_ticks" ]; then
    echo "Setting tick rate to 1k..."
    scripts/config --disable CONFIG_HZ_300
    scripts/config --enable CONFIG_HZ_1000
    scripts/config --set-val CONFIG_HZ 1000
  fi

  ### Optionally set tickrate to 500HZ
  if [ -n "$_750_HZ_ticks" ]; then
    echo "Setting tick rate to 500HZ..."
    scripts/config --disable CONFIG_HZ_300
    scripts/config --enable CONFIG_HZ_750
    scripts/config --set-val CONFIG_HZ 750
  fi

  ### Optionally set tickrate to 500HZ
  if [ -n "$_500_HZ_ticks" ]; then
    echo "Setting tick rate to 500HZ..."
    scripts/config --disable CONFIG_HZ_300
    scripts/config --enable CONFIG_HZ_500
    scripts/config --set-val CONFIG_HZ 500
  fi

  ### Optionally disable NUMA for 64-bit kernels only
  # (x86 kernels do not support NUMA)
  if [ -n "$_NUMAdisable" ]; then
    echo "Disabling NUMA from kernel config..."
    scripts/config --disable CONFIG_NUMA
  fi

  if [ -n "$_fsync" ]; then
    echo "Enable Fsync support"
    scripts/config --enable CONFIG_FUTEX
    scripts/config --enable CONFIG_FUTEX_PI
  fi

  if [ -n "$_futex2" ]; then
    echo "Enable Futex2 support"
    scripts/config --enable CONFIG_FUTEX2
  fi

  if [ -n "$_winesync" ]; then
    echo "Enable winesync support"
    scripts/config --module CONFIG_WINESYNC
  fi

  ### Set performance governor
  if [ -n "$_per_gov" ]; then
    echo "Setting performance governor..."
    scripts/config --disable CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
    scripts/config --enable CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE
    echo "Disabling uneeded governors..."
    scripts/config --enable CONFIG_CPU_FREQ_GOV_ONDEMAND
    scripts/config --disable CONFIG_CPU_FREQ_GOV_CONSERVATIVE
    scripts/config --disable CONFIG_CPU_FREQ_GOV_USERSPACE
    scripts/config --disable CONFIG_CPU_FREQ_GOV_SCHEDUTIL
  fi

  ### Disable Deadline I/O scheduler
  if [ -n "$_deadline_disable" ]; then
    echo "Disabling Deadline I/O scheduler..."
    scripts/config --disable CONFIG_MQ_IOSCHED_DEADLINE
  fi

  ### Disable Kyber I/O scheduler
  if [ -n "$_kyber_disable" ]; then
    echo "Disabling Kyber I/O scheduler..."
    scripts/config --disable CONFIG_MQ_IOSCHED_KYBER
  fi

  if [ -n "$_mm_protect" ]; then
    echo "Enabling protect file mappings under memory pressure..."
    #        	scripts/config --enable CONFIG_UNEVICTABLE_FILE
    scripts/config --set-val CONFIG_CLEAN_LOW_KBYTES 150000
    scripts/config --set-val CONFIG_CLEAN_MIN_KBYTES 0
  fi

  ### Enabling Cacule-Config ##
  echo "Enable CacULE CPU scheduler..."
  scripts/config --enable CONFIG_CACULE_SCHED
  scripts/config --enable CONFIG_FAIR_GROUP_SCHED
  scripts/config --enable CONFIG_SCHED_AUTOGROUP
  scripts/config --enable CONFIG_CONTEXT_TRACKING
  scripts/config --disable CONFIG_CONTEXT_TRACKING_FORCE
  echo "Enabling KBUILD_CFLAGS -O3..."
  scripts/config --enable CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
  scripts/config --disable CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3
  echo "Enable PREEMPT"
  scripts/config --disable CONFIG_PREEMPT_NONE
  scripts/config --disable CONFIG_PREEMPT_VOLUNTARY
  scripts/config --enable CONFIG_PREEMPT
  scripts/config --enable CONFIG_PREEMPT_COUNT
  scripts/config --enable CONFIG_PREEMPTION
  scripts/config --enable CONFIG_PREEMPT_DYNAMIC
  echo "Enable NTFS3"
  scripts/config --module CONFIG_NTFS_FS
  scripts/config --enable CONFIG_NTFS_RW
  scripts/config --enable CONFIG_NTFS_DEBUG
  scripts/config --module CONFIG_NTFS3_FS
  scripts/config --enable CONFIG_NTFS3_64BIT_CLUSTER
  scripts/config --enable CONFIG_NTFS3_LZX_XPRESS
  scripts/config --enable CONFIG_NTFS3_FS_POSIX_ACL
  echo "Enable Anbox"
  scripts/config --module  CONFIG_ASHMEM
  scripts/config --enable  CONFIG_ANDROID_BINDER_IPC_SELFTEST
  scripts/config --enable  CONFIG_ANDROID
  scripts/config --enable  CONFIG_ANDROID_BINDER_IPC
  scripts/config --enable  CONFIG_ANDROID_BINDERFS
  scripts/config --set-str CONFIG_ANDROID_BINDER_DEVICES binder,hwbinder,vndbinder
  echo "Disabling TCP_CONG_CUBIC..."
  scripts/config --module CONFIG_TCP_CONG_CUBIC
  scripts/config --disable CONFIG_DEFAULT_CUBIC
  echo "Enabling TCP_CONG_BBR2..."
  scripts/config --enable CONFIG_TCP_CONG_BBR2
  scripts/config --enable CONFIG_DEFAULT_BBR2
  scripts/config --set-str CONFIG_DEFAULT_TCP_CONG bbr2
  echo "Enable VHBA-Module"
  scripts/config --module CONFIG_VHBA


  echo "Setting config..."
  cp ../config .config
  make olddefconfig
  #return 1
  make -s kernelrelease > version
  echo "Prepared $pkgbase version $(<version)"
}

build() {
  cd $_srcname
  make  -j$(nproc) all
}

_package() {
  pkgdesc="The $pkgdesc kernel and modules"
  depends=(coreutils kmod initramfs)
  optdepends=('crda: to set the correct wireless channels of your country'
  'linux-firmware: firmware images needed for some devices')
  provides=(VIRTUALBOX-GUEST-MODULES WIREGUARD-MODULE)
  replaces=(wireguard-lts)

  cd $_srcname
  local kernver="$(<version)"
  local modulesdir="$pkgdir/usr/lib/modules/$kernver"

  echo "Installing boot image..."
  # systemd expects to find the kernel here to allow hibernation
  # https://github.com/systemd/systemd/commit/edda44605f06a41fb86b7ab8128dcf99161d2344
  install -Dm644 "$(make -s image_name)" "$modulesdir/vmlinuz"

  # Used by mkinitcpio to name the kernel
  echo "$pkgbase" | install -Dm644 /dev/stdin "$modulesdir/pkgbase"

  echo "Installing modules..."
  make INSTALL_MOD_PATH="$pkgdir/usr" INSTALL_MOD_STRIP=1 modules_install

  # remove build and source links
  rm "$modulesdir"/{source,build}
}

_package-headers() {
  pkgdesc="Headers and scripts for building modules for the $pkgdesc kernel"

  cd $_srcname
  local builddir="$pkgdir/usr/lib/modules/$(<version)/build"

  echo "Installing build files..."
  install -Dt "$builddir" -m644 .config Makefile Module.symvers System.map \
    localversion.* version vmlinux
  install -Dt "$builddir/kernel" -m644 kernel/Makefile
  install -Dt "$builddir/arch/x86" -m644 arch/x86/Makefile
  cp -t "$builddir" -a scripts

  # add objtool for external module building and enabled VALIDATION_STACK option
  install -Dt "$builddir/tools/objtool" tools/objtool/objtool

  # add xfs and shmem for aufs building
  mkdir -p "$builddir"/{fs/xfs,mm}

  echo "Installing headers..."
  cp -t "$builddir" -a include
  cp -t "$builddir/arch/x86" -a arch/x86/include
  install -Dt "$builddir/arch/x86/kernel" -m644 arch/x86/kernel/asm-offsets.s

  install -Dt "$builddir/drivers/md" -m644 drivers/md/*.h
  install -Dt "$builddir/net/mac80211" -m644 net/mac80211/*.h

  # http://bugs.archlinux.org/task/13146
  install -Dt "$builddir/drivers/media/i2c" -m644 drivers/media/i2c/msp3400-driver.h

  # http://bugs.archlinux.org/task/20402
  install -Dt "$builddir/drivers/media/usb/dvb-usb" -m644 drivers/media/usb/dvb-usb/*.h
  install -Dt "$builddir/drivers/media/dvb-frontends" -m644 drivers/media/dvb-frontends/*.h
  install -Dt "$builddir/drivers/media/tuners" -m644 drivers/media/tuners/*.h

  echo "Installing KConfig files..."
  find . -name 'Kconfig*' -exec install -Dm644 {} "$builddir/{}" \;

  echo "Removing unneeded architectures..."
  local arch
  for arch in "$builddir"/arch/*/; do
    [[ $arch = */x86/ ]] && continue
    echo "Removing $(basename "$arch")"
    rm -r "$arch"
  done

  echo "Removing documentation..."
  rm -r "$builddir/Documentation"

  echo "Removing broken symlinks..."
  find -L "$builddir" -type l -printf 'Removing %P\n' -delete

  echo "Removing loose objects..."
  find "$builddir" -type f -name '*.o' -printf 'Removing %P\n' -delete

  echo "Stripping build tools..."
  local file
  while read -rd '' file; do
    case "$(file -bi "$file")" in
      application/x-sharedlib\;*)      # Libraries (.so)
        strip -v $STRIP_SHARED "$file" ;;
      application/x-archive\;*)        # Libraries (.a)
        strip -v $STRIP_STATIC "$file" ;;
      application/x-executable\;*)     # Binaries
        strip -v $STRIP_BINARIES "$file" ;;
      application/x-pie-executable\;*) # Relocatable binaries
        strip -v $STRIP_SHARED "$file" ;;
    esac
  done < <(find "$builddir" -type f -perm -u+x ! -name vmlinux -print0)

  echo "Stripping vmlinux..."
  strip -v $STRIP_STATIC "$builddir/vmlinux"

  echo "Adding symlink..."
  mkdir -p "$pkgdir/usr/src"
  ln -sr "$builddir" "$pkgdir/usr/src/$pkgbase"
}

pkgname=("$pkgbase" "$pkgbase-headers")
for _p in "${pkgname[@]}"; do
  eval "package_$_p() {
    $(declare -f "_package${_p#$pkgbase}")
    _package${_p#$pkgbase}
  }"
done

# vim:set ts=8 sts=2 sw=2 et:
