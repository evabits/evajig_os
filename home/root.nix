{ pkgs, ... }:

let
   evajig-config = import <evajig-config> {};
in rec {
  name = "root";

  user = {
    inherit name;
    initialPassword = "Evajig2024";
    openssh.authorizedKeys.keyFiles = evajig-config.openssh-keys.root;
  };

  home-manager = {
    home.stateVersion = "24.05";

    home.username = name;
    home.homeDirectory = "/root";

    programs.home-manager.enable = true;
  };
}
