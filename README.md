# <center>Linux Kernel with several scheduler and other improvements</center>

## General Information

CachyOS are improved kernels that improve performance and other aspects. The Schedulers listed below are supported:

### linux-cachyos will now use as default the BORE scheduler!

- Standard Scheduler Completely Fair Scheduler (CFS) - linux-cachyos-cfs
- CacULE and CacULE-RDB created from Hamad Marri, maintained by CachyOS - linux-cachyos-cacule
- BitMap Queue (BMQ) Alfred Chen Scheduler - linux-cachyos-bmq
- Priority and Deadline based Skiplist multiple queue scheduler (PDS) - Alfred Chen Scheduler » linux-cachyos-pds
- Task Type Scheduler by [Hamad Marri (TT)](https://github.com/hamadmarri/TT-CPU-Scheduler) - linux-cachyos-tt / linux-tt
- BORE (Burst-Oriented Response Enhancer) CPU Scheduler by [firelzrd (BORE)](https://github.com/firelzrd/bore-scheduler) - linux-cachyos-bore / linux-cachyos / linux-bore

**All kernels are prebuilt in two different march versions (x86_64 and x86_64_v3) and also with the lto enabled kernels in the cachyos repo.**

## Features

- Very customizable PKGBUILD with many features and improvements
- 5 Different scheduler are supported, CacULE-,CFS-,tt-,bmq-,bore-, and pds scheduler
- GCC/CLANG Optimization with automatically found cpu arch or also selectable cpu arch
- Choose between LLVM/LTO or GCC
- Choose between 300Hz, 500Hz, 600 Hz ,750Hz and 1000Hz # default 750 Hz
- Improved BFQ Scheduler
- Back-ported patches from linux-next
- General improved sysctl settings and upstream scheduler fixes
- Latest LRU (v15) Patch-set, default enabled
- Maple Tree from linux-next
- MM Demotion from linux-next
- Latency Nice Patchset included usuage with ananicy-cpp feature branch (https://lore.kernel.org/lkml/20220925143908.10846-1-vincent.guittot@linaro.org/T/#t)
- NEST Scheduler
- rcu fixes and improvements
- latest DAMON improvements and fixes
- BBRv2 tcp_congestion_control
- LLVM THIN-LTO Kernels prebuilt in x86-64-v3 and x86-64 in the CachyOS repo
- LRNG Framework (default enabled)
- Latest & improved ZSTD patch-set
- Latest BTRFS/XFS/EXT4 improvements & fixes
- KSMBD Module for Samba3 Server
- AMD PSTATE EPP Driver enabled by default and with enhancements patches/fixes
- Clearlinux Patchset
- Kernel Control Flow Integrity (kCFI) selectable when using LLVM(patched llvm can be found in the cachyos-repo)
- ZFS Filesystem Support and prebuilt in the repo!
- WINESYNC Fastsync
- Use entropy optimization for zram
- UserKSM daemon from pf
- support for bcachefs

## Other distros

- Complete patch for simple patching on the kernel
- It is planned to implement into our kernel builder from cachyos buildsystem, which works also on other distro

### Gentoo

Its a community maintained ebuild from a user, which can be used for a dynamic building:
(https://github.com/sandikata/ROKO__/tree/master/sys-kernel/cachyos-sources)

Or simply run:

```
eselect repository enable ROKO__
emaint sync -r ROKO__
```

## We are providing a [repo](https://mirror.cachyos.org/) which includes all kernels in generic-v3 and generic and more optimized packages

### How to add our repo automatically with CPU detection (if x86-64-v3 is supported)

**Just run following command:**

## **Automatic `march` detection and changing the pacman.conf:**

```
wget https://mirror.cachyos.org/cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz && cd cachyos-repo
sudo ./cachyos-repo.sh
```

## **Manually**:

````
sudo pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com

sudo pacman-key --lsign-key F3B607488DB35A47

sudo pacman -U 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-2-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-13-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-13-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/pacman-6.0.2-6-x86_64.pkg.tar.zst'

  **Checking x86_64_v3 cpu support:**

  /lib/ld-linux-x86-64.so.2 --help | grep "x86-64-v3 (supported, searched)"

  add following under the arch repos the "-v3" repos only if they are supported:
  ```
  # cachyos repos
  ## Only add if your cpu does v3 architecture
  [cachyos-v3]
  Include = /etc/pacman.d/cachyos-v3-mirrorlist
  [cachyos]
  Include = /etc/pacman.d/cachyos-mirrorlist
  ````

This script will also backup your old pacman.conf.

This script will auto-detect you architecture, if your CPU have x86-64-v3 support, it will automatically use the repos which are optimized with this flag and some other flags.

Also all provided Kernels, Browsers, ... are optimized and compiled.

## How to Backup the config and use the native Arch Packages

- Remove or Backup the config located at /etc/pacman.conf
- then run `sudo mv /etc/pacman.conf.bak /etc/pacman.conf`
- Then run following command to switch the packages to the default arch packages `sudo pacman -Suuy`


More information's you will find here [CachyOS](https://github.com/cachyos) or [Discord](https://discord.gg/k39qfrxPNa) 

## How to use CLANG/LLVM/LTO compiled Kernels on Nvidia driver with DKMS:

Not needed anymore, just install the latest dkms version (3.0.2).

## Support

You can join the CachyOS Discord with the following link:

<https://discord.gg/qJqj94uFwE>

or at telegram:

<https://t.me/+zCzPX4cAFjk1MTYy>

## Donations are welcome for the compile server for the repo or a cup of coffee for maintain this repo

<https://paypal.me/pttrr>

<https://www.patreon.com/CachyOS>

### Valueable Contributors

[Hamad Marri](https://github.com/hamadmarri) for the CacULE Scheduler

[Archlinux](https://archlinux.org) for the great linux operating system

[And all other Kernel Developers and Supporters](https://github.com/torvalds/linux)
