# NOTE: https://nix.dev/tutorials/installing-nixos-on-a-raspberry-pi
_: {
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = ["noatime"];
    };
    "/home" = {
      device = "/dev/disk/by-label/HOME";
      fsType = "ext4";
      options = ["noatime"];
    };
  };

  swapDevices = [{device = "/dev/disk/by-label/SWAP";}];

  hardware.video.hidpi.enable = true;

  networking = {
    wireless = {
      enable = true;
      interfaces = ["wlan0"];
    };
  };
}
