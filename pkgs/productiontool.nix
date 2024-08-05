{ pkgs ? import <nixpkgs> { }, ... }:

let
  pyocdConfig = {
    pack = [
      (pkgs.fetchurl {
        url = http://developer.nordicsemi.com/nRF5_SDK/pieces/nRF_DeviceFamilyPack/NordicSemiconductor.nRF_DeviceFamilyPack.8.44.1.pack;
        hash = "sha256-lRNrV6gxC6NnqkbLZsjRSVYfx4dsXzc28yOp2/uPVZ4=";
      })
    ];
  };
in
pkgs.appimageTools.wrapType2 rec {
  pname = "evajig-productiontool";
  version = "1.0.11";

  src = pkgs.fetchurl {
    url = "https://evajig.ams3.digitaloceanspaces.com/evajig_production_tool/updates/evajig_production_tool-${version}.AppImage";
    hash = "sha256-MwkQoIBUDTXdloy6CpIRQokRi/VQkuI6M5UE4833brs=";
  };

  extraPkgs = pkgs: with pkgs; [
    segger-jlink
    (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
      pyocd
    ]))
    dfu-util
  ];

  profile = ''
    export PYOCD_PROJECT_DIR=$(mktemp -d)
    export EVAJIG_OS=NIXOS

    echo '${builtins.toJSON pyocdConfig}' > $PYOCD_PROJECT_DIR/pyocd.yaml
  '';
}
