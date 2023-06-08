{
  description = "The 64gram-desktop telegram client, binary version";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  outputs = { self, nixpkgs }: 
  let data = rec {
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    t64desktop = import ./t64desktop.nix { pkgs = pkgs; };
    fhs = import ./fhs.nix {pkgs = pkgs; t64desktop = t64desktop;};
    };
  in with data;
  rec {
    packages.x86_64-linux =
    {
      default = import ./default.nix { inherit pkgs; inherit t64desktop; inherit fhs; };
    };
      
    apps.x86_64-linux = let
      app = name: {
        type = "app";
        program = "${packages.x86_64-linux.${name}}/bin/telegram-desktop";
      };
    in
    {
      default = app "default";
    };
  };
}
