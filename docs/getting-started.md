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

## 3. Format and Mount

create a config.nix
```nix
{...}: {
  disk = "/dev/sda";
  interface = "ens3";
}
```

and make it visible by
```bash
export NIX_PATH="$NIX_PATH:evajig-config=./config.nix"
```

```bash
nix --experimental-features 'nix-command flakes' run github:nix-community/disko -- --mode disko -f github:evabits/evajig_os#disko 
```

```bash
nixos-install --flake github:evabits/evajig_os#evajig --impure
```