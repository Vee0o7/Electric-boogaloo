{self, inputs, ...}:
{
  flake.nixosModules.bigBoogalooHardware = { config, lib, pkgs, modulesPath, ... }:
  {
    imports =
      [ (modulesPath + "/installer/scan/not-detected.nix")
      ];

  networking.hostName = "bigBoogaloo";

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/d5dd42e9-ffc1-4be8-abe7-52166101c568";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/ECC2-491D";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };
}
