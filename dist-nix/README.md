# Illogical Impulse Dotfiles - Nix Installation Guide

This directory contains Nix flake configuration for installing the Illogical Impulse dotfiles on any Linux distribution using Nix and home-manager.

> **Note**: This is designed for use with home-manager on any distribution, not specifically for NixOS. If you're using NixOS, you can still use this flake as a home-manager module.

## Quick Start

### Option 1: Automated Installation (Recommended)

If you're starting fresh or want a quick setup:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/end-4/dots-hyprland.git
   cd dots-hyprland/dist-nix
   ```

2. **Run the installation script**:
   ```bash
   ./install-deps.sh
   ```

   The script will:
   - Install Nix if not present
   - Enable flakes
   - Install home-manager
   - Generate a home-manager configuration with sensible defaults
   - Apply the configuration

### Option 2: Manual Integration

If you already have home-manager configured or prefer manual setup:

### Prerequisites

- Nix package manager installed (see [Installation](#installing-nix) if you don't have it)
- Nix flakes enabled (see [Enabling Flakes](#enabling-flakes))
- home-manager installed (see [Installing home-manager](#installing-home-manager))

### Using the Flake

1. **Add this flake as an input to your home-manager configuration**:

   ```nix
   # In your ~/.config/home-manager/flake.nix
   {
     inputs = {
       nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
       home-manager = {
         url = "github:nix-community/home-manager";
         inputs.nixpkgs.follows = "nixpkgs";
       };
       illogical-impulse = {
         url = "github:end-4/dots-hyprland?dir=dist-nix";
         inputs.nixpkgs.follows = "nixpkgs";
       };
     };

     outputs = { nixpkgs, home-manager, illogical-impulse, ... }: {
       homeConfigurations."yourusername" = home-manager.lib.homeManagerConfiguration {
         pkgs = nixpkgs.legacyPackages.x86_64-linux;
         modules = [
           illogical-impulse.homeManagerModules.default
           {
             home.username = "yourusername";
             home.homeDirectory = "/home/yourusername";
             home.stateVersion = "24.11";

             # Enable Illogical Impulse dotfiles
             illogical-impulse = {
               enable = true;
               
               # Essential components
               audio.enable = true;
               basic.enable = true;
               fonts-themes.enable = true;
               hyprland.enable = true;
               portal.enable = true;
               screencapture.enable = true;
               toolkit.enable = true;
               widgets.enable = true;
               
               # Optional components
               backlight.enable = true;  # For laptops
               kde.enable = true;         # KDE integration
               python.enable = false;     # Python development
             };
           }
         ];
       };
     };
   }
   ```

2. **Apply the configuration**:

   ```bash
   home-manager switch --flake ~/.config/home-manager#yourusername
   ```

## Installation from Scratch

If you're starting fresh, follow these steps:

### Installing Nix

We recommend using the Determinate Systems Nix Installer:

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

This installer automatically enables flakes and provides better defaults than the official installer.

### Enabling Flakes

If you installed Nix through other means, enable flakes by adding to `~/.config/nix/nix.conf`:

```
experimental-features = nix-command flakes
```

### Installing home-manager

```bash
nix run home-manager/master -- init --switch
```

This creates a basic home-manager configuration at `~/.config/home-manager/`.

## Configuration Options

### Sensible Default Profiles

#### Minimal Desktop

```nix
illogical-impulse = {
  enable = true;
  basic.enable = true;
  hyprland.enable = true;
  portal.enable = true;
};
```

#### Standard Desktop

```nix
illogical-impulse = {
  enable = true;
  
  # Essential components
  audio.enable = true;
  basic.enable = true;
  fonts-themes.enable = true;
  hyprland.enable = true;
  portal.enable = true;
  screencapture.enable = true;
  toolkit.enable = true;
  widgets.enable = true;
};
```

#### Full Desktop (Laptop)

```nix
illogical-impulse = {
  enable = true;
  
  # Essential components
  audio.enable = true;
  basic.enable = true;
  fonts-themes.enable = true;
  hyprland.enable = true;
  portal.enable = true;
  screencapture.enable = true;
  toolkit.enable = true;
  widgets.enable = true;
  
  # Optional laptop features
  backlight.enable = true;
  
  # Optional integrations
  kde.enable = true;
  bibata-cursor.enable = true;
};
```

#### Developer Setup

```nix
illogical-impulse = {
  enable = true;
  
  # Essential components
  audio.enable = true;
  basic.enable = true;
  fonts-themes.enable = true;
  hyprland.enable = true;
  portal.enable = true;
  screencapture.enable = true;
  toolkit.enable = true;
  widgets.enable = true;
  
  # Development tools
  python.enable = true;
  microtex.enable = true;  # LaTeX rendering
};
```

### Available Modules

For a complete list of options, see [OPTIONS.md](../OPTIONS.md) in the repository root.

Essential modules:
- `audio` - Audio control and visualization (cava, pavucontrol, playerctl)
- `basic` - Basic utilities (curl, wget, jq, ripgrep, etc.)
- `fonts-themes` - Font packages and theming
- `hyprland` - Hyprland compositor and tools
- `portal` - XDG Desktop Portal implementations
- `screencapture` - Screenshot and recording tools
- `toolkit` - Qt/GTK toolkit dependencies
- `widgets` - Widget system (Quickshell, fuzzel, wlogout)

Optional modules:
- `backlight` - Backlight control (useful for laptops)
- `bibata-cursor` - Bibata Modern Classic cursor theme
- `kde` - KDE/Plasma integration
- `microtex` - LaTeX/math rendering
- `oneui4-icons` - OneUI4 icon theme
- `python` - Python development dependencies

### Hyprland Configuration

```nix
illogical-impulse.hyprland = {
  enable = true;
  
  # Monitor setup
  monitors = [
    "DP-1,2560x1440@144,0x0,1"       # Primary monitor
    "HDMI-A-1,1920x1080@60,2560x0,1" # Secondary monitor
  ];
  
  # Workspace configuration
  workspaces = [
    "1, monitor:DP-1, default:true"
    "2, monitor:DP-1"
    "3, monitor:HDMI-A-1, default:true"
  ];
  
  # Extra configuration (appended to custom/env.conf)
  extraConfig = ''
    env = XCURSOR_SIZE,24
  '';
};
```

### Fish Shell Configuration

```nix
illogical-impulse.fish = {
  enable = true;
  enableStarship = true;
  
  # Custom aliases
  aliases = {
    ll = "ls -la";
    gs = "git status";
    vim = "nvim";
  };
  
  # Autostart Hyprland on tty1
  autostart.hyprland = true;
};
```

### Terminal Configuration

```nix
illogical-impulse.terminal = {
  default = "kitty";
  kitty.enable = true;
};
```

## Deployment Options

The flake automatically deploys configuration files from `.config` to `~/.config`. To disable this:

```nix
illogical-impulse.configFiles.enable = false;
```

This is useful if you want to manage configurations separately or customize them before deployment.

## Updating

To update the dotfiles and all packages:

```bash
# Update flake inputs
nix flake update ~/.config/home-manager

