{
  description = "The 64gram-desktop telegram client, binary version";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nosys = {
      url = "github:divnix/nosys";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    nosys,
    ...
  }:
    nosys inputs ({
      self,
      nixpkgs,
      ...
    }: let
      inherit (nixpkgs.legacyPackages) pkgs;
      t64desktop = import ./t64desktop.nix {inherit pkgs;};
    in {
      packages = {
        default = t64desktop;
      };

      #ADD THIS NEXT
      #_overlay = self.overlays.default;
      _overlays.default = final: prev: {
        t64gram = t64desktop;
      };
    });
}
