{
  description = "The 64gram-desktop-bin telegram client";
  inputs.nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux =
      import ./default.nix { pkgs = nixpkgs.legacyPackages.x86_64-linux; };



  };
}
