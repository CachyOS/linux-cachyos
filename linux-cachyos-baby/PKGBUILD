# Maintainer: Peter Jung ptr1337 <admin@ptr1337.dev>

### BUILD OPTIONS
# Set the next two variables to ANYTHING that is not null to enable them

## Choose which flavor of the baby scheduler, defailt is dl
# Available options:
# _sched_baby='dl'
# _sched_baby='vrt'
# _sched_baby='rr'
_sched_baby='dl'


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

### Running with a 2000 HZ, 1000HZ, 750Hz or  500HZ tick rate
_1k_HZ_ticks=
_803_HZ_ticks=y
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

## Samba3 Server
_ksmbd_enable=

# Tweak kernel options prior to a build via nconfig
_makenconfig=


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
_use_pgo=

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

if [ "$_sched_baby" = "dl" ] && [ -n "$_use_llvm_lto" ]; then
pkgbase=linux-cachyos-baby-dl-lto
elif  [ "$_sched_baby" = "vrt" ] && [ -n "$_use_llvm_lto" ]; then
pkgbase=linux-cachyos-cacule-baby-vrt-lto
elif  [ "$_sched_baby" = "rr" ] && [ -n "$_use_llvm_lto" ]; then
pkgbase=linux-cachyos-baby-rr-lto
elif [ "$_sched_baby" = "dl" ]; then
pkgbase=linux-cachyos-baby-dl
elif [ "$_sched_baby" = "vrt" ]; then
pkgbase=linux-cachyos-cacule-baby-vrt
elif [ "$_sched_baby" = "vrt" ]; then
pkgbase=linux-cachyos-baby-rr
fi
if [ "$_cpusched" = "cacule" ]  && [ -n "$_use_llvm_lto" ]; then
pkgbase=linux-cachyos-cacule-lto
elif  [ "$_cpusched" = "rdb" ] && [ -n "$_use_llvm_lto" ]; then
pkgbase=linux-cachyos-cacule-rdb-lto
elif [ "$_cpusched" = "cacule" ]; then
pkgbase=linux-cachyos-cacule
elif [ "$_cpusched" = "rdb" ]; then
pkgbase=linux-cachyos-cacule-rdb
fi
pkgver=5.14.11
pkgrel=3
arch=(x86_64 x86_64_v3)
pkgdesc='Linux-baby Kernel by CachyOS and with some other patches and other improvements'
#_gittag=v${pkgver%.*}-${pkgver##*.}
arch=('x86_64' 'x86_64_v3')
url="https://github.com/CachyOS/linux-cachyos"
license=('GPL2')
options=('!strip')
makedepends=('kmod' 'bc' 'libelf' 'python-sphinx' 'python-sphinx_rtd_theme'
             'graphviz' 'imagemagick' 'pahole' 'cpio' 'perl' 'tar' 'xz')
if [ -n "$_use_llvm_lto" ]; then
makedepends+=(clang llvm lld python)
fi
_patchsource="https://raw.githubusercontent.com/ptr1337/kernel-patches/master/5.14"
source=("https://cdn.kernel.org/pub/linux/kernel/v${pkgver:0:1}.x/linux-${pkgver}.tar.xz"
        "config"
#        "${_patchsource}/arch-patches/0001-ZEN-Add-sysctl-and-CONFIG-to-disallow-unprivileged-C.patch"
        "${_patchsource}/arch-patches-v10/0001-arch-patches.patch"
#        "${_patchsource}/0001-CK-TIMER.patch"
        "${_patchsource}/misc/amd/0006-amd-cppc.patch"
        "${_patchsource}/misc/0008-remove-LightNVM.patch"
        "${_patchsource}/ll-patches/0003-sched-core-nr_migrate-256-increases-number-of-tasks-.patch"
        "${_patchsource}/ll-patches/0004-mm-set-8-megabytes-for-address_space-level-file-read.patch"
        "${_patchsource}/android-patches/0001-android-export-symbold-and-enable-building-ashmem-an.patch"
        "${_patchsource}/bbr2-patches/0001-bbr2-5.14-introduce-BBRv2.patch"
        "${_patchsource}/block-patches/0001-block-patches.patch"
        "${_patchsource}/btrfs-patches-v7/0001-btrfs-patches.patch"
        "${_patchsource}/fixes-miscellaneous-v6/0001-fixes-miscellaneous.patch"
        "${_patchsource}/futex-xanmod-patches-v2/0001-futex-resync-from-gitlab.collabora.com.patch"
        "${_patchsource}/futex2-xanmod-patches-v2/0001-futex2-resync-from-gitlab.collabora.com.patch"
        "${_patchsource}/ksmbd-patches-v17/0001-ksmbd-patches.patch"
        "${_patchsource}/hwmon-patches/0001-hwmon-patches.patch"
        "${_patchsource}/lqx-patches/0001-lqx-patches.patch"
        "${_patchsource}/lrng-patches-v2/0001-lrng-patches.patch"
        "${_patchsource}/lru-patches-v4/0001-lru-patches.patch"
        "${_patchsource}/pf-patches-v9/0001-pf-patches.patch"
        "${_patchsource}/xanmod-patches-v2/0001-xanmod-patches.patch"
        "${_patchsource}/zen-patches-v3/0001-zen-patches.patch"
        "${_patchsource}/zstd-patches-v2/0001-zstd-patches.patch"
        "${_patchsource}/security-patches/0001-security-patches.patch"
        "${_patchsource}/zstd-dev-patches-v6/0001-zstd-dev-patches.patch"
        "${_patchsource}/ntfs3-patches-v14/0001-ntfs3-patches.patch"
        "${_patchsource}/0001-ksm.patch"
        "${_patchsource}/0001-cpu-patches.patch"
        "${_patchsource}/0001-winesync.patch"
        "${_patchsource}/0001-v4l2loopback.patch"
        "auto-cpu-optimization.sh"
        )


  if  [ "$_sched_baby" = "rr" ]; then
