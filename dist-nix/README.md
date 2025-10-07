# Illogical Impulse Dotfiles - Nix Flake

A home-manager module for the Illogical Impulse Hyprland dotfiles.

## Quick Start

Add to your `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    illogical-impulse.url = "github:end-4/dots-hyprland?dir=dist-nix";
  };

  outputs = { nixpkgs, home-manager, illogical-impulse, ... }: {
    homeConfigurations.yourusername = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        illogical-impulse.homeManagerModules.default
        {
          home.username = "yourusername";
          home.homeDirectory = "/home/yourusername";
          home.stateVersion = "24.11";
        }
      ];
    };
  };
}
```

Then apply with:
```bash
home-manager switch --flake .#yourusername
```

## Configuration

Everything is enabled by default. To disable specific components:

```nix
illogical-impulse = {
  audio.enable = false;      # Disable audio packages
  backlight.enable = true;   # Enable laptop backlight (disabled by default)
};
```

### Monitor Setup

Configure Hyprland monitors:

```nix
illogical-impulse.hyprland = {
  monitors = [
    "DP-1,2560x1440@144,0x0,1"
    "HDMI-A-1,1920x1080@60,2560x0,1"
  ];
  workspaces = [
    "1, monitor:DP-1, default:true"
  ];
};
```

## Available Modules

**Enabled by default:**
- `audio` - Audio controls
- `basic` - Core utilities
- `fonts-themes` - Fonts and theming
- `hyprland` - Hyprland compositor
- `portal` - XDG Desktop Portals
- `screencapture` - Screenshots/recording
- `toolkit` - Qt/GTK dependencies
- `widgets` - Quickshell widgets
- `bibata-cursor` - Cursor theme

**Disabled by default:**
- `backlight` - Laptop backlight control
- `kde` - KDE integration
- `microtex` - LaTeX rendering
- `oneui4-icons` - OneUI4 icons
- `python` - Python dev tools
