# Remote update

## Requirements

- [Nix: the package manager](https://nixos.org/downloads)
- [nixpkgs channel](https://nixos.wiki/wiki/Nix_channels)

## `nix-shell`

`nix-shell` is a beautiful tool to create a development environment. Useful programs are installed and environment-variables set.

To create a dev-shell, change your directory to this repository and run `nix-shell`. Now you have following programs installed:
- `nixos-rebuild`: a tool to build and install nixos remotely
- `qemu`: for testing a vm

## Testing

```bash
nixos-rebuild build-vm
```

## Deploying

```bash
nixos-rebuild {switch|boot} --target-host root@<evajig>
```

The `switch`-subcommand will build the new generation, upload it to the EVAjig and reloads services if needed.

The `boot`-subcommand is useful for big updates which includes kernel-updates or other reboot-required things.