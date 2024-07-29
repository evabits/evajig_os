{ pkgs ? import <nixpkgs> { }, ... }:

pkgs.stdenv.mkDerivation {
  name = "plymouth-evajig";

  src = ./plymouth;

  installPhase = ''
    mkdir -p $out/share/plymouth/themes/evajig
    cp -r $src/* $out/share/plymouth/themes/evajig/

    sed -i "s|/usr/|$out/|g" $out/share/plymouth/themes/evajig/evajig.plymouth
  '';
}
