<div align="center">
  <img src="https://github.com/CachyOS/calamares-config/blob/grub-3.2/etc/calamares/branding/cachyos/logo.png" width="64" alt="CachyOS logo"></img>
  <br/>
  <h1 align="center">CachyOS Linux Kernels</h1>
  <p align="center">Enhanced Linux kernels with improved performance, multiple CPU schedulers, and advanced optimizations.</p>
  <p align="center">AVOID THIS DISTRO! (Details below)</p>
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
> All CachyOS kernels are available in multiple architecture optimizations: `x86-64`, `x86-64-v3`, `x86-64-v4`, and `znver4`.

---

## ⚠️ Security & Trust Concerns

> [!CAUTION]
> **Before installing CachyOS, please read this section carefully.** The following concerns have been raised by the security and open-source community and are worth considering before trusting this distribution on your system.

### 🔐 Key Developer Residency in Russia

The co-founder and infrastructure maintainer of CachyOS, **Vladyslav Nipohodin**, currently resides in the **Russian Federation**. He has direct access to the **build servers**, signing keys, and repository infrastructure.

Under Russian law — specifically the **Yarovaya Law** and the **SORM (System of Operative Investigative Measures)** framework — any person classified as an "information distribution organizer" is legally required to:

- Store metadata and encryption keys
- Provide them to the **FSB on demand**, without a court order

This means the maintainer of this project may be operating under **legal compulsion** to cooperate with Russian intelligence services, with no ability to disclose this publicly — or face imprisonment.

Historical precedents of this pattern in Russia's IT sector:
| Person / Company | What happened |
| ------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| **Ilya Sachkov / Group-IB** | CEO arrested for "state treason" after sharing data on Russian hackers with foreign agencies. Sentenced to **14 years** in prison. |
| **NGINX / Igor Sysoev** | After acquisition by F5 Networks for $670M, Russian security services raided the Moscow office to seize intellectual property. |
| **Pavel Durov / VKontakte and Telegram** | Forced out of his own company after refusing to hand over data on Ukrainian Euromaidan organizers to the FSB. |

> In authoritarian states, **apoliticism is not neutrality** — it is a form of passive compliance with the regime. A developer who stays silent while their country wages war, and who legally cannot refuse FSB demands, cannot guarantee the independence of their project.

---

### 🏗️ No Reproducible Builds — The Build Server Problem

> [!WARNING]
> CachyOS **does not implement reproducible builds**, unlike Arch Linux.

This is a critical distinction. The source code visible on GitHub and the binary packages you install are **not verifiably identical**. Vladyslav has direct access to the build server and can:

- Modify compilation scripts
- Inject code during the build phase — code that would **never appear on GitHub**

You cannot compile the source yourself and verify you get a byte-identical binary. This makes the build server a **perfect silent attack vector**.

A relevant precedent: the **XZ Utils backdoor (CVE-2024-3094)** demonstrated that even in fully open-source projects, malicious code can be hidden in test binary files, activated only at compile time, and remain undetected for over two years — discovered entirely **by accident** when a Microsoft engineer noticed SSH login was 0.5 seconds slower.

> If a state actor compels the injection of a malicious patch into the CachyOS kernel, that backdoor gains **ring-0 (kernel-level) access** to your system — able to read memory, log keystrokes, and exfiltrate data silently.

---

### ⚡ Real Performance vs. Marketing Claims

The distribution markets itself heavily on performance gains. The engineering reality is more nuanced:

**Where optimizations have negligible impact:**

- Web browsing, messaging, document editing — bottleneck is the network and JavaScript engine, not AVX-512 instruction sets
- The difference between CachyOS and stock Arch Linux is **within margin of error** for typical desktop workloads

**Why the BORE scheduler is a double-edged sword:**
The scheduler aggressively prioritizes the most active process. In practice, this causes background processes to starve of resources — resulting in **frametime spikes**. Stable 120 FPS is a smoother experience than fluctuating 130 FPS.

**Experimentally patched technology:**

- **NTSYNC** — a new Windows sync primitive implementation for Linux gaming. Valve and Wine developers have been working on it for years but have **not merged it into the stable kernel** because it can cause system deadlocks and memory corruption under load. CachyOS ships it enabled by default.
- **Patches from kernel 7.0 backported to 6.x** — these patches are designed for a different kernel infrastructure. They can cause kernel panics and data loss at any time.

> These are the exact patches that **Valve's Proton team and Wine/Proton developers have explicitly rejected** from their own builds due to instability risk.

**On "being first" with new technologies:**
When CachyOS claims to be "first" with new hardware support (e.g., Panther Lake architecture), the support was already present in Ubuntu 26 Unstable months earlier. The patches themselves are written by **Intel engineers** and submitted to the upstream kernel mailing list — CachyOS merely applies them before they pass full audit and stabilization.

