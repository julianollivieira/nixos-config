{ config, pkgs, ... }:

{
  imports = [
    ./awesome
    ./neovim
		./kitty
  ];

  home = {
    username = "julian";
    homeDirectory = "/home/julian";
    stateVersion = "23.11";
    packages = [
      pkgs.neovim
      pkgs.dmenu
      pkgs.kitty
    ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = true;
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.zsh = {
    enable = true;
		initExtra = ''
			bindkey '^r' history-incremental-search-backward
		'';
  	enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "jeffreytse/zsh-vi-mode" ];
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
