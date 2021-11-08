# Maintainer: Peter Jung ptr1337 <admin@ptr1337.dev>
# Maintainer: Piotr Gorski <lucjan.lucjanov@gmail.com>
# Contributor: Jan Alexander Steffens (heftig) <jan.steffens@gmail.com>
# Contributor: Tobias Powalowski <tpowa@archlinux.org>
# Contributor: Thomas Baechler <thomas@archlinux.org>

# Selecting CacULE or CacULE-RDB scheduler, default:cacule
_cpusched='cacule'
#_cpusched='rdb'

### BUILD OPTIONS
# Set these variables to ANYTHING that is not null to enable them

### Tweak kernel options prior to a build via nconfig
_makenconfig=

### Tweak kernel options prior to a build via menuconfig
_makemenuconfig=

### Tweak kernel options prior to a build via xconfig
_makexconfig=

### Tweak kernel options prior to a build via gconfig
_makegconfig=

# NUMA is optimized for multi-socket motherboards.
# A single multi-core CPU actually runs slower with NUMA enabled.
# See, https://bugs.archlinux.org/task/31187
_NUMAdisable=y

# Compile ONLY used modules to VASTLYreduce the number of modules built
# and the build time.
#
# To keep track of which modules are needed for your specific system/hardware,
# give module_db script a try: https://aur.archlinux.org/packages/modprobed-db
# This PKGBUILD read the database kept if it exists
#
# More at this wiki page ---> https://wiki.archlinux.org/index.php/Modprobed-db
_localmodcfg=

# Use the current kernel's .config file
# Enabling this option will use the .config of the RUNNING kernel rather than
# the ARCH defaults. Useful when the package gets updated and you already went
# through the trouble of customizing your config options.  NOT recommended when
# a new kernel is released, but again, convenient for package bumps.
_use_current=


# Enable fsync
_fsync=y

#enable futex2
_futex2=y

#enable winesync
_winesync=y

### Running with a 2000 HZ, 1000HZ, 750Hz or  500HZ tick rate
_2k_HZ_ticks=
_1k_HZ_ticks=
_750_HZ_ticks=
_600_HZ_ticks=y
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
_lrng_enable=y


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

### Enable SPECULATIVE_PAGE
# ATTENTION - one of three predefined values should be selected!
# 'full' - enable full SPECULATIVE_PAGE
# 'basic' - enable basic SPECULATIVE_PAGE
# 'none' - disable SPECULATIVE_PAGE
_speculative_page='none'

## Enable it for compiling with LLVM and THINLTO
_use_llvm_lto=

# Enable it for using the LLVM CFI PATCH for a better security
_use_cfi=

## Enable PGO (patch is failing when cfi is also used)
_use_pgo=


if [ "$_cpusched" = "cacule" ]  && [ -n "$_use_llvm_lto" ]; then
  pkgbase=linux-cachyos-cacule-lto
elif  [ "$_cpusched" = "rdb" ] && [ -n "$_use_llvm_lto" ]; then
  pkgbase=linux-cachyos-cacule-rdb-lto
elif [ "$_cpusched" = "cacule" ]; then
  pkgbase=linux-cachyos-cacule
elif [ "$_cpusched" = "rdb" ]; then
  pkgbase=linux-cachyos-cacule-rdb
fi
_major=5.15
_minor=1
pkgver=${_major}.${_minor}
_srcname=linux-${pkgver}
arch=(x86_64 x86_64_v3)
pkgdesc='Linux CacULE scheduler Kernel by CachyOS and with some other patches and other improvements'
_srcname=linux-${pkgver}
pkgrel=3
arch=('x86_64' 'x86_64_v3')
url="https://github.com/CachyOS/linux-cachyos"
license=('GPL2')
options=('!strip')
makedepends=('kmod' 'bc' 'libelf' 'python-sphinx' 'python-sphinx_rtd_theme'
'graphviz' 'imagemagick' 'pahole' 'cpio' 'perl' 'tar' 'xz')
if [ -n "$_use_llvm_lto" ]; then
  makedepends+=(clang llvm lld python)
