# Getting Started

## Requirements

- a program to flash an ISO
- some knowlegde about the Linux Shell

## 1. Make a bootable USB

- Go to [nixos.org](https://nixos.org/download) and download the distribution ISO
  > This tutorial uses GNOME
- Flash the iso to an empty USB

## 2. Boot the ISO

The system should boot without hassle. You'll be welcomed with the installer, close it as we don't do the regular installation!

Make sure you have internet. How to setup 

## 3. Partition the installation disk

| Nr. | Parition | Label   | Parition Type    | File System  | Size            |
| --- | -------- | ------- | ---------------- | ------------ | --------------- |
| 1.  | boot     | `BOOT`  | EFI System       | fat32        | 1GiB            |
| 2.  | swap     | `swap`  | Linux swap       | (linux-)swap | 4-8GiB          |
| 3.  | root     | `nixos` | Linux filesystem | ext4         | remaining space |

It is **really important** to apply the partition labels, otherwise nix doesn't know where your installation should be

### 3.1. GParted

GParted is installed on the regular graphic installation, if you're less familar with the terminal or just lazy.

### 3.2 `cfdisk` & `mkfs.*`

- open `cfdisk` with
  ```bash
  cfdisk /dev/<disk>
  ```
  - parition your disk and hit `write`
- create the filesystems with
  ```bash
  mkfs.vfat -F32 -n BOOT /dev/<boot-partion>
  mkswap -L swap /dev/<swap-partion>
  mkfs.ext4 -L nixos /dev/<root-partion>
  ```

## 4. Mount the disks

- mount the root-partition
  ```bash
  mount /dev/<root-partition> /mnt
  ```
- create the boot-target directory
  ```bash
  mkdir -p /mnt/boot
  ```
- mount the boot-partition into just created directory
  ```bash
  mount /dev/<boot-partition> /mnt/boot
  ```
- activate the swap for better performance
  ```bash
  swapon /dev/<swap-partition>
  ```

## 5. Fetch the configuation

- create the configuration-directory
  ```bash
  mkdir /mnt/etc
  ```
- clone this repository into `/etc/nixos
  ```bash
  git clone https://github.com/evabits/evajig_os /mnt/etc/nixos/
  ```

## 6. Install

- install the system
  ```bash
  nixos-install
  ```

## 7. Reboot

- reboot the system via GNOME or in the terminal
  ```bash
  reboot
  ```