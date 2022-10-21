<div align="center">
  <img src="https://github.com/CachyOS/calamares-config/blob/grub-3.2/etc/calamares/branding/cachyos/logo.png" width="64" alt="CachyOS logo"></img>
  <br/>
  <h1 align="center">CachyOS</h1>
  <p align="center">CachyOS ships improved kernels that improve performance and other aspects.</p>
</div>

## 🌐 General Information about kernels
The Schedulers listed below are supported:

### 🧬 linux-cachyos uses as default the BORE scheduler
We provided all of these schedulers because each scheduler performs differently and depends on usage. Please test it and choose what suits your requirements.
- BORE (Burst-Oriented Response Enhancer) CPU Scheduler by [firelzrd (BORE)](https://github.com/firelzrd/bore-scheduler)
  - `linux-cachyos` - Default kernel and we decided to ship BORE by default, but the scheduler could be changed in the future.
  - `linux-cachyos-bore` - If we decide to change the scheduler in the future, we still want to provide BORE.
- Task Type Scheduler by [Hamad Marri (TT)](https://github.com/hamadmarri/TT-CPU-Scheduler) - `linux-cachyos-tt` / `linux-tt`
- BitMap Queue (BMQ) Alfred Chen Scheduler - `linux-cachyos-bmq`
- Priority and Deadline based Skiplist multiple queue scheduler (PDS) - Alfred Chen Scheduler » `linux-cachyos-pds`
- CacULE and CacULE-RDB created from Hamad Marri, maintained by CachyOS - `linux-cachyos-cacule`
- Standard Scheduler Completely Fair Scheduler (CFS) - `linux-cachyos-cfs`
> All kernels are prebuilt in two different march versions (x86-64 and x86-64-v3) and also with the LTO-enabled kernels in the cachyos repositories.

## 🎯 Features
- Very customizable PKGBUILD with many features and improvements.
- 5 Different scheduler are supported, `CacULE-`,`CFS-`,`tt-`,`bmq-`,`bore-`, and `pds` scheduler
- `GCC/CLANG` Optimization with automatically found CPU arch or also selectable CPU architecture.
- Choose between `LLVM/LTO` or `GCC`.
- Choose between 300Hz, 500Hz, 600 Hz ,750Hz and 1000Hz # default 750 Hz.
- Improved BFQ Scheduler.
- Back-ported patches from `linux-next`.
- General improved sysctl settings and upstream scheduler fixes.
- Latest LRU (v15) Patch-set, default enabled.
- Maple Tree from `linux-next`.
- MM Demotion from `linux-next`.
- Latency Nice Patchset included usuage with `ananicy-cpp` [feature branch](https://lore.kernel.org/lkml/20220925143908.10846-1-vincent.guittot@linaro.org/T/#t).
- NEST Scheduler.
- rcu fixes and improvements.
- latest DAMON improvements and fixes.
- BBRv2 tcp_congestion_control.
- LLVM THIN-LTO Kernels prebuilt in `x86-64-v3` and `x86-64` in the CachyOS repositories.
- LRNG Framework. (default enabled)
- Latest & improved ZSTD patch-set.
- Latest BTRFS/XFS/EXT4 improvements & fixes.
- KSMBD Module for Samba3 Server.
- AMD PSTATE EPP Driver enabled by default and with enhancements patches/fixes.
- Clearlinux Patchset.
- Kernel Control Flow Integrity (kCFI) selectable when using `LLVM`. (patched llvm can be found in the cachyos-repositories)
- ZFS Filesystem Support and prebuilt in the repository.
- WINESYNC Fastsync.
- Use entropy optimization for zRAM.
- UserKSM daemon from pf.
- support for bcachefs.

## Other GNU/Linux distributions
- Complete patch for simple patching on the kernel
- It is planned to implement into our kernel builder from cachyos buildsystem, which works also on other distributions.

### Gentoo
Its a community maintained ebuild from a user, which can be used for a dynamic building right [here](https://github.com/sandikata/ROKO__/tree/master/sys-kernel/cachyos-sources)

Or simply run:
```
eselect repository enable ROKO__
emaint sync -r ROKO__
```

## We are providing a [repositories](https://mirror.cachyos.org/) which includes all kernels in x86-64-v3 and x86-64 and more performance-optimized packages
How to add our repositories automatically with compatibility detection (if x86-64-v3 is supported) is described below:

## 🦾 Automatic adding of our repositories

Run following commands:
1. Get archive with script
```
wget https://mirror.cachyos.org/cachyos-repo.tar.xz
```
> If don't have `wget`, install them by `sudo pacman -S wget`

2. Extract and jump into the archive
```
tar xvf cachyos-repo.tar.xz && cd cachyos-repo
```

3. Run script under sudo
```
sudo ./cachyos-repo.sh
```

> The script performs automatic `march` detection and changes the pacman.conf

## ✋ Manually
1. Add key
```
sudo pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
```

2. Add key
```
sudo pacman-key --lsign-key F3B607488DB35A47
```

3. You can download first initial packages
```
sudo pacman -U 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-2-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-13-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-13-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/pacman-6.0.2-6-x86_64.pkg.tar.zst'
```
## Checking x86-64-v3 cpu support
1. Check support by the following the command
```
/lib/ld-linux-x86-64.so.2 --help | grep "x86-64-v3 (supported, searched)"
```

add following under the arch repos the "-v3" repos only if they are supported:
```
# cachyos repos
## Only add if your CPU does v3 architecture
[cachyos-v3]
Include = /etc/pacman.d/cachyos-v3-mirrorlist
[cachyos]
Include = /etc/pacman.d/cachyos-mirrorlist
```

> This script will also backup your old pacman.conf.
> This script will auto-detect you architecture, if your CPU have x86-64-v3 support, it will automatically use the repos which are optimized with this flag > and some other flags.
> Also all provided Kernels, Browsers, ... are optimized and compiled.

## ◀️ How to Backup the config and use the native Arch Packages

- Remove or Backup the config located at /etc/pacman.conf
- then run `sudo mv /etc/pacman.conf.bak /etc/pacman.conf`
- Then run following command to switch the packages to the default arch packages `sudo pacman -Suuy`


More information's you will find here [CachyOS](https://github.com/cachyos) or [Discord](https://discord.gg/k39qfrxPNa) 

## 🔧 How to use CLANG/LLVM/LTO compiled Kernels on Nvidia driver with DKMS:
> Not needed anymore, just install the latest dkms version from our repo.

## 🗣️ Support - get in touch with CachyOS community
**Discord:** <https://discord.gg/qJqj94uFwE> <br />
**Telegram:** <https://t.me/+zCzPX4cAFjk1MTYy> <br />

## 🌱 Donations are welcome for the build server for the repositories or a cup of coffee for maintaining our repositories.

**PayPal:** <https://paypal.me/pttrr> <br />
**Patreon:** <https://www.patreon.com/CachyOS> <br />

**BTC:** bc1qmwglfchlc335du6pcu6w64cexu7cck0mzhyw42 <br />
**ETH:** 0xc2dc77327F78A7B85Db3941Eb49e74F41E961649

### Valueable Contributors
[Hamad Marri](https://github.com/hamadmarri) for the CacULE and TT Scheduler <br />
[Archlinux](https://archlinux.org) for the great linux operating system <br />
[And all other Kernel Developers and Supporters](https://github.com/torvalds/linux) <br />