fi
_caculepatches="https://raw.githubusercontent.com/ptr1337/kernel-patches/master/CacULE"
_patchsource="https://raw.githubusercontent.com/ptr1337/kernel-patches/master/5.15"
source=("https://www.kernel.org/pub/linux/kernel/v5.x/${_srcname}.tar.xz"
  "${_caculepatches}/v5.15/cacule-5.15-full.patch"
  "config"
  "${_patchsource}/arch-patches/0001-ZEN-Add-sysctl-and-CONFIG-to-disallow-unprivileged-C.patch"
  "${_patchsource}/0001-stable-fix.patch"
  "${_patchsource}/0001-misc.patch"
  "${_patchsource}/android-patches/0001-android-export-symbold-and-enable-building-ashmem-an.patch"
  "${_patchsource}/AMD/0001-amd64-patches.patch"
  "${_patchsource}/0001-bbr2.patch"
  "${_patchsource}/0001-clearlinux-patches.patch"
  "${_patchsource}/0001-cpu-patches.patch"
  "${_patchsource}/0001-cpufreq-patches.patch"
  "${_patchsource}/0001-block-backport.patch"
  "${_patchsource}/0001-btrfs-patches.patch"
  "${_patchsource}/0001-ck-hrtimer.patch"
  "${_patchsource}/0001-fixes-miscellaneous.patch"
  "${_patchsource}/0001-futex.patch"
  "${_patchsource}/0001-hwmon-patches.patch"
  "${_patchsource}/0001-acpi.patch"
  "${_patchsource}/0001-ksmbd-patches.patch"
  "${_patchsource}/0001-sched.patch"
  "${_patchsource}/0001-lru-patches.patch"
  "${_patchsource}/0001-lqx-patches.patch"
  "${_patchsource}/0001-lrng-patches.patch"
  #  "${_patchsource}/0001-speculative-patches.patch"
  "${_patchsource}/0001-security-patches.patch"
  "${_patchsource}/0001-xfs-backport.patch"
  "${_patchsource}/0001-v4l2loopback.patch"
  "${_patchsource}/0001-zen-patches.patch"
  "${_patchsource}/0001-zstd-patches.patch"
  "${_patchsource}/0001-zstd-upstream-patches.patch"
  "auto-cpu-optimization.sh"
)

if [ -n "$_use_cfi" ]; then
  source+=("${_patchsource}/0001-cfi.patch")
fi

if [ -n "$_use_pgo" ]; then
  source+=("${_patchsource}/0001-PGO.patch")
fi

if [ -n "$_use_llvm_lto" ]; then

  BUILD_FLAGS=(
    LLVM=1
    LLVM_IAS=1
  )
fi

export KBUILD_BUILD_HOST=archlinux
export KBUILD_BUILD_USER=$pkgbase
export KBUILD_BUILD_TIMESTAMP="$(date -Ru${SOURCE_DATE_EPOCH:+d @$SOURCE_DATE_EPOCH})"

