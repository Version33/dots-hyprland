# Illogical Impulse Audio Dependencies
# These packages are equivalent to dist-arch/illogical-impulse-audio/PKGBUILD
{ config, lib, pkgs, ... }:

with lib;

{
  options.illogical-impulse.audio.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable Illogical Impulse audio dependencies";
  };

  config = mkIf config.illogical-impulse.audio.enable {
    home.packages = [
      pkgs.cava
      pkgs.lxqt.pavucontrol-qt
      pkgs.wireplumber
      pkgs.libdbusmenu-gtk3
      pkgs.playerctl
    ];
  };
}
