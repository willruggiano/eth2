{
  description = "A very basic flake";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  inputs.eth-nix.url = "github:willruggiano/eth-nix";
  inputs.eth-nix.inputs.nixpkgs.follows = "nixpkgs";
  inputs.flake-utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
  inputs.nixos-hardware.url = "github:nixos/nixos-hardware";

  outputs = {
    self,
    nixpkgs,
    eth-nix,
    ...
  } @ inputs:
    with inputs.flake-utils.lib;
      mkFlake {
        inherit self inputs;

        hostDefaults.modules = [
          eth-nix.nixosModules.prysm
        ];

        hosts.ethereum-node-rpi4 = {
          system = "aarch64-linux";
          modules = [
            ./hardware/raspberry-pi-4.nix
            ./.
          ];
        };

        outputsBuilder = channels: let
          pkgs = channels.nixpkgs;
        in {
          devShells.default = pkgs.mkShell {
            name = "eth2";
            buildInputs = with pkgs; [coreutils rpi-imager zstd wget];
          };
        };
      };
}
