{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    name = "evajig-os-dev-enviroment";

    packages = with pkgs; [
        nixos-rebuild
        qemu
    ];

    shellHook = ''
        export NIXOS_CONFIG=${./configuration.nix}
    '';
}