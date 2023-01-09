{ pkgs , t64desktop ? import ./t64desktop.nix { pkgs = pkgs; }, ... }:
let
  fhs =
    {
      name = "telegram-desktop";
      targetPkgs =
        pkgs: with pkgs; [ glib fontconfig freetype libglvnd xorg.libxcb xorg.libX11 dbus xkeyboard_config desktop-file-utils wayland gtk3 t64desktop ];
      runScript = "Telegram";
    };
in
pkgs.symlinkJoin {
  name = "${t64desktop.pname}";
  paths = [
    (pkgs.buildFHSUserEnv fhs)
  ];
  postBuild = ''
    mkdir -p $out/share
    ln -s ${t64desktop}/share/applications $out/share
    ln -s ${t64desktop}/share/icons $out/share
  '';
}
