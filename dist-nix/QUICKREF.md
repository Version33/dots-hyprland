# Illogical Impulse Nix - Quick Reference

## Installation

```bash
# Clone and install
git clone https://github.com/end-4/dots-hyprland.git
cd dots-hyprland/dist-nix
./install-deps.sh
```

## Updating

```bash
# Update flake inputs and apply
cd ~/.config/home-manager
nix flake update
home-manager switch --flake .#yourusername
```

## Common Configurations

### Enable a Module
```nix
illogical-impulse.modulename.enable = true;
```

### Essential Modules (Recommended)
```nix
audio.enable = true;        # Audio controls
basic.enable = true;        # Basic utilities
fonts-themes.enable = true; # Fonts and themes
hyprland.enable = true;     # Hyprland compositor
portal.enable = true;       # XDG portals
screencapture.enable = true; # Screenshots
toolkit.enable = true;      # Qt/GTK tools
widgets.enable = true;      # Quickshell widgets
```

### Optional Modules
```nix
backlight.enable = true;    # Laptop backlight control
kde.enable = true;          # KDE integration
python.enable = true;       # Python dev tools
microtex.enable = true;     # LaTeX rendering
```

## Monitor Configuration

```nix
hyprland.monitors = [
  "DP-1,2560x1440@144,0x0,1"     # Primary
  "HDMI-A-1,1920x1080@60,2560x0,1" # Secondary
];
```

## Workspace Configuration

```nix
hyprland.workspaces = [
  "1, monitor:DP-1, default:true"
  "2, monitor:DP-1"
];
```

## Fish Aliases

```nix
fish.aliases = {
  ll = "ls -la";
  gs = "git status";
};
```

## File Locations

- Config: `~/.config/home-manager/flake.nix`
- Logs: `~/.cache/hyprland.log`
- Hyprland configs: `~/.config/hypr/`

## Troubleshooting

```bash
# Check home-manager status
home-manager --version

# View available packages
nix search nixpkgs packagename

# Rebuild without updating
home-manager switch --flake ~/.config/home-manager#yourusername

# View logs
tail -f ~/.cache/hyprland.log
```

## Useful Commands

```bash
# List installed packages
home-manager packages

# Rollback to previous generation
home-manager generations
home-manager switch --switch-generation GENERATION_NUMBER

# Clean old generations
nix-collect-garbage -d
```

## Getting Help

- Docs: [dist-nix/README.md](README.md)
- Options: [OPTIONS.md](../OPTIONS.md)
- Wiki: https://end-4.github.io/dots-hyprland-wiki/
- Discord: https://discord.gg/GtdRBXgMwq
