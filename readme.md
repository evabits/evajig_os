# NixOS-distributie voor EVAjig-productiontool

## Build Requirements

- Nix (niet de distribution, alleen de _package manager_)
- Qemu (voor testing)

## Wat is Nix?
> niet niks he

Nix is een programmeertaal en een systeem- en package-manager.

```bash
$ nix-channel --list
home-manager https://github.com/nix-community/home-manager/archive/master.tar.gz
nixpkgs http://nixos.org/channels/nixpkgs-unstable
```

```bash
$ nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
$ nix-channel --add http://nixos.org/channels/nixpkgs-unstable nixpkgs
$ nix-channel --update
```

```bash
$ nixos-rebuild build-vm -I nixos-config=./configuration.nix
```

Ik ben twee public-keys nodig:
- keys/root-ssh-rsa.pub
- keys/user-ssh-rsa.pub

