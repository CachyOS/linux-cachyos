# Maintainer: Peter Jung ptr1337 <admin@ptr1337.dev>
# Maintainer: Piotr Gorski <piotrgorski@cachyos.org>
# Maintainer: Vasiliy Stelmachenok <ventureo@cachyos.org>
# Contributor: Jan Alexander Steffens (heftig) <jan.steffens@gmail.com>
# Contributor: Tobias Powalowski <tpowa@archlinux.org>
# Contributor: Thomas Baechler <thomas@archlinux.org>

### BUILD OPTIONS
# Set these variables to ANYTHING that is not null or choose proper variable to enable them

### Selecting CachyOS config
_cachy_config=${_cachy_config-y}

### Selecting the CPU scheduler
# ATTENTION - only one of the following values can be selected:
# 'bore' - select 'Burst-Oriented Response Enhancer'
# 'bmq' - select 'BMQ Scheduler'
# 'hardened' - select 'BORE Scheduler hardened' ## kernel with hardened config and hardening patches with the bore scheduler
# 'cachyos' - select 'Sched-Ext Scheduler Framework Variant Scheduler with BORE Scheduler'
# 'eevdf' - select 'EEVDF Scheduler'
# 'rt' - select EEVDF, but includes a series of realtime patches
# 'rt-bore' - select Burst-Oriented Response Enhancer, but includes a series of realtime patches
# 'sched-ext' - select 'sched-ext' Scheduler, based on EEVDF
_cpusched=${_cpusched-bore}

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
# It seems that in 2023 this is not really a huge regression anymore
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

# Path to the list of used modules
_localmodcfg_path=${_localmodcfg_path-"$HOME/.config/modprobed.db"}

# Use the current kernel's .config file
# Enabling this option will use the .config of the RUNNING kernel rather than
# the ARCH defaults. Useful when the package gets updated and you already went
# through the trouble of customizing your config options.  NOT recommended when
# a new kernel is released, but again, convenient for package bumps.
_use_current=${_use_current-}

### Enable KBUILD_CFLAGS -O3
_cc_harder=${_cc_harder-y}

### Set this to your number of threads you have in your machine otherwise it will default to 320
_nr_cpus=${_nr_cpus-}

### Set performance governor as default
_per_gov=${_per_gov-}

### Enable TCP_CONG_BBR3
_tcp_bbr3=${_tcp_bbr3-y}

### Running with a 1000HZ, 750Hz, 625Hz, 600 Hz, 500Hz, 300Hz, 250Hz and 100Hz tick rate
_HZ_ticks=${_HZ_ticks-1000}

## Choose between perodic, idle or full
### Full tickless can give higher performances in various cases but, depending on hardware, lower consistency.
_tickrate=${_tickrate-full}

## Choose between full(low-latency), voluntary or server
_preempt=${_preempt-full}

### Transparent Hugepages
# ATTENTION - one of two predefined values should be selected!
# 'always' - always enable THP
# 'madvise' - madvise, prevent applications from allocating more memory resources than necessary
# More infos here:
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/performance_tuning_guide/sect-red_hat_enterprise_linux-performance_tuning_guide-configuring_transparent_huge_pages
_hugepage=${_hugepage-always}

# CPU compiler optimizations - Defaults to prompt at kernel config if left empty
# AMD CPUs : "k8" "k8sse3" "k10" "barcelona" "bobcat" "jaguar" "bulldozer" "piledriver" "steamroller" "excavator" "zen" "zen2" "zen3" "zen4"
# Intel CPUs : "mpsc"(P4 & older Netburst based Xeon) "atom" "core2" "nehalem" "westmere" "silvermont" "sandybridge" "ivybridge" "haswell" "broadwell" "skylake" "skylakex" "cannonlake" "icelake" "goldmont" "goldmontplus" "cascadelake" "cooperlake" "tigerlake" "sapphirerapids" "rocketlake" "alderlake"
# Other options :
# - "native_amd" (use compiler autodetection - Selecting your arch manually in the list above is recommended instead of this option)
# - "native_intel" (use compiler autodetection and will prompt for P6_NOPS - Selecting your arch manually in the list above is recommended instead of this option)
# - "generic" (kernel's default - to share the package between machines with different CPU µarch as long as they are x86-64)
#
_processor_opt=${_processor_opt-}

