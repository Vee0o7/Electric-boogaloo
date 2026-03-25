{self, inputs, ...}:
{
  flake.nixosModules.smolBoogalooHardware = { config, lib, pkgs, modulesPath, ... }:
  {
    networking.hostName = "smolBoogaloo";
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/mapper/luks-be4236bb-1a14-4a6c-9f9e-5febd7b82c01";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-be4236bb-1a14-4a6c-9f9e-5febd7b82c01".device = "/dev/disk/by-uuid/be4236bb-1a14-4a6c-9f9e-5febd7b82c01";

  boot.initrd.luks.devices."luks-2782529e-4c2f-4899-b667-f3660ef697ef".device = "/dev/disk/by-uuid/2782529e-4c2f-4899-b667-f3660ef697ef";
  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/4CA9-8584";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/mapper/luks-2782529e-4c2f-4899-b667-f3660ef697ef"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
};
}
