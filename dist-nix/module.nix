{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.illogical-impulse;
in
{
  imports = [
    ./illogical-impulse-audio.nix
    ./illogical-impulse-backlight.nix
    ./illogical-impulse-basic.nix
    ./illogical-impulse-bibata-modern-classic-bin.nix
    ./illogical-impulse-fonts-themes.nix
    ./illogical-impulse-hyprland.nix
    ./illogical-impulse-kde.nix
    ./illogical-impulse-microtex-git.nix
    ./illogical-impulse-oneui4-icons-git.nix
    ./illogical-impulse-portal.nix
    ./illogical-impulse-python.nix
    ./illogical-impulse-screencapture.nix
    ./illogical-impulse-toolkit.nix
    ./illogical-impulse-widgets.nix
  ];

  options.illogical-impulse = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Illogical Impulse dotfiles configuration";
    };

    # Fish shell configuration
    fish = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable Fish shell configuration";
      };

      enableStarship = mkOption {
        type = types.bool;
        default = true;
        description = "Enable Starship prompt";
      };

      aliases = mkOption {
        type = types.attrsOf types.str;
        default = {
          pamcan = "pacman";
          ls = "eza --icons";
          clear = "printf '\\033[2J\\033[3J\\033[1;1H'";
          q = "qs -c ii";
        };
        description = "Fish shell aliases";
      };

      autostart = {
        hyprland = mkOption {
          type = types.bool;
          default = true;
          description = "Automatically start Hyprland on tty1";
        };
      };
    };

    # Terminal configuration
    terminal = {
      default = mkOption {
        type = types.str;
        default = "kitty";
        description = "Default terminal emulator";
      };

      kitty = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Enable Kitty terminal configuration";
        };
      };
    };

    # Configuration file deployment
    configFiles = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Deploy configuration files from .config directory";
      };
    };
  };

  config = mkIf cfg.enable {
    xdg.configFile = mkMerge [
      # Deploy Fish configuration
      (mkIf (cfg.fish.enable && cfg.configFiles.enable) {
        "fish/config.fish".text = ''
          function fish_prompt -d "Write out the prompt"
              # This shows up as USER@HOST /home/user/ >, with the directory colored
              # $USER and $hostname are set by fish, so you can just use them
              # instead of using `whoami` and `hostname`
              printf '%s@%s %s%s%s > ' $USER $hostname \
                  (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
          end

          if status is-interactive # Commands to run in interactive sessions can go here

              # No greeting
              set fish_greeting

              ${optionalString cfg.fish.enableStarship ''
              # Use starship
              starship init fish | source
              if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
                  cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
              end
              ''}

              # Aliases
              ${concatStringsSep "\n    " (mapAttrsToList (name: value: "alias ${name} '${value}'") cfg.fish.aliases)}
              
          end
        '';

        "fish/auto-Hypr.fish" = mkIf cfg.fish.autostart.hyprland {
          text = ''
            # Auto start Hyprland on tty1
            if test -z "$DISPLAY" ;and test "$XDG_VTNR" -eq 1
                mkdir -p ~/.cache
                exec Hyprland > ~/.cache/hyprland.log 2>&1
            end
          '';
        };
      })

      # Deploy Kitty configuration
      (mkIf (cfg.terminal.kitty.enable && cfg.configFiles.enable) {
        "kitty/kitty.conf".source = ../.config/kitty/kitty.conf;
        "kitty/scroll_mark.py".source = ../.config/kitty/scroll_mark.py;
        "kitty/search.py".source = ../.config/kitty/search.py;
      })

      # Deploy Starship configuration
      (mkIf (cfg.fish.enableStarship && cfg.configFiles.enable) {
        "starship.toml".source = ../.config/starship.toml;
      })

      # Deploy foot terminal configuration
      (mkIf cfg.configFiles.enable {
        "foot".source = ../.config/foot;
      })

      # Deploy Chromium/Chrome flags
      (mkIf cfg.configFiles.enable {
        "chrome-flags.conf".source = ../.config/chrome-flags.conf;
        "code-flags.conf".source = ../.config/code-flags.conf;
        "thorium-flags.conf".source = ../.config/thorium-flags.conf;
      })
    ];

    # Enable Fish shell through home-manager
    programs.fish = mkIf cfg.fish.enable {
      enable = true;
      # ... (unchanged content omitted)
    };
  };
}