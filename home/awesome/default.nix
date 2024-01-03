{ config, pkgs, ...  }:

{
  home.file.".config/awesome/rc.lua".source = ./rc.lua;
  home.file.".config/awesome/theme.lua".source = ./theme.lua;
	home.file.".config/awesome/icons/" = { source = ./icons; recursive = true; };
  home.file.".config/awesome/wallpaper.png".source = ./wallpaper.png;
}
