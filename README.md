<div align="center">
  <img src="https://github.com/CachyOS/calamares-config/blob/grub-3.2/etc/calamares/branding/cachyos/logo.png" width="64" alt="CachyOS logo"></img>
  <br/>
  <h1 align="center">CachyOS</h1>
  <p align="center">CachyOS provides enhanced kernels that offer improved performance and other benefits.</p>
</div>


- [General Information about kernels](#general-information-about-kernels)
  - [linux-cachyos](#linux-cachyos)
  - [Features](#features)
- [CachyOS repositories](#cachyos-repositories)
  - [How to add CachyOS repositories](#how-to-add-cachyos-repositories)
  - [Check CPU compatibility](#check-cpu-compatibility)
  - [Uninstalling CachyOS repositories](#uninstalling-cachyos-repositories)
  - [Install SCX schedulers - only for linux-cachyos-sched-ext](#install-scx-schedulers)
- [Other GNU/Linux distributions](#other-gnulinux-distributions)
  - [Gentoo](#gentoo)
  - [Fedora](#fedora)
  - [NixOS](#NixOS)
 - [Support](#support)

# General Information about kernels
The Schedulers listed below are supported

## linux-cachyos
We have provided all these CPU schedulers because each scheduler performs differently depending on usage. We recommend testing each one to determine which best suits your specific requirements.
- **([BORE](https://github.com/firelzrd))** **Burst-Oriented Response Enhancer** Scheduler by [firelzrd (BORE)](https://github.com/firelzrd/bore-scheduler) `linux-cachyos` / `linux-bore` / `linux-cachyos-bore`
- **([EEVDF](https://lwn.net/Articles/927530/))** **Earliest Eligible Virtual Deadline** - `linux-cachyos-eevdf`
- **([SCHED-EXT](https://lwn.net/Articles/922405/))** **BPF extensible scheduler class** - `linux-cachyos-sched-ext` / `linux-cachyos-sched-ext-debug`
- **([ECHO](https://github.com/hamadmarri))** **Enhanced CPU Handling Orchestrator** Scheduler by [Hamad Marri](https://github.com/hamadmarri) - `linux-cachyos-echo`

#### CachyOS default kernel
> - **([SCHED-EXT](https://lwn.net/Articles/922405/))** **BPF extensible scheduler class** + **BORE Scheduler** - `linux-cachyos`

> The CachyOS repositories provide prebuilt kernels in three different march versions: `x86-64`, `x86-64-v3`, and `x86-64-v4`. In addition, the repositories also offer LTO-enabled kernels.

## Features
Here is a list of features of Linux kernels prebuilt in the CachyOS repositories for `x86-64-v4`, `x86-64-v3`, and `x86-64`.
### :hammer_and_wrench: Advanced building & compiling
- Very customizable PKGBUILD with many features and improvements.
- `GCC/CLANG` Optimization with automatically found CPU architecture or also selectable CPU architecture.
- Choose between `LLVM/LTO & Thin-LTO` or `GCC`.
- Choose between 300Hz, 500Hz, 600 Hz ,750Hz and 1000Hz. Defaults to 1000Hz
- Kernel Control Flow Integrity (kCFI) selectable when using `LLVM`

### :abacus: CPU enhancements
- 3 Different scheduler are supported,`SCHED-EXT`,`BORE`,`EEVDF` and `ECHO` scheduler
- AMD P-State Preferred Core, AMD cpb boost (disable boost) and upstream amd-pstate enhancements
- SCHED-EXT Schedulers prebuilt in the repository # https://lwn.net/Articles/922405/ - `linux-cachyos` and `linux-cachyos-sched-ext`
- Cachy Sauce (CONFIG_CACHY), enables various tweaks for the scheduler and other settings
### :bookmark_tabs: Filesystem & memory
- ZFS Filesystem Support and prebuilt in the repository
- NVIDIA Module Support including patches - Build the nvidia module together with the kernel
- Latest & improved ZSTD 1.5.6 patch-set
- UserKSM daemon from pf
- Improved BFQ Scheduler

### &#128423; Network 
- BBRv3 tcp_congestion_control

### :arrow_heading_down: Other features
- partial Clearlinux Patchset.
- Back-ported patches from `linux-next`
- Scheduler patches from linux-next/tip
- OpenRGB and ACS Override support
- AMD: Allow override of min_powercap with `amdgpu_ignore_min_pcap`
- Steam Deck Patches included - Audio, HW Quirks, HID
- Rog Ally patches included
- v4l2loopback modules as default included
- HDR support enabled
- Various GCC Optimization flags applied (`-fivopts -fmodulo-sched`)
- NTSync patched and integrated into the kernel (`NTSYNC=y`)
- VRR fixes for AMD GPU's

# [CachyOS repositories](https://mirror.cachyos.org/)
The repositories contain both Arch Linux and CachyOS packages, which have been re-built with flags optimized for performance, stability, and security.
- `x86-64-v4` - all Arch Linux packages + LTO
- `x86-64-v3` - all Arch Linux packages + LTO
- `x86-64` - currently only kernel packages

## How to add CachyOS repositories

### Option 1: Automated Installation of cachyos repositories

We've made it easy for you! Simply run the following commands to use our helper script that does all the work for you.  😉

Run the following commands:
1. Get archive with script

```
wget https://mirror.cachyos.org/cachyos-repo.tar.xz
```
> If you don't have `wget`, install it with `sudo pacman -S wget`

2. Extract and enter into the archive
```
tar xvf cachyos-repo.tar.xz && cd cachyos-repo
```

3. Run script with sudo
```
sudo ./cachyos-repo.sh
```

#### Behaviour of script
1. Script will auto-detect CPU architecture, if CPU has `x86-64-v4` or `x86-64-v3` support, script will automatically use the repositories which are optimized with this flag > and some other flags.
2. Script will backup your old `pacman.conf`.

For more information, check out our [GitHub](https://github.com/cachyos) or join our [Discord](https://discord.gg/cachyos-862292009423470592) community.

### Option 2: Manual Installation

1. Install the cachyos keyring
```
sudo pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key F3B607488DB35A47
```

2. Install required packages

ATTENTION: Installing the CachyOS Pacman, will install a forked pacman with features added from CachyOS, like "INSTALLED_FROM" and an automatic architecture check.
Pacman 6.1 added a feature validation feature, which could lead when using the Archlinux pacman into warnings. We are working with archlinux to provide a proper compatibility again.
If you want to avoid this, don't add the "cachyos" repository, which contains the customized pacman. All other repositories like cachyos-v3, cachyos-v4, cachyos-extra/core-v3/4 are fine to add.

```
sudo pacman -U 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-20240331-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-18-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-18-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v4-mirrorlist-6-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/pacman-6.1.0-7-x86_64.pkg.tar.zst'
```

## Check CPU compatibility
If you want to add our repositories manually, you must check the compatibility of the CPU with cachyos repositories.
> If you are using the script above to add cachyos repositories, you can skip the check.

#### 1. Check support by running the following the command
```
/lib/ld-linux-x86-64.so.2 --help | grep supported
```

#### 2. Understanding of command output
Pay attention to the following text with brackets. **(supported, searched)**
- If you see `x86-64-v4 (supported, searched)`, that means the **CPU is compatible** and can use **x86-64-v4** instruction set.
- If you see `x86-64-v4`, that means the **CPU is incompatible** and can't use **x86-64-v4** instruction set.

#### Example of CPU compatible with x86-64-v4 instruction set
```
> /lib/ld-linux-x86-64.so.2 --help | grep supported
  x86-64-v4 (supported, searched)
  x86-64-v3 (supported, searched)
  x86-64-v2 (supported, searched)
```

### 3. Adding cachyos repositories
You need to edit `pacman.conf` and add repositories.
```
sudo nano /etc/pacman.conf
```

#### if your CPU supports `x86-64`, then add only `[cachyos]` repositories
```
# cachyos repos
[cachyos]
Include = /etc/pacman.d/cachyos-mirrorlist
```

#### if your CPU supports `x86-64-v3`, then add `[cachyos-v3]`,`[cachyos-core-v3]`,`[cachyos-extra-v3]` and `[cachyos]`
```
# cachyos repos
## Only add if your CPU does v3 architecture
[cachyos-v3]
Include = /etc/pacman.d/cachyos-v3-mirrorlist
[cachyos-core-v3]
Include = /etc/pacman.d/cachyos-v3-mirrorlist
[cachyos-extra-v3]
Include = /etc/pacman.d/cachyos-v3-mirrorlist
[cachyos]
Include = /etc/pacman.d/cachyos-mirrorlist
```

#### if your CPU supports `x86-64-v4`, then add `[cachyos-v4]`, `[cachyos-core-v4]`, `[cachyos-extra-v4]` and `[cachyos]`
```
# cachyos repos
## Only add if your CPU does support x86-64-v4 architecture
[cachyos-v4]
Include = /etc/pacman.d/cachyos-v4-mirrorlist
[cachyos-core-v4]
Include = /etc/pacman.d/cachyos-v4-mirrorlist
[cachyos-extra-v4]
Include = /etc/pacman.d/cachyos-v4-mirrorlist
[cachyos]
Include = /etc/pacman.d/cachyos-mirrorlist
```

Finally, update your system with CachyOS packages:

```
sudo pacman -Syu
```
Enjoy improved system speed with CachyOS packages!

## Debug packages

See [CachyOS Wiki](https://wiki.cachyos.org/cachyos_repositories/how_to_add_cachyos_repo/)

## Uninstalling CachyOS repositories

See [Uninstalling Cachyos Repositories](https://wiki.cachyos.org/cachyos_repositories/how_to_add_cachyos_repo/#uninstalling-cachyos-repositories)

## Install SCX Schedulers

If you choose linux-cachyos or linux-cachyos-sched-ext you can install scx-scheds package, which includes external schedulers, which can be started in userspace and detach the kernel scheduler

```
sudo pacman -S scx-scheds
# or -git package for latest features and updates
sudo pacman -S scx-scheds-git
```

Below is a list of schedulers with their locations:

```
/usr/bin/scx_central
/usr/bin/scx_flatcg
/usr/bin/scx_lavd
/usr/bin/scx_layered
/usr/bin/scx_nest
/usr/bin/scx_pair
/usr/bin/scx_qmap
/usr/bin/scx_rlfifo
/usr/bin/scx_rustland
/usr/bin/scx_rusty
/usr/bin/scx_simple
/usr/bin/scx_userland
```

To start the scheduler, execute in the console:

```
sudo scx_NAME
```

## Other GNU/Linux distributions
- Complete patch for simple patching on the kernel
- It is planned to implement into our kernel builder from cachyos buildsystem, which works also on other distributions.

### Gentoo
Its a community maintained ebuild from a user, which can be used for a dynamic building right [here](https://github.com/Szowisz/CachyOS-kernels)

Or simply run:
```
eselect repository add CachyOS-kernels git https://github.com/Szowisz/CachyOS-kernels
emaint sync -r CachyOS-kernels
```
### Fedora
[Port](https://github.com/sirlucjan/copr-linux-cachyos) of kernel linux-cachyos-bore, linux-cachyos-rt-bore, linux-cachyos-bore-lto and linux-cachyos-lts by [bieszczaders](https://copr.fedorainfracloud.org/coprs/bieszczaders/kernel-cachyos/)

Visit the [COPR page](https://copr.fedorainfracloud.org/coprs/bieszczaders/kernel-cachyos/) for installation instructions and the latest announcements.

### NixOS

Nyx does provide a precompiled CachyOS Kernel and a bunch of other interesting packages. This repository is maintained by [chaotic-aur](https://github.com/chaotic-cx)
Just follow this [README](https://github.com/chaotic-cx/nyx#how-to-use-it)

## Support
**Discord:** <https://discord.gg/cachyos-862292009423470592> <br />
**Forum:** <https://discuss.cachyos.org> <br />
**Telegram:** <https://t.me/+zCzPX4cAFjk1MTYy> <br />
**Matrix:** <https://matrix.cachyos.org> <br />

## Donations appreciated for maintaining repositories and build server. Thank you for your support!
**PayPal:** <https://paypal.me/pttrr> <br />
**Patreon:** <https://www.patreon.com/CachyOS> <br />
**BTC:** bc1qmwglfchlc335du6pcu6w64cexu7cck0mzhyw42 <br />
**ETH:** 0xc2dc77327F78A7B85Db3941Eb49e74F41E961649 <br />
**LTC:** LgGTwcEBcXqMgNT6XyyNWABMb7dZVtVg9w

## Valueable Contributors
[Hamad Marri](https://github.com/hamadmarri) for the TT Scheduler <br />
[Archlinux](https://archlinux.org) for the great linux operating system <br />
[And all other Kernel Developers and Supporters](https://github.com/torvalds/linux) <br />
