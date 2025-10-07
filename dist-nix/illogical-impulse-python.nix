# Illogical Impulse Python Dependencies
# These packages are equivalent to dist-arch/illogical-impulse-python/PKGBUILD
{ config, lib, pkgs, ... }:

with lib;

{
  options.illogical-impulse.python.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable Illogical Impulse Python dependencies (optional)";
  };

  config = mkIf config.illogical-impulse.python.enable {
    home.packages = [
      pkgs.clang
      pkgs.uv
      pkgs.gtk4
      pkgs.libadwaita
      pkgs.libsoup_3
      pkgs.libportal-gtk4
      pkgs.gobject-introspection
      pkgs.sassc
      pkgs.python3Packages.opencv4
    ];
  };
}
