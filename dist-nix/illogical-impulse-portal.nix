# Illogical Impulse XDG Desktop Portals
# These packages are equivalent to dist-arch/illogical-impulse-portal/PKGBUILD
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.illogical-impulse.portal;
in
{
  options.illogical-impulse.portal = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Illogical Impulse XDG Desktop Portal dependencies";
    };

    configFiles = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Deploy XDG portal configuration files from .config directory";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.xdg-desktop-portal
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];

    # Deploy XDG portal configuration
    xdg.configFile = mkIf cfg.configFiles.enable {
      "xdg-desktop-portal".source = ../.config/xdg-desktop-portal;
    };
  };
}
