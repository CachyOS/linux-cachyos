# <center>Linux Kernel With CacULE Scheduler, Several Other Patches &amp; Improvements</center>

## General Informations

The CacULE CPU Scheduler is a improved alternative to CFS Patch-set which is based on interactivity score mechanism. The interactivity score is inspired by the ULE Scheduler (FreeBSD Scheduler). The goal of this scheduler is to enhance system performance, responsiveness and latency.

## Features

- At the time of compiling you can set several features which you want to use
- GCC/CLANG Optimization with Auto CPU Optimization
- Choose between LLVM/LTO or GCC
- Choose between 500Hz, , 750 Hz, 1000Hz (default), 2000Hz
- Improved BFQ Scheduler
- Latest LRU Patch-set
- BBRv2 tcp_congestion_control
- LLVM FULL LTO provided with *-llvm Kernel (in the repo)
- LRNG Framework (default)
- FUTEX, WINESYNC & FUTEX2 patch-set
- Android ANBOX patch-set
- Latest Paragon NTFS3 driver support
- Latest & improved ZSTD patch-set
- Latest BTRFS improvements & fixes
- KSMBD Module for Samba3 Server
- Protection of clean file pages (page cache) may be used to prevent thrashing, reducing I/O under memory pressure, avoid high latency and prevent livelock in near OOM (Out Of Memory) conditions

## CacULE Tips & Tricks (Sysctl Values)

You can tune the scheduler by setting these sysctl values

```
net.core.netdev_max_backlog = 16384
net.core.somaxconn = 8192
net.core.rmem_default = 1048576
net.core.rmem_max = 16777216
net.core.wmem_default = 1048576
net.core.wmem_max = 16777216
net.core.optmem_max = 65536
net.ipv4.tcp_rmem = 4096 1048576 2097152
net.ipv4.tcp_wmem = 4096 65536 16777216
net.ipv4.udp_rmem_min = 8192
net.ipv4.udp_wmem_min = 8192
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_keepalive_time = 60
net.ipv4.tcp_keepalive_intvl = 10
net.ipv4.tcp_keepalive_probes = 6
net.ipv4.conf.default.log_martians = 1
net.ipv4.conf.all.log_martians = 1
net.ipv4.tcp_mtu_probing = 1
net.ipv4.tcp_syncookies = 1
net.core.default_qdisc = cake
net.ipv4.tcp_congestion_control = bbr2
```

## We are providing a [repo](https://mirror.cachyos.org/) which includes all kernels in generic-v3 and generic and more optimized packages

### How to add our Repo automatically with CPU detection (if x86-64-v3 is supported)

**Just run following command:**

--------------------------------------------------------------------------------

```
wget https://mirror.cachyos.org/cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz
cd repo
sudo ./cachyos-repo.sh
```

--------------------------------------------------------------------------------

```
This script will also backup your old pacman.conf.

This script will auto-detect you architecture, if your CPU have x86-64-v3 support, it will automatically use the repos which are optimized with this flag and some other flags.

Also all provided Kernels, Browsers, ... are optimized and compiled.

## How to Backup the config and use the native Arch Packages

- Remove or Backup the config located at /etc/pacman.conf
- then run `sudo mv /etc/pacman.conf.bak /etc/pacman.conf`
- Then run following command to switch the packages to the default arch packages `sudo pacman -Suuy`


More information's you will find here [CachyOS](https://gitlab.com/cachyos) or [Discord](https://discord.gg/k39qfrxPNa)
```

## How to use CLANG/LLVM/LTO compiled Kernels on Nvidia driver with DKMS:

There is mostly an easy workaround, but be aware, if you install a Kernel and have those parameters still in, the GCC Compiled Kernel will fail. Also some modules which uses DKMS needs to recompiled with CLANG/LLVM. I just compile the backup kernel LINUX-LTS also with CLANG, so i got no problems anymore.

- Just do following:

  ```
    sudo nano /etc/dkms/framework.conf
    and add following entrys on the bottom of the file:
    export LLVM=1
    export CC=clang
  ```

- If you have this done, just reinstall or install the kernel which is compiled with LLVM/LTO and DKMS wont fail anymore.

If you got questions, just hit me up!

## Donations are welcome for the compile server for the repo or a cup of coffee for maintain this repo

<https://paypal.me/pttrr?locale.x=de_DE>

### More Informations for the CacULE Scheduler

Here you find more information from the [repo](https://github.com/cachyos/cacule-cpu-scheduler)

### Valueable Contributors

[Hamad Marri](https://github.com/hamadmarri) for the CacULE Scheduler

[BL4CKH47H4CK3R](https://github.com/BL4CKH47H4CK3R) for Optimization, Bug Hunting & Support

[SirLucjan (Piotr Gorski)](https://github.com/sirlucjan) for many cool patches

[Archlinux](https://archlinux.org) for the great linux operating system

[GarudaLinux](https://garudalinux.org) for suggestions and supports

[And all other Kernel Developers and Supporters](https://github.com/torvalds/linux)
