{
  description = "The 64gram-desktop-bin telegram client";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux =
      import ./default.nix { pkgs = nixpkgs.legacyPackages.x86_64-linux; };
  };
}
