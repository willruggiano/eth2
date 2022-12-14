# NOTE: https://nix.dev/tutorials/installing-nixos-on-a-raspberry-pi
_: {
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = ["noatime"];
    };
    "/var/lib/private/ethereum" = {
      device = "/dev/disk/by-label/ETHEREUM";
      fsType = "ext4";
      options = ["noatime"];
    };
  };

  swapDevices = [{device = "/dev/disk/by-label/SWAP";}];
}
