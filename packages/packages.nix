{config,pkgs,inputs, ...}:
{

  # Enable desktop environments.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  programs.hyprland.enable= true;

  # Installing programs that need to be installed via program.enable.
  programs={
    firefox.enable = true;
    waybar.enable=true;
    neovim.enable=true;
    firejail.enable=true;
  };
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.appimage.package = pkgs.appimage-run.override 
  {
    extraPkgs = pkgs: 
    [
      pkgs.icu
      pkgs.libxcrypt-legacy
      pkgs.python312
      pkgs.python312Packages.torch
    ]; 
  };
  services.postgresql.enable=true;
  services.flatpak.enable = true; 
  security.polkit.enable =true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  #enabling opengl
  hardware.graphics.enable = true;
  #nessisary for distrobox
# virtualisation.podman = {
#   enable = true;
#   dockerCompat = true;
# };
  environment.systemPackages = with pkgs; [
    
    (python3.withPackages (python-pkgs: with python-pkgs; [
        pip
        websockets
        boto3
        cryptography
        pandas
        requests
        rpy2
    ]))
    qbittorrent
    python313Packages.pip
    python313Packages.websockets
    python313Packages.cryptography
    python313Packages.boto3
    appimage-run
  # List packages installed in system profile. To search, run:
    libreoffice-qt
    hunspell
    hunspellDicts.uk_UA
    hunspellDicts.el_GR
   # $ nix search wget
    docker-compose
    ntfs3g
    mysql-workbench
    htop
    texliveFull
    zathura
    vim 
    crosspipe
    git 
    wget
    kitty
    nwg-look
    wofi
    steam-run
    easyeffects
#    inputs.zen-browser.packages."x86_64-linux".default
    gnumake
    fastfetch
    postgresql
    cmake
    pkg-config
    mesa-demos
    grim
    hyprpolkitagent
    satty
    wl-clipboard-rs
    swaynotificationcenter
    libnotify
    hyprpaper
    localsend
    python3
    curl
    unzip
    gnutar
    gzip
    distrobox
    rpi-imager
  #audio
    pavucontrol
    pulseaudio
  #drawing
    krita
  ];
  
  
  #picking a font
  fonts.packages=[ pkgs.nerd-fonts.fira-mono];
  #setting up openvpn
  services.openvpn.servers = {
    VPN  = { config = ''config /home/strats/.vpn/VPN.ovpn''; };
  };

  users.users.strats.packages =  [
    #  thunderbird
    inputs.zen-browser.packages."x86_64-linux".default
    ];
  


  #stolen snippet from a reddit post to let me mount my drive properly 
    security.polkit.extraConfig = ''
    /* Allow local users to mount system disks */
    polkit.addRule(function(action, subject) {
      if ( subject.local && action.id == "org.freedesktop.udisks2.filesystem-mount-system") {
        return polkit.Result.YES;
      }
  });
  '';


}
