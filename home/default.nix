{ config, pkgs, ... }:

{
  imports = [
    ./awesome
  ];

  home = {
    username = "julian";
    homeDirectory = "/home/julian";
    stateVersion = "23.11";
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = true;
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  system.stateVersion = "23.11";
}