source+=("${_patchsource}/baby/baby-rr-5.14.patch")
md5sums+=("SKIP")
elif

[ "$_sched_baby" = "vrt" ]; then
  source+=("${_patchsource}/baby/baby-vrt-5.14.patch")
  md5sums+=("SKIP")
elif

[ "$_sched_baby" = "dl" ]; then
source+=("${_patchsource}/baby/baby-dl-5.14.patch")
md5sums+=("SKIP")


fi
  if [ -n "$_use_cfi" ]; then
source+=("${_patchsource}/0002-clang-cfi.patch")
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

            ### Optionally set tickrate to 803Hz
          if [ -n "$_803_HZ_ticks" ]; then
            echo "Setting tick rate to 803HZ..."
            scripts/config --disable CONFIG_HZ_300
            scripts/config --enable CONFIG_HZ_803
            scripts/config --set-val CONFIG_HZ 803
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

            ### Enable protect file mappings under memory pressure
            if [ -n "$_mm_protect" ]; then
              echo "Enabling protect file mappings under memory pressure..."
              scripts/config --enable CONFIG_UNEVICTABLE_FILE
              scripts/config --set-val CONFIG_UNEVICTABLE_FILE_KBYTES_LOW 262144
              scripts/config --set-val CONFIG_UNEVICTABLE_FILE_KBYTES_MIN 131072
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
    echo "Enable CFS ZENIFY"
  	scripts/config --enable CONFIG_ZEN_INTERACTIVE
   echo "Setting performance governor..."
   scripts/config --disable CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
   scripts/config --enable CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE
   scripts/config --enable CONFIG_CPU_FREQ_GOV_ONDEMAND
   scripts/config --enable CONFIG_CPU_FREQ_GOV_CONSERVATIVE
   scripts/config --enable CONFIG_CPU_FREQ_GOV_USERSPACE
   scripts/config --enable CONFIG_CPU_FREQ_GOV_SCHEDUTIL
   echo "Enable AMD PSTATE v3 driver"
   scripts/config --enable CONFIG_X86_AMD_PSTATe



  echo "Disable NUMA"
	if [ -n "$_NUMAdisable" ]; then
		echo "Disabling NUMA from kernel config..."
		scripts/config --disable CONFIG_NUMA
	fi

  echo "Change config for baby scheduler"
   scripts/config --enable CONFIG_HZ_PERIODIC
   scripts/config --disable CONFIG_NO_HZ_IDLE
   scripts/config --disable CONFIG_NO_HZ_FULL
   scripts/config --disable CONFIG_NO_HZ
   scripts/config --disable CONFIG_EXPERT
   scripts/config --disable CONFIG_DEBUG_KERNEL
   scripts/config --disable CONFIG_SCHED_DEBUG    #  duplicated config see line 151
   scripts/config --disable CONFIG_SCHEDSTATS
   scripts/config --disable NO_HZ
   scripts/config --disable SCHED_AUTOGROUP
   scripts/config --disable CGROUP_SCHED
   scripts/config --disable UCLAMP_TASK
   scripts/config --disable SCHED_CORE
   scripts/config --enable CONFIG_BS_SCHED
   scripts/config --disable CONFIG_HIGH_RES_TIMERS


   echo "Setting performance governor..."
   scripts/config --disable CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
   scripts/config --enable CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE
   scripts/config --enable CONFIG_CPU_FREQ_GOV_ONDEMAND
   scripts/config --enable CONFIG_CPU_FREQ_GOV_CONSERVATIVE
   scripts/config --enable CONFIG_CPU_FREQ_GOV_USERSPACE
   scripts/config --enable CONFIG_CPU_FREQ_GOV_SCHEDUTIL


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
        if [ -e "$HOME"/.config/modprobed.db ]; then
            echo "Running Steven Rostedt's make localmodconfig now"
            make ${BUILD_FLAGS[*]} LSMOD="$HOME"/.config/modprobed.db localmodconfig
        else
            echo "No modprobed.db data found"
            exit
        fi
    fi

    echo "Applying default config..."
    make ${BUILD_FLAGS[*]} olddefconfig
    make ${BUILD_FLAGS[*]} -s kernelrelease > version
    echo "Prepared $pkgbase version $(<version)"

    [[ -z "$_makenconfig" ]] || make ${BUILD_FLAGS[*]} nconfig

    ### Save configuration for later reuse
    cp -Tf ./.config "${startdir}/config-${pkgver}-${pkgrel}${pkgbase#linux}"
}

