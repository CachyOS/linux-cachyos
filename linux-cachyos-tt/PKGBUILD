# Maintainer: Peter Jung ptr1337 <admin@ptr1337.dev> && Piotr Gorski <piotrgorski@cachyos.org>
# Contributor: Jan Alexander Steffens (heftig) <jan.steffens@gmail.com>
# Contributor: Tobias Powalowski <tpowa@archlinux.org>
# Contributor: Thomas Baechler <thomas@archlinux.org>

### Selecting CachyOS config
# ATTENTION - one of two predefined values should be selected!
# 'yes' - enable CachyOS config
# 'no' - disable CachyOS config
_cachy_config=${_cachy_config-'yes'}

### Selecting the CPU scheduler
# ATTENTION - one of seven predefined values should be selected!
# 'bmq' - select 'BitMap Queue CPU scheduler'
# 'pds' - select 'Priority and Deadline based Skip list multiple queue CPU scheduler'
# 'cacule' - select 'CacULE scheduler'
# 'cacule-rdb' - select 'CacULE-RDB scheduler'
# 'bore' - select 'Burst-Oriented Response Enhancer'
# 'cfs' - select 'Completely Fair Scheduler'
# 'tt' - select 'Task Type Scheduler by Hamad Marri'
# 'hardened' - select 'BORE Scheduler hardened' ## kernel with hardened config and hardening patches with the bore scheduler
_cpusched=${_cpusched-'tt'}

## Apply some suggested sysctl values from the bore developer
## These are adjusted to BORE
_tune_bore=${_tune_bore-}

### BUILD OPTIONS
# Set these variables to ANYTHING that is not null to enable them

### Tweak kernel options prior to a build via nconfig
_makenconfig=${_makenconfig-}

### Tweak kernel options prior to a build via menuconfig
_makemenuconfig=${_makemenuconfig-}

### Tweak kernel options prior to a build via xconfig
_makexconfig=${_makexconfig-}

### Tweak kernel options prior to a build via gconfig
_makegconfig=${_makegconfig-}

# NUMA is optimized for multi-socket motherboards.
# A single multi-core CPU actually runs slower with NUMA enabled.
# See, https://bugs.archlinux.org/task/31187
_NUMAdisable=${_NUMAdisable-}

# Compile ONLY used modules to VASTLYreduce the number of modules built
# and the build time.
#
# To keep track of which modules are needed for your specific system/hardware,
# give module_db script a try: https://aur.archlinux.org/packages/modprobed-db
# This PKGBUILD read the database kept if it exists
#
# More at this wiki page ---> https://wiki.archlinux.org/index.php/Modprobed-db
_localmodcfg=${_localmodcfg-}

# Use the current kernel's .config file
# Enabling this option will use the .config of the RUNNING kernel rather than
# the ARCH defaults. Useful when the package gets updated and you already went
# through the trouble of customizing your config options.  NOT recommended when
# a new kernel is released, but again, convenient for package bumps.
_use_current=${_use_current-}

### Enable KBUILD_CFLAGS -O3
_cc_harder=${_cc_harder-y}

### Set this to your number of threads you have in your machine otherwise it will default to 128
_nr_cpus=${_nr_cpus-}

### Set performance governor as default
_per_gov=${_per_gov-y}

### Enable TCP_CONG_BBR2
_tcp_bbr2=${_tcp_bbr2-y}

### Running with a 1000HZ, 750Hz, 600 Hz, 500Hz, 300Hz, 250Hz and 100Hz tick rate
_HZ_ticks=${_HZ_ticks-1000}

## Choose between perodic, idle or full
### Full tickless can give higher performances in various cases but, depending on hardware, lower consistency.
_tickrate=${_tickrate-full}

## Choose between full(low-latency), voluntary or server
_preempt=${_preempt-full}

### Disable MQ-Deadline I/O scheduler
_mq_deadline_disable=${_mq_deadline_disable-y}

### Disable Kyber I/O scheduler
_kyber_disable=${_kyber_disable-y}

### Enable multigenerational LRU
# ATTENTION - one of three predefined values should be selected!
# 'standard' - enable multigenerational LRU
# 'stats' - enable multigenerational LRU with stats
# 'none' - disable multigenerational LRU
_lru_config=${_lru_config-'standard'}

## Enable DAMON
_damon=${_damon-}

## Enable Linux Random Number Generator
_lrng_enable=${_lrng_enable-}

# CPU compiler optimizations - Defaults to prompt at kernel config if left empty
# AMD CPUs : "k8" "k8sse3" "k10" "barcelona" "bobcat" "jaguar" "bulldozer" "piledriver" "steamroller" "excavator" "zen" "zen2" "zen3"
# Intel CPUs : "mpsc"(P4 & older Netburst based Xeon) "atom" "core2" "nehalem" "westmere" "silvermont" "sandybridge" "ivybridge" "haswell" "broadwell" "skylake" "skylakex" "cannonlake" "icelake" "goldmont" "goldmontplus" "cascadelake" "cooperlake" "tigerlake" "sapphirerapids" "rocketlake" "alderlake"
# Other options :
# - "native_amd" (use compiler autodetection - Selecting your arch manually in the list above is recommended instead of this option)
# - "native_intel" (use compiler autodetection and will prompt for P6_NOPS - Selecting your arch manually in the list above is recommended instead of this option)
# - "generic" (kernel's default - to share the package between machines with different CPU µarch as long as they are x86-64)
#
# Or use the _use_auto_optimization with _use_auto_optimization=y
_processor_opt=${_processor_opt-}

