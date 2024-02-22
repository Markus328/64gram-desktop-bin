{
  description = "The 64gram-desktop telegram client, binary version";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };
  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
      t64desktop = import ./t64desktop.nix {inherit pkgs;};
    in rec {
      packages = {
        default = t64desktop;
      };

      # defaultPackage.x86_64-linux = packages.x86_64-linux.default;

      # apps.x86_64-linux = let
      #   app = name: {
      #     type = "app";
      #     program = "${packages.x86_64-linux.${name}}/bin/telegram-desktop";
      #   };
      # in {
      #   default = app "default";
      # };

      overlay = overlays.default;
      overlays.default = final: prev: {
        t64gram = t64desktop;
      };
    });
}
