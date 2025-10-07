# Illogical Impulse Bibata Modern Classic Cursor Theme
# These packages are equivalent to dist-arch/illogical-impulse-bibata-modern-classic-bin/PKGBUILD
{ config, lib, pkgs, ... }:

with lib;

{
  options.illogical-impulse.bibata-cursor.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable Illogical Impulse Bibata cursor theme";
  };

  config = mkIf config.illogical-impulse.bibata-cursor.enable {
    home.packages = [
      pkgs.bibata-cursors
    ];
  };
}