build() {
  cd "${srcdir:?}/linux-${pkgver}" || (
    echo -e "\E[1;31mCan't cd to ${srcdir:?}/linux-${pkgver} directory! Build failed! \E[0m"
    exit 1
  )
    make ${BUILD_FLAGS[*]} -j$(nproc) all
}

_package() {
    pkgdesc="The $pkgdesc kernel and modules"
    depends=('coreutils' 'kmod' 'initramfs')
    optdepends=('crda: to set the correct wireless channels of your country'
                'linux-firmware: firmware images needed for some devices'
                'modprobed-db: Keeps track of EVERY kernel module that has ever been probed - useful for those of us who make localmodconfig')
    provides=(VIRTUALBOX-GUEST-MODULES WIREGUARD-MODULE)

  cd "${srcdir:?}/linux-${pkgver}" || (
    echo -e "\E[1;31mCan't cd to ${srcdir:?}/linux-${pkgver} directory! Package linux kernel failed! \E[0m"
    exit 1
  )

  local kernver="$(<version)"
  local modulesdir="${pkgdir:?}/usr/lib/modules/$kernver"

  echo "Installing boot image..."
  # systemd expects to find the kernel here to allow hibernation
  # https://github.com/systemd/systemd/commit/edda44605f06a41fb86b7ab8128dcf99161d2344
  install -Dm644 "$(make -s image_name)" "${modulesdir}/vmlinuz"

  # Used by mkinitcpio to name the kernel
  echo "${pkgbase}" | install -Dm644 /dev/stdin "${modulesdir}/pkgbase"

  echo "Installing modules..."
  make ${BUILD_FLAGS[*]} INSTALL_MOD_PATH="${pkgdir:?}/usr" INSTALL_MOD_STRIP=1 modules_install

  # remove build and source links
  rm "${modulesdir}/"{source,build}

}

