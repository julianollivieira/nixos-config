# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];


	boot = {
  	blacklistedKernelModules = [ "rtl8xxxu" ];
  	kernelModules = [ "kvm-amd" ];
		extraModulePackages = [ config.boot.kernelPackages.rtl88xxau-aircrack ];

		extraModprobeConfig = ''
			options cfg80211 ieee80211_regdom="SE"
		'';

		initrd = {
			availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
		};
	};

	hardware = {
		wirelessRegulatoryDatabase = true;
		nvidia = {
			modesetting.enable = true;

			powerManagement = {
				# Nvidia power management. Experimental, and can cause sleep/suspend to fail.
				enable = false;
				# Fine-grained power management. Turns off GPU when not in use.
				# Experimental and only works on modern Nvidia GPUs (Turing or newer).
				finegrained = false;
			};

			# Use the NVidia open source kernel module (not to be confused with the
			# independent third-party "nouveau" open source driver).
			# Support is limited to the Turing and later architectures. Full list of 
			# supported GPUs is at: 
			# https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
			# Only available from driver 515.43.04+
			# Currently alpha-quality/buggy, so false is currently the recommended setting.
			open = false;

			# Enable the Nvidia settings menu,
			# accessible via `nvidia-settings`.
			nvidiaSettings = true;

			# Optionally, you may need to select the appropriate driver version for your specific GPU.
			package = config.boot.kernelPackages.nvidiaPackages.stable;
		};
	};

  networking.networkmanager = {
    enable = true;
    wifi.scanRandMacAddress = false;
  };

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-label/swap"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp34s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
