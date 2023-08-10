{
  description = "The 64gram-desktop telegram client, binary version";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  outputs = inputs: let
    data = rec {
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      t64desktop = import ./t64desktop.nix {pkgs = pkgs;};
    };
  in
    with data; rec {
      packages.x86_64-linux = {
        default = import ./default.nix {
          inherit pkgs;
          inherit t64desktop;
        };
      };

      defaultPackage.x86_64-linux = packages.x86_64-linux.default;

      apps.x86_64-linux = let
        app = name: {
          type = "app";
          program = "${packages.x86_64-linux.${name}}/bin/telegram-desktop";
        };
      in {
        default = app "default";
      };

      overlay = overlays.default;
      overlays.default = final: prev: {
        t64gram = import ./t64desktop.nix {
          pkgs = final;
        };
      };
    };
}