# This does automatically detect your supported CPU and optimizes for it
_use_auto_optimization=${_use_auto_optimization-y}

# Clang LTO mode, only available with the "llvm" compiler - options are "none", "full" or "thin".
# ATTENTION - one of three predefined values should be selected!
# "full: uses 1 thread for Linking, slow and uses more memory, theoretically with the highest performance gains."
# "thin: uses multiple threads, faster and uses less memory, may have a lower runtime performance than Full."
# "none: disable LTO
_use_llvm_lto=${_use_llvm_lto-none}

# Use suffix -lto only when requested by the user
# Enabled by default.
# y - enable -lto suffix
# n - disable -lto suffix
# https://github.com/CachyOS/linux-cachyos/issues/36
_use_lto_suffix=${_use_lto_suffix-y}

# Use suffix -gcc when requested by the user
# This was added to facilitate https://github.com/CachyOS/linux-cachyos/issues/286
_use_gcc_suffix=${_use_gcc_suffix-}

# KCFI is a proposed forward-edge control-flow integrity scheme for
# Clang, which is more suitable for kernel use than the existing CFI
# scheme used by CONFIG_CFI_CLANG. kCFI doesn't require LTO, doesn't
# alter function references to point to a jump table, and won't break
# function address equality.
_use_kcfi=${_use_kcfi-}

# Build the zfs module in to the kernel
# WARNING: The ZFS module doesn't build with selected RT sched due to licensing issues.
# If you use ZFS, refrain from building the RT kernel
_build_zfs=${_build_zfs-}

# Builds the nvidia module and package it into a own base
# This does replace the requirement of nvidia-dkms
_build_nvidia=${_build_nvidia-}

# Builds the open nvidia module and package it into a own base
# This does replace the requirement of nvidia-open-dkms
# Use this only if you have Turing+ GPU
_build_nvidia_open=${_build_nvidia_open-}

# Build a debug package with non-stripped vmlinux
_build_debug=${_build_debug-}

if [[ "$_use_llvm_lto" = "thin" || "$_use_llvm_lto" = "full" ]] && [ "$_use_lto_suffix" = "y"  ]; then
    _pkgsuffix="cachyos-${_cpusched}-lto"
elif [ "$_use_llvm_lto" = "none" ]  && [ -z "$_use_kcfi" ] && [ "$_use_gcc_suffix" = "y" ]; then
    _pkgsuffix="cachyos-${_cpusched}-gcc"
else
    _pkgsuffix="cachyos-${_cpusched}"
fi

pkgbase="linux-$_pkgsuffix"
_major=6.11
_minor=3
#_minorc=$((_minor+1))
#_rcver=rc8
pkgver=${_major}.${_minor}
_stable=${_major}.${_minor}
#_stable=${_major}
#_stablerc=${_major}-${_rcver}
_srcname=linux-${_stable}
#_srcname=linux-${_major}
pkgdesc='Linux BORE + Cachy Sauce scheduler Kernel by CachyOS with other patches and improvements'
pkgrel=1
_kernver="$pkgver-$pkgrel"
_kernuname="${pkgver}-${_pkgsuffix}"
arch=('x86_64')
url="https://github.com/CachyOS/linux-cachyos"
license=('GPL-2.0-only')
options=('!strip' '!debug' '!lto')
makedepends=(
  bc
  cpio
  gettext
  libelf
  pahole
  perl
  python
  tar
  xz
  zstd
)

_patchsource="https://raw.githubusercontent.com/cachyos/kernel-patches/master/${_major}"
_nv_ver=560.35.03
_nv_pkg="NVIDIA-Linux-x86_64-${_nv_ver}"
_nv_open_pkg="open-gpu-kernel-modules-${_nv_ver}"
source=(
    "https://cdn.kernel.org/pub/linux/kernel/v${pkgver%%.*}.x/${_srcname}.tar.xz"
    "config"
    "auto-cpu-optimization.sh"
    "${_patchsource}/all/0001-cachyos-base-all.patch")

# LLVM makedepends
if [[ "$_use_llvm_lto" = "thin" || "$_use_llvm_lto" = "full" ]] || [ -n "$_use_kcfi" ]; then
    makedepends+=(clang llvm lld)
    source+=("${_patchsource}/misc/dkms-clang.patch")
    BUILD_FLAGS=(
        CC=clang
        LD=ld.lld
        LLVM=1
        LLVM_IAS=1
    )
