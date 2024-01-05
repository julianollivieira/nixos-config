{ config, pkgs, ...  }:

{
  home.file.".config/nvim/init.lua".source = ./init.lua;
  home.file.".config/nvim/lua/" = { source = ./lua; recursive = true; };
}
