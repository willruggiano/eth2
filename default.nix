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
    };
  };

  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [vim];
  services.openssh.enable = true;
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.xfce.enable = true;
  };

  hardware.pulseaudio.enable = true;

  system.stateVersion = "22.11";
}