_use_auto_optimization=${_use_auto_optimization-y}

# disable debug to lower the size of the kernel
_disable_debug=${_disable_debug-}

## Enable zram/zswap ZSTD compression
_zstd_compression=${_zstd_compression-y}

### Selecting the ZSTD kernel and modules compression level
# ATTENTION - one of two predefined values should be selected!
# 'ultra' - highest compression ratio
# 'normal' - standard compression ratio
# WARNING: the ultra settings can sometimes
# be counterproductive in both size and speed.
_zstd_level_value=${_zstd_level_value-'normal'}

# Clang LTO mode, only available with the "llvm" compiler - options are "no", "full" or "thin".
# "full: uses 1 thread for Linking, slow and uses more memory, theoretically with the highest performance gains."
# "thin: uses multiple threads, faster and uses less memory, may have a lower runtime performance than Full."
_use_llvm_lto=${_use_llvm_lto-}

# Use suffix -lto only when requested by the user
# Enabled by default.
# If you do not want the suffix -lto remove the "y" sign next to the flag.
# https://github.com/CachyOS/linux-cachyos/issues/36
_use_lto_suffix=${_use_lto_suffix-y}

# ATTENTION!: Really experimental LTO implementation for GCC
# This can improve the performance of the kernel
# The performance difference is currently negligible
# DEBUG and BTF needs to be disabled, otherwise the compilation is failing
# The Kernel is bigger with GCC LTO due to more inlining
# More informations:
# https://lore.kernel.org/lkml/20221114114344.18650-1-jirislaby@kernel.org/T/#md8014ad799b02221b67f33584002d98ede6234eb
_use_gcc_lto=${_use_gcc_lto-}

# KCFI is a proposed forward-edge control-flow integrity scheme for
# Clang, which is more suitable for kernel use than the existing CFI
# scheme used by CONFIG_CFI_CLANG. kCFI doesn't require LTO, doesn't
# alter function references to point to a jump table, and won't break
# function address equality.
# ATTENTION!: You need llvm-git or a patched llvm 15
# ATTENTION!: This is experimental, could fail to boot with nvidia
_use_kcfi=${_use_kcfi-}

# Build the zfs module in to the kernel
_build_zfs=${_build_zfs-}

# Enable bcachefs
_bcachefs=${_bcachefs-}

# Enable LATENCY NICE
# Latency nice is a approach to sets latency-nice as a per-task attribute
# It can improve the latency of applications similar to sched_nice, but focused on the latency
# You need to set the values per task
# Ananicy-cpp has a experimental implementation for this
# It converts sched_nice to latency_nice and set this per task
# You need to configure ananicy-cpp for this or use existing settings
# If you want to test it, use the following branch
# https://gitlab.com/ananicy-cpp/ananicy-cpp/-/tree/feature/latency-nice
_latency_nice=${_latency_nice-}

if [[ -n "$_use_llvm_lto" && -n "$_use_lto_suffix" ]]; then
    pkgsuffix=cachyos-${_cpusched}-lto
    pkgbase=linux-$pkgsuffix

else
    pkgsuffix=cachyos-${_cpusched}
    pkgbase=linux-$pkgsuffix
fi
_major=6.1
_minor=1
#_minorc=$((_minor+1))
#_rcver=rc8
pkgver=${_major}.${_minor}
_stable=${_major}.${_minor}
#_stable=${_major}
#_stablerc=${_major}-${_rcver}
_srcname=linux-${_stable}
#_srcname=linux-${_major}
pkgdesc='Linux TT scheduler Kernel by CachyOS with other patches and improvements'
pkgrel=1
_kernver=$pkgver-$pkgrel
arch=('x86_64' 'x86_64_v3')
url="https://github.com/CachyOS/linux-cachyos"
license=('GPL2')
options=('!strip')
makedepends=('bc' 'libelf' 'pahole' 'cpio' 'perl' 'tar' 'xz' 'zstd' 'gcc' 'gcc-libs' 'glibc' 'binutils' 'make' 'patch')
# LLVM makedepends
if [ -n "$_use_llvm_lto" ]; then
    makedepends+=(clang llvm lld python)
    BUILD_FLAGS=(
        CC=clang
        LD=ld.lld
        LLVM=1
        LLVM_IAS=1
    )
fi
# ZFS makedepends
if [ -n "$_build_zfs" ]; then
    makedepends+=(git)

fi
_patchsource="https://raw.githubusercontent.com/cachyos/kernel-patches/master/${_major}"
source=(
    "https://cdn.kernel.org/pub/linux/kernel/v${pkgver%%.*}.x/${_srcname}.tar.xz"
    "config"
    "auto-cpu-optimization.sh"
    "${_patchsource}/all/0001-cachyos-base-all.patch")
