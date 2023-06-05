{ pkgs , t64desktop ? import ./t64desktop.nix { pkgs = pkgs; }, ... }:
let
  fhs =
    {
      name = "telegram-desktop";
      targetPkgs =
        pkgs: with pkgs; [ 
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
      #   qt6.qtbase
      #   qt6.qtwayland
      #   qt6.qtsvg
		    # qt6.qtimageformats
		    # qt6.qt5compat
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
		    # range-v3
		    # tl-expected
		    # hunspell
		    # glibmm_2_68
		    # webkitgtk_6_0
		    # jemalloc
		    # rnnoise
		    # protobuf
		    # # Transitive dependencies:
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
