{ config, pkgs, ...  }:

{
  home.file.".config/awesome/rc.lua".source = ./rc.lua;
  home.file.".config/awesome/theme.lua".source = ./theme.lua;
}
