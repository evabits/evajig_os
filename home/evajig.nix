{ pkgs, ... }@args:

let
  productiontool = (import ../pkgs/productiontool.nix args);
in
rec {
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
      networkmanagerapplet # -> nm-connection-editor
      firefox
      xfce.thunar
      obconf
    ];

    home.sessionVariables = {
      EDITOR = "${pkgs.vim}/bin/vim";
    };

    home.file = {
      ".xinitrc".source = ../files/xinitrc;
      ".config/openbox".source = ../files/openbox;
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