fi

# WARNING The ZFS module doesn't build with selected RT sched due to licensing issues.
if [[ "$_cpusched" = "rt" || "$_cpusched" = "rt-bore" ]]; then
    unset _build_zfs
fi

# ZFS support
if [ -n "$_build_zfs" ]; then
    makedepends+=(git)
    source+=("git+https://github.com/cachyos/zfs.git#commit=baa50314567afd986a00838f0fa65fdacbd12daf")
fi

# NVIDIA pre-build module support
if [ -n "$_build_nvidia" ]; then
    source+=("https://us.download.nvidia.com/XFree86/Linux-x86_64/${_nv_ver}/${_nv_pkg}.run"
             "${_patchsource}/misc/nvidia/0001-Make-modeset-and-fbdev-default-enabled.patch"
             "${_patchsource}/misc/nvidia/0004-6.11-Add-fix-for-fbdev.patch")
fi

if [ -n "$_build_nvidia_open" ]; then
    source+=("nvidia-open-${_nv_ver}.tar.gz::https://github.com/NVIDIA/open-gpu-kernel-modules/archive/refs/tags/${_nv_ver}.tar.gz"
             "${_patchsource}/misc/nvidia/0001-Make-modeset-and-fbdev-default-enabled.patch"
             "${_patchsource}/misc/nvidia/0002-Do-not-error-on-unkown-CPU-Type-and-add-Zen5-support.patch"
             "${_patchsource}/misc/nvidia/0003-Add-IBT-Support.patch"
             "${_patchsource}/misc/nvidia/0004-6.11-Add-fix-for-fbdev.patch"
             "${_patchsource}/misc/nvidia/0005-6.12-drm_outpull_pill-changed-check.patch")
fi

## List of CachyOS schedulers
case "$_cpusched" in
    cachyos) # CachyOS Scheduler (Sched-ext + BORE + Cachy Sauce)
        source+=("${_patchsource}/sched/0001-sched-ext.patch"
                 "${_patchsource}/sched/0001-bore-cachy-ext.patch");;
    bore) ## BORE Scheduler
        source+=("${_patchsource}/sched/0001-bore-cachy.patch");;
    bmq) ## Project C Scheduler
        source+=("${_patchsource}/sched/0001-prjc-cachy.patch");;
    eevdf) ## 6.12 EEVDF patches
        source+=("${_patchsource}/sched/0001-eevdf-next.patch");;
    rt) ## EEVDF with RT patches
        source+=("${_patchsource}/misc/0001-rt.patch");;
    rt-bore) ## RT with BORE Scheduler
        source+=("${_patchsource}/misc/0001-rt.patch"
                 "${_patchsource}/sched/0001-bore-cachy-rt.patch");;
    hardened) ## Hardened Patches with BORE Scheduler
        source+=("${_patchsource}/sched/0001-bore-cachy.patch"
                 "${_patchsource}/misc/0001-hardened.patch");;
    sched-ext) ## SCHED-EXT
        source+=("${_patchsource}/sched/0001-sched-ext.patch");;
esac

export KBUILD_BUILD_HOST=cachyos
export KBUILD_BUILD_USER="$pkgbase"
export KBUILD_BUILD_TIMESTAMP="$(date -Ru${SOURCE_DATE_EPOCH:+d @$SOURCE_DATE_EPOCH})"

_die() { error "$@" ; exit 1; }

