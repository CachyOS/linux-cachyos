# Maintainer: Peter Jung ptr1337 <admin@ptr1337.dev>

### BUILD OPTIONS
# Set the next two variables to ANYTHING that is not null to enable them

# NUMA is optimized for multi-socket motherboards.
# A single multi-core CPU actually runs slower with NUMA enabled.
# See, https://bugs.archlinux.org/task/31187
_NUMAdisable=y

# Enable fsync
_fsync=y

#enable futex2
_futex2=y

#enable winesync
_winesync=y

### Running with a 1000HZ, 750Hz or  500HZ tick rate
_2k_HZ_ticks=
_1k_HZ_ticks=y
_750_HZ_ticks=
_600_HZ_ticks=
_500_HZ_ticks=

### Disable MQ-Deadline I/O scheduler
_mq_deadline_disable=y

### Disable Kyber I/O scheduler
_kyber_disable=y

### Enable protect file mappings under memory pressure
_mm_protect=y

### Enable multigenerational LRU
_lru_enable=y

### Enable Linux Random Number Generator
_lrng_enable=

## Samba3 Server
_ksmbd_enable=

## Apply Kernel automatic Optimization
_use_auto_optimization=y

## Apply Kernel Optimization selecting
_use_optimization_select=


### Selecting the ZSTD compression level
# ATTENTION - one of two predefined values should be selected!
# 'ultra' - highest compression ratio
# 'normal' - standard compression ratio
_zstd_level='ultra'

### Selecting the ZSTD module compression level
# If you want to use ZSTD compression,
# first install mkinitcpio-zstd:
# https://gitlab.com/sirlucjan/lucjan-kernels/tree/master/depends
# or
# https://github.com/sirlucjan/lucjan-kernels/tree/master/depends
# ATTENTION - one of two predefined values should be selected!
# 'ultra' - highest compression ratio
# 'normal' - standard compression ratio
# WARNING: the ultra settings can sometimes
# be counterproductive in both size and speed.
_zstd_module_level='normal'

### Enable SECURITY_FORK_BRUTE
# WARNING Not recommended.
# An experimental solution, still in testing phase.
# Possible compilation and installation errors.
# Leave it unselected.
_fork_brute=

## Enable it for compiling with LLVM and THINLTO
_use_llvm_lto=

# Enable it for using the LLVM CFI PATCH for a better security
_use_cfi=

## Enable PGO (patch is failing when cfi is also used)
#_use_pgo=

# Only compile active modules to VASTLY reduce the number of modules built and
# the build time.
#
# To keep track of which modules are needed for your specific system/hardware,
# give module_db a try: https://aur.archlinux.org/packages/modprobed-db
# This PKGBUILD reads the database kept if it exists
#
# More at this wiki page ---> https://wiki.archlinux.org/index.php/Modprobed-db
_localmodcfg=

# Use the current kernel's .config file
# Enabling this option will use the .config of the RUNNING kernel rather than
# the ARCH defaults. Useful when the package gets updated and you already went
# through the trouble of customizing your config options.  NOT recommended when
# a new kernel is released, but again, convenient for package bumps.
_use_current=

# Tweak kernel options prior to a build via nconfig
_makenconfig=


if [ -n "$_use_llvm_lto" ]; then
  pkgbase=linux-cachyos-rt-lto
else
  pkgbase=linux-cachyos-rt
