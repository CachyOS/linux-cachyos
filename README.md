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
- [Other GNU/Linux distributions](#other-gnulinux-distributions)
  - [Gentoo](#gentoo)
  - [Fedora](#fedora)
  - [NixOS](#NixOS)
 - [Revert changes](#revert-changes)
 - [Support](#support)

# General Information about kernels
The Schedulers listed below are supported

## linux-cachyos
We have provided all these CPU schedulers because each scheduler performs differently depending on usage. We recommend testing each one to determine which best suits your specific requirements.
- **([BORE](https://github.com/firelzrd/bore-scheduler))** **Burst-Oriented Response Enhancer** Scheduler by [firelzrd (BORE)](https://github.com/firelzrd/bore-scheduler) `linux-bore` / `linux-cachyos-bore` / `linux-cachyos`
- **([EEVDF](https://lwn.net/Articles/927530/))** **Earliest Eligible Virtual Deadline** - `linux-cachyos-eevdf`
- **([SCHED-EXT](https://lwn.net/Articles/922405/))** **BPF extensible scheduler class** - `linux-cachyos-sched-ext`

#### CachyOS default kernel
> - **([BORE](https://github.com/firelzrd/bore-scheduler))** **Burst-Oriented Response Enhancer** Scheduler by [firelzrd (BORE)](https://github.com/firelzrd/bore-scheduler) `linux-cachyos`

### :books: Archived schedulers
- **CacULE and CacULE-RDB** by Hamad Marri, supported by CachyOS in the past as - `linux-cachyos-cacule`  
  ***ATTENTION:** Not supported after version 6.1. If you still want to use it, you can get it from the archive repository - [linux-cacule](https://github.com/ptr1337/linux-cacule)*
- **(CFS) - Standard Scheduler Completely Fair Scheduler** - `linux-cachyos-cfs`
- **(BMQ) - BitMap Queue** by Alfred Chen - `linux-cachyos-bmq`
- **(PDS) - Priority and Deadline based Skiplist multiple queue** by Alfred Chen - `linux-cachyos-pds`
  ***ATTENTION:** Not supported after version 6.6.*

### :books: Temporarily archived kernels
- **(TT) - Task Type** Scheduler by [Hamad Marri](https://github.com/hamadmarri/TT-CPU-Scheduler) - `linux-cachyos-tt` / `linux-tt`
  ***ATTENTION:** Not supported after version 6.6. If there will be patch updates, they will most likely be updated to the latest version.*
> The CachyOS repositories provide prebuilt kernels in three different march versions: `x86-64`, `x86-64-v3`, and `x86-64-v4`. In addition, the repositories also offer LTO-enabled kernels.

## Features
Here is a list of features of Linux kernels prebuilt in the CachyOS repositories for `x86-64-v4`, `x86-64-v3`, and `x86-64`.
### :hammer_and_wrench: Advanced building & compiling
- Very customizable PKGBUILD with many features and improvements.
- `GCC/CLANG` Optimization with automatically found CPU architecture or also selectable CPU architecture.
- Choose between `LLVM/LTO & Thin-LTO` or `GCC`.
- Choose between 300Hz, 500Hz, 600 Hz ,750Hz and 1000Hz. Defaults to 500Hz for BORE/CFS/EEVDF and 1000Hz for other schedulers.
- Kernel Control Flow Integrity (kCFI) selectable when using `LLVM`

### :abacus: CPU enhancements
- 3 Different scheduler are supported,`SCHED-EXT`,`BORE`, and `EEVDF` scheduler.
- AMD P-State Preferred Core and enabled as default
- SCHED-EXT Schedulers prebuilt in the repository # https://lwn.net/Articles/922405/ (only for `linux-cachyos-sched-ext`)
### :bookmark_tabs: Filesystem & memory
- Latest BTRFS/XFS/EXT4 improvements & fixes.
- ZFS Filesystem Support and prebuilt in the repository.
- NVIDIA Module Support - Build the nvidia module together with the kernel
- Latest & improved ZSTD 1.5.5 patch-set.
- UserKSM daemon from pf.
- Improved BFQ Scheduler.
- support for bcachefs.

### &#128423; Network 
- BBRv3 tcp_congestion_control.

### :arrow_heading_down: Other features
- partial Clearlinux Patchset.
- Back-ported patches from `linux-next`.
- Scheduler patches from linux-next/tip.
- General improved sysctl settings and upstream scheduler fixes.
- LRNG Framework - *default disabled*
- OpenRGB and ACS Override support
- maple-tree, MG-LRU and per-VMA-locks fixes from upstream
- kvm-lru patches from upstream

# [CachyOS repositories](https://mirror.cachyos.org/)
The repositories contain both Arch Linux and CachyOS packages, which have been re-built with flags optimized for performance, stability, and security.
- `x86-64-v4` - currently only kernel packages + LTO.
- `x86-64-v3` - all Arch Linux packages + LTO.
- `x86-64` - all Arch Linux packages + LTO.

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

For more information, check out our [GitHub](https://github.com/cachyos) or join our [Discord](https://discord.gg/k39qfrxPNa) community.

### Option 2: Manual Installation

1. Install the cachyos keyring
```
sudo pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key F3B607488DB35A47
```

2. Install required packages
```
sudo pacman -U 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-3-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-18-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-18-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v4-mirrorlist-6-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/pacman-6.0.2-14-x86_64.pkg.tar.zst'
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
  haswell (AT_PLATFORM; supported, searched)
  tls (supported, searched)
  avx512_1 (supported, searched)
  x86_64 (supported, searched)
```

#### Example of CPU incompatible with x86-64-v4 instruction set
```
> /lib/ld-linux-x86-64.so.2 --help | grep supported
  x86-64-v4
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

#### if your CPU supports `x86-64-v4`, then add `[cachyos-v4]`, `[cachyos-v3]`, `[cachyos-core-v3]`, `[cachyos-extra-v3]` and `[cachyos]`
```
# cachyos repos
## Only add if your CPU does support x86-64-v4 architecture
[cachyos-v4]
Include = /etc/pacman.d/cachyos-v4-mirrorlist
[cachyos-v3]
Include = /etc/pacman.d/cachyos-v3-mirrorlist
[cachyos-core-v3]
Include = /etc/pacman.d/cachyos-v3-mirrorlist
[cachyos-extra-v3]
Include = /etc/pacman.d/cachyos-v3-mirrorlist
[cachyos]
Include = /etc/pacman.d/cachyos-mirrorlist
```

Finally, update your system with CachyOS packages:

```
sudo pacman -Syu
```
Enjoy improved system speed with CachyOS packages!

## Debug packages

We provide a debuginfod server for easy access to debug symbols via `gdb`. Set the following environment variable:

```
export DEBUGINFOD_URLS=https://debuginfod.cachyos.org
```

Debug packages are available in the `cachyos-debug-v3` repository. Add it with the following configuration:

```
[cachyos-debug-v3]
Server = https://debug.cachyos.org/repo/$arch_v3/$repo
[cachyos-core-debug-v3]
Server = https://debug.cachyos.org/repo/$arch_v3/$repo
[cachyos-extra-debug-v3]
Server = https://debug.cachyos.org/repo/$arch_v3/$repo
```

## Uninstalling CachyOS repositories

### Option 1: Automated Removal

Run these commands to remove the CachyOS repos from your system:

```
wget https://build.cachyos.org/cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz
cd cachyos-repo
sudo ./cachyos-repo.sh --remove
```

### Option 2: Manual Removal

1.  Backup or remove the config file at `/etc/pacman.conf`.
2.  Run this command:

```
sudo mv /etc/pacman.conf.bak /etc/pacman.conf
```

3.  Switch to default Arch Linux packages with this command:

```
sudo pacman -Suuy
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
[Port](https://github.com/sirlucjan/copr-linux-cachyos) of kernel linux-cachyos-bore and linux-cachyos-bore-lto by [bieszczaders](https://copr.fedorainfracloud.org/coprs/bieszczaders/kernel-cachyos/)

Only x86_64_v3 versions are available. Check support by the following the command
```
/lib64/ld-linux-x86-64.so.2 --help | grep "(supported, searched)"

```
If it does not detect x86_64_v3 support do not install the kernel. Otherwise you will end up with a non-functioning operating system!

##### Installation Instructions:

###### Fedora Workstation

```
sudo dnf copr enable bieszczaders/kernel-cachyos
```

and next

```
sudo dnf install kernel-cachyos-bore
```

OR
```
sudo dnf install kernel-cachyos-bore-eevdf
```

###### Fedora Silverblue

```
cd /etc/yum.repos.d/

sudo wget https://copr.fedorainfracloud.org/coprs/bieszczaders/kernel-cachyos/repo/fedora-$(rpm -E %fedora)/bieszczaders-kernel-cachyos-fedora-$(rpm -E %fedora).repo
```

and next

```
sudo rpm-ostree override remove kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra --install kernel-cachyos-bore

sudo systemctl reboot
```

OR
```
sudo rpm-ostree override remove kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra --install kernel-cachyos-bore-eevdf

sudo systemctl reboot
```

### NixOS

Nyx does provide a precompiled CachyOS Kernel and a bunch of other interesting packages. This repository is maintained by [chaotic-aur](https://github.com/chaotic-cx)
Just follow this [README](https://github.com/chaotic-cx/nyx#how-to-use-it)

## Revert changes
How to backup and use Arch packages?
- Remove or Backup the config located at /etc/pacman.conf
- then run `sudo mv /etc/pacman.conf.bak /etc/pacman.conf`
- Then run following command to switch the packages to the default arch packages `sudo pacman -Suuy`

## How to use CLANG/LLVM/LTO compiled Kernels on Nvidia driver with DKMS
> This is no longer necessary, as you can simply install the latest DKMS version from our repository.

## Support
**Discord:** <https://discord.gg/qJqj94uFwE> <br />
**Telegram:** <https://t.me/+zCzPX4cAFjk1MTYy> <br />
**Matrix:** <https://matrix.cachyos.org> <br />

## Donations appreciated for maintaining repositories and build server. Thank you for your support!
**PayPal:** <https://paypal.me/pttrr> <br />
**Patreon:** <https://www.patreon.com/CachyOS> <br />
**BTC:** bc1qmwglfchlc335du6pcu6w64cexu7cck0mzhyw42 <br />
**ETH:** 0xc2dc77327F78A7B85Db3941Eb49e74F41E961649

## Valueable Contributors
[Hamad Marri](https://github.com/hamadmarri) for the TT Scheduler <br />
[Archlinux](https://archlinux.org) for the great linux operating system <br />
[And all other Kernel Developers and Supporters](https://github.com/torvalds/linux) <br />
