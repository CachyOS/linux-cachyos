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

CachyOS provides a collection of enhanced Linux kernels designed for improved performance across different workloads. Our kernels feature multiple CPU schedulers, advanced compiler optimizations, and carefully selected patches to deliver better responsiveness and throughput.

> [!NOTE]
> All CachyOS kernels are available in multiple architecture optimizations: `x86-64`, `x86-64-v3`, `x86-64-v4`, and `znver4`. The default `linux-cachyos` kernel is compiled with Clang and Thin LTO, utilizing AutoFDO + Propeller profiling for optimal performance.

## Kernel Variants & Schedulers

Each scheduler is optimized for different use cases. We recommend testing each one to find the best fit for your specific requirements:

### Available Schedulers

- **[BORE](https://github.com/firelzrd/bore-scheduler)** - **Burst-Oriented Response Enhancer**
  - Packages: `linux-cachyos`, `linux-cachyos-bore`
  - Best for: Interactive workloads and gaming
  - Developer: [firelzrd](https://github.com/firelzrd)

- **[EEVDF](https://lwn.net/Articles/927530/)** - **Earliest Eligible Virtual Deadline First**
  - Package: `linux-cachyos-eevdf`
  - Best for: General-purpose computing with fair scheduling
  - Status: Upstream Linux scheduler

- **[BMQ](https://gitlab.com/alfredchen/linux-prjc)** - **BitMap Queue CPU Scheduler**
  - Package: `linux-cachyos-bmq`
  - Best for: Low-latency applications
  - Developer: [Alfred Chen](https://gitlab.com/alfredchen)

### Specialized Variants

- **`linux-cachyos-hardened`** - Security-focused kernel with hardening patches
- **`linux-cachyos-lts`** - Long Term Support version for stability
- **`linux-cachyos-rt-bore`** - Real-time kernel with BORE scheduler
- **`linux-cachyos-server`** - Server-optimized configuration
- **`linux-cachyos-deckify`** - Steam Deck optimized variant

### Compiler Variants

- **`linux-cachyos`** - Default Clang-compiled kernel with Thin LTO
- **`linux-cachyos-gcc`** - GCC-compiled variant for compatibility

> [!TIP]
> For detailed explanations of each kernel variant, visit our [Kernel Wiki](https://wiki.cachyos.org/features/kernel).

## Features

### Performance Optimizations

- **Advanced Compilation**: Highly customizable PKGBUILD with support for both GCC and Clang compilers
- **Link Time Optimization (LTO)**: Thin LTO enabled by default for better performance
- **Profile-Guided Optimization**: AutoFDO + Propeller profiling for optimal code generation ([Learn more](https://cachyos.org/blog/2411-kernel-autofdo/))
- **Kernel Control Flow Integrity (kCFI)**: Available when using LLVM for enhanced security
- **Timer Frequency Options**: Configurable between 300Hz, 500Hz, 600Hz, 750Hz, and 1000Hz (default: 1000Hz)
- **Architecture Optimizations**: Support for x86-64-v3, x86-64-v4, and AMD Zen4 specific builds
- **Compiler Optimizations**: Advanced GCC flags including `-fivopts` and `-fmodulo-sched`

### CPU Enhancements

- **Multiple Schedulers**: BORE, EEVDF, and BMQ schedulers for different workload optimization
- **AMD P-State Enhancements**: Preferred Core support and latest amd-pstate improvements from linux-next
- **Real-Time Support**: RT kernel builds available with BORE scheduler integration
- **CachyOS Sauce**: Custom `CONFIG_CACHY` configuration with scheduler and system tweaks
- **Low-Latency Optimizations**: Patches for improved responsiveness and reduced jitter

### Filesystem & Memory

- **ZFS Support**: Built-in ZFS filesystem support with pre-compiled modules
- **NVIDIA Integration**: 
  - Proprietary NVIDIA driver modules with patches
  - Open-source NVIDIA driver support
  - Ready-to-use modules in repository
- **I/O Scheduler Improvements**:
  - Enhanced BFQ and mq-deadline performance
  - Alternative [ADIOS](https://github.com/firelzrd/adios) I/O scheduler support
- **Memory Management**:
  - [le9uo](https://github.com/firelzrd/le9uo) patch for preventing page thrashing under memory pressure
  - Zen-kernel memory management tweaks (compaction, watermark optimization)

### Additional Features

#### Hardware Support
- **Gaming Hardware**: Steam Deck patches (Audio, HW Quirks, HID) and ROG Ally support
- **Apple Hardware**: T2 MacBook support included by default
- **ASUS Hardware**: Extended ASUS hardware compatibility patches
- **Graphics**: HDR support enabled, AMDGPU min_powercap override (`amdgpu_ignore_min_pcap`)

#### System Enhancements
- **Boot & Shutdown**: Async shutdown patches for faster system operations
- **Multimedia**: v4l2loopback modules included by default
- **Virtualization**: ACS Override support for VFIO/GPU passthrough
- **Upstream Integration**: Cherry-picked patches from Clear Linux and linux-next

> [!INFO]
> For comprehensive details about each kernel variant and their specific optimizations, visit our [Kernel Documentation](https://wiki.cachyos.org/features/kernel).

## CachyOS Repositories

Our [repositories](https://mirror.cachyos.org/) contain optimized Arch Linux and CachyOS packages rebuilt with performance, stability, and security enhancements.

### Available Repository Tiers

| Repository | Target CPUs | Package Coverage | Optimization Level |
|------------|-------------|------------------|--------------------|
| `znver4` | AMD Zen 4 & Zen 5 | Full package set | Zen4-specific optimizations |
| `x86-64-v4` | Intel Haswell+ / AMD Excavator+ | Full package set | AVX2, BMI1/2, FMA |
| `x86-64-v3` | Intel Nehalem+ / AMD Bulldozer+ | Full package set | AVX, SSE4.2, SSSE3 |
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
    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-22-1-any.pkg.tar.zst' \
    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-22-1-any.pkg.tar.zst' \
    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v4-mirrorlist-22-1-any.pkg.tar.zst' \
    'https://mirror.cachyos.org/repo/x86_64/cachyos/pacman-7.0.0.r7.g1f38429-1-x86_64.pkg.tar.zst'
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
Include = /etc/pacman.d/cachyos-znver4-mirrorlist
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

Precompiled kernels available through the Chaotic-AUR Nyx repository:

**Repository:** [chaotic-cx/nyx](https://github.com/chaotic-cx/nyx)  
**Setup:** Follow the [installation guide](https://github.com/chaotic-cx/nyx#how-to-use-it)

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
