# Illogical Impulse KDE Dependencies
# These packages are equivalent to dist-arch/illogical-impulse-kde/PKGBUILD
{ config, lib, pkgs, ... }:

with lib;

{
  options.illogical-impulse.kde.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable Illogical Impulse KDE dependencies (optional)";
  };

  config = mkIf config.illogical-impulse.kde.enable {
    home.packages = [
      pkgs.bluedevil
      pkgs.gnome-keyring
      pkgs.networkmanager
      pkgs.plasma-nm
      pkgs.polkit-kde-agent
      pkgs.dolphin
      pkgs.systemsettings
    ];
  };
}