prepare() {
    cd "$_srcname"

    echo "Setting version..."
    echo "-$pkgrel" > localversion.10-pkgrel
    echo "${pkgbase#linux}" > localversion.20-pkgname

    local src
    for src in "${source[@]}"; do
        src="${src%%::*}"
        # Skip nvidia patches
        [[ "$src" == "${_patchsource}"/misc/nvidia/*.patch ]] && continue
        src="${src##*/}"
        src="${src%.zst}"
        [[ $src = *.patch ]] || continue
        echo "Applying patch $src..."
        patch -Np1 < "../$src"
    done

    echo "Setting config..."
    cp ../config .config

    ### Select CPU optimization
    if [ -n "$_processor_opt" ]; then
        MARCH="${_processor_opt^^}"

        if [ "$MARCH" != "GENERIC" ]; then
            if [[ "$MARCH" =~ GENERIC_V[1-4] ]]; then
                X86_64_LEVEL="${MARCH//GENERIC_V}"
                scripts/config --set-val X86_64_VERSION "${X86_64_LEVEL}"
            else
                scripts/config -k -d CONFIG_GENERIC_CPU
                scripts/config -k -e "CONFIG_M${MARCH}"
            fi
        fi
    fi

    ### Use autooptimization
    if [ -n "$_use_auto_optimization" ]; then
        "${srcdir}"/auto-cpu-optimization.sh
    fi

    ### Selecting CachyOS config
    if [ -n "$_cachy_config" ]; then
        echo "Enabling CachyOS config..."
        scripts/config -e CACHY
    fi

    ### Selecting the CPU scheduler
    [ -z "$_cpusched" ] && _die "The value is empty. Choose the correct one again."

    case "$_cpusched" in
        cachyos) scripts/config -e SCHED_CLASS_EXT -e SCHED_BORE;;
        bore|hardened) scripts/config -e SCHED_BORE;;
        bmq) scripts/config -e SCHED_ALT -e SCHED_BMQ;;
        eevdf) ;;
        rt) scripts/config -e PREEMPT_COUNT -e PREEMPTION -d PREEMPT_VOLUNTARY -d PREEMPT -d PREEMPT_NONE -d PREEMPT_RT -d PREEMPT_DYNAMIC -e PREEMPT_BUILD -e PREEMPT_BUILD_AUTO -e PREEMPT_AUTO;;
        rt-bore) scripts/config -e SCHED_BORE -e PREEMPT_COUNT -e PREEMPTION -d PREEMPT_VOLUNTARY -d PREEMPT -d PREEMPT_NONE -d PREEMPT_RT -d PREEMPT_DYNAMIC -e PREEMPT_BUILD -e PREEMPT_BUILD_AUTO -e PREEMPT_AUTO;;
        sched-ext) scripts/config -e SCHED_CLASS_EXT;;
        *) _die "The value $_cpusched is invalid. Choose the correct one again.";;
    esac

    echo "Selecting ${_cpusched^^} CPU scheduler..."

    ### Enable KCFI
    if [ -n "$_use_kcfi" ]; then
        echo "Enabling kCFI"
        scripts/config -e ARCH_SUPPORTS_CFI_CLANG -e CFI_CLANG -e CFI_AUTO_DEFAULT
    fi

    ### Select LLVM level
    [ -z "$_use_llvm_lto" ] && _die "The value is empty. Choose the correct one again."

    case "$_use_llvm_lto" in
        thin) scripts/config -e LTO -e LTO_CLANG -e ARCH_SUPPORTS_LTO_CLANG -e ARCH_SUPPORTS_LTO_CLANG_THIN -d LTO_NONE -e HAS_LTO_CLANG -d LTO_CLANG_FULL -e LTO_CLANG_THIN -e HAVE_GCC_PLUGINS;;
        full) scripts/config -e LTO -e LTO_CLANG -e ARCH_SUPPORTS_LTO_CLANG -e ARCH_SUPPORTS_LTO_CLANG_THIN -d LTO_NONE -e HAS_LTO_CLANG -e LTO_CLANG_FULL -d LTO_CLANG_THIN -e HAVE_GCC_PLUGINS;;
        none) scripts/config -e LTO_NONE;;
        *) _die "The value '$_use_llvm_lto' is invalid. Choose the correct one again.";;
    esac

    echo "Selecting '$_use_llvm_lto' LLVM level..."

    ### Select tick rate
    [ -z "$_HZ_ticks" ] && _die "The value is empty. Choose the correct one again."

    case "$_HZ_ticks" in
        100|250|500|600|625|750|1000)
            scripts/config -d HZ_300 -e "HZ_${_HZ_ticks}" --set-val HZ "${_HZ_ticks}";;
        300)
            scripts/config -e HZ_300 --set-val HZ 300;;
        *)
            _die "The value $_HZ_ticks is invalid. Choose the correct one again."
    esac

    echo "Setting tick rate to ${_HZ_ticks}Hz..."

    ### Disable NUMA
    if [ -n "$_NUMAdisable" ]; then
        echo "Disabling NUMA from kernel config..."
        scripts/config -d NUMA \
            -d AMD_NUMA \
            -d X86_64_ACPI_NUMA \
            -d NODES_SPAN_OTHER_NODES \
            -d NUMA_EMU \
            -d USE_PERCPU_NUMA_NODE_ID \
            -d ACPI_NUMA \
            -d ARCH_SUPPORTS_NUMA_BALANCING \
            -d NODES_SHIFT \
            -u NODES_SHIFT \
            -d NEED_MULTIPLE_NODES \
            -d NUMA_BALANCING \
            -d NUMA_BALANCING_DEFAULT_ENABLED
    fi

    ### Setting NR_CPUS
    if [[ "$_nr_cpus" -ge 2 && "$_nr_cpus" -le 512 ]]; then
        echo "Setting custom NR_CPUS..."
        scripts/config --set-val NR_CPUS "$_nr_cpus"
    elif [ -z "$_nr_cpus" ]; then
        echo "Setting default NR_CPUS..."
        scripts/config --set-val NR_CPUS 320
    else
        _die "The value '$_nr_cpus' is invalid. Please select a numerical value from 2 to 512..."
    fi

    ### Select performance governor
    if [ -n "$_per_gov" ]; then
        echo "Setting performance governor..."
        scripts/config -d CPU_FREQ_DEFAULT_GOV_SCHEDUTIL \
            -e CPU_FREQ_DEFAULT_GOV_PERFORMANCE
    fi

    ### Select tick type
    [ -z "$_tickrate" ] && _die "The value is empty. Choose the correct one again."

    case "$_tickrate" in
        perodic) scripts/config -d NO_HZ_IDLE -d NO_HZ_FULL -d NO_HZ -d NO_HZ_COMMON -e HZ_PERIODIC;;
        idle) scripts/config -d HZ_PERIODIC -d NO_HZ_FULL -e NO_HZ_IDLE  -e NO_HZ -e NO_HZ_COMMON;;
        full) scripts/config -d HZ_PERIODIC -d NO_HZ_IDLE -d CONTEXT_TRACKING_FORCE -e NO_HZ_FULL_NODEF -e NO_HZ_FULL -e NO_HZ -e NO_HZ_COMMON -e CONTEXT_TRACKING;;
        *) _die "The value '$_tickrate' is invalid. Choose the correct one again.";;
    esac

    echo "Selecting '$_tickrate' tick type..."

    ### Select preempt type

    # We should not set up the PREEMPT for RT kernels
    if [[ "$_cpusched" != "rt" || "$_cpusched" != "rt-bore" ]]; then
        [ -z "$_preempt" ] && _die "The value is empty. Choose the correct one again."

        case "$_preempt" in
            full) scripts/config -e PREEMPT_BUILD -d PREEMPT_NONE -d PREEMPT_VOLUNTARY -e PREEMPT -e PREEMPT_COUNT -e PREEMPTION -e PREEMPT_DYNAMIC;;
            voluntary) scripts/config -e PREEMPT_BUILD -d PREEMPT_NONE -e PREEMPT_VOLUNTARY -d PREEMPT -e PREEMPT_COUNT -e PREEMPTION -d PREEMPT_DYNAMIC;;
            server) scripts/config -e PREEMPT_NONE_BUILD -e PREEMPT_NONE -d PREEMPT_VOLUNTARY -d PREEMPT -d PREEMPTION -d PREEMPT_DYNAMIC;;
            *) _die "The value '$_preempt' is invalid. Choose the correct one again.";;
        esac

        echo "Selecting '$_preempt' preempt type..."
    fi

    ### Enable O3
    if [ -n "$_cc_harder" ] && [ -z "$_cc_size" ]; then
        echo "Enabling KBUILD_CFLAGS -O3..."
        scripts/config -d CC_OPTIMIZE_FOR_PERFORMANCE \
            -e CC_OPTIMIZE_FOR_PERFORMANCE_O3
    fi

    ### CI-only stuff
    if [[ -n "$CI" || -n "$GITHUB_RUN_ID" ]]; then
        echo "Detected build inside CI"
        scripts/config -d CC_OPTIMIZE_FOR_PERFORMANCE \
            -d CC_OPTIMIZE_FOR_PERFORMANCE_O3 \
            -e CONFIG_CC_OPTIMIZE_FOR_SIZE \
            -d SLUB_DEBUG \
            -d PM_DEBUG \
            -d PM_ADVANCED_DEBUG \
            -d PM_SLEEP_DEBUG \
            -d ACPI_DEBUG \
            -d LATENCYTOP \
            -d SCHED_DEBUG \
            -d DEBUG_PREEMPT
    fi

    ### Enable bbr3
    if [ -n "$_tcp_bbr3" ]; then
        echo "Disabling TCP_CONG_CUBIC..."
        scripts/config -m TCP_CONG_CUBIC \
            -d DEFAULT_CUBIC \
            -e TCP_CONG_BBR \
            -e DEFAULT_BBR \
            --set-str DEFAULT_TCP_CONG bbr
    fi

    ### Select THP
    [ -z "$_hugepage" ] && _die "The value is empty. Choose the correct one again."

    case "$_hugepage" in
        always) scripts/config -d TRANSPARENT_HUGEPAGE_MADVISE -e TRANSPARENT_HUGEPAGE_ALWAYS;;
        madvise) scripts/config -d TRANSPARENT_HUGEPAGE_ALWAYS -e TRANSPARENT_HUGEPAGE_MADVISE;;
        *) _die "The value '$_hugepage' is invalid. Choose the correct one again.";;
    esac

    echo "Selecting '$_hugepage' TRANSPARENT_HUGEPAGE config..."

    echo "Enable USER_NS_UNPRIVILEGED"
    scripts/config -e USER_NS

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
        if [ -e "$_localmodcfg_path" ]; then
            echo "Running Steven Rostedt's make localmodconfig now"
            make "${BUILD_FLAGS[@]}" LSMOD="${_localmodcfg_path}" localmodconfig
        else
            _die "No modprobed.db data found"
        fi
    fi

    ### Rewrite configuration
    echo "Rewrite configuration..."
    make "${BUILD_FLAGS[@]}" prepare
    yes "" | make "${BUILD_FLAGS[@]}" config >/dev/null
    diff -u ../config .config || :

    ### Prepared version
    make -s kernelrelease > version
    echo "Prepared $pkgbase version $(<version)"

    ### Running make nconfig
    [[ -z "$_makenconfig" ]] ||  make "${BUILD_FLAGS[@]}" nconfig

    ### Running make menuconfig
    [[ -z "$_makemenuconfig" ]] ||  make "${BUILD_FLAGS[@]}" menuconfig

    ### Running make xconfig
    [[ -z "$_makexconfig" ]] ||  make "${BUILD_FLAGS[@]}" xconfig

    ### Running make gconfig
    [[ -z "$_makegconfig" ]] ||  make "${BUILD_FLAGS[@]}" gconfig

    ### Save configuration for later reuse
    echo "Save configuration for later reuse..."
    local basedir="$(dirname "$(readlink "${srcdir}/config")")"
    cat .config > "${basedir}/config-${pkgver}-${pkgrel}${pkgbase#linux}"

    if [ -n "$_build_nvidia" ]; then
        cd "${srcdir}"
        sh "${_nv_pkg}.run" --extract-only

        # Use fbdev and modeset as default
        patch -Np1 -i "${srcdir}/0001-Make-modeset-and-fbdev-default-enabled.patch" -d "${srcdir}/${_nv_pkg}/kernel"
        # Fix broken fbdev on 6.11
        patch -Np2 -i "${srcdir}/0004-6.11-Add-fix-for-fbdev.patch" -d "${srcdir}/${_nv_pkg}/kernel"
    fi

    if [ -n "$_build_nvidia_open" ]; then
        patch -Np1 -i "${srcdir}/0001-Make-modeset-and-fbdev-default-enabled.patch" -d "${srcdir}/${_nv_open_pkg}/kernel-open"
        # Fix for https://bugs.archlinux.org/task/74886
        patch -Np1 --no-backup-if-mismatch -i "${srcdir}/0003-Add-IBT-Support.patch" -d "${srcdir}/${_nv_open_pkg}"
        # Fix for Zen5 error print in dmesg
        patch -Np1 --no-backup-if-mismatch -i "${srcdir}/0002-Do-not-error-on-unkown-CPU-Type-and-add-Zen5-support.patch" -d "${srcdir}/${_nv_open_pkg}"
        # Fix broken fbdev on 6.11
        patch -Np1 --no-backup-if-mismatch -i "${srcdir}/0004-6.11-Add-fix-for-fbdev.patch" -d "${srcdir}/${_nv_open_pkg}"
        # Fix for 6.12 Module Compilation
        patch -Np1 --no-backup-if-mismatch -i "${srcdir}/0005-6.12-drm_outpull_pill-changed-check.patch" -d "${srcdir}/${_nv_open_pkg}"
    fi
}

