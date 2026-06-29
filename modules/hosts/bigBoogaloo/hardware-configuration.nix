{self, inputs, ...}:
{
  flake.nixosModules.bigBoogalooHardware = { config, lib, pkgs, modulesPath, ... }:
  {
    imports =
      [ (modulesPath + "/installer/scan/not-detected.nix")
      ];

    networking.hostName = "bigBoogaloo";

# Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
    { device = "/dev/disk/by-uuid/df32375d-73bc-448a-8cb4-7077618e0669";
      fsType = "ext4";
    };

    fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/EA2A-8B9D";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

    fileSystems."/run/media/viv/steamDrive" = {
      device = "/dev/disk/by-uuid/8b05993b-b61f-4273-8cc1-5571d2e9e8ad";
      fsType = "ext4";
    };

    swapDevices =
      [ { device = "/dev/disk/by-uuid/66cb004d-6e40-46dd-a9c5-5f6aa7bc4aa7"; }
      ];

# Enables DHCP on each ethernet and wireless interface. In case of scripted networking
# (the default) this is the recommended approach. When using systemd-networkd it's
# still possible to use this option, but it's recommended to use it in conjunction
# with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
      networking.useDHCP = lib.mkDefault true;
# networking.interfaces.eno1.useDHCP = lib.mkDefault true;
# networking.interfaces.wlp1s0f0u4.useDHCP = lib.mkDefault true;

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      services.xserver.videoDrivers = ["amdgpu"];
  };
}
