# Illogical Impulse Hyprland related packages
# These packages are equivalent to dist-arch/illogical-impulse-hyprland/PKGBUILD
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.illogical-impulse.hyprland;
in
{
  options.illogical-impulse.hyprland = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Illogical Impulse Hyprland dependencies";
    };

    # Package installation
    package = mkOption {
      type = types.package;
      default = pkgs.hyprland;
      description = "The Hyprland package to use";
    };

    # Monitor configuration
    monitors = mkOption {
      type = types.listOf types.str;
      default = [ ",preferred,auto,1" ];
      description = ''
        Monitor configuration for Hyprland.
        Each string should be in the format: name,resolution,position,scale
        Example: "DP-1,1920x1080@60,0x0,1"
        Use ",preferred,auto,1" for automatic configuration.
      '';
    };

    # Workspace configuration
    workspaces = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = ''
        Workspace configuration for Hyprland.
        Example: "1, monitor:DP-1, default:true"
      '';
    };

    # Extra configuration
    extraConfig = mkOption {
      type = types.lines;
      default = "";
      description = "Extra configuration to append to hyprland.conf";
    };

    # Configuration file deployment
    configFiles = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Deploy Hyprland configuration files from .config directory";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.hypridle
      pkgs.hyprcursor
      cfg.package
      pkgs.hyprland-qtutils
      pkgs.hyprland-qt-support
      pkgs.hyprlang
      pkgs.hyprlock
      pkgs.hyprpicker
      pkgs.hyprsunset
      pkgs.hyprutils
      pkgs.hyprwayland-scanner
      pkgs.xdg-desktop-portal-hyprland
      pkgs.wl-clipboard
    ];

    # Deploy Hyprland configuration files
    xdg.configFile = mkIf cfg.configFiles.enable {
      "hypr/hyprland.conf".source = ../.config/hypr/hyprland.conf;
      "hypr/hypridle.conf".source = ../.config/hypr/hypridle.conf;
      "hypr/hyprlock.conf".source = ../.config/hypr/hyprlock.conf;

      # Hyprland subdirectory configs
      "hypr/hyprland/colors.conf".source = ../.config/hypr/hyprland/colors.conf;
      "hypr/hyprland/env.conf".source = ../.config/hypr/hyprland/env.conf;
      "hypr/hyprland/execs.conf".source = ../.config/hypr/hyprland/execs.conf;
      "hypr/hyprland/general.conf".source = ../.config/hypr/hyprland/general.conf;
      "hypr/hyprland/keybinds.conf".source = ../.config/hypr/hyprland/keybinds.conf;
      "hypr/hyprland/rules.conf".source = ../.config/hypr/hyprland/rules.conf;

      # Custom configs (empty by default for user customization)
      "hypr/custom/env.conf".text = cfg.extraConfig;
      "hypr/custom/execs.conf".text = "";
      "hypr/custom/general.conf".text = "";
      "hypr/custom/keybinds.conf".text = "";
      "hypr/custom/rules.conf".text = "";

      # Monitor configuration
      "hypr/monitors.conf".text = ''
        # Monitor configuration
        ${concatMapStrings (monitor: "monitor=${monitor}\n") cfg.monitors}
      '';

      # Workspace configuration
      "hypr/workspaces.conf".text = ''
        # Workspace configuration
        ${concatMapStrings (workspace: "workspace=${workspace}\n") cfg.workspaces}
      '';
    };

    # Enable Hyprland through home-manager if requested
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd.enable = true;
      package = cfg.package;
    };
  };
}