fi
pkgver=5.15.11
pkgrel=1
arch=(x86_64 x86_64_v3)
pkgdesc='Linux-cacule Kernel by CachyOS and with some other patches and other improvements'
_gittag=v${pkgver%.*}-${pkgver##*.}
arch=('x86_64' 'x86_64_v3')
url="https://github.com/ptr1337/linux-cacule"
license=('GPL2')
options=('!strip')
makedepends=('kmod' 'bc' 'libelf' 'python-sphinx' 'python-sphinx_rtd_theme'
'graphviz' 'imagemagick' 'pahole' 'cpio' 'perl' 'tar' 'xz')
if [ -n "$_use_llvm_lto" ]; then
  makedepends+=(clang llvm lld python)
fi
_caculepatches="https://raw.githubusercontent.com/ptr1337/kernel-patches/master/CacULE"
_patchsource="https://raw.githubusercontent.com/ptr1337/kernel-patches/master/5.15"
source=("https://cdn.kernel.org/pub/linux/kernel/v${pkgver:0:1}.x/linux-${pkgver}.tar.xz"
  "config"
  "${_patchsource}/0001-5.15.10-rt24.patch"
  "${_patchsource}/arch-patches/0001-ZEN-Add-sysctl-and-CONFIG-to-disallow-unprivileged-C.patch"
  "${_patchsource}/0001-misc.patch"
  "${_patchsource}/AMD/0001-amd64-patches.patch"
  "${_patchsource}/0001-bbr2.patch"
  "${_patchsource}/0001-clearlinux-patches.patch"
  "${_patchsource}/0001-cpu-patches.patch"
  "${_patchsource}/AMD/0001-amdpstate.patch"
  "${_patchsource}/0001-btrfs-patches.patch"
  "${_patchsource}/0001-ck-hrtimer.patch"
  "${_patchsource}/0001-fixes-miscellaneous.patch"
  "${_patchsource}/0001-futex-wait.v-fsync-winesync.patch"
  "${_patchsource}/0001-hwmon-patches.patch"
  "${_patchsource}/0001-ksmbd-patches.patch"
  #  "${_patchsource}/0001-damon-patches.patch"
  "${_patchsource}/0001-lqx-patches.patch"
  #  "${_patchsource}/0001-lrng-patches.patch"
  "${_patchsource}/0001-pf-patches.patch"
  "${_patchsource}/0001-v4l2loopback.patch"
  "${_patchsource}/0001-zen-patches.patch"
  "${_patchsource}/0001-zstd.patch"
  "auto-cpu-optimization.sh"
)
if [ -n "$_use_cfi" ]; then
  source+=("${_patchsource}/0002-clang-cfi.patch")
fi

if [ -n "$_use_pgo" ]; then
  source+=("${_patchsource}/0001-PGO.patch")
fi

if [ -n "$_use_llvm_lto" ]; then
  LLVMOPTS="LLVM=1 LLVM_IAS=1"
  CLANGOPTS="CC=clang LD=ld.lld"
else
  LLVMOPTS=""
  CLANGOPTS=""
fi

export KBUILD_BUILD_HOST=archlinux
export KBUILD_BUILD_USER=$pkgbase
export KBUILD_BUILD_TIMESTAMP="$(date -Ru${SOURCE_DATE_EPOCH:+d @$SOURCE_DATE_EPOCH})"


prepare() {
  cd "${srcdir:?}/linux-${pkgver}" || (
    echo -e "\E[1;31mCan't cd to ${srcdir:?}/linux-${pkgver} directory! Prepare failed! \E[0m"
    exit 1
  )

  ### Setting version
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

  echo "Setting config..."
  cp ../config .config

  if [ -n "$_use_cfi" ]; then
    scripts/config --enable CONFIG_ARCH_SUPPORTS_CFI_CLANG
    scripts/config --enable CONFIG_CFI_CLANG
  fi

  if [ -n "$_use_pgo" ]; then
    scripts/config --enable CONFIG_ARCH_SUPPORTS_PGO_CLANG
    scripts/config --enable DEBUG_FS
    scripts/config --enable CONFIG_PGO_CLANG
  fi

  ### Microarchitecture Optimization (GCC/CLANG)
  if [ -n "$_use_auto_optimization" ]; then
    "${srcdir}"/auto-cpu-optimization.sh
  fi
  if [ -n "$_use_optimization_select" ]; then
    source "${startdir}"/configure
    cpu_arch
  fi

  ### Optionally set tickrate to 1000
  if [ -n "$_1k_HZ_ticks" ]; then
    echo "Setting tick rate to 1k..."
    scripts/config --disable CONFIG_HZ_300
    scripts/config --enable CONFIG_HZ_1000
    scripts/config --set-val CONFIG_HZ 1000
  fi

  ### Optionally set tickrate to 750HZ
  if [ -n "$_750_HZ_ticks" ]; then
    echo "Setting tick rate to 750HZ..."
    scripts/config --disable CONFIG_HZ_300
    scripts/config --enable CONFIG_HZ_750
    scripts/config --set-val CONFIG_HZ 750
  fi

  ### Optionally set tickrate to 600HZ
  if [ -n "$_600_HZ_ticks" ]; then
    echo "Setting tick rate to 600HZ..."
    scripts/config --disable CONFIG_HZ_300
    scripts/config --enable CONFIG_HZ_600
    scripts/config --set-val CONFIG_HZ 600
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

  if [ -n "$_winesync" ]; then
    echo "Enable winesync support"
    scripts/config --module CONFIG_WINESYNC
  fi

  ### Disable MQ-Deadline I/O scheduler
  if [ -n "$_mq_deadline_disable" ]; then
    echo "Disabling MQ-Deadline I/O scheduler..."
    scripts/config --disable CONFIG_MQ_IOSCHED_DEADLINE
  fi

  ### Disable Kyber I/O scheduler
  if [ -n "$_kyber_disable" ]; then
    echo "Disabling Kyber I/O scheduler..."
    scripts/config --disable CONFIG_MQ_IOSCHED_KYBER
  fi

  ### Enable protect file mappings under memory pressure
  if [ -n "$_mm_protect" ]; then
    echo "Enabling protect file mappings under memory pressure..."
    scripts/config --enable CONFIG_UNEVICTABLE_FILE
    scripts/config --set-val CONFIG_UNEVICTABLE_FILE_KBYTES_LOW 262144
    scripts/config --set-val CONFIG_UNEVICTABLE_FILE_KBYTES_MIN 131072
    scripts/config --enable CONFIG_UNEVICTABLE_ANON
    scripts/config --set-val CONFIG_UNEVICTABLE_ANON_KBYTES_LOW 65536
    scripts/config --set-val CONFIG_UNEVICTABLE_ANON_KBYTES_MIN 32768
    scripts/config --enable CONFIG_DAMON
    scripts/config --disable CONFIG_DAMON_VADDR
    scripts/config --disable CONFIG_DAMON_DBGFS
    scripts/config --enable CONFIG_DAMON_PADDR
    scripts/config --enable CONFIG_DAMON_RECLAIM
  fi

  ### Enable multigenerational LRU
  if [ -n "$_lru_enable" ]; then
    echo "Enabling multigenerational LRU..."
    scripts/config --enable CONFIG_HAVE_ARCH_PARENT_PMD_YOUNG
    scripts/config --enable CONFIG_LRU_GEN
    scripts/config --set-val CONFIG_NR_LRU_GENS 7
    scripts/config --set-val CONFIG_TIERS_PER_GEN 4
    scripts/config --enable CONFIG_LRU_GEN_ENABLED
    scripts/config --disable CONFIG_LRU_GEN_STATS
  fi

  ### Enable Linux Random Number Generator
  if [ -n "$_lrng_enable" ]; then
    echo "Enabling Linux Random Number Generator ..."
    scripts/config --enable CONFIG_LRNG
    scripts/config --enable CONFIG_LRNG_OVERSAMPLE_ENTROPY_SOURCES
    scripts/config --set-val CONFIG_CONFIG_LRNG_OVERSAMPLE_ES_BITS 64
    scripts/config --set-val CONFIG_LRNG_SEED_BUFFER_INIT_ADD_BITS 128
    scripts/config --enable CONFIG_LRNG_CONTINUOUS_COMPRESSION_ENABLED
    scripts/config --disable CONFIG_LRNG_CONTINUOUS_COMPRESSION_DISABLED
    scripts/config --enable CONFIG_LRNG_ENABLE_CONTINUOUS_COMPRESSION
    scripts/config --enable CONFIG_LRNG_SWITCHABLE_CONTINUOUS_COMPRESSION
    scripts/config --disable CONFIG_LRNG_COLLECTION_SIZE_512
    scripts/config --enable CONFIG_LRNG_COLLECTION_SIZE_1024
    scripts/config --disable CONFIG_LRNG_COLLECTION_SIZE_2048
    scripts/config --disable CONFIG_LRNG_COLLECTION_SIZE_4096
    scripts/config --disable CONFIG_LRNG_COLLECTION_SIZE_8192
    scripts/config --set-val CONFIG_LRNG_COLLECTION_SIZE 1024
    scripts/config --enable CONFIG_LRNG_HEALTH_TESTS
    scripts/config --set-val CONFIG_LRNG_RCT_CUTOFF 31
    scripts/config --set-val CONFIG_LRNG_APT_CUTOFF 325
    scripts/config --set-val CONFIG_LRNG_IRQ_ENTROPY_RATE 256
    scripts/config --enable CONFIG_LRNG_JENT
    scripts/config --set-val CONFIG_LRNG_JENT_ENTROPY_RATE 16
    scripts/config --set-val CONFIG_LRNG_CPU_ENTROPY_RATE 8
    scripts/config --enable CONFIG_LRNG_DRNG_SWITCH
    scripts/config --enable CONFIG_LRNG_KCAPI_HASH
    scripts/config --module CONFIG_LRNG_DRBG
    scripts/config --module CONFIG_LRNG_KCAPI
    scripts/config --enable CONFIG_LRNG_TESTING_MENU
    scripts/config --disable CONFIG_LRNG_RAW_HIRES_ENTROPY
    scripts/config --disable CONFIG_LRNG_RAW_JIFFIES_ENTROPY
    scripts/config --disable CONFIG_LRNG_RAW_IRQ_ENTROPY
    scripts/config --disable CONFIG_LRNG_RAW_IRQFLAGS_ENTROPY
    scripts/config --disable CONFIG_LRNG_RAW_RETIP_ENTROPY
    scripts/config --disable CONFIG_LRNG_RAW_REGS_ENTROPY
    scripts/config --disable CONFIG_LRNG_RAW_ARRAY
    scripts/config --disable CONFIG_LRNG_IRQ_PERF
    scripts/config --disable CONFIG_LRNG_ACVT_HASH
    scripts/config --enable CONFIG_LRNG_RUNTIME_ES_CONFIG
    scripts/config --disable CONFIG_LRNG_RUNTIME_MAX_WO_RESEED_CONFIG
    scripts/config --enable CONFIG_LRNG_SELFTEST
    scripts/config --disable CONFIG_LRNG_SELFTEST_PANIC
  fi
  echo "Enable LLVM LTO"
  if [ -n "$_use_llvm_lto" ]; then
    scripts/config --disable CONFIG_LTO_NONE
  fi

  ### Enable multigenerational LRU
  if [ -n "$_lru_enable" ]; then
    echo "Enabling multigenerational LRU..."
    scripts/config --enable CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
    scripts/config --enable CONFIG_LRU_GEN
    scripts/config --set-val CONFIG_NR_LRU_GENS 7
    scripts/config --set-val CONFIG_TIERS_PER_GEN 4
    scripts/config --enable CONFIG_LRU_GEN_ENABLED
    scripts/config --disable CONFIG_LRU_GEN_STATS
  fi

  ### Enable SMB3 Kernel Server
  if [ -n "$_ksmbd_enable" ]; then
    echo "Enabling SMB3 Kernel Server..."
    scripts/config --module CONFIG_SMB_SERVER
    scripts/config --enable CONFIG_SMB_SERVER_SMBDIRECT
    scripts/config --enable CONFIG_SMB_SERVER_CHECK_CAP_NET_ADMIN
    scripts/config --enable CONFIG_SMB_SERVER_KERBEROS5
  fi


  ### Selecting the ZSTD compression level
  if [ "$_zstd_level" = "ultra" ]; then
    echo "Enabling highest ZSTD compression ratio..."
    scripts/config --set-val CONFIG_KERNEL_ZSTD_LEVEL 19
    scripts/config --enable CONFIG_KERNEL_ZSTD_LEVEL_ULTRA
  elif [ "$_zstd_level" = "normal" ]; then
    echo "Enabling standard ZSTD compression ratio..."
    scripts/config --set-val CONFIG_KERNEL_ZSTD_LEVEL 19
    scripts/config --disable CONFIG_KERNEL_ZSTD_LEVEL_ULTRA
  else
    if [ -n "$_zstd_level" ]; then
      error "The value $_zstd_level is invalid. Choose the correct one again."
    else
      error "The value is empty. Choose the correct one again."
    fi
    error "Selecting the ZSTD compression level failed!"
    exit
  fi

  ### Selecting the ZSTD module compression level
  if [ "$_zstd_module_level" = "ultra" ]; then
    echo "Enabling highest ZSTD module compression ratio..."
    scripts/config --set-val CONFIG_MODULE_COMPRESS_ZSTD_LEVEL 19
    scripts/config --enable CONFIG_MODULE_COMPRESS_ZSTD_ULTRA
    scripts/config --set-val CONFIG_MODULE_COMPRESS_ZSTD_LEVEL_ULTRA 22
  elif [ "$_zstd_module_level" = "normal" ]; then
    echo "Enabling standard ZSTD module compression ratio..."
    scripts/config --set-val CONFIG_MODULE_COMPRESS_ZSTD_LEVEL 19
    scripts/config --disable CONFIG_MODULE_COMPRESS_ZSTD_ULTRA
  else
    if [ -n "$_zstd_module_level" ]; then
      error "The value $_zstd_module_level is invalid. Choose the correct one again."
    else
      error "The value is empty. Choose the correct one again."
    fi
    error "Selecting the ZSTD module compression level failed!"
    exit
  fi

  echo "Disabling TCP_CONG_CUBIC..."
  scripts/config --module CONFIG_TCP_CONG_CUBIC
  scripts/config --disable CONFIG_DEFAULT_CUBIC
  echo "Enabling TCP_CONG_BBR2..."
  scripts/config --enable CONFIG_TCP_CONG_BBR2
  scripts/config --enable CONFIG_DEFAULT_BBR2
  scripts/config --set-str CONFIG_DEFAULT_TCP_CONG bbr2
  echo "Enabling FULLCONENAT..."
  scripts/config --module CONFIG_IP_NF_TARGET_FULLCONENAT
  scripts/config --module CONFIG_NETFILTER_XT_TARGET_FULLCONENAT
  echo "Setting performance governor..."
  scripts/config --disable CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
  scripts/config --enable CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE
  scripts/config --enable CONFIG_CPU_FREQ_GOV_ONDEMAND
  scripts/config --enable CONFIG_CPU_FREQ_GOV_PERFORMANCE
  scripts/config --enable CONFIG_CPU_FREQ_GOV_CONSERVATIVE
  scripts/config --enable CONFIG_CPU_FREQ_GOV_USERSPACE
  scripts/config --enable CONFIG_CPU_FREQ_GOV_SCHEDUTIL
  echo "Enable AMD PSTATE driver"
  scripts/config --enable CONFIG_AMD_PTDMA
  scripts/config --enable CONFIG_AMD_PSTATE
  echo "Enable Anbox"
  scripts/config --enable CONFIG_ASHMEM
  scripts/config --enable CONFIG_ANDROID
  scripts/config --enable CONFIG_ANDROID_BINDER_IPC
  scripts/config --enable CONFIG_ANDROID_BINDERFS
  scripts/config --enable CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
  echo "Enable NTFS"
  scripts/config --enable CONFIG_NTFS3_FS



  ### Optionally disable NUMA for 64-bit kernels only
  # (x86 kernels do not support NUMA)
  if [ -n "$_NUMAdisable" ]; then
    echo "Disabling NUMA from kernel config..."
    scripts/config --disable CONFIG_NUMA
  fi

  ### Optionally use running kernel's config
  # code originally by nous; http://aur.archlinux.org/packages.php?ID=40191
  if [ -n "$_use_current" ]; then
    if [[ -s /proc/config.gz ]]; then
      echo "Extracting config from /proc/config.gz..."
      # modprobe configs
      zcat /proc/config.gz > ./.config
    else
      warning "Your kernel was not compiled with IKCONFIG_PROC!"
      warning "You cannot read the current config!"
      warning "Aborting!"
      exit
    fi
  fi

  ### Optionally load needed modules for the make localmodconfig
  # See https://aur.archlinux.org/packages/modprobed-db
  if [ -n "$_localmodcfg" ]; then
    if [ -f $HOME/.config/modprobed.db ]; then
      echo "Running Steven Rostedt's make localmodconfig now"
      make  $LLVMOPTS LSMOD=$HOME/.config/modprobed.db localmodconfig
    else
      echo "No modprobed.db data found"
      exit
    fi
  fi


  echo "Applying default config..."
  make $LLVMOPTS olddefconfig
  make $LLVMOPTS -s kernelrelease > version
  echo "Prepared $pkgbase version $(<version)"

  ### Running make nconfig
  [[ -z "$_makenconfig" ]] ||  make $LLVMOPTS nconfig

  ### Running make menuconfig
  [[ -z "$_makemenuconfig" ]] || make $LLVMOPTS menuconfig

  ### Running make xconfig
  [[ -z "$_makexconfig" ]] || make $LLVMOPTS xconfig

  ### Running make gconfig
  [[ -z "$_makegconfig" ]] || make $LLVMOPTS gconfig

  ### Save configuration for later reuse
  cp -Tf ./.config "${startdir}/config-${pkgver}-${pkgrel}${pkgbase#linux}"

}

build() {
  cd $_srcname

  make $LLVMOPTS -j$(nproc) all
}

_package() {
  pkgdesc="The $pkgdesc kernel and modules"
  depends=('coreutils' 'kmod' 'initramfs')
  optdepends=('crda: to set the correct wireless channels of your country'
    'linux-firmware: firmware images needed for some devices'
  'modprobed-db: Keeps track of EVERY kernel module that has ever been probed - useful for those of us who make localmodconfig')
  provides=(VIRTUALBOX-GUEST-MODULES WIREGUARD-MODULE)

  cd $_srcname

  local kernver="$(<version)"
  local modulesdir="$pkgdir/usr/lib/modules/$kernver"

  echo "Installing boot image..."
  # systemd expects to find the kernel here to allow hibernation
  # https://github.com/systemd/systemd/commit/edda44605f06a41fb86b7ab8128dcf99161d2344
  install -Dm644 "$(make $CLANGOPTS -s image_name)" "$modulesdir/vmlinuz"

  # Used by mkinitcpio to name the kernel
  echo "$pkgbase" | install -Dm644 /dev/stdin "$modulesdir/pkgbase"

  echo "Installing modules..."
  make $CLANGOPTS INSTALL_MOD_PATH="$pkgdir/usr" INSTALL_MOD_STRIP=1 modules_install

  # remove build and source links
  rm "$modulesdir"/{source,build}

}

_package-headers() {
  pkgdesc="Headers and scripts for building modules for the ${pkgdesc}"
  depends=("${pkgbase}=${pkgver}" "pahole")

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

  # https://bugs.archlinux.org/task/13146
  install -Dt "$builddir/drivers/media/i2c" -m644 drivers/media/i2c/msp3400-driver.h

  # https://bugs.archlinux.org/task/20402
  install -Dt "$builddir/drivers/media/usb/dvb-usb" -m644 drivers/media/usb/dvb-usb/*.h
  install -Dt "$builddir/drivers/media/dvb-frontends" -m644 drivers/media/dvb-frontends/*.h
  install -Dt "$builddir/drivers/media/tuners" -m644 drivers/media/tuners/*.h

  # https://bugs.archlinux.org/task/71392
  install -Dt "$builddir/drivers/iio/common/hid-sensors" -m644 drivers/iio/common/hid-sensors/*.h

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


md5sums=('7fcbea316f8439d092040996295c8f9d'
         'a0e0c04d19191dce51b530d04f38e7cb'
         'cdbb72be18eed85ed1beb02cb799acb1'
         'cf26387aadf2a90428350ac246b070c9'
         '299b176cbfc1b386d74406387e9e2d6b'
         '53f037488a66667220c263f92ded333d'
         '2a8097ba46be56fbbe3967e9c34c9a0b'
         '41887f2f959068e41756f4c39671ca79'
         '67764a5824b567b49bcce19c01d4e1b3'
         '3aaa8d1bc993d4173aa1bb79ade16fb7'
         '70be88d96e0bc9e72759bf3902e7eb53'
         '6038177c72982533035309fcd6df208a'
         '8bda7327ae759b1b52e3b617952bd964'
         '8c354c3d1962ec6785db7f0c3fbbab03'
         '349c88a39ec553aa3c9caf886b44c7ab'
         '480c6bb9db4842114787f66ad5a68404'
         '56fdf3562b041c0408d9751b7e447977'
         '08c84362cb916b30d9c77e35b1b3bc54'
         'd9a892f66631615a72bdc93ee7397afa'
         'de6db1147385c058b2e94df3c1739fdf'
         '8a7c7cf90dcad3f655491b21c35f36b3'
         '21c98f19e883879dd3336c1fa143fd31')
