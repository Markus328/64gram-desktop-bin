{
  pkgs,
  t64desktop,
  ...
}: let
  fhs = {
    name = "telegram-desktop";
    targetPkgs = pkgs:
      with pkgs; [
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
        #    systemdMinimal
        #   qt6.qtbase
        #   qt6.qtwayland
        #   qt6.qtsvg
        # qt6.qtimageformats
        # qt6.qt5compat
        #   glibmm
        gtk3
        # libdbusmenu
        # lz4
        # xxHash
        # ffmpeg
        # openalSoft
        # minizip
        # libopus
        # alsa-lib
        # libpulseaudio
        pipewire
        # range-v3 tl-expected
        # hunspell
        # glibmm_2_68
        # webkitgtk_6_0
        # jemalloc
        # rnnoise
        # protobuf
        # Transitive dependencies:
        # util-linuxMinimal # Required for libmount thus not nativeBuildInputs.
        # pcre
        # xorg.libpthreadstubs
        # xorg.libXdamage
        # xorg.libXdmcp
        # libselinux
        # libsepol
        # libepoxy
        # at-spi2-core
        # xorg.libXtst
        # libthai
        # libdatrie
        # libsysprof-capture
        # libpsl
        #   brotli
        #   microsoft_gsl
        #   rlottie
        t64desktop
      ];
    runScript = "/bin/Telegram";
    extraBwrapArgs = [
      "--ro-bind-try /usr/share/icons /usr/share/icons"
      "--ro-bind-try /usr/share/pixmaps /usr/share/pixmaps"
      "--ro-bind-try /usr/share/fonts /usr/share/fonts"
      "--ro-bind-try /usr/share/zoneinfo /usr/share/zoneinfo"
    ];
  };
in
  pkgs.buildFHSUserEnvBubblewrap fhs
