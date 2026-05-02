#Edit this configuration file to define what should be installed on
#your system.  Help is available in the configuration.nix(5) man page
#and in the NixOS manual (accessible by running ‘nixos-help’).

{config,pkgs,inputs,...}:
{
  imports =
    [ # Include the results of the hardware scan.
      ./packages/packages.nix
      ./packages/binaries.nix
      ./nvim/config.nix 
      #including home manager
      inputs.home-manager.nixosModules.default
      inputs.nvf.nixosModules.default

    ];

  #"pointing" home manager to the file where we will actually configure home-manager
  home-manager={
    extraSpecialArgs={inherit inputs;};
    users={
      strats= import ./home.nix;
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
#  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  
  networking.networkmanager.enable = true;
# networking.networkmanager.unmanaged = [
#   "*"
#   "except:type:wwan"
#   "except:type:gsm"
# ];
  
services.gnome.gnome-keyring.enable=true;

  # Set your time zone.
  time.timeZone = "Europe/Athens";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "el_GR.UTF-8";
    LC_IDENTIFICATION = "el_GR.UTF-8";
    LC_MEASUREMENT = "el_GR.UTF-8";
    LC_MONETARY = "el_GR.UTF-8";
    LC_NAME = "el_GR.UTF-8";
    LC_NUMERIC = "el_GR.UTF-8";
    LC_PAPER = "el_GR.UTF-8";
    LC_TELEPHONE = "el_GR.UTF-8";
    LC_TIME = "el_GR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,gr";
    options = "grp:alt_shift_toggle";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  xdg.portal.enable=true;
  xdg.portal.extraPortals=  [pkgs.xdg-desktop-portal-gnome ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.strats = {
    isNormalUser = true;
    description = "username-temporary";
    extraGroups = [ "networkmanager" "wheel" "docker" "kvm" ];

  };
 

  # setting up flakes
  nix.settings.experimental-features=["nix-command" "flakes"];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall

   networking.firewall.allowedTCPPorts = [53317];
   networking.firewall.allowedUDPPorts = [53317];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
### sad attempt at fixing the wifi
systemd.services.wpa_supplicant.environment.OPENSSL_CONF = pkgs.writeText"openssl.cnf"''
openssl_conf = openssl_init
[openssl_init]
ssl_conf = ssl_sect
[ssl_sect]
system_default = system_default_sect
[system_default_sect]
Options = UnsafeLegacyRenegotiation
[system_default_sect]
CipherString = Default:@SECLEVEL=0
''
;
##razer mouse settings
hardware.openrazer.enable = true;
hardware.openrazer.users = ["strats"];

###docker stuff
virtualisation.docker.enable = true;

}
