{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  users = {
    mutableUsers = false;
    users.admin = {
      isNormalUser = true;
      initialPassword = "password";
      extraGroups = ["wheel"];
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEAIngPgrqRfYi/YTrd0+eVRbylSL+weBTtL819GgXUb "];
    };
  };

  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";

  networking.hostName = "eth-nix";
  networking.hostId = builtins.substring 0 8 (builtins.hashString "md5" config.networking.hostName);

  environment.systemPackages = with pkgs; [vim];
  services.openssh.enable = true;

  system.stateVersion = "22.11";
}