## ZFS Support
if [ -n "$_build_zfs" ]; then
    source+=("git+https://github.com/cachyos/zfs.git#commit=21bd7661334cd865d17934bebbcaf8d3356279ee")
fi
## Latency NICE Support
if [ -n "$_latency_nice" ]; then
    if [[ "$_cpusched" = "bore"  || "$_cpusched" = "cfs" || "$_cpusched" = "hardened" ]]; then
         source+=("${_patchsource}/misc/0001-Add-latency-priority-for-CFS-class.patch")
    fi
fi
## BMQ Scheduler
if [ "$_cpusched" = "bmq" ]; then
    source+=("${_patchsource}/sched/0001-prjc-cachy.patch")
fi
## PDS Scheduler
if [ "$_cpusched" = "pds" ]; then
    source+=("${_patchsource}/sched/0001-prjc-cachy.patch")
fi
## BORE Scheduler with latency_nice
if [ "$_cpusched" = "bore" ]; then
    source+=("${_patchsource}/sched/0001-bore-cachy.patch")
## BORE SYSCTL TUNING
   if [ -n "$_tune_bore" ]; then
		source+=("${_patchsource}/misc/0001-bore-tuning-sysctl.patch")
   fi
fi
## CacULE Scheduler
if [ "$_cpusched" = "cacule" ]; then
    source+=("${_patchsource}/sched/0001-cacULE-cachy.patch")
fi
## CacULE-RDB Scheduler
if [ "$_cpusched" = "cacule-rdb" ]; then
    source+=("${_patchsource}/sched/0001-cacULE-cachy.patch")
fi
## TT Scheduler
if [ "$_cpusched" = "tt" ]; then
    source+=("${_patchsource}/sched/0001-tt-cachy.patch")
fi
## Hardened Patches with BORE Scheduler
if [ "$_cpusched" = "hardened" ]; then
    source+=("${_patchsource}/sched/0001-bore-cachy.patch"
         "${_patchsource}/misc/0001-hardened.patch")
fi
## Kernel CFI Patch
if [ -n "$_use_kcfi" ]; then
    BUILD_FLAGS=(
        CC=clang
        LD=ld.lld
        LLVM=1
    )
fi
## bcachefs Support
if [ -n "$_bcachefs" ]; then
    source+=("${_patchsource}/misc/0001-bcachefs-after-lru.patch")
fi
if [ -n "$_use_gcc_lto" ]; then
## GCC-LTO Patch
## Fix for current gcc --enable-default-pie option
    source+=("${_patchsource}/misc/gcc-lto/0001-gcc-LTO-support-for-the-kernel.patch"
             "${_patchsource}/misc/gcc-lto/0002-gcc-lto-no-pie.patch")
fi

export KBUILD_BUILD_HOST=cachyos
export KBUILD_BUILD_USER=$pkgbase
export KBUILD_BUILD_TIMESTAMP="$(date -Ru${SOURCE_DATE_EPOCH:+d @$SOURCE_DATE_EPOCH})"

