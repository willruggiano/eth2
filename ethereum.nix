{
  config,
  pkgs,
  ...
}: let
  network = "mainnet";
in {
  age.secrets = {
    client-stats-env.file = ./secrets/client-stats-env.age;
    prysm-env.file = ./secrets/prysm-env.age;
    wallet-password.file = ./secrets/wallet-password.age;
  };

  services.ethereum = {
    jwt-secret.enable = true;

    execution.geth = {
      enable = true;
      inherit network;
      extra-arguments = [
        "--http.api 'eth,net,engine,admin'"
      ];
    };

    consensus.prysm = {
      beacon-chain = {
        enable = true;
        checkpoint-sync = true;
        inherit network;
        extra-arguments = [
          "--suggested-fee-recipient $SUGGESTED_FEE_RECIPIENT"
        ];
      };

      validator = {
        enable = false;
        inherit network;
        wallet-password-file = config.age.secrets.wallet-password.path;
        extra-arguments = [
          "--suggested-fee-recipient $SUGGESTED_FEE_RECIPIENT"
        ];
      };
    };

    monitoring.prysm.client-stats = {
      enable = true;
      api-url = "https://beaconcha.in/api/v1/stats/$CLIENT_STATS_API_KEY/${config.networking.hostName}";
    };
  };

  systemd.services.beacon-chain.serviceConfig.EnvironmentFile = config.age.secrets.prysm-env.path;
  systemd.services.validator.serviceConfig.EnvironmentFile = config.age.secrets.prysm-env.path;
  systemd.services.client-stats.serviceConfig.EnvironmentFile = config.age.secrets.client-stats-env.path;
}
