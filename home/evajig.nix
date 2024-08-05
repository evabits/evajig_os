{ pkgs, ... }@args:

let
  productiontool = (import ../pkgs/productiontool.nix args);
  evajig-config = import <evajig-config> {};
in
rec {
  name = "evajig";

  user = {
    inherit name;
    isNormalUser = true;
    initialPassword = "evajig2024";
    extraGroups = [ "networkmanager" "dialout" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keyFiles = evajig-config.openssh-keys.evajig;
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