prepare() {

    cd ${srcdir}/$_srcname

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

    ### Select CPU optimization
    if [ -n "$_processor_opt" ]; then
        MARCH=$(echo $_processor_opt|tr '[:lower:]' '[:upper:]'&&echo)
        MARCH2=M${MARCH}
        scripts/config -k --disable CONFIG_GENERIC_CPU
        scripts/config -k --enable CONFIG_${MARCH2}
    fi

    ### Use autooptimization
    if [ -n "$_use_auto_optimization" ]; then
        "${srcdir}"/auto-cpu-optimization.sh
    fi

    ### Selecting CachyOS config
    if [ "$_cachy_config" = "yes" ]; then
        echo "Enabling CachyOS config..."
        scripts/config --enable CACHY
    elif [ "$_cachy_config" = "no" ]; then
       echo "Disabling CachyOS config..."
       scripts/config --disable CACHY
    else
       if [ -n "$_cachy_config" ]; then
           error "The value $_cachy_config is invalid. Choose the correct one again."
       else
           error "The value is empty. Choose the correct one again."
       fi
       error "Selecting CachyOS config failed!"
       exit
    fi

    ### Selecting the CPU scheduler
    if [ "$_cpusched" = "bmq" ]; then
        echo "Selecting BMQ CPU scheduler..."
        scripts/config --enable SCHED_ALT \
            --enable SCHED_BMQ \
            --disable SCHED_PDS
    elif [ "$_cpusched" = "pds" ]; then
        echo "Selecting PDS CPU scheduler..."
        scripts/config --enable SCHED_ALT \
            --disable SCHED_BMQ \
            --enable SCHED_PDS
    elif [ "$_cpusched" = "cacule" ]; then
        echo "Selecting CacULE scheduler..."
        scripts/config --enable CACULE_SCHED \
            --disable CACULE_RDB
    elif [ "$_cpusched" = "cacule-rdb" ]; then
        echo "Selecting CacULE-RDB scheduler..."
        scripts/config --enable CACULE_SCHED \
            --enable CACULE_RDB \
            --set-val RDB_INTERVAL 19
    elif [ "$_cpusched" = "bore" ]; then
        echo "Selecting BORE Scheduler..."
        scripts/config --enable SCHED_BORE
    elif [ "$_cpusched" = "tt" ]; then
        echo "Selecting TT Scheduler..."
        scripts/config --enable TT_SCHED \
            --enable TT_ACCOUNTING_STATS
    elif [ "$_cpusched" = "cfs" ]; then
        echo "Selecting Completely Fair Scheduler..."
    elif [ "$_cpusched" = "hardened" ]; then
        echo "Selecting hardened patches with the BORE Scheduler..."
    else
        if [ -n "$_cpusched" ]; then
            error "The value $_cpusched is invalid. Choose the correct one again."
        else
            error "The value is empty. Choose the correct one again."
        fi
        error "Selecting the CPU scheduler failed!"
        exit
    fi

    ### Enable KCFI
    if [ -n "$_use_kcfi" ]; then
        echo "Enabling kCFI"
        scripts/config --enable ARCH_SUPPORTS_CFI_CLANG \
            --enable CFI_CLANG
    fi

    ### Select LLVM level
    if [ "$_use_llvm_lto" = "thin" ]; then
        echo "Enabling LLVM THIN LTO..."
        scripts/config --enable LTO \
            --enable LTO_CLANG \
            --enable ARCH_SUPPORTS_LTO_CLANG \
            --enable ARCH_SUPPORTS_LTO_CLANG_THIN \
            --disable LTO_NONE \
            --enable HAS_LTO_CLANG \
            --disable LTO_CLANG_FULL \
            --enable LTO_CLANG_THIN \
            --enable HAVE_GCC_PLUGINS
    elif [ "$_use_llvm_lto" = "full" ]; then
        echo "Enabling LLVM FULL LTO..."
        scripts/config --enable LTO \
            --enable LTO_CLANG \
            --enable ARCH_SUPPORTS_LTO_CLANG \
            --enable ARCH_SUPPORTS_LTO_CLANG_THIN \
            --disable LTO_NONE \
            --enable HAS_LTO_CLANG \
            --enable LTO_CLANG_FULL \
            --disable LTO_CLANG_THIN \
            --enable HAVE_GCC_PLUGINS
    else
        scripts/config --enable LTO_NONE
    fi

    ### Enable GCC FULL LTO
    ### Disable LTO_CP_CLONE, its experimental
    if [ -n "$_use_gcc_lto" ]; then
         scripts/config --enable LTO_GCC \
            --disable LTO_CP_CLONE
    ### Disable DEBUG, pahole is currently broken with GCC LTO
            _disable_debug=y
    fi

    ### Select tick rate
    if [ "$_HZ_ticks" = "1000" ]; then
        echo "Setting tick rate to 1k Hz..."
        scripts/config --disable HZ_300 \
            --enable HZ_1000 \
            --set-val HZ 1000
    elif [ "$_HZ_ticks" = "750" ]; then
        echo "Setting tick rate to 750Hz..."
        scripts/config --disable HZ_300 \
            --enable HZ_750 \
            --set-val HZ 750
    elif [ "$_HZ_ticks" = "600" ]; then
        echo "Setting tick rate to 600Hz..."
        scripts/config --disable HZ_300 \
            --enable HZ_600 \
            --set-val HZ 600
    elif [ "$_HZ_ticks" = "500" ]; then
        echo "Setting tick rate to 500Hz..."
        scripts/config --disable HZ_300 \
            --enable HZ_500 \
            --set-val HZ 500
    elif [ "$_HZ_ticks" = "300" ]; then
        echo "Setting tick rate to 300Hz..."
        scripts/config --enable HZ_300 \
            --set-val HZ 300
    elif [ "$_HZ_ticks" = "250" ]; then
        echo "Setting tick rate to 250Hz..."
        scripts/config --disable HZ_300 \
            --enable HZ_250 \
            --set-val HZ 250
    elif [ "$_HZ_ticks" = "100" ]; then
        echo "Setting tick rate to 100Hz..."
        scripts/config --disable HZ_300 \
            --enable HZ_100 \
            --set-val HZ 100
    else
       if [ -n "$_HZ_ticks" ]; then
           error "The value $_HZ_ticks is invalid. Choose the correct one again."
       else
           error "The value is empty. Choose the correct one again."
       fi
       error "Selecting Setting tick rate failed!"
       exit
    fi

    ### Disable NUMA
    if [ -n "$_NUMAdisable" ]; then
        echo "Disabling NUMA from kernel config..."
        scripts/config --disable NUMA \
            --disable AMD_NUMA \
            --disable X86_64_ACPI_NUMA \
            --disable NODES_SPAN_OTHER_NODES \
            --disable NUMA_EMU \
            --disable NEED_MULTIPLE_NODES \
            --disable USE_PERCPU_NUMA_NODE_ID \
            --disable ACPI_NUMA \
            --disable ARCH_SUPPORTS_NUMA_BALANCING \
            --disable NODES_SHIFT \
            --undefine NODES_SHIFT \
            --disable NEED_MULTIPLE_NODES
    fi

    ### Setting NR_CPUS
    if [ -n "$_nr_cpus" ]; then
        echo "Setting custom NR_CPUS..."
        scripts/config --set-val NR_CPUS "$_nr_cpus"
    else
        echo "Setting default NR_CPUS..."
        scripts/config --set-val NR_CPUS 128
    fi

    ### Disable MQ Deadline I/O scheduler
    if [ -n "$_mq_deadline_disable" ]; then
        echo "Disabling MQ-Deadline I/O scheduler..."
        scripts/config --disable MQ_IOSCHED_DEADLINE
    fi

    ### Disable Kyber I/O scheduler
    if [ -n "$_kyber_disable" ]; then
        echo "Disabling Kyber I/O scheduler..."
        scripts/config --disable MQ_IOSCHED_KYBER
    fi

    ### Select performance governor
    if [ -n "$_per_gov" ]; then
        echo "Setting performance governor..."
        scripts/config --disable CPU_FREQ_DEFAULT_GOV_SCHEDUTIL \
            --enable CPU_FREQ_DEFAULT_GOV_PERFORMANCE
    fi

    ### Select tick type
    if [ "$_tickrate" = "periodic" ]; then
        echo "Enabling periodic ticks..."
        scripts/config --disable NO_HZ_IDLE \
            --disable NO_HZ_FULL \
            --disable NO_HZ \
            --disable NO_HZ_COMMON \
            --enable HZ_PERIODIC
    elif [ "$_tickrate" = "idle" ]; then
        echo "Enabling idle ticks.."
        scripts/config --disable HZ_PERIODIC \
            --disable NO_HZ_FULL \
            --enable NO_HZ_IDLE \
            --enable NO_HZ \
            --enable NO_HZ_COMMON
    elif [ "$_tickrate" = "full" ]; then
        echo "Enabling full ticks..."
        scripts/config --disable HZ_PERIODIC \
            --disable NO_HZ_IDLE \
            --disable CONTEXT_TRACKING_FORCE \
            --enable NO_HZ_FULL_NODEF \
            --enable NO_HZ_FULL \
            --enable NO_HZ \
            --enable NO_HZ_COMMON \
            --enable CONTEXT_TRACKING
    else
        if [ -n "$_tickrate" ]; then
            error "The value $_tickrate is invalid. Choose the correct one again."
        else
            error "The value is empty. Choose the correct one again."
        fi
        error "Selecting the tick rate failed!"
        exit
    fi

    ### Select preempt type
    if [ "$_preempt" = "full" ]; then
        echo "Enabling low latency preempt..."
        scripts/config --enable PREEMPT_BUILD \
            --disable PREEMPT_NONE \
            --disable PREEMPT_VOLUNTARY \
            --enable PREEMPT \
            --enable PREEMPT_COUNT \
            --enable PREEMPTION \
            --enable PREEMPT_DYNAMIC
    elif [ "$_preempt" = "voluntary" ]; then
        echo "Enabling voluntary preempt..."
        scripts/config --enable PREEMPT_BUILD \
            --disable PREEMPT_NONE \
            --enable PREEMPT_VOLUNTARY \
            --disable PREEMPT \
            --enable PREEMPT_COUNT \
            --enable PREEMPTION \
            --disable PREEMPT_DYNAMIC
    elif [ "$_preempt" = "server" ]; then
        echo "Enabling server preempt..."
        scripts/config --enable PREEMPT_NONE_BUILD \
            --enable PREEMPT_NONE \
            --disable PREEMPT_VOLUNTARY \
            --disable PREEMPT \
            --disable PREEMPT_COUNT \
            --disable PREEMPTION \
            --disable PREEMPT_DYNAMIC
    else
        if [ -n "$_preempt" ]; then
            error "The value $_preempt is invalid. Choose the correct one again."
        else
            error "The value is empty. Choose the correct one again."
        fi
        error "Selecting PREEMPT failed!"
        exit
    fi

    ### Enable O3
    if [ -n "$_cc_harder" ]; then
        echo "Enabling KBUILD_CFLAGS -O3..."
        scripts/config --disable CC_OPTIMIZE_FOR_PERFORMANCE \
            --enable CC_OPTIMIZE_FOR_PERFORMANCE_O3
    fi

    ### Enable bbr2
    if [ -n "$_tcp_bbr2" ]; then
        echo "Disabling TCP_CONG_CUBIC..."
        scripts/config --module TCP_CONG_CUBIC \
            --disable DEFAULT_CUBIC \
            --enable TCP_CONG_BBR2 \
            --enable DEFAULT_BBR2 \
            --set-str DEFAULT_TCP_CONG bbr2
    fi

   ### Select LRU config
    if [ "$_lru_config" = "standard" ]; then
       echo "Enabling multigenerational LRU..."
       scripts/config --enable LRU_GEN \
           --enable LRU_GEN_ENABLED \
           --disable LRU_GEN_STATS
    elif [ "$_lru_config" = "stats" ]; then
       echo "Enabling multigenerational LRU with stats..."
       scripts/config --enable LRU_GEN \
           --enable LRU_GEN_ENABLED \
           --enable LRU_GEN_STATS
    elif [ "$_lru_config" = "none" ]; then
       echo "Disabling multigenerational LRU..."
       scripts/config --disable LRU_GEN
    else
        if [ -n "$_lru_config" ]; then
           error "The value $_lru_config is invalid. Choose the correct one again."
        else
           error "The value is empty. Choose the correct one again."
        fi
         error "Enabling multigenerational LRU failed!"
         exit
    fi

    ### Enable DAMON
    if [ -n "$_damon" ]; then
        echo "Enabling DAMON..."
        scripts/config --enable DAMON \
            --enable DAMON_VADDR \
            --enable DAMON_DBGFS \
            --enable DAMON_SYSFS \
            --enable DAMON_PADDR \
            --enable DAMON_RECLAIM \
            --enable DAMON_LRU_SORT
    fi

    ### Enable LRNG
    if [ -n "$_lrng_enable" ]; then
        echo "Enabling Linux Random Number Generator ..."
        scripts/config --disable RANDOM_DEFAULT_IMPL \
            --enable LRNG \
            --enable LRNG_SHA256 \
            --enable LRNG_COMMON_DEV_IF \
            --enable LRNG_DRNG_ATOMIC \
            --enable LRNG_SYSCTL \
            --enable LRNG_RANDOM_IF \
            --enable LRNG_AIS2031_NTG1_SEEDING_STRATEGY \
            --module LRNG_KCAPI_IF \
            --module LRNG_HWRAND_IF \
            --enable LRNG_DEV_IF \
            --enable LRNG_RUNTIME_ES_CONFIG \
            --enable LRNG_IRQ_DFLT_TIMER_ES \
            --disable LRNG_SCHED_DFLT_TIMER_ES \
            --enable LRNG_TIMER_COMMON \
            --disable LRNG_COLLECTION_SIZE_256 \
            --disable LRNG_COLLECTION_SIZE_512 \
            --enable LRNG_COLLECTION_SIZE_1024 \
            --disable LRNG_COLLECTION_SIZE_2048 \
            --disable LRNG_COLLECTION_SIZE_4096 \
            --disable LRNG_COLLECTION_SIZE_8192 \
            --set-val LRNG_COLLECTION_SIZE 1024 \
            --enable LRNG_HEALTH_TESTS \
            --set-val LRNG_RCT_CUTOFF 31 \
            --set-val LRNG_APT_CUTOFF 325 \
            --enable LRNG_IRQ \
            --enable LRNG_CONTINUOUS_COMPRESSION_ENABLED \
            --disable LRNG_CONTINUOUS_COMPRESSION_DISABLED \
            --enable LRNG_ENABLE_CONTINUOUS_COMPRESSION \
            --enable LRNG_SWITCHABLE_CONTINUOUS_COMPRESSION \
            --set-val LRNG_IRQ_ENTROPY_RATE 256 \
            --enable LRNG_JENT \
            --set-val LRNG_JENT_ENTROPY_RATE 16 \
            --enable LRNG_CPU \
            --set-val LRNG_CPU_FULL_ENT_MULTIPLIER 1 \
            --set-val LRNG_CPU_ENTROPY_RATE 8 \
            --enable LRNG_SCHED \
            --set-val LRNG_SCHED_ENTROPY_RATE 4294967295 \
            --enable LRNG_DRNG_CHACHA20 \
            --module LRNG_DRBG \
            --module LRNG_DRNG_KCAPI \
            --enable LRNG_SWITCH \
            --enable LRNG_SWITCH_HASH \
            --module LRNG_HASH_KCAPI \
            --enable LRNG_SWITCH_DRNG \
            --module LRNG_SWITCH_DRBG \
            --module LRNG_SWITCH_DRNG_KCAPI \
            --enable LRNG_DFLT_DRNG_CHACHA20 \
            --disable LRNG_DFLT_DRNG_DRBG \
            --disable LRNG_DFLT_DRNG_KCAPI \
            --enable LRNG_TESTING_MENU \
            --disable LRNG_RAW_HIRES_ENTROPY \
            --disable LRNG_RAW_JIFFIES_ENTROPY \
            --disable LRNG_RAW_IRQ_ENTROPY \
            --disable LRNG_RAW_RETIP_ENTROPY \
            --disable LRNG_RAW_REGS_ENTROPY \
            --disable LRNG_RAW_ARRAY \
            --disable LRNG_IRQ_PERF \
            --disable LRNG_RAW_SCHED_HIRES_ENTROPY \
            --disable LRNG_RAW_SCHED_PID_ENTROPY \
            --disable LRNG_RAW_SCHED_START_TIME_ENTROPY \
            --disable LRNG_RAW_SCHED_NVCSW_ENTROPY \
            --disable LRNG_SCHED_PERF \
            --disable LRNG_ACVT_HASH \
            --disable LRNG_RUNTIME_MAX_WO_RESEED_CONFIG \
            --disable LRNG_TEST_CPU_ES_COMPRESSION \
            --enable LRNG_SELFTEST \
            --disable LRNG_SELFTEST_PANIC \
            --disable LRNG_RUNTIME_FORCE_SEEDING_DISABLE
    fi

    ### Enable zram/zswap ZSTD compression
    if [ -n "$_zstd_compression" ]; then
        echo "Enabling zram/swap ZSTD compression..."
        scripts/config --disable ZRAM_DEF_COMP_LZORLE \
            --enable ZRAM_DEF_COMP_ZSTD \
            --set-str ZRAM_DEF_COMP zstd \
            --disable ZSWAP_COMPRESSOR_DEFAULT_LZ4 \
            --enable ZSWAP_COMPRESSOR_DEFAULT_ZSTD \
            --set-str ZSWAP_COMPRESSOR_DEFAULT zstd
    fi

    ### Selecting the ZSTD modules and kernel compression level
    if [ "$_zstd_level_value" = "ultra" ]; then
        echo "Enabling highest ZSTD modules and kernel compression ratio..."
        scripts/config --set-val MODULE_COMPRESS_ZSTD_LEVEL 19 \
            --enable MODULE_COMPRESS_ZSTD_ULTRA \
            --set-val MODULE_COMPRESS_ZSTD_LEVEL_ULTRA 22 \
            --set-val ZSTD_COMP_VAL 22
    elif [ "$_zstd_level_value" = "normal" ]; then
        echo "Enabling standard ZSTD modules and kernel compression ratio..."
        scripts/config --set-val MODULE_COMPRESS_ZSTD_LEVEL 9 \
            --disable MODULE_COMPRESS_ZSTD_ULTRA \
            --set-val ZSTD_COMP_VAL 19
    else
        if [ -n "$_zstd_level_value" ]; then
            error "The value $_zstd_level_value is invalid. Choose the correct one again."
        else
            error "The value is empty. Choose the correct one again."
        fi
        error "Selecting the ZSTD modules and kernel compression level failed!"
        exit
    fi

    ### Disable DEBUG
    if [ -n "$_disable_debug" ]; then
        scripts/config --disable DEBUG_INFO \
            --disable DEBUG_INFO_BTF \
            --disable DEBUG_INFO_DWARF4 \
            --disable DEBUG_INFO_DWARF5 \
            --disable PAHOLE_HAS_SPLIT_BTF \
            --disable DEBUG_INFO_BTF_MODULES \
            --disable SLUB_DEBUG \
            --disable PM_DEBUG \
            --disable PM_ADVANCED_DEBUG \
            --disable PM_SLEEP_DEBUG \
            --disable ACPI_DEBUG \
            --disable SCHED_DEBUG \
            --disable LATENCYTOP \
            --disable DEBUG_PREEMPT
    fi

    echo "Enable USER_NS_UNPRIVILEGED"
    scripts/config --enable USER_NS
    echo "Enable WINE FASTSYNC"
    scripts/config --enable WINESYNC

    ### Optionally use running kernel's config
    # code originally by nous; http://aur.archlinux.org/packages.php?ID=40191
    if [ -n "$_use_current" ]; then
        if [[ -s /proc/config.gz ]]; then
            echo "Extracting config from /proc/config.gz..."
            # modprobe configs
            zcat /proc/config.gz > ./.config
        else
            warning "Your kernel was not compiled with IKPROC!"
            warning "You cannot read the current config!"
            warning "Aborting!"
            exit
        fi
    fi


    ### Optionally load needed modules for the make localmodconfig
    # See https://aur.archlinux.org/packages/modprobed-db
    if [ -n "$_localmodcfg" ]; then
        if [ -e $HOME/.config/modprobed.db ]; then
            echo "Running Steven Rostedt's make localmodconfig now"
            make ${BUILD_FLAGS[*]} LSMOD=$HOME/.config/modprobed.db localmodconfig
        else
            echo "No modprobed.db data found"
            exit
        fi
    fi

    ### Rewrite configuration
    echo "Rewrite configuration..."
    make ${BUILD_FLAGS[*]} prepare
    yes "" | make ${BUILD_FLAGS[*]} config >/dev/null
    diff -u ../config .config || :

    ### Prepared version
    make ${BUILD_FLAGS[*]} -s kernelrelease > version
    echo "Prepared $pkgbase version $(<version)"

    ### Running make nconfig
    [[ -z "$_makenconfig" ]] ||  make ${BUILD_FLAGS[*]} nconfig

    ### Running make menuconfig
    [[ -z "$_makemenuconfig" ]] ||  make ${BUILD_FLAGS[*]} menuconfig

    ### Running make xconfig
    [[ -z "$_makexconfig" ]] ||  make ${BUILD_FLAGS[*]} xconfig

    ### Running make gconfig
    [[ -z "$_makegconfig" ]] ||  make ${BUILD_FLAGS[*]} gconfig

    ### Save configuration for later reuse
    echo "Save configuration for later reuse..."
    cat .config > "${startdir}/config-${pkgver}-${pkgrel}${pkgbase#linux}"

}

