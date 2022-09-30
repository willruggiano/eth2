{
  config,
  pkgs,
  ...
}: let
  network = "mainnet";
  # NOTE: This is the *mainnet* url!
  mev-relay-url = "https://0xac6e77dfe25ecd6110b8e780608cce0dab71fdd5ebea22a16c0205200f2f8e2e3ad3b71d3499c54ad14d6c21b41a37ae@boost-relay.flashbots.net";
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
        inherit network;
        checkpoint-sync = {
          enable = true;
          url = "https://beaconstate.ethstaker.cc";
        };
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

    mev-boost = {
      enable = false;
      inherit network;
      relays = [mev-relay-url];
    };

    monitoring.prysm.client-stats = {
      enable = true;
      api-url = "https://beaconcha.in/api/v1/client/metrics?apikey=$CLIENT_STATS_API_KEY?machine=${config.networking.hostName}";
    };
  };

  systemd.services.beacon-chain.serviceConfig.EnvironmentFile = config.age.secrets.prysm-env.path;
  systemd.services.validator.serviceConfig.EnvironmentFile = config.age.secrets.prysm-env.path;
  systemd.services.client-stats.serviceConfig.EnvironmentFile = config.age.secrets.client-stats-env.path;
}
