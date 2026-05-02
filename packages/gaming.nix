{pkgs,config,input,...}:
{
  programs.steam.enable=true;
  programs.steam.protontricks.enable=true;
  programs.gamemode.enable = true;
#I will add any packages I need for gaming here I just can't  think of any right now :/
  environment.systemPackages= with pkgs;[
  protonplus
  lutris
  jdk25_headless
  jre25_minimal
  prismlauncher
#ok blender has nothing to do with gaming but I don't want to make a seperate category for it and it's a bit too demanding to be treated like a regular package
  (blender.withPackages(python313Packages: [ python313Packages.pyserial  python313Packages.cryptography python313Packages.boto3  python313Packages.websockets python313Packages.fs python313Packages.pip]))

  ];









  }
