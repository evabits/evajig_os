{ pkgs, ... }:

rec {
  name = "root";

  user = {
    inherit name;
    isNormalUser = true;
    initialPassword = "root";
    openssh.authorizedKeys.keyFiles = [
      ../keys/root-ssh-rsa.pub
    ];
  };

  home-manager = {
    home.stateVersion = "24.05";

    home.username = name;
    home.homeDirectory = "/root";

    programs.zsh.enable = true;
    programs.home-manager.enable = true;
  };
}
