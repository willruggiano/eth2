let
  willruggiano = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEAIngPgrqRfYi/YTrd0+eVRbylSL+weBTtL819GgXUb";
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIACSzX6qdR3gm7bvXq8f6e8bVhKc2VFEgzXNC2p4jYnk";
in {
  "prysm-env.age".publicKeys = [willruggiano system];
  "wallet-password.age".publicKeys = [willruggiano system];
}
