let
  developers = [
    # willruggiano (ecthelion)
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEAIngPgrqRfYi/YTrd0+eVRbylSL+weBTtL819GgXUb"
    # willruggiano (mothership)
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIERAQpJ3mjcz+b2Y+Wf598wURIrGU710Sr91HCcwSiXS"
  ];

  systems = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINVpAjJ4IHby/YT5uw3NvYgy+PCad1yWZQwy1DEDED7h"
  ];
in {
  "prysm-env.age".publicKeys = developers ++ systems;
  "wallet-password.age".publicKeys = developers ++ systems;
}
