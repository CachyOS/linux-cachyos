# Maintainer: Peter Jung ptr1337 <admin@ptr1337.dev>
# Contributor: Piotr Gorski <lucjan.lucjanov@gmail.com>
# Contributor: Jan Alexander Steffens (heftig) <jan.steffens@gmail.com>
# Contributor: Tobias Powalowski <tpowa@archlinux.org>
# Contributor: Thomas Baechler <thomas@archlinux.org>

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
_cpusched='tt'

### BUILD OPTIONS
# Set these variables to ANYTHING that is not null to enable them

### Tweak kernel options prior to a build via nconfig
_makenconfig=

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

### Enable KBUILD_CFLAGS -O3
_cc_harder=y

### Set performance governor as default
_per_gov=y

### Enable TCP_CONG_BBR2
_tcp_bbr2=y

### Running with a 1000HZ, 750Hz, 600 Hz or 500Hz tick rate
_HZ_ticks=750

## Choose between perodic, tickless idle or full tickless
### Full tickless can give higher performances in various cases but, depending on hardware, lower consistency.
_tickrate=full

## Choose between full(low-latency), voluntary or server
_preempt=voluntary

### Disable MQ-Deadline I/O scheduler
_mq_deadline_disable=y

### Disable Kyber I/O scheduler
_kyber_disable=y

### Enable multigenerational LRU
_lru_enable=y

## Enable DAMON
_damon=y

## enable SPECULATIVE_PAGE_FAULT
_spf_enable=y

## Enable Linux Random Number Generator
_lrng_enable=y

# CPU compiler optimizations - Defaults to prompt at kernel config if left empty
# AMD CPUs : "k8" "k8sse3" "k10" "barcelona" "bobcat" "jaguar" "bulldozer" "piledriver" "steamroller" "excavator" "zen" "zen2" "zen3"
# Intel CPUs : "mpsc"(P4 & older Netburst based Xeon) "atom" "core2" "nehalem" "westmere" "silvermont" "sandybridge" "ivybridge" "haswell" "broadwell" "skylake" "skylakex" "cannonlake" "icelake" "goldmont" "goldmontplus" "cascadelake" "cooperlake" "tigerlake" "sapphirerapids" "rocketlake" "alderlake"
# Other options :
# - "native_amd" (use compiler autodetection - Selecting your arch manually in the list above is recommended instead of this option)
# - "native_intel" (use compiler autodetection and will prompt for P6_NOPS - Selecting your arch manually in the list above is recommended instead of this option)
# - "generic" (kernel's default - to share the package between machines with different CPU µarch as long as they are x86-64)
#
# Or use the _use_auto_optimization with _use_auto_optimization=y
_processor_opt=

_use_auto_optimization=y

# disable debug to lower the size of the kernel
_disable_debug=y

## Enable zram/zswap ZSTD compression
_zstd_compression=y

_nf_cone=y

# Clang LTO mode, only available with the "llvm" compiler - options are "no", "full" or "thin".
# "full: uses 1 thread for Linking, slow and uses more memory, theoretically with the highest performance gains."
# "thin: uses multiple threads, faster and uses less memory, may have a lower runtime performance than Full."
_use_llvm_lto=

# KCFI is a proposed forward-edge control-flow integrity scheme for
# Clang, which is more suitable for kernel use than the existing CFI
# scheme used by CONFIG_CFI_CLANG. KCFI doesn't require LTO, doesn't
# alter function references to point to a jump table, and won't break
# function address equality.
# ATTENTION!: you do need a patched llvm for the usage of kcfi,
# you can find a patched llvm-git in the cachyos-repo's.
# The packagename is called "llvm-kcfi"
_use_kcfi=

# Build the zfs module builtin in to the kernel
_build_zfs=

# Enable bcachefs
_bcachefs=

if [ -n "$_use_llvm_lto" ]; then
    pkgsuffix=cachyos-${_cpusched}-lto
    pkgbase=linux-$pkgsuffix

else
    pkgsuffix=cachyos-${_cpusched}
    pkgbase=linux-$pkgsuffix
