{
  config,
  pkgs,
  ...
}: let
  eth1network = "mainnet";
  eth2network = "mainnet";
in {
  age.secrets = {
    prysm-env.file = ./secrets/prysm-env.age;
    wallet-password.file = ./secrets/wallet-password.age;
  };

  services.ethereum = {
    jwt-secret.enable = true;

    execution.geth = {
      enable = true;
      network = eth1network;
      extra-arguments = [
        "--http.api 'eth,net,engine,admin'"
      ];
    };

    consensus.prysm = {
      beacon-chain = {
        enable = true;
        checkpoint-sync = true;
        network = eth2network;
        extra-arguments = [
          "--suggested-fee-recipient $SUGGESTED_FEE_RECIPIENT"
        ];
      };

      validator = {
        enable = false;
        network = eth2network;
        wallet-password-file = config.age.secrets.wallet-password.path;
        extra-arguments = [
          "--suggested-fee-recipient $SUGGESTED_FEE_RECIPIENT"
        ];
      };
    };
  };

  systemd.services.beacon-chain.serviceConfig.EnvironmentFile = config.age.secrets.prysm-env.path;
  systemd.services.validator.serviceConfig.EnvironmentFile = config.age.secrets.prysm-env.path;
}
