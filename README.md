# <center>Linux Kernel with several scheduler and other improvements</center>

## General Informations

The CachyOS are improved kernels which improve the performance and other improvements. Following Scheduler are supported:

- Standard Scheduler Completely Fair Scheduler (CFS) - linux-cachyos
- CacULE and CacULE-RDB created from Hamad Marri, maintained by CachyOS - linux-cachyos-cacule
- BitMap Queue (BMQ) Alfred Chen Scheduler - linux-cachyos-bmq
- Priority and Deadline based Skiplist multiple queue scheduler (PDS) - Alfred Chen Scheduler » linux-cachyos-pds
- Task Type Scheduler by [Hamad Marri (TT)](https://github.com/hamadmarri/TT-CPU-Scheduler) - linux-cachyos-tt
- BORE (Burst-Oriented Response Enhancer) CPU Scheduler by [firelzrd (BORE)](https://github.com/firelzrd/bore-scheduler) - linux-cachyos-bore

**All kernels are prebuilt in two different march versions (x86_64 and x86_64_v3) and also with the lto enabled kernels in the cachyos repo.**

## Features

- Very customizable PKGBUILD with many features and improvements
- 5 Different scheduler are supported, CacULE-,CFS-,tt-,bmq-,bore-, and pds scheduler
- GCC/CLANG Optimization with automatically found cpu arch or also selectable cpu arch
- Choose between LLVM/LTO or GCC
- Choose between 300Hz, 500Hz, 600 Hz ,750Hz and 1000Hz
- Improved BFQ Scheduler
- Back-ported patches from linux-next
- General improved sysctl settings and upstream scheduler fixes
- Latest LRU Patch-set, default enabled
- Damon Reclaim enabled at default
- BBRv2 tcp_congestion_control
- LLVM ThinLTO provided with *-lto Kernel (in the cachyos-repo)
- LRNG Framework (default enabled)
- Android ANBOX patch-set
- Latest & improved ZSTD patch-set
- Latest BTRFS improvements & fixes
- KSMBD Module for Samba3 Server
- AMD PSTATE Driver enabled by default
- Clearlinux Patchset
- Control Flow Integrity (CFI) selectable when using LLVM
- ZFS Filesystem Support and prebuilt in the repo!
- WINESYNC Fastsync

## WINESYNC Usage:

Insall following packages from the AUR, if you get into issue's:

- [winesync](https://aur.archlinux.org/packages/winesync)
- [winesync-dkms](https://aur.archlinux.org/packages/winesync-dkms)
- [winesync-header](https://aur.archlinux.org/packages/winesync-header)
- [winesync-udev-rule](https://aur.archlinux.org/packages/winesync-udev-rule)

And disable following enviroment variables in lutris/steam/..

```
WINEESYNC=0
WINEFSYNC=0
WINEFSYNC_FUTEX2=0
```

Also you need a wine/proton which includes the winesync patch. I would recommend to built one from [wine-tkg](https://github.com/Frogging-Family/wine-tkg-git) or you will find prebuilt ones in our repo.

## Other distros

- First I will release every kernel update with a complete patch for every scheduler and their config.
- Next I will implement a building system so it is possible to build the kernel for several distros.
- Maybe I will provide some releases for debian based distros.

## We are providing a [repo](https://mirror.cachyos.org/) which includes all kernels in generic-v3 and generic and more optimized packages

### How to add our repo automatically with CPU detection (if x86-64-v3 is supported)

**Just run following command:**

## **automatic march detection and changing the pacman.conf:**

```
wget https://mirror.cachyos.org/cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz
cd repo
sudo ./cachyos-repo.sh
```

--------------------------------------------------------------------------------

--

## **manually**:

````
sudo pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com

sudo pacman-key --lsign-key F3B607488DB35A47

sudo pacman -U 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-2-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-8-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-8-1-any.pkg.tar.zst'

  **Checking x86_64_v3 cpu support:**

  /lib/ld-linux-x86-64.so.2 --help | grep "x86-64-v3 (supported, searched)"

  if you get an output change at the /etc/pacman.conf following:
  ```
  #Architecture = auto
  Architecture = x86_64 x86_64_v3
  ```
  add following under the arch repos the "-v3" repos only if they are supported:
  ```
  # cachyos repos
  [cachyos-v3]
  Include = /etc/pacman.d/cachyos-v3-mirrorlist
  [cachyos]
  Include = /etc/pacman.d/cachyos-mirrorlist
````

--------------------------------------------------------------------------------

```
This script will also backup your old pacman.conf.

This script will auto-detect you architecture, if your CPU have x86-64-v3 support, it will automatically use the repos which are optimized with this flag and some other flags.

Also all provided Kernels, Browsers, ... are optimized and compiled.

## How to Backup the config and use the native Arch Packages

- Remove or Backup the config located at /etc/pacman.conf
- then run `sudo mv /etc/pacman.conf.bak /etc/pacman.conf`
- Then run following command to switch the packages to the default arch packages `sudo pacman -Suuy`


More information's you will find here [CachyOS](https://github.com/cachyos) or [Discord](https://discord.gg/k39qfrxPNa)
```

## How to use CLANG/LLVM/LTO compiled Kernels on Nvidia driver with DKMS:

Not needed anymore, just install the latest dkms version (3.0.2).

## Support

You can join the CachyOS Discord with the following link:

<https://discord.gg/qJqj94uFwE>

or at telegram:

<https://t.me/+zCzPX4cAFjk1MTYy>

## Donations are welcome for the compile server for the repo or a cup of coffee for maintain this repo

<https://paypal.me/pttrr>

### Valueable Contributors

[Hamad Marri](https://github.com/hamadmarri) for the CacULE Scheduler

[BL4CKH47H4CK3R](https://github.com/BL4CKH47H4CK3R) for Optimization, Bug Hunting & Support

[SirLucjan (Piotr Gorski)](https://github.com/sirlucjan)

[Archlinux](https://archlinux.org) for the great linux operating system

[And all other Kernel Developers and Supporters](https://github.com/torvalds/linux)