build() {
    cd ${srcdir}/${_srcname}
    make ${BUILD_FLAGS[*]} -j$(nproc) all

    if [ -n "$_build_zfs" ]; then
        cd ${srcdir}/"zfs"

        if [ -n "$_use_llvm_lto" ]; then
            ./autogen.sh
            sed -i "s|\$(uname -r)|${pkgver}-${pkgsuffix}|g" configure
            ./configure KERNEL_LLVM=1 --prefix=/usr --sysconfdir=/etc --sbindir=/usr/bin --libdir=/usr/lib \
                --datadir=/usr/share --includedir=/usr/include --with-udevdir=/lib/udev \
                --libexecdir=/usr/lib/zfs --with-config=kernel \
                --with-linux=${srcdir}/$_srcname
        else
            ./autogen.sh
            sed -i "s|\$(uname -r)|${pkgver}-${pkgsuffix}|g" configure
            ./configure --prefix=/usr --sysconfdir=/etc --sbindir=/usr/bin --libdir=/usr/lib \
                --datadir=/usr/share --includedir=/usr/include --with-udevdir=/lib/udev \
                --libexecdir=/usr/lib/zfs --with-config=kernel \
                --with-linux=${srcdir}/$_srcname
        fi
        make ${BUILD_FLAGS[*]}
    fi
}

