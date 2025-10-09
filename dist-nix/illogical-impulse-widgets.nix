# Illogical Impulse Widget Dependencies
# These packages are equivalent to dist-arch/illogical-impulse-widgets/PKGBUILD
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.illogical-impulse.widgets;
in
{
  options.illogical-impulse.widgets = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Illogical Impulse widget dependencies";
    };

    configFiles = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Deploy widget configuration files from .config directory";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.fuzzel
      pkgs.glib
      pkgs.hypridle
      pkgs.hyprutils
      pkgs.hyprlock
      pkgs.hyprpicker
      pkgs.networkmanagerapplet
      pkgs.quickshell
      pkgs.translate-shell
      pkgs.wlogout
    ];

    # Deploy widget configuration files
    xdg.configFile = mkIf cfg.configFiles.enable {
      "fuzzel".source = ../.config/fuzzel;
      "wlogout".source = ../.config/wlogout;
      "quickshell".source = ../.config/quickshell;
    };
  };
}
