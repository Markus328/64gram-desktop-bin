{ pkgs, ...}:
with pkgs;
let
  url_git = "https://github.com/TDesktop-x64/tdesktop";
  version = "1.0.63";
  srcs = [
    (fetchurl {
      url = "${url_git}/raw/dev/lib/xdg/org.telegram.desktop.desktop";
      sha256 = "57b2e4d6a0f84723a4e346f28ec888fecfcbea64f03688349be8a1df9121570b";
    })
    (fetchurl {
      url = "${url_git}/raw/dev/Telegram/Resources/art/icon256.png";
      sha256 = "3fb1400c7dc9bbc3b5cb3ffedcbf4a9b09c53e28b57a7ff33a8a6b9048864090";
    })
    (fetchurl {
      url = "${url_git}/releases/download/v${version}/64Gram_${version}_linux.zip";
      sha256 = "3423a7cf18d4bedf595f8112d48c5f1edb3dd6ba133bfb0794325181d60ad22c";
    })
  ];
  desktop = builtins.elemAt srcs 0;
  icon = builtins.elemAt srcs 1;
  app = builtins.elemAt srcs 2;
in
stdenv.mkDerivation {
  pname = "64gram-desktop-bin";
  inherit version srcs;
  dontBuild = true;
  nativeBuildInputs = [ unzip ];
  unpackPhase = ''
    unzip ${app}
  '';
  installPhase = ''
    mkdir -p $out/bin 
    mkdir -p $out/share/pixmaps 
    mkdir -p $out/share/applications 
    mkdir -p $out/share/icons/hicolor/256x256/apps

    cp ./Telegram $out/bin
    cp ${icon} $out/share/pixmaps/telegram.png
    cp ${icon} $out/share/icons/hicolor/256x256/apps/telegram.png

    cp ${desktop} $out/share/applications/telegram.desktop
    sed -i 's/@CMAKE_INSTALL_FULL_BINDIR@\///g' $out/share/applications/telegram.desktop
  '';
}
