# Illogical Impulse Backlight Dependencies
# These packages are equivalent to dist-arch/illogical-impulse-backlight/PKGBUILD
{ config, lib, pkgs, ... }:

with lib;

{
  options.illogical-impulse.backlight.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable Illogical Impulse backlight dependencies (useful for laptops)";
  };

  config = mkIf config.illogical-impulse.backlight.enable {
    home.packages = [
      pkgs.geoclue2
      pkgs.brightnessctl
      pkgs.ddcutil
    ];
  };
}
