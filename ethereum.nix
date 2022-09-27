{
  config,
  pkgs,
  ...
}: let
  eth1network = "goerli";
  eth2network = "prater";
in {
  services.geth.execution = {
    enable = true;
    http = {
      enable = true;
      apis = ["eth" "net" "engine" "admin"];
    };
    # TODO: Enable agenix and store the jwt secret.
    # authrpc = {
    #   enable = true;
    #   jwtsecret = "${config.age.secrets.jwtsecret.path}";
    # };
    network = eth1network;
  };

  services.prysm = {
    beacon-chain = {
      enable = true;
      network = eth2network;
      extra-arguments = [
        "--jwt-secret=${config.age.secrets.jwtsecret.path}"
        "--suggested-fee-recipient=$(cat ${config.age.secrets.suggested-fee-recipient.path})"
      ];
    };
    validator = {
      enable = true;
      network = eth2network;
      extra-arguments = [
        "--suggested-fee-recipient=$(cat ${config.age.secrets.suggested-fee-recipient.path})"
        "--wallet-password-file=${config.age.secrets.wallet-password.path}"
      ];
    };
    # client-stats = {
    #   enable = true;
    # };
  };
}
