# nixos-config
my nixos config

```shell
sudo nixos-rebuild switch --flake '/home/julian/projects/nixos-config#julian-nix-desktop'
home-manager switch --flake '/home/julian/projects/nixos-config#julian@julian-nix-desktop'

# home-manager switch --flake .#julian@julian-nix-desktop --extra-experimental-features 'nix-command flakes' --option eval-cache false
```
