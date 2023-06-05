{ pkgs, ...}:
with pkgs;
let
  url_git = "https://github.com/TDesktop-x64/tdesktop";
  version = "1.0.85";
  srcs = [
    (fetchurl {
      url = "${url_git}/raw/dev/lib/xdg/org.telegram.desktop.desktop";
      sha256 = "731dcfb4dcdfe5e4cfcf9f1adc256090576ee91bc7592c7807c2bd343b7705f9";
    })
    (fetchurl {
      url = "${url_git}/raw/dev/Telegram/Resources/art/icon256.png";
      sha256 = "3fb1400c7dc9bbc3b5cb3ffedcbf4a9b09c53e28b57a7ff33a8a6b9048864090";
    })
    (fetchurl {
      url = "${url_git}/releases/download/v${version}/64Gram_${version}_linux.zip";
      sha256 = "c7545252efae304fb3009222c10700a7519eea8ba484ad56ed97ec6c0f273556";
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
