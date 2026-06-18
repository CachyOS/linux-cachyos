<div align="center">
  <img src="https://github.com/CachyOS/calamares-config/blob/grub-3.2/etc/calamares/branding/cachyos/logo.png" width="64" alt="CachyOS logo"></img>
  <br/>
  <h1 align="center">CachyOS Linux Kernels</h1>
  <p align="center">Enhanced Linux kernels with improved performance, multiple CPU schedulers, and advanced optimizations.</p>
</div>

## Table of Contents

- [Overview](#overview)
- [Kernel Variants & Schedulers](#kernel-variants--schedulers)
- [Features](#features)
  - [Performance Optimizations](#performance-optimizations)
  - [CPU Enhancements](#cpu-enhancements)
  - [Networking](#networking)
  - [Filesystem & Memory](#filesystem--memory)
  - [Additional Features](#additional-features)
- [CachyOS Repositories](#cachyos-repositories)
  - [Quick Installation](#quick-installation)
  - [Manual Installation](#manual-installation)
  - [CPU Compatibility Check](#cpu-compatibility-check)
  - [Repository Configuration](#repository-configuration)
- [SCX Schedulers](#scx-schedulers)
- [Other Distributions](#other-distributions)
- [Support & Community](#support--community)
- [Contributors](#contributors)

## Overview

CachyOS provides a collection of enhanced Linux kernels designed for improved performance across different workloads. Kernels are built from the [CachyOS Linux](https://github.com/CachyOS/linux) fork (currently based on **Linux 7.1**), which merges topic branches on top of upstream stable releases.

Our kernels feature multiple CPU schedulers, advanced compiler optimizations, and carefully selected patches to deliver better responsiveness and throughput.

> [!NOTE]
> All CachyOS kernels are available in multiple architecture optimizations: `x86-64`, `x86-64-v3`, `x86-64-v4`, and `znver4`.

## Kernel Variants & Schedulers

Each scheduler is optimized for different use cases. We recommend testing each one to find the best fit for your specific requirements.

### Available Schedulers
| Scheduler | Full Name | Package(s) | Best for... | Developer |
| :--- | :--- | :--- | :--- | :--- |
| **[BORE](https://github.com/firelzrd/bore-scheduler)** | **B**urst-**O**riented **R**esponse **E**nhancer | `linux-cachyos-bore`, `linux-cachyos-deckify`, `linux-cachyos-hardened`, `linux-cachyos-rt-bore` | Interactive workloads & gaming | [firelzrd](https://github.com/firelzrd) |
| **[EEVDF](https://lwn.net/Articles/927530/)** | **E**arliest **E**ligible **V**irtual **D**eadline **F**irst | `linux-cachyos`, `linux-cachyos-eevdf`, `linux-cachyos-lts`, `linux-cachyos-server` | General-purpose computing | Peter Zijlstra |
| **[BMQ](https://gitlab.com/alfredchen/linux-prjc)** | **B**it**M**ap **Q**ueue CPU Scheduler | `linux-cachyos-bmq` | Throughput-oriented workloads | [Alfred Chen](https://gitlab.com/alfredchen) |

### Specialized Variants

- **`linux-cachyos`** - Default kernel: EEVDF scheduler with Clang Thin LTO and AutoFDO
- **`linux-cachyos-rc`** - Release candidate kernel tracking the next upstream version
- **`linux-cachyos-hardened`** - Security-focused kernel with hardening patches and the BORE scheduler
- **`linux-cachyos-lts`** - Long Term Support version (currently 6.18) with EEVDF and Cachy Sauce
- **`linux-cachyos-rt-bore`** - Real-time kernel with BORE scheduler integration
- **`linux-cachyos-server`** - Server-optimized EEVDF configuration with lazy preemption
- **`linux-cachyos-deckify`** - Handheld gaming variant with BORE scheduler, Steam Deck support, and MSI Claw driver

### Compiler Variants

- **`linux-cachyos`** - Default optimized build using Clang Thin LTO with AutoFDO + Propeller profile-guided optimizations
- **Scheduler-specific packages** (`linux-cachyos-bore`, `linux-cachyos-bmq`, `linux-cachyos-eevdf`, etc.) - GCC-compiled builds without LTO, focused on scheduler choice over compiler optimizations

> [!TIP]
> For detailed explanations of each kernel variant, visit our [Kernel Wiki](https://wiki.cachyos.org/features/kernel).

## Features

The CachyOS kernel fork merges topic branches into each release. The current **Linux 7.1** base integrates fifteen topic branches (`amd-isp4`, `bbr3`, `cachy`, `cgroup-vram`, `drm-fair`, `fixes`, `hdmi`, `lenovo-wmi`, `mglru`, `preempt-ipi`, `sched-cluster`, `snd-codecs`, `t2`, `vesa-dsc-bpp`, and `vmalloc-free`) on top of upstream stable.

### Performance Optimizations

- **Advanced Compilation**: Highly customizable PKGBUILD with support for both GCC and Clang compilers
- **Link Time Optimization (LTO)**: Clang Thin LTO (v12) enabled by default on the main `linux-cachyos` package
- **Distributed ThinLTO**: Support for distributed Clang ThinLTO builds to speed up kernel compilation
- **Profile-Guided Optimization**: AutoFDO + Propeller profiling on the default kernel for optimal code generation ([Learn more](https://cachyos.org/blog/2411-kernel-autofdo/))
- **Kernel Control Flow Integrity (kCFI)**: Available when using LLVM for enhanced security
- **Timer Frequency Options**: Configurable between 100Hz, 250Hz, 300Hz, 500Hz, 600Hz, 750Hz, and 1000Hz (default: 1000Hz)
- **Architecture Optimizations**: Support for x86-64-v3, x86-64-v4, and AMD Zen4 specific builds
- **Compiler Optimizations**: Advanced GCC flags including `-fivopts` and `-fmodulo-sched`
- **PREEMPT_DYNAMIC**: Runtime-selectable preemption modes (full, lazy, voluntary, none)
- **vmalloc Optimizations**: Bulk page freeing in `vfree()`, improved `vrealloc()` shrink/grow paths, and optimized contiguous range freeing

### CPU Enhancements

- **Multiple Schedulers**: BORE, EEVDF, and BMQ schedulers for different workload optimization
- **[POC Selector](https://github.com/masahitoS/scx_cake) v2.6.2**: Piece-Of-Cake fast idle CPU selector inspired by scx_cake, reducing wakeup latency
- **Cluster-Aware Scheduling**: Improved load balancing for CPU clusters, including balancing between CPUs of identical capacity on hybrid architectures
- **Preempt-IPI Optimizations**: Lower-latency SMP/IPI paths with preemption re-enabled before TLB flushes and streamlined `smp_call_function()` handling
- **CachyOS Sauce**: Custom `CONFIG_CACHY` configuration with scheduler and system tweaks
- **AMD P-State Enhancements**: Preferred Core support and latest amd-pstate improvements from linux-next
- **Real-Time Support**: RT kernel builds available with BORE scheduler integration
- **Low-Latency Optimizations**: Patches for improved responsiveness and reduced jitter
- **sched/wait LIFO accept()**: Socket accept() processed in LIFO order for better cache efficiency
- **Wakeup CPU Affinity**: Prefer the previous CPU for task wakeups to improve cache locality

### Networking

- **[BBR3 TCP](https://github.com/google/bbr)**: BBRv3 congestion control available as a separate module alongside BBRv1

### Filesystem & Memory

- **ZFS Support**: Built-in ZFS filesystem support with pre-compiled modules
- **NTFS Improvements**: Upstream NTFS driver fixes for MFT mirror validation, attribute bounds checking, and logfile handling
- **MGLRU Enhancements**: Unified writeback reclaim statistics, simplified vmscan accounting, improved dirty writeback reactivation, and Cachy Sauce MM tuning (LRU-gen working set protection, compaction/watermark tweaks, hugepage reclaim)
- **Transparent Hugepages**: `ADVISE` mode for shmem/tmpfs transparent hugepages
- **NVIDIA Integration**: 
  - Proprietary NVIDIA driver modules with patches
  - Open-source NVIDIA driver support
  - Ready-to-use modules in repository
- **I/O Scheduler Improvements**:
  - Enhanced BFQ and mq-deadline performance
  - [ADIOS](https://github.com/firelzrd/adios) v3.2.0 multi-queue I/O scheduler support
- **VRAM Cgroup (DMEM)**: Device memory controller for restricting GPU VRAM usage per cgroup, with protection limits, common-ancestor pool sharing, and Nouveau DMEM support

### Additional Features

#### Hardware Support
- **AMD ISP4**: AMD ISP 4 camera driver for supported platforms
- **Gaming Hardware**: Steam Deck patches (Audio, HW Quirks, HID), ROG Ally support, MSI Claw HID driver (deckify), and EasySMX 05 Pro gamepad support
- **Apple Hardware**: T2 MacBook support with apple-bce driver in staging
- **ASUS Hardware**: Extended ASUS hardware compatibility patches, including ACP audio fixes for Vivobook 18 and TUF Gaming A14 (2026)
- **Lenovo Hardware**: WMI battery charge limiting, GPU/CPU tunable attributes, capdata debugfs, and AMD PMC suspend delay for improved sleep/resume
- **HP Hardware**: OMEN Slim (including 16t-an000) and OMEN MAX laptop support via hp-wmi
- **Samsung Hardware**: Galaxy Book 4/5 series audio fixes via MAX98390 HDA codec support
- **Graphics**: HDR support enabled, AMDGPU min_powercap override (`amdgpu_ignore_min_pcap`), and DRM fair GPU scheduling favoring interactive clients
- **Display**: HDMI VRR on AMD (including PCON path and freesync-on-desktop), ALLM and passive VRR connector properties, VESA DSC bits-per-pixel parsing from EDID
- **Audio Codecs**: AW88399 and MAX98390 HDA side codec support

#### System Enhancements
- **Multimedia**: v4l2loopback modules included by default
- **Virtualization**: ACS Override support for VFIO/GPU passthrough
- **Upstream Integration**: Cherry-picked patches from Clear Linux and linux-next

> [!NOTE]
> For comprehensive details about each kernel variant and their specific optimizations, visit our [Kernel Documentation](https://wiki.cachyos.org/features/kernel).

## CachyOS Repositories

Our [repositories](https://mirror.cachyos.org/) contain optimized Arch Linux and CachyOS packages rebuilt with performance, stability, and security enhancements.

### Available Repository Tiers

| Repository | Target CPUs | Package Coverage | Optimization Level |
|------------|-------------|------------------|--------------------|
| `znver4` | AMD Zen 4 & Zen 5 | Full package set | Zen4-specific optimizations |
| `x86-64-v4` | Intel Xeon / Intel 11th | Full package set | AVX, AVX2, AVX512, SSE4.2, SSSE3 |
| `x86-64-v3` | 2012 or newer | Full package set | AVX, AVX2, SSE4.2, SSSE3 |
| `x86-64` | All x86-64 CPUs | Kernels only | Basic optimizations |

### Quick Installation

**Automated Setup (Recommended)**

Our installation script automatically detects your CPU and configures the optimal repositories:

```bash
# Download and extract the installer
curl -O https://mirror.cachyos.org/cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz && cd cachyos-repo

# Run the automated installer
sudo ./cachyos-repo.sh
```

**What the script does:**
- Auto-detects your CPU architecture support
- Configures appropriate repository tiers
- Backs up your existing `pacman.conf`
- Sets up GPG keys and mirrors

For more information, visit our [GitHub](https://github.com/cachyos) or join our [Discord](https://discord.gg/cachyos-862292009423470592) community.

### Manual Installation

**Step 1: Add CachyOS Signing Keys**

```bash
sudo pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key F3B607488DB35A47
```

**Step 2: Install Required Packages**

```bash
sudo pacman -U \
    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-20240331-1-any.pkg.tar.zst' \
    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-27-1-any.pkg.tar.zst' \
    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-27-1-any.pkg.tar.zst' \
    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v4-mirrorlist-27-1-any.pkg.tar.zst' \
    'https://mirror.cachyos.org/repo/x86_64/cachyos/pacman-7.1.0.r9.g54d9411-4-x86_64.pkg.tar.zst'
```

> [!CAUTION]
> **About CachyOS Pacman**: This installs a forked version of pacman with CachyOS-specific features like `INSTALLED_FROM` tracking and automatic architecture detection. While this provides enhanced functionality, it may cause compatibility warnings with standard Arch Linux workflows.
>
> **Alternative**: If you prefer to avoid the custom pacman, skip the `cachyos` repository and only use the optimized package repositories (`cachyos-v3`, `cachyos-v4`, `cachyos-extra`, etc.).

**Rollback Instructions**

If you need to revert to standard Arch repositories after using CachyOS pacman:

```bash
sudo find /var/lib/pacman/local/ -type f -name "desc" -exec sed -i '/^%INSTALLED_DB%$/,+2d' {} \;
```

### CPU Compatibility Check

Before manually configuring repositories, verify your CPU's instruction set support.

> [!NOTE]
> Skip this step if using the automated installation script—it handles detection automatically.

**Check Your CPU Support**

```bash
/lib/ld-linux-x86-64.so.2 --help | grep supported
```

**Understanding the Output**

Look for the `(supported, searched)` indicators:

- ✅ **`x86-64-v4 (supported, searched)`** = CPU supports v4 instruction set
- ❌ **`x86-64-v4`** (without parentheses) = CPU does NOT support v4

**Example Output for Compatible CPU:**
```
$ /lib/ld-linux-x86-64.so.2 --help | grep supported
  x86-64-v4 (supported, searched)
  x86-64-v3 (supported, searched)
  x86-64-v2 (supported, searched)
```

**Instruction Set Requirements:**
- **x86-64-v4**: Intel Haswell (2013+) / AMD Excavator (2015+)
- **x86-64-v3**: Intel Nehalem (2008+) / AMD Bulldozer (2011+)
- **x86-64-v2**: Intel Core 2 (2006+) / AMD K8 (2003+)

### Repository Configuration

Edit your pacman configuration to add the appropriate repositories:

```bash
sudo nano /etc/pacman.conf
```

**For x86-64 (Basic) Support:**
```ini
# CachyOS repositories
[cachyos]
Include = /etc/pacman.d/cachyos-mirrorlist
```

**For x86-64-v3 Support:**
```ini
# CachyOS repositories (add in this order)
[cachyos-v3]
Include = /etc/pacman.d/cachyos-v3-mirrorlist
[cachyos-core-v3]
Include = /etc/pacman.d/cachyos-v3-mirrorlist
[cachyos-extra-v3]
Include = /etc/pacman.d/cachyos-v3-mirrorlist
[cachyos]
Include = /etc/pacman.d/cachyos-mirrorlist
```

**For x86-64-v4 Support:**
```ini
# CachyOS repositories (add in this order)
[cachyos-v4]
Include = /etc/pacman.d/cachyos-v4-mirrorlist
[cachyos-core-v4]
Include = /etc/pacman.d/cachyos-v4-mirrorlist
[cachyos-extra-v4]
Include = /etc/pacman.d/cachyos-v4-mirrorlist
[cachyos]
Include = /etc/pacman.d/cachyos-mirrorlist
```

**For AMD Zen4 CPUs:**
```ini
# CachyOS repositories (Zen4 optimized)
[cachyos-znver4]
Include = /etc/pacman.d/cachyos-v4-mirrorlist
[cachyos-core-znver4]
Include = /etc/pacman.d/cachyos-v4-mirrorlist
[cachyos-extra-znver4]
Include = /etc/pacman.d/cachyos-v4-mirrorlist
[cachyos]
Include = /etc/pacman.d/cachyos-mirrorlist
```

**Finalize Installation:**

```bash
# Update package databases and system
sudo pacman -Syu
```

🎉 **Congratulations!** Your system is now optimized with CachyOS packages.

### Debug Packages

Debug symbols are available through debuginfod. Configure it by creating:

```bash
# Create debuginfod configuration
sudo mkdir -p /etc/debuginfod
echo "https://debuginfod.cachyos.org" | sudo tee /etc/debuginfod/cachyos.urls
```

### Uninstalling CachyOS Repositories

For complete removal instructions, see our [Uninstallation Guide](https://wiki.cachyos.org/features/optimized_repos/#uninstalling-cachyos-repositories).

## SCX Schedulers

CachyOS supports the new sched-ext (SCX) framework for userspace schedulers. For setup and configuration, see our [sched-ext Tutorial](https://wiki.cachyos.org/configuration/sched-ext/).

> [!WARNING]
> SCX schedulers are **not compatible** with the `linux-cachyos-bmq` kernel variant.

## Other Distributions

CachyOS kernels are available for other Linux distributions through community efforts:

### Gentoo Linux

Community-maintained ebuilds for dynamic kernel building:

```bash
# Add the CachyOS kernels overlay
eselect repository add CachyOS-kernels git https://github.com/Szowisz/CachyOS-kernels
emaint sync -r CachyOS-kernels
```

**Repository:** [Szowisz/CachyOS-kernels](https://github.com/Szowisz/CachyOS-kernels)

### Fedora Linux

COPR repository with multiple kernel variants:

- `linux-cachyos-bore`
- `linux-cachyos-rt-bore` 
- `linux-cachyos-bore-lto`
- `linux-cachyos-lts`

**Maintainer:** [bieszczaders](https://copr.fedorainfracloud.org/coprs/bieszczaders/kernel-cachyos/)  
**Installation:** Visit the [COPR page](https://copr.fedorainfracloud.org/coprs/bieszczaders/kernel-cachyos/) for setup instructions

### NixOS

Precompiled kernels available through the xddxdd/nix-cachyos-kernel repository:

**Repository:** [xddxdd/nix-cachyos-kernel](https://github.com/xddxdd/nix-cachyos-kernel)  
**Setup:** Follow the [installation guide](https://github.com/xddxdd/nix-cachyos-kernel#readme)

## Support & Community

### Get Help
- **Discord:** [CachyOS Community](https://discord.gg/cachyos-862292009423470592)
- **Forum:** [discuss.cachyos.org](https://discuss.cachyos.org)
- **Telegram:** [CachyOS Group](https://t.me/+zCzPX4cAFjk1MTYy)

### Support Development

Help us maintain repositories and build infrastructure:

- **PayPal:** [paypal.me/pttrr](https://paypal.me/pttrr)
- **Patreon:** [patreon.com/CachyOS](https://www.patreon.com/CachyOS)
- **BTC:** `bc1qmwglfchlc335du6pcu6w64cexu7cck0mzhyw42`
- **ETH:** `0xc2dc77327F78A7B85Db3941Eb49e74F41E961649`
- **LTC:** `LgGTwcEBcXqMgNT6XyyNWABMb7dZVtVg9w`

## Contributors

Special thanks to our key contributors:

- **[firelzrd](https://github.com/firelzrd/bore-scheduler)** - BORE Scheduler developer
- **[Arch Linux](https://archlinux.org)** - Foundation distribution
- **[Linux Kernel Community](https://github.com/torvalds/linux)** - Upstream kernel development
- **All CachyOS contributors and community members**
