{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  # imports = [./ethereum.nix];

  users = {
    mutableUsers = false;
    users.admin = {
      isNormalUser = true;
      initialPassword = "password";
      extraGroups = ["wheel"];
      openssh.authorizedKeys.keys = [
        # willruggiano (ecthelion):
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEAIngPgrqRfYi/YTrd0+eVRbylSL+weBTtL819GgXUb"
        # willruggiano (mothership):
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIERAQpJ3mjcz+b2Y+Wf598wURIrGU710Sr91HCcwSiXS"
      ];
    };
  };

  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostId = builtins.substring 0 8 (builtins.hashString "md5" config.networking.hostName);
    wireless.networks = {
      NETGEAR39.pskRaw = "8c0581fd9efea018310be1a5872e37211ac724f4e4d4955e2b4e148a4ee1438b";
    };
  };

  environment.systemPackages = with pkgs; [fzf git ripgrep sysz vim];
  services.openssh.enable = true;

  system.stateVersion = "22.05";
}