fi
_major=5.18
_minor=6
#_minorc=$((_minor+1))
#_rcver=rc8
pkgver=${_major}.${_minor}
_stable=${_major}.${_minor}
#_stable=${_major}
#_stablerc=${_major}-${_rcver}
_srcname=linux-${_stable}
#_srcname=linux-${_major}
arch=(x86_64 x86_64_v3)
pkgdesc='Linux TT scheduler Kernel by CachyOS with other patches and improvements'
pkgrel=2
_kernver=$pkgver-$pkgrel
arch=('x86_64' 'x86_64_v3')
url="https://github.com/CachyOS/linux-cachyos"
license=('GPL2')
options=('!strip')
makedepends=('bc' 'texlive-latexextra' 'libelf' 'pahole' 'cpio' 'perl' 'tar' 'xz' 'zstd' 'xmlto' 'git' 'gcc' 'gcc-libs' 'glibc' 'binutils' 'make' 'patch')
if [ -n "$_use_llvm_lto" ]; then
    makedepends+=(clang llvm lld python)
    BUILD_FLAGS=(
        CC=clang
        LD=ld.lld
        LLVM=1
        LLVM_IAS=1
    )
fi
_patchsource="https://raw.githubusercontent.com/ptr1337/kernel-patches/master/${_major}"
source=(
    "https://cdn.kernel.org/pub/linux/kernel/v${pkgver%%.*}.x/${_srcname}.tar.xz"
    "config"
    "${_patchsource}/0001-cachy.patch"
)
if [ -n "$_build_zfs" ]; then
    source+=("git+https://github.com/openzfs/zfs.git#commit=6c3c5fcfbe27d9193cd131753cc7e47ee2784621")
fi
if [ "$_cpusched" = "bmq" ]; then
    source+=("${_patchsource}/sched/0001-prjc.patch")
fi
if [ "$_cpusched" = "pds" ]; then
    source+=("${_patchsource}/sched/0001-prjc.patch")
fi
if [ "$_cpusched" = "bore" ]; then
    source+=("${_patchsource}/sched/0001-bore-sched.patch")
fi
if [ "$_cpusched" = "cacule" ]; then
    source+=("${_patchsource}/sched/0001-cacULE-5.18-migrate.patch")
fi
if [ "$_cpusched" = "cacule-rdb" ]; then
    source+=("${_patchsource}/sched/0001-cacULE-5.18-migrate.patch")
fi
if [ "$_cpusched" = "tt" ]; then
    source+=("${_patchsource}/sched/0001-tt-5.18.patch")
fi
if [ "$_cpusched" = "hardened" ]; then
    source+=(
        "${_patchsource}/sched/0001-bore-sched.patch"
        "${_patchsource}/0001-hardening.patch"
    "${_patchsource}/0001-hardened.patch")
fi
source+=(
    "${_patchsource}/0001-amd-perf.patch"
    "${_patchsource}/0001-bbr2.patch"
    "${_patchsource}/0001-Extend-DAMOS-for-Proactive-LRU-lists-Sorting.patch"
    "${_patchsource}/0001-fixes.patch"
    "${_patchsource}/0001-fs-patches.patch"
    "${_patchsource}/0001-futex-winesync.patch"
    "${_patchsource}/0001-hwmon.patch"
    "${_patchsource}/0001-lrng.patch"
    "${_patchsource}/0001-lru-le9-spf.patch"
    "${_patchsource}/0001-kbuild.patch"
    "${_patchsource}/0001-rcu.patch"
    "auto-cpu-optimization.sh"
)
if [ -n "$_use_kcfi" ]; then
    source+=("${_patchsource}/0001-kcfi.patch")
    depends+=(clang llvm lld python)
    BUILD_FLAGS=(
        CC=clang
        LD=ld.lld
        LLVM=1
    )
fi

if [ -n "$_bcachefs" ]; then
    source+=("${_patchsource}/0001-bcachefs-after-lru.patch")
fi

export KBUILD_BUILD_HOST=archlinux
export KBUILD_BUILD_USER=$pkgbase
export KBUILD_BUILD_TIMESTAMP="$(date -Ru${SOURCE_DATE_EPOCH:+d @$SOURCE_DATE_EPOCH})"