prepare() {

  cd $_srcname

  ### Setting version
  echo "Setting version..."
  scripts/setlocalversion --save-scmversion
  echo "-$pkgrel" > localversion.10-pkgrel
  echo "${pkgbase#linux}" > localversion.20-pkgname

  ### Patching sources
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
  cp ../config .config


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

  if [ -n "$_futex2" ]; then
    echo "Enable Futex2 support"
    scripts/config --enable CONFIG_FUTEX2
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

  ### Enable protect mappings under memory pressure
  if [ -n "$_mm_protect" ]; then
    echo "Enabling protect file mappings under memory pressure..."
    scripts/config --enable CONFIG_UNEVICTABLE_FILE
    scripts/config --set-val CONFIG_UNEVICTABLE_FILE_KBYTES_LOW 262144
    scripts/config --set-val CONFIG_UNEVICTABLE_FILE_KBYTES_MIN 131072
    echo "Enabling protect anonymous mappings under memory pressure..."
    scripts/config --enable CONFIG_UNEVICTABLE_ANON
    scripts/config --set-val CONFIG_UNEVICTABLE_ANON_KBYTES_LOW 65536
    scripts/config --set-val CONFIG_UNEVICTABLE_ANON_KBYTES_MIN 32768
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

  ### Enable SPECULATIVE_PAGE
  if [ "$_speculative_page" = "full" ]; then
    echo "Enabling full SPECULATIVE_PAGE..."
    scripts/config --enable CONFIG_ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
    scripts/config --enable CONFIG_SPECULATIVE_PAGE_FAULT
    scripts/config --enable CONFIG_SPECULATIVE_PAGE_FAULT_STATS
  elif [ "$_speculative_page" = "basic" ]; then
    echo "Enabling basic SPECULATIVE_PAGE..."
    scripts/config --enable CONFIG_ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
    scripts/config --enable CONFIG_SPECULATIVE_PAGE_FAULT
    scripts/config --disable CONFIG_SPECULATIVE_PAGE_FAULT_STATS
  elif [ "$_speculative_page" = "none" ]; then
    echo "Disabling SPECULATIVE_PAGE..."
    scripts/config --disable CONFIG_SPECULATIVE_PAGE_FAULT
  else
    if [ -n "$_speculative_page" ]; then
      error "The value $_speculative_page is invalid. Choose the correct one again."
    else
      error "The value is empty. Choose the correct one again."
    fi
    error "Selecting SPECULATIVE_PAGE failed!"
    exit
  fi

  ### Enable Linux Random Number Generator
  if [ -n "$_lrng_enable" ]; then
    echo "Enabling Linux Random Number Generator ..."
    scripts/config --enable CONFIG_LRNG
    scripts/config --enable CONFIG_LRNG_OVERSAMPLE_ENTROPY_SOURCES
    scripts/config --set-val CONFIG_CONFIG_LRNG_OVERSAMPLE_ES_BITS 64
    scripts/config --set-val CONFIG_LRNG_SEED_BUFFER_INIT_ADD_BITS 128
    scripts/config --enable CONFIG_LRNG_IRQ
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
    scripts/config --enable CONFIG_LRNG_CPU
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
    scripts/config --disable CONFIG_LRNG_TEST_CPU_ES_COMPRESSION
    scripts/config --enable CONFIG_LRNG_SELFTEST
    scripts/config --disable CONFIG_LRNG_SELFTEST_PANIC
  fi

  echo "Enable LLVM LTO"
  if [ -n "$_use_llvm_lto" ]; then
    scripts/config --disable CONFIG_LTO_NONE
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

  if [ "$_cpusched" = "cacule" ]; then
    echo "Selecting CacULE scheduler..."
    scripts/config --enable CONFIG_CACULE_SCHED
    scripts/config --disable CONFIG_CACULE_RDB
  fi

  if [ "$_cpusched" = "rdb" ]; then
    echo "Enabling CacULE-RDB scheduler..."
    scripts/config --enable CONFIG_CACULE_SCHED
    scripts/config --enable CONFIG_CACULE_RDB
    scripts/config --set-val CONFIG_RDB_INTERVAL 19
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
  echo "Enable AMD PSTATE v2 driver"
  scripts/config --enable CONFIG_X86_AMD_PSTATE
  scripts/config --enable CONFIG_AMD_PTDMA
  echo "Enable Anbox"
  scripts/config --enable CONFIG_ASHMEM
  scripts/config --enable CONFIG_ANDROID
  scripts/config --enable CONFIG_ANDROID_BINDER_IPC
  scripts/config --enable CONFIG_ANDROID_BINDERFS
  scripts/config --enable CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
  echo "Enable NTFS"
  scripts/config --enable CONFIG_NTFS3_FS_POSIX_ACL
  scripts/config --enable CONFIG_NTFS3_FS
  scripts/config --enable CONFIG_NTFS3_64BIT_CLUSTER
  scripts/config --enable CONFIG_NTFS3_LZX_XPRESS
  scripts/config --enable CONFIG_NLS_DEFAULT


  ### Optionally load needed modules for the make localmodconfig
  # See https://aur.archlinux.org/packages/modprobed-db
  if [ -n "$_localmodcfg" ]; then
    if [ -f $HOME/.config/modprobed.db ]; then
      echo "Running Steven Rostedt's make localmodconfig now"
      make  ${BUILD_FLAGS[*]}  LSMOD=$HOME/.config/modprobed.db localmodconfig
    else
      echo "No modprobed.db data found"
      exit
    fi
  fi


  echo "Applying default config..."
  make ${BUILD_FLAGS[*]} olddefconfig
  make ${BUILD_FLAGS[*]} -s kernelrelease > version
  echo "Prepared $pkgbase version $(<version)"

  ### Running make nconfig
  [[ -z "$_makenconfig" ]] ||  make  ${BUILD_FLAGS[*]}  nconfig

  ### Running make menuconfig
  [[ -z "$_makemenuconfig" ]] || make  ${BUILD_FLAGS[*]} menuconfig

  ### Running make xconfig
  [[ -z "$_makexconfig" ]] || make  ${BUILD_FLAGS[*]}  xconfig

  ### Running make gconfig
  [[ -z "$_makegconfig" ]] || make  ${BUILD_FLAGS[*]}  gconfig

  ### Save configuration for later reuse
  cp -Tf ./.config "${startdir}/config-${pkgver}-${pkgrel}${pkgbase#linux}"

}

