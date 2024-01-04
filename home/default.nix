{ config, pkgs, ... }:

{
  imports = [
    ./awesome
    ./neovim
		./kitty
		./tmux
  ];

	nixpkgs = {
		overlays = [ (self: super: {
			obsidian = super.obsidian.overrideAttrs (old: {
				version = "1.5.3";
				src = pkgs.fetchurl {
					url = "https://github.com/obsidianmd/obsidian-releases/releases/download/v1.5.3/obsidian-1.5.3.tar.gz";
					hash = "sha256:F7nqWOeBGGSmSVNTpcx3lHRejSjNeM2BBqS9tsasTvg=";
				};
				# src = pkgs.fetchFromGitHub {
				#	owner = "obsidianmd";
				#	repo = "obsidian-releases";
				#	rev = "v1.5.3";
				#	sha256 = "sha256-yjSneMssP/EBJrj/tZDseXXauWvpB84VCeSiEXmcVhM=";
					# sha256 = lib.fakeSha256;
					# sha256 = "sha256:1wvq6slgcqmjz379wkxzk13m02g423hnzlwvv5zz1wg1mzfy1522";
				# };
			});
		}) ];

		config = {
			allowUnfree = true;
			allowUnfreePredicate = true;
			permittedInsecurePackages = [
				"electron-25.9.0"
			];
		};
	};


  home = {
    username = "julian";
    homeDirectory = "/home/julian";
    stateVersion = "23.11";
    packages = with pkgs; [
      neovim
      dmenu
      kitty
			spotify
			obsidian
			tmux
    ];
  };

	programs = {
		home-manager.enable = true;
		git.enable = true;
		zsh = {
			enable = true;
			initExtra = ''
				bindkey '^r' history-incremental-search-backward
			'';
			enableCompletion = true;
			oh-my-zsh = {
				enable = true;
			};
		};
	};

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
