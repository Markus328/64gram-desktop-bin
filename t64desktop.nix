{pkgs, ...}:
with pkgs; let
  url_git = "https://github.com/TDesktop-x64/tdesktop";
  version = "1.1.51";
  srcs = [
    (fetchurl {
      url = "${url_git}/raw/dev/lib/xdg/io.github.tdesktop_x64.TDesktop.desktop";
      sha256 = "345efff96a3f7c828f38142fe4d9e553a99871d7228a73c9ff69089791f4e963";
    })
    (fetchurl {
      url = "${url_git}/raw/dev/Telegram/Resources/art/icon256.png";
      sha256 = "3fb1400c7dc9bbc3b5cb3ffedcbf4a9b09c53e28b57a7ff33a8a6b9048864090";
    })
    (fetchurl {
      url = "${url_git}/releases/download/v${version}/64Gram_${version}_linux.zip";
      sha256 = "456797d9afcdbec95b20c1d47793c4bdc78253846612fd4086f1184c6ee1274e";
    })
  ];
  desktop = builtins.elemAt srcs 0;
  icon = builtins.elemAt srcs 1;
  app = builtins.elemAt srcs 2;

  rpath = lib.makeLibraryPath [
    glib
    fontconfig
    freetype
    libglvnd
    xorg.libxcb
    xorg.libX11
    dbus
    xkeyboard_config
    desktop-file-utils
    wayland
    qt6.qtbase
    qt6.qtwayland
    qt6.qtsvg
    qt6.qtimageformats
    qt6.qt5compat
    glibmm
    gtk3
    libdbusmenu
    lz4
    xxHash
    ffmpeg
    openalSoft
    minizip
    libopus
    alsa-lib
    libpulseaudio
    pipewire
    range-v3
    tl-expected
    hunspell
    glibmm_2_68
    webkitgtk_6_0
    jemalloc
    rnnoise
    protobuf
    util-linuxMinimal
    pcre
    xorg.libpthreadstubs
    xorg.libXdamage
    xorg.libXdmcp
    libselinux
    libsepol
    libepoxy
    at-spi2-core
    xorg.libXtst
    libthai
    libdatrie
    libsysprof-capture
    libpsl
    brotli
    microsoft_gsl
    rlottie
  ];
in
  stdenv.mkDerivation {
    pname = "64gram-desktop-bin";
    inherit version srcs;
    dontBuild = true;
    nativeBuildInputs = [
      unzip
      qt6.qtbase
      qt6.wrapQtAppsHook
      # autoPatchelfHook
    ];

    # runtimeDependencies = [

    # ];

    unpackPhase = ''
      unzip ${app}
    '';
    installPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/share/pixmaps
      mkdir -p $out/share/applications
      mkdir -p $out/share/icons/hicolor/256x256/apps

      cp ./Telegram $out/bin/telegram-desktop
      cp ${icon} $out/share/pixmaps/telegram.png
      cp ${icon} $out/share/icons/hicolor/256x256/apps/telegram.png

      cp ${desktop} $out/share/applications/telegram.desktop
      sed -i 's/@CMAKE_INSTALL_FULL_BINDIR@\///g' $out/share/applications/telegram.desktop
    '';
    postFixup = ''
      patchelf --set-interpreter ${pkgs.glibc}/lib/ld-linux-x86-64.so.2 "$out/bin/.telegram-desktop-wrapped"
      patchelf --set-rpath ${rpath} "$out/bin/.telegram-desktop-wrapped"
    '';
  }
