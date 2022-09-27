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
    ...
  } @ inputs:
    with inputs.flake-utils.lib;
      mkFlake {
        inherit self inputs;
        supportedSystems = ["aarch64-linux" "x86_64-linux"];

        channelsConfig = {allowUnfree = true;};
        sharedOverlays = [agenix.overlay eth-nix.overlays.default];

        hostDefaults.modules = [
          agenix.nixosModule
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
            buildInputs = with pkgs; [agenix coreutils rpi-imager zstd wget];
          };
        };
      };
}
