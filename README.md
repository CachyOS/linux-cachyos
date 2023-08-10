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
- [Other GNU/Linux distributions](#other-gnulinux-distributions)
  - [Gentoo](#gentoo)
  - [Fedora](#fedora)
  - [NixOS](#NixOS)
 - [Revert changes](#revert-changes)
 - [Support](#support)

# General Information about kernels
The Schedulers listed below are supported

## linux-cachyos
We have provided all of these CPU schedulers because each scheduler performs differently depending on usage. We recommend testing each one to determine which best suits your specific requirements.
- **(BORE) - Burst-Oriented Response Enhancer** Scheduler by [firelzrd (BORE)](https://github.com/firelzrd/bore-scheduler) `linux-bore` / `linux-cachyos-bore`
- **([EEVDF](https://lwn.net/Articles/927530/))** **Earliest Eligible Virtual Deadline** - `linux-cachyos-eevdf`
- **([EEVDF](https://lwn.net/Articles/927530/))** **Earliest Eligible Virtual Deadline** & **([BORE](https://github.com/firelzrd/bore-scheduler))** **Burst-Oriented Response Enhancer** - have been combined in the `linux-cachyos`
- **(TT) - Task Type** Scheduler by [Hamad Marri](https://github.com/hamadmarri/TT-CPU-Scheduler) - `linux-cachyos-tt` / `linux-tt`
- **(BMQ) - BitMap Queue** by Alfred Chen - `linux-cachyos-bmq`
- **(PDS) - Priority and Deadline based Skiplist multiple queue** by Alfred Chen - `linux-cachyos-pds`
- **(CFS) - Standard Scheduler Completely Fair Scheduler** - `linux-cachyos-cfs`

### :books: Archived schedulers
- **CacULE and CacULE-RDB** by Hamad Marri, supported by CachyOS in the past as - `linux-cachyos-cacule`  
  ***ATTENTION:** Not supported after version 6.1. If you still want to use it, you can get it from the archive repository - [linux-cacule](https://github.com/ptr1337/linux-cacule)*
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
- 6 Different scheduler are supported,`CFS`,`TT`,`BMQ`,`BORE`,`PDS` and `EEVDF` scheduler.
- Latency Nice included with EEVDF
- RCU fixes and improvements.
- EEVDF Scheduler # https://lwn.net/Articles/927530/
- EEVDF-BORE Scheduler Variant used in linux-cachyos
### :bookmark_tabs: Filesystem & memory
- Latest BTRFS/XFS/EXT4 improvements & fixes.
- ZFS Filesystem Support and prebuilt in the repository.
- Latest & improved ZSTD 1.5.5 patch-set.
- UserKSM daemon from pf.
- Improved BFQ Scheduler.
- support for bcachefs.
- [per VMA lock](https://lore.kernel.org/lkml/20230109205336.3665937-1-surenb@google.com/T/#ma04517b963591298a9eb76d96d2c453256a4d9ab)
- zram patches from upstream

### &#128423; Network 
- BBRv3 tcp_congestion_control.

### :arrow_heading_down: Other features
- Clearlinux Patchset.
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
### 🦾 Automatic adding of cachyos repositories
Run following commands:
1. Get archive with script
```
wget https://mirror.cachyos.org/cachyos-repo.tar.xz
```
> If don't have `wget`, install them by `sudo pacman -S wget`

2. Extract and enter into the archive
```
tar xvf cachyos-repo.tar.xz && cd cachyos-repo
```

3. Run script with sudo
```
sudo ./cachyos-repo.sh
```

#### Behaviour of script  
1. The script automatically detects the CPU architecture. If the CPU supports `x86-64-v4` or `x86-64-v3`, the script uses the repositories optimized with this flag and other flags.
2. The script will create a backup of your previous `pacman.conf` file.

### Manually
1. Add both keys
```
sudo pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
```
```
sudo pacman-key --lsign-key F3B607488DB35A47
```

2. You can download first initial packages
```
sudo pacman -U 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-2-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-17-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-17-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v4-mirrorlist-5-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/pacman-6.0.2-11-x86_64.pkg.tar.zst'
```

## Check CPU compatibility
If you want to add our repositories manually, you must check the compatibility of the CPU with cachyos repositories.
> If you use script above for adding cachyos repositories, you can skip checking.

### 1. Check support by the following the command
```
/lib/ld-linux-x86-64.so.2 --help | grep supported
```

### 2. Understanding of command output
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
     STDIN
  40 Subdirectories of glibc-hwcaps directories, in priority order:
  41   x86-64-v4
  42   x86-64-v3 (supported, searched)                                          
  43   x86-64-v2 (supported, searched)       
```

### 3. Adding cachyos repositories
You need edit `pacman.conf` and add repositories.
```
sudo nano /etc/pacman.conf
```

#### if CPU support `x86-64`, then add only `[cachyos]` repositories
```
# cachyos repos
## Only add if your CPU does v3 architecture
[cachyos]
Include = /etc/pacman.d/cachyos-mirrorlist
```

#### if CPU support `x86-64-v3`, then add `[cachyos-v3]`,`[cachyos-core-v3]`, `[cachyos-extra-v3]` and `[cachyos]`
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

#### if CPU support `x86-64-v4`, then add `[cachyos-v4]`, `[cachyos-v3]`, `[cachyos-core-v3]`, `[cachyos-extra-v3]` and `[cachyos]`
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

```
sudo dnf copr enable bieszczaders/kernel-cachyos
```

and next

```
sudo dnf install kernel-cachyos-bore
```

OR
```
sudo dnf install kernel-cachyos-bore-lto
```

##### Install drivers for LTO kernel
For those who build external modules such as Nvidia graphics card drivers and use the -lto kernel, make sure to install the required dependencies.
```
sudo dnf install clang clang-devel llvm lld
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