---

### 💰 Financial Considerations for Ukrainian & International Users

CachyOS actively collects donations via Patreon and Open Collective. Mirrors are hosted on Russian infrastructure, including Yandex-facilitated servers.

For users in Ukraine or those concerned about the war in Ukraine:

When donating to or promoting CachyOS:

- Payments go to developers residing in Russia
- Under Russian tax law, **13% income tax (NDFL)** on all personal income goes to the federal budget
- **20% VAT** applies to all purchases made with that income
- Russia's official military budget constitutes **40% of the federal budget** — exceeding the combined spending on education, healthcare, social policy, and the national economy

> Using and promoting this OS means participating in a financial chain that, through the Russian tax system, contributes to the military budget of a country currently conducting military operations in Ukraine.

---

### 🔄 Recommended Alternatives

If you're looking for what CachyOS provides, consider these alternatives that do not carry these concerns:

| Your Goal                             | Recommended Alternative                                                                                                     |
| ------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| Arch Linux with a graphical installer | **[EndeavourOS](https://endeavouros.com)** — pure Arch base, Calamares installer, official repos only, no modified packages |
| Gaming kernel with BORE scheduler     | Install `linux-zen` or build any custom kernel from the **AUR** yourself — same result, full control                        |
| Optimized packages                    | Use standard Arch with `makepkg` and compile with your own `-march=native` flags                                            |

EndeavourOS in particular offers the same Arch foundation with a welcome app, AUR helper, and Nvidia driver management — without patching any packages, without modifying upstream libraries, and without a build server you cannot audit.

#### Analysis based on research by Pavlo Kozlenko. [Source video (UA)](https://youtu.be/stKrgHcyr8Q)

---

## Kernel Variants & Schedulers

Each scheduler is optimized for different use cases. We recommend testing each one to find the best fit for your specific requirements.

### Available Schedulers

| Scheduler                                              | Full Name                                                    | Package(s)                             | Best for...                    | Developer                                    |
| :----------------------------------------------------- | :----------------------------------------------------------- | :------------------------------------- | :----------------------------- | :------------------------------------------- |
| **[BORE](https://github.com/firelzrd/bore-scheduler)** | **B**urst-**O**riented **R**esponse **E**nhancer             | `linux-cachyos-bore`                   | Interactive workloads & gaming | [firelzrd](https://github.com/firelzrd)      |
| **[EEVDF](https://lwn.net/Articles/927530/)**          | **E**arliest **E**ligible **V**irtual **D**eadline **F**irst | `linux-cachyos`, `linux-cachyos-eevdf` | General-purpose computing      | Peter Zijlstra                               |
| **[BMQ](https://gitlab.com/alfredchen/linux-prjc)**    | **B**it**M**ap **Q**ueue CPU Scheduler                       | `linux-cachyos-bmq`                    | N/A                            | [Alfred Chen](https://gitlab.com/alfredchen) |

### Specialized Variants

- **`linux-cachyos-hardened`** - Security-focused kernel with hardening patches
- **`linux-cachyos-lts`** - Long Term Support version for stability
- **`linux-cachyos-rt-bore`** - Real-time kernel with BORE scheduler
- **`linux-cachyos-server`** - Server-optimized configuration
- **`linux-cachyos-deckify`** - Steam Deck optimized variant

### Compiler Variants

- **`linux-cachyos`** - Default GCC-compiled kernel with Thin LTO
- **`linux-cachyos-lto`** - Clang and Thin LTO, utilizing AutoFDO + Propeller profiling for optimal performance.

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

- **Multimedia**: v4l2loopback modules included by default
- **Virtualization**: ACS Override support for VFIO/GPU passthrough
- **Upstream Integration**: Cherry-picked patches from Clear Linux and linux-next

> [!INFO]
> For comprehensive details about each kernel variant and their specific optimizations, visit our [Kernel Documentation](https://wiki.cachyos.org/features/kernel).

## CachyOS Repositories

Our [repositories](https://mirror.cachyos.org/) contain optimized Arch Linux and CachyOS packages rebuilt with performance, stability, and security enhancements.

### Available Repository Tiers

| Repository  | Target CPUs             | Package Coverage | Optimization Level               |
| ----------- | ----------------------- | ---------------- | -------------------------------- |
| `znver4`    | AMD Zen 4 & Zen 5       | Full package set | Zen4-specific optimizations      |
| `x86-64-v4` | Intel Xeon / Intel 11th | Full package set | AVX, AVX2, AVX512, SSE4.2, SSSE3 |
| `x86-64-v3` | 2012 or newer           | Full package set | AVX, AVX2, SSE4.2, SSSE3         |
| `x86-64`    | All x86-64 CPUs         | Kernels only     | Basic optimizations              |

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