_package-headers() {
  pkgdesc="Headers and scripts for building modules for the ${pkgdesc}"
  depends=("${pkgbase}=${pkgver}" "pahole")

  cd "${srcdir:?}/linux-${pkgver}" || (
    echo -e "\E[1;31mCan't cd to ${srcdir:?}/linux-${pkgver} directory! Package linux headers failed! \E[0m"
    exit 1
  )

  local builddir="${pkgdir:?}/usr/lib/modules/$(<version)/build"

  echo "Installing build files..."
  install -Dt "${builddir}" -m644 .config Makefile Module.symvers System.map \
    localversion.* version vmlinux
  install -Dt "${builddir}/kernel" -m644 kernel/Makefile
  install -Dt "${builddir}/arch/x86" -m644 arch/x86/Makefile
  cp -t "${builddir}" -a scripts

  # add objtool for external module building and enabled VALIDATION_STACK option
  install -Dt "${builddir}/tools/objtool" tools/objtool/objtool

  # add xfs and shmem for aufs building
  mkdir -p "${builddir}"/{fs/xfs,mm}

  echo "Installing headers..."
  cp -t "${builddir}" -a include
  cp -t "${builddir}/arch/x86" -a arch/x86/include
  install -Dt "${builddir}/arch/x86/kernel" -m644 arch/x86/kernel/asm-offsets.s

  install -Dt "${builddir}/drivers/md" -m644 drivers/md/*.h
  install -Dt "${builddir}/net/mac80211" -m644 net/mac80211/*.h

  # https://bugs.archlinux.org/task/13146
  install -Dt "${builddir}/drivers/media/i2c" -m644 drivers/media/i2c/msp3400-driver.h

  # https://bugs.archlinux.org/task/20402
  install -Dt "${builddir}/drivers/media/usb/dvb-usb" -m644 drivers/media/usb/dvb-usb/*.h
  install -Dt "${builddir}/drivers/media/dvb-frontends" -m644 drivers/media/dvb-frontends/*.h
  install -Dt "${builddir}/drivers/media/tuners" -m644 drivers/media/tuners/*.h

  # https://bugs.archlinux.org/task/71392
  install -Dt "${builddir}/drivers/iio/common/hid-sensors" -m644 drivers/iio/common/hid-sensors/*.h

  echo "Installing KConfig files..."
  find . -name 'Kconfig*' -exec install -Dm644 {} "${builddir}/{}" \;

  echo "Removing unneeded architectures..."
  local arch
  for arch in "${builddir}"/arch/*/; do
    [[ $arch = */x86/ ]] && continue
    echo "Removing $(basename "$arch")"
    rm -r "$arch"
  done

  echo "Removing documentation..."
  rm -r "${builddir}/Documentation"

  echo "Removing broken symlinks..."
  find -L "${builddir}" -type l -printf 'Removing %P\n' -delete

  echo "Removing loose objects..."
  find "${builddir}" -type f -name '*.o' -printf 'Removing %P\n' -delete

  echo "Stripping build tools..."
  local file
  while read -rd '' file; do
    case "$(file -bi "$file")" in
    application/x-sharedlib\;*) # Libraries (.so)
      strip -v "${STRIP_SHARED}" "$file" ;;
    application/x-archive\;*) # Libraries (.a)
      strip -v "${STRIP_STATIC}" "$file" ;;
    application/x-executable\;*) # Binaries
      strip -v "${STRIP_BINARIES}" "$file" ;;
    application/x-pie-executable\;*) # Relocatable binaries
      strip -v "${STRIP_SHARED}" "$file" ;;
    esac
  done < <(find "${builddir}" -type f -perm -u+x ! -name vmlinux -print0)

  echo "Stripping vmlinux..."
  strip -v "${STRIP_STATIC}" "${builddir}/vmlinux"

  echo "Adding symlink..."
  mkdir -p "${pkgdir:?}/usr/src"
  ln -sr "${builddir}" "${pkgdir:?}/usr/src/${pkgbase}"

}

md5sums=('0eba0d3a75f56ddbbb0f4265b35724c3'
         'd93835cc970f8c135609081fec836139'
         '581faf85cd625c41bbdd0cadbd0e451e'
         '430972ae1e936f99d8dc2a1f4fdaf774'
         'eb39a5681a153f5a1f5a67e8b9e957a5'
         'af7328eb8c72c754e5bc8c7be1ca2f1c'
         'f0d84fc024b9933bc19db696e0393a4e'
         'e45c7962a78d6e82a0d3808868cd6ac0'
         '196d6ac961497aa880264b83160eb140'
         'a3f2cbf318dd2a63af9673f9e34e7125'
         'cb9f92bf2ce143d5552dc89b037fb1f7'
         'f364618bad6154856085c7025d388d3b'
         'fd934f7d11131d5a5043e4aea640583b'
         '8a96c5e8346bd5b430776ac8a41f96b0'
         'f71331c247285499ca42b63d707831a6'
         'bad682a72d2549f409caea361fb0456f'
         '6787c78ba3e7b0a34fbba9c50da7e3b4'
         '366c90b64f9582c0733b8fb607a07594'
         '8adcaccbb5c0ebd4bc81144e16b92627'
         '607228871a4127c31baae7b1d66866bc'
         '28864f14bf33bad92e57bc48bc5c2c78'
         'cfef1423ad1e6aecad63f0d5eacaea37'
         '808981a36c81165953017e5e432c1fa1'
         'f6a1c51adfc68fb7b52dc5715a9cb5a7'
         '97d9c9da437152c2f1161e5da5b5d7d4'
         '0636779d32ba47bda25d3edb5fbd08c9'
         '566435a0444ee45816599f2e0e362c7a'
         'bb22330e270bf36ccf53cb04d6b496d2'
         '4c493a3e0f3486be8ad1b6c67c9c6917'
         '95eb4457f95f3f8dd153983612ee65c0'
         '21c98f19e883879dd3336c1fa143fd31'
         '63ee6ec75b8867b24a573bbb5e413623')

pkgname=("$pkgbase" "$pkgbase-headers" )
      for _p in "${pkgname[@]}"; do
            eval "package_$_p() {
              $(declare -f "_package${_p#$pkgbase}")
              _package${_p#$pkgbase}
                    }"
            done
