{
  description = "The 64gram-desktop telegram client, binary version";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    # The only supported system
    system = "x86_64-linux";
    inherit (nixpkgs.legacyPackages.${system}) pkgs;
    t64desktop = import ./t64desktop.nix {inherit pkgs;};
  in {
    packages.${system} = {
      default = t64desktop;
    };
    apps.${system}.default = {
      type = "app";
      program = "${self.packages.${system}.default}/bin/telegram-desktop";
    };

    overlay = self.overlays.default;
    overlays.default = final: prev: {
      t64gram = t64desktop;
    };
  };
}