build() {
  cd $_srcname

  make ${BUILD_FLAGS[*]} -j$(nproc) all
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
  install -Dm644 "$(make -s image_name)" "$modulesdir/vmlinuz"

  # Used by mkinitcpio to name the kernel
  echo "$pkgbase" | install -Dm644 /dev/stdin "$modulesdir/pkgbase"

  echo "Installing modules..."
  make INSTALL_MOD_PATH="$pkgdir/usr" INSTALL_MOD_STRIP=1 modules_install

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

sha512sums=('bfa8f7a4a742038ebf8f9a5b151554e268545543abca1ea1817fffcf388d6a5f3af3dce1c8279824af3938a9155f5a0d547edad334486d0fe78b7bdf3aef78f0'
            '4240fc839755694536d6010c30442b465ba88310292da8f682d03d5b34225681d2aabd6f5816c892a019d2088a1654d11a5df7fb5eea1afd86e23c68164bbb2e'
            'acb9340808c06776db13dfb35f7f5fab54f6344840655c7d6a1efdbef2d8299379f7b89e25a6bd1b6c7ff148d40fa587e16517bc665918d1fca58e8d9bd7f651'
            'aac8c0a1d2d9dfe37c98e5b83093394fae1f112569ddb8c23228f0e39a42f058ec8b2bb4cfb5303dae32a501cf1d0c918c0f5139a4a896962c7a223a9a52586b'
            '6700e4c440dedc078c349de7bd04a8100cdde5c48e7571be41e963fa497388e28e378883e6846da3eef8432e8bdade3d6efdf3822bc2c81e8965f3f64e568b9c'
            '1f9767a376d0c5da947bf56dfdcad30b2a829718bdcd7a252275da02a9f084545aebdbdadfc78dadc2b56ad280f0a37601999d276c31796a19a5d546f3e9604f'
            'd083ccd4493cf1cfe7cbcfaaa82ff57fb0732fa7881d6581709d35937674a7db31f79a8f265c82f978d1d50161886f93247b1b5136d7b5e61b31f1bbd28fd31c'
            'd800ad18b40f71a8509acca4d74d8ea9b4d24558665e40a558345403cbcb8a29096baf686158e55baf3d0a4a41a605033c09b162d00a810aa50d8d50785e4bc1'
            'd549caac984a68ff95c928ffb2055b1ed09f1b0bb0beeded731c4a9f391bf0923c50c1cdefa145cc116121e4746bb35f0b9d32814bad8da142f48b1ead293ab1'
            'f8e20fe34b058e8e554f653424ced37fefd004489689e6047def11cd463b594241432dd425b082d73a2646fe91531be9083a481b47cc784930991f78d9214529'
            'fe8e24e5df032af4fbb49039cedcd4642158f9529de84b7b3579a879b7bc7d6a69c38bcfbcbce6df81fad0e4eec6153fedfb4edfcc5312b874f9821a3cd8d1e8'
            '421e3eaa6a29846d33dfdadf2bd933fae1ec30ee6e83af3148aab40831498e1e4427d62c56f37a23ebbb93d88d184ef177476a448c6d3503459eba5bb6321d38'
            'ae8c5dcdfd672c3ec6cc2ec64d5ffcd57804dba047ca9eb39ed6878d8a150ee8fbe667f895b6e30c18e342d6e3a200d1c0215d959e2af85ad4945354a329c332'
            'eaa4cd53119a4afa94cfb4e0c2d8c555e8b85e72c3996713f1af583d2f66b5471dffe12e58624cb97fe2d88d6b3c6e112e906d5e052c199233ed433d47c24e79'
            '29bb6f3b5ef1232f9c3a34dee19c592f5f87ba8b06a020e840ba9c914953092ee987380cab9a92e233df5e2e1a6a8f211d49376ca4f7ae076b7a4f92749758b6'
            '208a3c21a143ff507d2cac0846ff44fa6934e3d6c42555160da3cf34542254bcedf98e64db60ee56f3fe670e62e26b1e0eff617f242e469b6784c77ede1b4c5d'
            '8b02b4f6983f8506e6ae0226167c68ac58d8ad7bcda145c13c41dcafe8d5a4395eebbdae8b24b7d27c4ed5bc4ae5dee287b719eb61d9bdb4861fb361e4db1f0c'
            '8887f2b8104fc9b1adf51e45dcc7df7ec217146c2fb11da0df377b26e259dea5fdef8fd254b7659e4af5c6628ccfeba641afc97cd81890a57797cf16fe6734e2'
            'db067c26ddb1ca78bc4a162064806749008ad2519d502c9db7218e387e3413d21bb0bfc24841e746230fcceb66fb5153dcb160414e5e9cafba9279af1fbdf041'
            '8de65480baaee268d36af1dad75d5bf83536909a08a3caa5a21c28cd0daf89c841a660dde471c8c12e3983f6a2a4abf21f11bb3b16f3bdf840f08c314c1c3f2c'
            '0b659eeb5abb3bf6c899af6e87e0c56f10c5901d44b702e9c9c2177dbb116fed4230ff00e702b3a0066bd9497f9ce6ceb624b477c15cc15094b2d26cfc119fb1'
            'e3d6e57b63f140d0bf8cc59b524276b52bbac38d37c92a2e163632e5688d7adefd971f42bab3126b736fecda2d8711134ab8271e5f118799c0a3146fa9f0dcb1'
            '7b7e857b5c72a5cad8be73bb0065268abc71b08df4cbc487a6a8468a6bedfa923a258c95fa97ea44c3c54ed89b52d15c7a74bde4d0171cd86d2a5921a96c15a8'
            'c1851ef3bdc256e2b6d608bba115d24677759f49d5776e6efbb27994093a5934f90c496a9446f5822cd9c045451a5f53ae253cb71bb4767dd8a608298638f4d1'
            'f8edc60ca3fcfb123d08fc2a3ba8b5dcd504e20e61500ba00268ce4486cfd9432e42192cdd35cd2d63db6fe02fcf8139886b80e0e10cb7b81f7f92ccf539483c'
            'e38e46893ccd68576525ab76726a0cffd3ae2d7c7b2961518a9b41c79eac254c1ceff649dd265c846cde8b383f3b9f0e625ba5b394bbc3a8f6a52745d7b4ffd8'
            'a1279dcb47ff3d43811c5dfca84a5b4edd6be87f012fa4e2c1a1f0c379e707bee67f23e6dd186be97f78cf1f45f781619db0382fc6aa0d5c42208ad77b95373e'
            'c60019fa4f598031c24845d80814c56cb9585765fa9536e12b3c2f975f721a67808c2bc14830a12af0aea69da122d5a0874b64119f2409d636800ee83eb09ce5'
            'ed7578ef6ba2f1bd17535a03e7750a1ae6e2d4cd7dbcfcd68484f12c6c9273467544dfadf86034d866d35eed152d37c6f576f069e301b69ddfc6b16613ad5a81'
            'f78f8860df7e26dd13ec0cd7b51b1c820886603ceefa38fbb0e3dc297773d04c89c958b244c899cced4d2f5dfbe8da5cf4b6c41d767dc7a7e3c94059101d6d40'
            'a54c01ba42e7d5f9433dacaa21f656d8aefdb6a5228fbca2b8e55b26eb02b35327ae3fd98a26a708452b8559e7f4acb32b6e685e26edc64497d1b7d10c5d86e1')

pkgname=("$pkgbase" "$pkgbase-headers")
for _p in "${pkgname[@]}"; do
  eval "package_$_p() {
             $(declare -f "_package${_p#$pkgbase}")
             _package${_p#$pkgbase}
  }"
done
