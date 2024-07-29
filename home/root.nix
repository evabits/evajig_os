{ pkgs, ... }:

rec {
  name = "root";

  user = {
    inherit name;
    initialPassword = "root";
    openssh.authorizedKeys.keyFiles = [
      ../keys/root-ssh-rsa.pub
    ];
  };

  home-manager = {
    home.stateVersion = "24.05";

    home.username = name;
    home.homeDirectory = "/root";

    programs.home-manager.enable = true;
  };
}