_package() {
    pkgdesc="The $pkgdesc kernel and modules"
    depends=('coreutils' 'kmod' 'initramfs')
    optdepends=('wireless-regdb: to set the correct wireless channels of your country'
                'linux-firmware: firmware images needed for some devices'
                'modprobed-db: Keeps track of EVERY kernel module that has ever been probed - useful for those of us who make localmodconfig'
                'uksmd: Userspace KSM helper daemon')
    provides=(VIRTUALBOX-GUEST-MODULES WIREGUARD-MODULE KSMBD-MODULE UKSMD-BUILTIN)

    cd ${srcdir}/$_srcname

    local kernver="$(<version)"
    local modulesdir="$pkgdir/usr/lib/modules/$kernver"

    echo "Installing boot image..."
    # systemd expects to find the kernel here to allow hibernation
    # https://github.com/systemd/systemd/commit/edda44605f06a41fb86b7ab8128dcf99161d2344
    install -Dm644 "$(make -s image_name)" "$modulesdir/vmlinuz"

    # Used by mkinitcpio to name the kernel
    echo "$pkgbase" | install -Dm644 /dev/stdin "$modulesdir/pkgbase"

    echo "Installing modules..."
    make INSTALL_MOD_PATH="$pkgdir/usr" INSTALL_MOD_STRIP=1 \
        DEPMOD=/doesnt/exist  modules_install  # Suppress depmod

    # remove build and source links
    rm "$modulesdir"/{source,build}
}

