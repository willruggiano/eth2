{
  description = "A very basic flake";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  inputs.agenix.url = "github:ryantm/agenix";
  inputs.eth-nix.url = "github:willruggiano/eth-nix";
  inputs.eth-nix.inputs.nixpkgs.follows = "nixpkgs";
  inputs.flake-utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
  inputs.nixos-hardware.url = "github:nixos/nixos-hardware";

  outputs = {
    self,
    nixpkgs,
    agenix,
    eth-nix,
    nixos-hardware,
    ...
  } @ inputs:
    with inputs.flake-utils.lib;
      mkFlake {
        inherit self inputs;
        supportedSystems = ["aarch64-linux" "x86_64-linux"];

        channelsConfig = {allowUnfree = true;};
        sharedOverlays = [eth-nix.overlays.default];

        hostDefaults.modules = [
          agenix.nixosModule
          eth-nix.nixosModules.ethereum
        ];

        hosts.eth-nix = {
          system = "aarch64-linux";
          modules = [
            nixos-hardware.nixosModules.raspberry-pi-4
            ./hardware/raspberry-pi-4.nix
            ./ethereum.nix
            ./.
          ];
        };

        # TODO: It would be nice to make this work.
        hosts.eth-nix-test = {
          system = "x86_64-linux";
          modules = [
            ./ethereum.nix
            ./.
          ];
        };

        outputsBuilder = channels: let
          pkgs = channels.nixpkgs;
        in {
          devShells.default = pkgs.mkShell {
            name = "eth2";
            buildInputs = with pkgs; [
              agenix.packages."${pkgs.system}".agenix
              coreutils
              rpi-imager
              zstd
              wget
            ];
          };
        };
      };
}