# Apply changes
home-manager switch --flake ~/.config/home-manager#yourusername
```

## Troubleshooting

### "unknown flake output" warning

You may see a warning about `homeManagerModules` being an unknown flake output. This is harmless and can be ignored. It's a conventional output name for home-manager modules that isn't officially recognized by Nix.

### Configuration files not deploying

Ensure `configFiles.enable = true` (it's true by default) and that you're using the `illogical-impulse.homeManagerModules.default` module.

### Hyprland won't start

1. Ensure you have a display manager or are starting from tty
2. Check logs: `~/.cache/hyprland.log`
3. Verify all required modules are enabled (at minimum: `basic`, `hyprland`, `portal`)

### Missing packages

Some packages from the Arch version may not be available in nixpkgs. The flake includes the closest available alternatives. If you need specific packages:

1. Add them to your home-manager configuration
2. Use overlays to build custom packages
3. Consider using AUR packages if on an Arch-based system

## Manual Installation (Alternative Method)

If you prefer not to use the automated script, you can manually integrate the flake:

1. Ensure Nix is installed with flakes enabled
2. Add the flake to your home-manager inputs (see [Using the Flake](#using-the-flake))
3. Configure the modules in your home-manager configuration
4. Run `home-manager switch`

## Migration from dist-arch

If you're migrating from the Arch installation:

1. The Nix installation doesn't conflict with existing Arch packages
2. Configuration files will be symlinked by home-manager
3. You can keep both installations and switch between them
4. To fully switch, remove the Arch packages: `sudo pacman -R illogical-impulse-*`

## Contributing

If you find issues with the Nix configuration or have improvements:

1. Open an issue at https://github.com/end-4/dots-hyprland/issues
2. Submit a pull request with your changes
3. Join the Discord: https://discord.gg/GtdRBXgMwq

## License

Same as the main repository - see [LICENSE](../LICENSE)
