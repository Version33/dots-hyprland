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
    home.packages = with pkgs.kdePackages; [
      bluedevil
      plasma-nm
      polkit-kde-agent-1
      dolphin
      systemsettings
      pkgs.gnome-keyring
      pkgs.networkmanager
    ];
  };
}
