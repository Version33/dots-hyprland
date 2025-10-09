# Illogical Impulse GTK/Qt Dependencies
# These packages are equivalent to dist-arch/illogical-impulse-toolkit/PKGBUILD
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.illogical-impulse.toolkit;
in
{
  options.illogical-impulse.toolkit = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Illogical Impulse GTK/Qt toolkit dependencies";
    };

    configFiles = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Deploy Qt/toolkit configuration files from .config directory";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.kdePackages.kdialog
      pkgs.qt6.qt5compat
      # qt6-avif-image-plugin - May be available through qt6.qtimageformats
      pkgs.qt6.qtbase
      pkgs.qt6.qtdeclarative
      pkgs.qt6.qtimageformats
      pkgs.qt6.qtmultimedia
      pkgs.qt6.qtpositioning
      # qt6-quicktimeline - Part of qt6.qtdeclarative
      pkgs.qt6.qtsensors
      pkgs.qt6.qtsvg
      pkgs.qt6.qttools
      pkgs.qt6.qttranslations
      pkgs.qt6.qtvirtualkeyboard
      pkgs.qt6.qtwayland
      pkgs.kdePackages.syntax-highlighting
      pkgs.upower
      pkgs.wtype
      pkgs.ydotool
    ];

    # Deploy Qt configuration files
    xdg.configFile = mkIf cfg.configFiles.enable {
      "qt5ct".source = ../.config/qt5ct;
      "qt6ct".source = ../.config/qt6ct;
      "Kvantum".source = ../.config/Kvantum;
    };
  };
}
