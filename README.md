# nixos-config
my nixos config

'''shell
home-manager switch --flake .#julian@julian-nix-desktop --extra-experimental-features nix-command flakes --option eval-cache false
sudo nixos-rebuild switch --flake '/home/julian/projects/nixos-config#julian-nix-desktop'
'''
