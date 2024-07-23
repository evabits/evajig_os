{ pkgs ? import <nixpkgs> { }, ... }:

pkgs.appimageTools.wrapType2 rec {
  pname = "evajig-productiontool";
  version = "1.0.11";

  src = pkgs.fetchurl {
    url = "https://evajig.ams3.digitaloceanspaces.com/evajig_production_tool/updates/evajig_production_tool-${version}.AppImage";
    hash = "sha256-MwkQoIBUDTXdloy6CpIRQokRi/VQkuI6M5UE4833brs=";
  };

  extraPkgs = pkgs: with pkgs; [
    segger-jlink
    python311
    python311Packages.pyocd
    dfu-util
  ];
}