_package-headers() {
    pkgdesc="Headers and scripts for building modules for the $pkgdesc kernel"
    depends=('pahole' linux-${pkgsuffix} )

    cd ${srcdir}/${_srcname}
    local builddir="$pkgdir/usr/lib/modules/$(<version)/build"

    echo "Installing build files..."
    install -Dt "$builddir" -m644 .config Makefile Module.symvers System.map \
        localversion.* version vmlinux
    install -Dt "$builddir/kernel" -m644 kernel/Makefile
    install -Dt "$builddir/arch/x86" -m644 arch/x86/Makefile
    cp -t "$builddir" -a scripts

    # required when STACK_VALIDATION is enabled
    install -Dt "$builddir/tools/objtool" tools/objtool/objtool

    # required when DEBUG_INFO_BTF_MODULES is enabled
    if [ -f tools/bpf/resolve_btfids/resolve_btfids ]; then
        install -Dt "$builddir/tools/bpf/resolve_btfids" tools/bpf/resolve_btfids/resolve_btfids
    fi

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
        case "$(file -Sib "$file")" in
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

_package-zfs(){
    pkgdesc="zfs module for the $pkgdesc kernel"
    depends=('pahole' linux-$pkgsuffix=$_kernver)

    cd ${srcdir}/"zfs"
    install -dm755 "$pkgdir/usr/lib/modules/${_kernver}-${pkgsuffix}"
    install -m644 module/*/*.ko "$pkgdir/usr/lib/modules/${_kernver}-${pkgsuffix}"
    find "$pkgdir" -name '*.ko' -exec zstd --rm -10 {} +
    #  sed -i -e "s/EXTRAMODULES='.*'/EXTRAMODULES='${pkgver}-${pkgbase}'/" "$startdir/zfs.install"
}

pkgname=("$pkgbase" "$pkgbase-headers")
if [ -n "$_build_zfs" ]; then
    pkgname+=("$pkgbase-zfs")
fi
for _p in "${pkgname[@]}"; do
    eval "package_$_p() {
    $(declare -f "_package${_p#$pkgbase}")
    _package${_p#$pkgbase}
    }"
done

sha256sums=('a3e61377cf4435a9e2966b409a37a1056f6aaa59e561add9125a88e3c0971dfb'
            'c9c662d6adbf5a4bfeee3cabab6eafe7b9a2d2d51532df2bd53df1c61b6d5260'
            '32e77b3b71225c9f04df2d44c25f982773a8fff9927d26788366baab5e242e74'
            '5ecf5d28265339ee4372792ce86c08b8d4622aeac4f40a94647213a427157bcd'
            'f176a08ea7e84d808c52796b287e7d4acaa9e86e6d0d05ca3a6c86fe3cea9a9b')
