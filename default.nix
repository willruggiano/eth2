{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  imports = [./ethereum.nix];

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
  };

  environment.systemPackages = with pkgs; [fzf git htop ripgrep sysz vim];
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  system.stateVersion = "22.05";
}
