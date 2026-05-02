{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "strats";
  home.homeDirectory = "/home/strats";

  home.stateVersion = "25.11"; # Please read the comment before changing.
  home.packages = with pkgs; [
    swaynotificationcenter
    wofi
    hyprpaper
    qbittorrent
    texliveFull
    zathura
    easyeffects
    grim
    wl-clipboard-rs
    krita
    localsend
    satty
    

  ];
 #bashrc configuration
#
# programs={
#   bash={ 
#     enable=true;
#     initExtra=''
#     export PS1='\[\e[96;1m\]|\[\e]0;\u@\h: \w\a\]\u@:\[\e[22m\]\W\[\e[1m\]|\$\[\e[0m\]' 
#     fastfetch 
#     '';
#   };
#   
#     kitty={
#       enable=true;

#       settings={
#         dynamic_background_opacity= "no";
#         background_opacity = "0.85";
#         background_blur="0";
#       };
#     };
#  };
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/hypr/hyprland.conf".source=./home/hyprland.conf;
    ".config/waybar/config.jsonc".source=./home/waybar/config.jsonc;
    ".config/waybar/style.css".source=./home/waybar/style.css;
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/strats/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    EDITOR="nvim";
  };
  # Let packages acess the mesa drivers from pacman (I think ? ) 
  targets.genericLinux.enable = true;
  targets.genericLinux.gpu.enable = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
