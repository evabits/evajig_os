{ pkgs, ... }@args:

let 
  productiontool = (import ../pkgs/productiontool.nix args);
in rec {
  name = "evajig";

  user = {
    inherit name;
    isNormalUser = true;
    initialPassword = "evajig";
    extraGroups = [ "networkmanager" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keyFiles = [
      ../keys/user-ssh-rsa.pub
    ];
  };

  home-manager = {
    home.stateVersion = "24.05";

    home.username = name;
    home.homeDirectory = "/home/${name}";

    home.packages = with pkgs; [
      productiontool
    ];

    home.sessionVariables = {
      EDITOR = "${pkgs.vim}/bin/vim";
    };

    home.file = {
      ".xinitrc" = {
        text = ''
          #!/bin/sh

          evajig-productiontool &
          xterm &

          exec openbox
        '';
        executable = true;
      };
    };

    programs.zsh = {
      enable = true;
      oh-my-zsh.enable = true;

      profileExtra = ''
        if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
          startx
        fi
      '';
    };

    programs.home-manager.enable = true;
  };
}