build() {
    cd "$_srcname"
    make "${BUILD_FLAGS[@]}" -j"$(nproc)" all
    make -C tools/bpf/bpftool vmlinux.h feature-clang-bpf-co-re=1

    local MODULE_FLAGS=(
       KERNEL_UNAME="${_kernuname}"
       IGNORE_PREEMPT_RT_PRESENCE=1
       SYSSRC="${srcdir}/${_srcname}"
       SYSOUT="${srcdir}/${_srcname}"
    )
    if [ -n "$_build_nvidia" ]; then
        MODULE_FLAGS+=(NV_EXCLUDE_BUILD_MODULES='__EXCLUDE_MODULES')
        cd "${srcdir}/${_nv_pkg}/kernel"
        make "${BUILD_FLAGS[@]}" "${MODULE_FLAGS[@]}" -j"$(nproc)" modules

    fi

    if [ -n "$_build_nvidia_open" ]; then
        cd "${srcdir}/${_nv_open_pkg}"
        MODULE_FLAGS+=(IGNORE_CC_MISMATCH=yes)
        CFLAGS= CXXFLAGS= LDFLAGS= make "${BUILD_FLAGS[@]}" "${MODULE_FLAGS[@]}" -j"$(nproc)" modules
    fi

    if [ -n "$_build_zfs" ]; then
        cd ${srcdir}/"zfs"

        local CONFIGURE_FLAGS=()
        [ "$_use_llvm_lto" != "none" ] && CONFIGURE_FLAGS+=("KERNEL_LLVM=1")

        ./autogen.sh
        sed -i "s|\$(uname -r)|${_kernuname}|g" configure
        ./configure "${CONFIGURE_FLAGS[@]}" --prefix=/usr --sysconfdir=/etc --sbindir=/usr/bin \
            --libdir=/usr/lib --datadir=/usr/share --includedir=/usr/include \
            --with-udevdir=/lib/udev --libexecdir=/usr/lib/zfs --with-config=kernel \
            --with-linux="${srcdir}/$_srcname"
        make "${BUILD_FLAGS[@]}"
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

    cd "$_srcname"

    local modulesdir="$pkgdir/usr/lib/modules/$(<version)"

    echo "Installing boot image..."
    # systemd expects to find the kernel here to allow hibernation
    # https://github.com/systemd/systemd/commit/edda44605f06a41fb86b7ab8128dcf99161d2344
    install -Dm644 "$(make -s image_name)" "$modulesdir/vmlinuz"

    # Used by mkinitcpio to name the kernel
    echo "$pkgbase" | install -Dm644 /dev/stdin "$modulesdir/pkgbase"

    echo "Installing modules..."
    ZSTD_CLEVEL=19 make INSTALL_MOD_PATH="$pkgdir/usr" INSTALL_MOD_STRIP=1 \
        DEPMOD=/doesnt/exist  modules_install  # Suppress depmod

    # remove build links
    rm "$modulesdir"/build
}

