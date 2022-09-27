# NOTE: https://nix.dev/tutorials/installing-nixos-on-a-raspberry-pi
{nixos-hardware, ...}: {
  imports = ["${nixos-hardware}/raspberry-pi/4"];

  fileSystems = {
    "/" = {
      # TODO: Try this with an SSD instead
      # ..... and change the label to NIXOS
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = ["noatime"];
    };
    # "/home" = {
    #   device = "/dev/disk/by-label/HOME";
    #   fsType = "ext4";
    #   options = ["noatime"];
    # };
  };

  networking = {
    hostname = "eth-nix";
    wireless = {
      enable = true;
      interfaces = ["wlan0"];
    };
  };
}