prepare() {

    cd ${srcdir}/$_srcname

    echo "Setting version..."
    scripts/setlocalversion --save-scmversion
    echo "-$pkgrel" > localversion.10-pkgrel
    echo "${pkgbase#linux}" > localversion.20-pkgname

    #        [[ $src = 0001-zfs-2.1.5-staging.patch ]] && continue
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

    if [ -n "$_processor_opt" ]; then
        MARCH=$(echo $_processor_opt|tr '[:lower:]' '[:upper:]'&&echo)
        MARCH2=M${MARCH}
        scripts/config -k --disable CONFIG_GENERIC_CPU
        scripts/config -k --enable CONFIG_${MARCH2}
    fi

    if [ -n "$_use_auto_optimization" ]; then
        "${srcdir}"/auto-cpu-optimization.sh
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
        scripts/config --enable TT_SCHED
        scripts/config --enable TT_ACCOUNTING_STATS
    elif [ "$_cpusched" = "cfs" ]; then
        echo "Selecting Completely Fair Scheduler..."
    elif [ "$_cpusched" = "hardened" ]; then
        echo "Selecting hardened..."
    else
        if [ -n "$_cpusched" ]; then
            error "The value $_cpusched is invalid. Choose the correct one again."
        else
            error "The value is empty. Choose the correct one again."
        fi
        error "Selecting the CPU scheduler failed!"
        exit
    fi

    if [ -n "$_use_kcfi" ]; then
        echo "Enabling kCFI"
        scripts/config --enable ARCH_SUPPORTS_CFI_CLANG \
            --enable CFI_CLANG
    fi

    if [ "$_use_llvm_lto" = "thin" ]; then
        echo "Enabling LLVM THIN LTO..."
        scripts/config \
            --enable LTO \
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
        scripts/config \
            --enable LTO \
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
    fi

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

    if [ -n "$_mq_deadline_disable" ]; then
        echo "Disabling MQ-Deadline I/O scheduler..."
        scripts/config --disable MQ_IOSCHED_DEADLINE
    fi

    if [ -n "$_kyber_disable" ]; then
        echo "Disabling Kyber I/O scheduler..."
        scripts/config --disable MQ_IOSCHED_KYBER
    fi

    if [ -n "$_per_gov" ]; then
        echo "Setting performance governor..."
        scripts/config --disable CPU_FREQ_DEFAULT_GOV_SCHEDUTIL \
            --enable CPU_FREQ_DEFAULT_GOV_PERFORMANCE \
            --enable PCIEASPM \
            --enable PCIEASPM_PERFORMANCE \
            --enable PCIE_BUS_PERFORMANCE
    fi

    if [ "$_tickrate" = "perodic" ]; then
        echo "Enabling periodic ticks..."
        scripts/config --disable NO_HZ_IDLE \
            --disable NO_HZ_FULL \
            --disable NO_HZ \
            --disable NO_HZ_COMMON \
            --enable HZ_PERIODIC
    elif [ "$_tickrate" = "idle" ]; then
        echo "Enabling tickless idle..."
        scripts/config --disable HZ_PERIODIC \
            --disable NO_HZ_FULL \
            --enable NO_HZ_IDLE \
            --enable NO_HZ \
            --enable NO_HZ_COMMON
    elif [ "$_tickrate" = "full" ]; then
        echo "Enabling tickless idle..."
        scripts/config --disable HZ_PERIODIC \
            --disable NO_HZ_IDLE \
            --disable CONTEXT_TRACKING_FORCE \
            --enable NO_HZ_FULL_NODEF \
            --enable NO_HZ_FULL \
            --enable NO_HZ \
            --enable NO_HZ_COMMON \
            --enable CONTEXT_TRACKING
    fi

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
        echo "Enabling tickless idle..."
        scripts/config --enable PREEMPT_BUILD \
            --disable PREEMPT_NONE \
            --enable PREEMPT_VOLUNTARY \
            --disable PREEMPT \
            --enable PREEMPT_COUNT \
            --enable PREEMPTION \
            --disable PREEMPT_DYNAMIC
    elif [ "$_tickrate" = "server" ]; then
        echo "Enabling tickless idle..."
        scripts/config --enable PREEMPT_NONE_BUILD \
            --enable PREEMPT_NONE \
            --disable PREEMPT_VOLUNTARY \
            --disable PREEMPT \
            --disable PREEMPT_COUNT \
            --disable PREEMPTION \
            --disable PREEMPT_DYNAMIC
    fi

    if [ -n "$_cc_harder" ]; then
        echo "Enabling KBUILD_CFLAGS -O3..."
        scripts/config --disable CC_OPTIMIZE_FOR_PERFORMANCE \
            --enable CC_OPTIMIZE_FOR_PERFORMANCE_O3
    fi

    if [ -n "$_tcp_bbr2" ]; then
        echo "Disabling TCP_CONG_CUBIC..."
        scripts/config --module TCP_CONG_CUBIC \
            --disable DEFAULT_CUBIC \
            --enable TCP_CONG_BBR2 \
            --enable DEFAULT_BBR2 \
            --set-str DEFAULT_TCP_CONG bbr2
    fi

    if [ -n "$_nf_cone" ]; then
        echo "Enabling FULLCONENAT..."
        scripts/config --module IP_NF_TARGET_FULLCONENAT \
            --module NETFILTER_XT_TARGET_FULLCONENAT
    fi

    if [ -n "$_spf_enable" ]; then
        echo "Enabling SPECULATIVE_PAGE_FAULT LRU..."
        scripts/config --enable SPECULATIVE_PAGE_FAULT
    fi

    if [ -n "$_lru_enable" ]; then
        echo "Enabling multigenerational LRU..."
        scripts/config --enable ARCH_HAS_NONLEAF_PMD_YOUNG \
            --enable LRU_GEN \
            --enable LRU_GEN_ENABLED \
            --disable LRU_GEN_STATS
    fi

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
    if [ -n "$_lrng_enable" ]; then
        echo "Enabling Linux Random Number Generator ..."
        scripts/config --disable CONFIG_RANDOM_DEFAULT_IMPL
        scripts/config --enable CONFIG_LRNG
        scripts/config --enable CONFIG_LRNG_SHA256
        scripts/config --enable CONFIG_LRNG_COMMON_DEV_IF
        scripts/config --enable CONFIG_LRNG_DRNG_ATOMIC
        scripts/config --enable CONFIG_LRNG_SYSCTL
        scripts/config --enable CONFIG_LRNG_RANDOM_IF
        scripts/config --module CONFIG_LRNG_KCAPI_IF
        scripts/config --module CONFIG_LRNG_HWRAND_IF
        scripts/config --enable CONFIG_LRNG_DEV_IF
        scripts/config --enable CONFIG_LRNG_RUNTIME_ES_CONFIG
        scripts/config --enable CONFIG_LRNG_IRQ_DFLT_TIMER_ES
        scripts/config --disable CONFIG_LRNG_SCHED_DFLT_TIMER_ES
        scripts/config --enable CONFIG_LRNG_TIMER_COMMON
        scripts/config --disable CONFIG_LRNG_COLLECTION_SIZE_256
        scripts/config --disable CONFIG_LRNG_COLLECTION_SIZE_512
        scripts/config --enable CONFIG_LRNG_COLLECTION_SIZE_1024
        scripts/config --disable CONFIG_LRNG_COLLECTION_SIZE_2048
        scripts/config --disable CONFIG_LRNG_COLLECTION_SIZE_4096
        scripts/config --disable CONFIG_LRNG_COLLECTION_SIZE_8192
        scripts/config --set-val CONFIG_LRNG_COLLECTION_SIZE 1024
        scripts/config --enable CONFIG_LRNG_HEALTH_TESTS
        scripts/config --set-val CONFIG_LRNG_RCT_CUTOFF 31
        scripts/config --set-val CONFIG_LRNG_APT_CUTOFF 325
        scripts/config --enable CONFIG_LRNG_IRQ
        scripts/config --enable CONFIG_LRNG_CONTINUOUS_COMPRESSION_ENABLED
        scripts/config --disable CONFIG_LRNG_CONTINUOUS_COMPRESSION_DISABLED
        scripts/config --enable CONFIG_LRNG_ENABLE_CONTINUOUS_COMPRESSION
        scripts/config --enable CONFIG_LRNG_SWITCHABLE_CONTINUOUS_COMPRESSION
        scripts/config --set-val CONFIG_LRNG_IRQ_ENTROPY_RATE 256
        scripts/config --enable CONFIG_LRNG_JENT
        scripts/config --set-val CONFIG_LRNG_JENT_ENTROPY_RATE 16
        scripts/config --enable CONFIG_LRNG_CPU
        scripts/config --set-val CONFIG_LRNG_CPU_FULL_ENT_MULTIPLIER 1
        scripts/config --set-val CONFIG_LRNG_CPU_ENTROPY_RATE 8
        scripts/config --enable CONFIG_LRNG_SCHED
        scripts/config --set-val CONFIG_LRNG_SCHED_ENTROPY_RATE 4294967295
        scripts/config --enable CONFIG_LRNG_DRNG_CHACHA20
        scripts/config --module CONFIG_LRNG_DRBG
        scripts/config --module CONFIG_LRNG_DRNG_KCAPI
        scripts/config --enable CONFIG_LRNG_SWITCH
        scripts/config --enable CONFIG_LRNG_SWITCH_HASH
        scripts/config --module CONFIG_LRNG_HASH_KCAPI
        scripts/config --enable CONFIG_LRNG_SWITCH_DRNG
        scripts/config --module CONFIG_LRNG_SWITCH_DRBG
        scripts/config --module CONFIG_LRNG_SWITCH_DRNG_KCAPI
        scripts/config --enable CONFIG_LRNG_DFLT_DRNG_CHACHA20
        scripts/config --disable CONFIG_LRNG_DFLT_DRNG_DRBG
        scripts/config --disable CONFIG_LRNG_DFLT_DRNG_KCAPI
        scripts/config --enable CONFIG_LRNG_TESTING_MENU
        scripts/config --disable CONFIG_LRNG_RAW_HIRES_ENTROPY
        scripts/config --disable CONFIG_LRNG_RAW_JIFFIES_ENTROPY
        scripts/config --disable CONFIG_LRNG_RAW_IRQ_ENTROPY
        scripts/config --disable CONFIG_LRNG_RAW_RETIP_ENTROPY
        scripts/config --disable CONFIG_LRNG_RAW_REGS_ENTROPY
        scripts/config --disable CONFIG_LRNG_RAW_ARRAY
        scripts/config --disable CONFIG_LRNG_IRQ_PERF
        scripts/config --disable CONFIG_LRNG_RAW_SCHED_HIRES_ENTROPY
        scripts/config --disable CONFIG_LRNG_RAW_SCHED_PID_ENTROPY
        scripts/config --disable CONFIG_LRNG_RAW_SCHED_START_TIME_ENTROPY
        scripts/config --disable CONFIG_LRNG_RAW_SCHED_NVCSW_ENTROPY
        scripts/config --disable CONFIG_LRNG_SCHED_PERF
        scripts/config --disable CONFIG_LRNG_ACVT_HASH
        scripts/config --disable CONFIG_LRNG_RUNTIME_MAX_WO_RESEED_CONFIG
        scripts/config --disable CONFIG_LRNG_TEST_CPU_ES_COMPRESSION
        scripts/config --enable CONFIG_LRNG_SELFTEST
        scripts/config --disable CONFIG_LRNG_SELFTEST_PANIC
    fi

    if [ -n "$_zstd_swap_compression" ]; then
        echo "Enabling zram ZSTD compression..."
        scripts/config --disable ZRAM_DEF_COMP_LZORLE \
            --enable ZRAM_DEF_COMP_ZSTD \
            --set-str ZRAM_DEF_COMP zstd \
            --disable ZSWAP_COMPRESSOR_DEFAULT_LZ4 \
            --enable ZSWAP_COMPRESSOR_DEFAULT_ZSTD \
            --set-str ZSWAP_COMPRESSOR_DEFAULT zstd \
            --enable ZRAM_ENTROPY \
            --set-val ZRAM_ENTROPY_THRESHOLD 100000
    fi

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

    ### Save configuration for later reuse
    echo "Save configuration for later reuse..."
    cat .config > "${startdir}/config-${pkgver}-${pkgrel}${pkgbase#linux}"

    ### Save configuration for later reuse
    # cp -Tf ./.config "${startdir}/config-${pkgver}-${pkgrel}${pkgbase#linux}"

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

sha256sums=('4e1c2a9e79847850029571a1dd04761e5f657b52c558070a085365641f133478'
            '49ddff0aac1493c3049450f8dacb9de5217c5d9254bc736cd012b3e7bda6baf2'
            '0437704f362dbcd917af531824841683e16ea1a49d750a6ffc0b060b17b97057'
            'dfd20ada4ad708fa293476575189c560bed79a74c7682c01e74aa04dbfe8dbff'
            '326d129f9435145add756dc967accd56ffe1d8ff1b6650f84d2578c41bd6dfd6'
            'dc2898751118804bc3f36b5a6928a2927d04919ce41c0ce013009f5564d6d232'
            '71c33bf75dbf84673ad26a35c20b0f9ae0fa9944d91cd93a0b128752ca2eab0e'
            '39551bf08e6b965db7b125c81a17f60f695a686b13ddc6499463222fd6cec9b4'
            'efa0cd8f02f1289d8775ce64dc4a2a061b225612e8f1513591c147a3925dc7bd'
            '1d9c83de97d541f5a7ae4612a96c05aea8ce38de5471cc21fd2197dbd6644d00'
            '16085e0bba8e1843180f82df00d6040b97531cebb2c0c4c7fe23860322d06beb'
            'f5b02a27a6324fc5aaabbca03e76d483da9ff51c389e4fabda51fd85f77217fc'
            '292240ee42f4e34b97528c9b2b2afcef7bc892501a3750b8825ac6ef9c87072e'
            'f534b60c0d90ef59312ac874f0fbbcd60434ceac673148e76c503752e837126b'
            'e3bb6ca80b9156c409fdd0ca55916f028213f7b4fc7dcf7cea7702e08822ea5f'
            'ce8bf7807b45a27eed05a5e1de5a0bf6293a3bbc2085bacae70cd1368f368d1f')
