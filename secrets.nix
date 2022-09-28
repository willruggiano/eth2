let
  developers = [
    # willruggiano (ecthelion)
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEAIngPgrqRfYi/YTrd0+eVRbylSL+weBTtL819GgXUb"
    # willruggiano (mothership)
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIERAQpJ3mjcz+b2Y+Wf598wURIrGU710Sr91HCcwSiXS"
  ];

  systems = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIACSzX6qdR3gm7bvXq8f6e8bVhKc2VFEgzXNC2p4jYnk"
  ];
in {
  "prysm-env.age".publicKeys = developers ++ systems;
  "wallet-password.age".publicKeys = developers ++ systems;
}
