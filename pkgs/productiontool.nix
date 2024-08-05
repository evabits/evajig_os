{ pkgs ? import <nixpkgs> { }, ... }:

let
  pyocdConfig = {
    pack = [
      (pkgs.fetchurl {
        url = https://developer.nordicsemi.com/nRF5_SDK/pieces/nRF_DeviceFamilyPack/NordicSemiconductor.nRF_DeviceFamilyPack.8.44.1.pack;
        hash = "sha256-lRNrV6gxC6NnqkbLZsjRSVYfx4dsXzc28yOp2/uPVZ4=";
      })
      (pkgs.fetchurl {
        url = "https://download.ambiq.com/packs/AmbiqMicro.Apollo_DFP.1.4.1.pack";
        hash = "sha256-wIW4Ezh7QikJ0A3E8Wxbtbw8Vfw/KKHG9iYU3MOoBKU=";
      })
      (pkgs.fetchurl {
        url = "https://packs.download.microchip.com/Microchip.SAMD21_DFP.3.6.144.pack";
        hash = "sha256-l531IWnKPIxEzEbsz2x5l174IBjC0sS0vu1LSM3rVVM=";
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