_package-headers() {
    pkgdesc="Headers and scripts for building modules for the $pkgdesc kernel"
    depends=('pahole' "${pkgbase}")

    cd "${_srcname}"
    local builddir="$pkgdir/usr/lib/modules/$(<version)/build"

    echo "Installing build files..."
    install -Dt "$builddir" -m644 .config Makefile Module.symvers System.map \
        localversion.* version vmlinux tools/bpf/bpftool/vmlinux.h
    install -Dt "$builddir/kernel" -m644 kernel/Makefile
    install -Dt "$builddir/arch/x86" -m644 arch/x86/Makefile
    cp -t "$builddir" -a scripts
    ln -srt "$builddir" "$builddir/scripts/gdb/vmlinux-gdb.py"

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

_package-dbg(){
    pkgdesc="Non-stripped vmlinux file for the $pkgdesc kernel"
    depends=("${pkgbase}-headers")

    cd "${_srcname}"
    mkdir -p "$pkgdir/usr/src/debug/${pkgbase}"
    install -Dt "$pkgdir/usr/src/debug/${pkgbase}" -m644 vmlinux
}

_package-zfs(){
    pkgdesc="zfs module for the $pkgdesc kernel"
    depends=('pahole' "${pkgbase}=${_kernver}")
    provides=('ZFS-MODULE')
    license=('CDDL')

    cd "$_srcname"
    local modulesdir="$pkgdir/usr/lib/modules/$(<version)"

    cd "${srcdir}/zfs"
    install -dm755 "${modulesdir}"
    install -m644 module/*.ko "${modulesdir}"
    find "$pkgdir" -name '*.ko' -exec zstd --rm -19 {} +
    #  sed -i -e "s/EXTRAMODULES='.*'/EXTRAMODULES='${pkgver}-${pkgbase}'/" "$startdir/zfs.install"
}

_package-nvidia(){
    pkgdesc="nvidia module of ${_nv_ver} driver for the ${pkgbase} kernel"
    depends=("$pkgbase=$_kernver" "nvidia-utils=${_nv_ver}" "libglvnd")
    provides=('NVIDIA-MODULE')
    conflicts=("$pkgbase-nvidia-open")
    license=('custom')

    cd "$_srcname"
    local modulesdir="$pkgdir/usr/lib/modules/$(<version)"

    cd "${srcdir}/${_nv_pkg}"
    install -dm755 "${modulesdir}"
    install -m644 kernel/*.ko "${modulesdir}"
    install -Dt "$pkgdir/usr/share/licenses/${pkgname}" -m644 LICENSE
    find "$pkgdir" -name '*.ko' -exec zstd --rm -19 {} +
}

_package-nvidia-open(){
    pkgdesc="nvidia open modules of ${_nv_ver} driver for the ${pkgbase} kernel"
    depends=("$pkgbase=$_kernver" "nvidia-utils=${_nv_ver}" "libglvnd")
    provides=('NVIDIA-MODULE')
    conflicts=("$pkgbase-nvidia")
    license=('MIT AND GPL-2.0-only')

    cd "$_srcname"
    local modulesdir="$pkgdir/usr/lib/modules/$(<version)"

    cd "${srcdir}/${_nv_open_pkg}"
    install -dm755 "${modulesdir}"
    install -m644 kernel-open/*.ko "${modulesdir}"
    install -Dt "$pkgdir/usr/share/licenses/${pkgname}" -m644 COPYING

    find "$pkgdir" -name '*.ko' -exec zstd --rm -19 {} +
}

pkgname=("$pkgbase")
[ -n "$_build_debug" ] && pkgname+=("$pkgbase-dbg")
pkgname+=("$pkgbase-headers")
[ -n "$_build_zfs" ] && pkgname+=("$pkgbase-zfs")
[ -n "$_build_nvidia" ] && pkgname+=("$pkgbase-nvidia")
[ -n "$_build_nvidia_open" ] && pkgname+=("$pkgbase-nvidia-open")
for _p in "${pkgname[@]}"; do
    eval "package_$_p() {
    $(declare -f "_package${_p#$pkgbase}")
    _package${_p#$pkgbase}
    }"
done

b2sums=('69582e4745850f3ec004d87859ac88994e3715ed38cd66aff2633fbcb6c20ca2e3be83417cd2c42c2757ab4e084e622c688799b5ad28e15c391adb2afab79a68'
        '080302a1061cb4529bda58e1eecb782f0ee79aca547f03c991186dd4a647fc5fb772b32efcf5f895bca02104686a27f06b32eaf4745001e5bcb65b253349084f'
        'b1e964389424d43c398a76e7cee16a643ac027722b91fe59022afacb19956db5856b2808ca0dd484f6d0dfc170482982678d7a9a00779d98cd62d5105200a667'
        'f85ac822b5def33cd8a530bb698d2773d0b3a7c03e242c5ab48add0a084a846c5cb372cd11d2f4008b4205a0641f00a6ac16da9c56adcbbe40f827ccfae71bcf'
        '7a41b35dd68457724b23b769803edac7f090d2032177fdada6fbf67604cfc6f167f68853b9be15eacd04204f16bbf06af26307720dfe9d78f400365b9616871f')
