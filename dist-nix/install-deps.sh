#!/usr/bin/env bash

# Illogical Impulse Dotfiles - Nix Installation Script
# This script installs Nix, home-manager, and sets up the dotfiles configuration

set -e

# Colors for output
STY_RED='\033[0;31m'
STY_GREEN='\033[0;32m'
STY_YELLOW='\033[0;33m'
STY_CYAN='\033[0;36m'
STY_RESET='\033[0m'

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo -e "${STY_CYAN}╔══════════════════════════════════════════════════════════════╗${STY_RESET}"
echo -e "${STY_CYAN}║  Illogical Impulse Dotfiles - Nix Installation              ║${STY_RESET}"
echo -e "${STY_CYAN}╚══════════════════════════════════════════════════════════════╝${STY_RESET}"
echo ""
echo -e "${STY_YELLOW}This script will:${STY_RESET}"
echo -e "  1. Install Nix package manager (if not present)"
echo -e "  2. Enable Nix flakes (if not enabled)"
echo -e "  3. Install home-manager (if not present)"
echo -e "  4. Generate a home-manager configuration"
echo -e "  5. Set up the Illogical Impulse dotfiles"
echo ""
echo -e "${STY_YELLOW}WARNING: This script is experimental. Use at your own risk.${STY_RESET}"
echo -e "${STY_YELLOW}Make sure to backup your existing configurations before proceeding.${STY_RESET}"
echo ""

read -p "Do you want to continue? [y/N]: " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${STY_RED}Installation cancelled.${STY_RESET}"
    exit 1
fi

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if Nix flakes are enabled
flakes_enabled() {
    if nix --version >/dev/null 2>&1 && nix flake --help >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

echo ""
echo -e "${STY_CYAN}[Step 1/5] Checking Nix installation...${STY_RESET}"

if ! command_exists nix; then
    echo -e "${STY_YELLOW}Nix is not installed. Installing via Determinate Systems installer...${STY_RESET}"
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    
    # Source nix
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
    
    echo -e "${STY_GREEN}✓ Nix installed successfully${STY_RESET}"
else
    echo -e "${STY_GREEN}✓ Nix is already installed${STY_RESET}"
fi

echo ""
echo -e "${STY_CYAN}[Step 2/5] Checking Nix flakes...${STY_RESET}"

if ! flakes_enabled; then
    echo -e "${STY_YELLOW}Enabling Nix flakes...${STY_RESET}"
    
    # Create nix config directory
    mkdir -p ~/.config/nix
    
    # Enable flakes
    if ! grep -q "experimental-features.*flakes" ~/.config/nix/nix.conf 2>/dev/null; then
        echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
        echo -e "${STY_GREEN}✓ Flakes enabled in ~/.config/nix/nix.conf${STY_RESET}"
    else
        echo -e "${STY_GREEN}✓ Flakes already enabled${STY_RESET}"
    fi
else
    echo -e "${STY_GREEN}✓ Nix flakes are already enabled${STY_RESET}"
fi

echo ""
echo -e "${STY_CYAN}[Step 3/5] Checking home-manager installation...${STY_RESET}"

if ! command_exists home-manager; then
    echo -e "${STY_YELLOW}Installing home-manager...${STY_RESET}"
    nix run home-manager/master -- init --switch
    echo -e "${STY_GREEN}✓ home-manager installed${STY_RESET}"
else
    echo -e "${STY_GREEN}✓ home-manager is already installed${STY_RESET}"
fi

echo ""
echo -e "${STY_CYAN}[Step 4/5] Setting up home-manager configuration...${STY_RESET}"

HM_CONFIG_DIR="$HOME/.config/home-manager"
USERNAME="$(whoami)"

# Detect if configuration already exists
if [ -f "$HM_CONFIG_DIR/flake.nix" ]; then
    echo -e "${STY_YELLOW}Existing home-manager configuration detected at $HM_CONFIG_DIR${STY_RESET}"
    echo -e "You can manually add the Illogical Impulse flake to your existing configuration."
    echo -e "See the README.md in $SCRIPT_DIR for instructions."
    echo ""
    read -p "Do you want to backup and create a new configuration? [y/N]: " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        BACKUP_DIR="$HM_CONFIG_DIR.backup.$(date +%Y%m%d_%H%M%S)"
        mv "$HM_CONFIG_DIR" "$BACKUP_DIR"
        echo -e "${STY_GREEN}✓ Existing configuration backed up to $BACKUP_DIR${STY_RESET}"
    else
        echo -e "${STY_YELLOW}Skipping configuration generation. Please configure manually.${STY_RESET}"
        echo -e "See: $SCRIPT_DIR/README.md"
        exit 0
    fi
fi

# Create home-manager configuration directory
mkdir -p "$HM_CONFIG_DIR"

# Generate flake.nix
cat > "$HM_CONFIG_DIR/flake.nix" << EOF
{
  description = "Home Manager configuration with Illogical Impulse dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    illogical-impulse = {
      url = "path:$REPO_ROOT/dist-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, illogical-impulse, ... }: {
    homeConfigurations."$USERNAME" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      
      modules = [
        illogical-impulse.homeManagerModules.default
        {
          home.username = "$USERNAME";
          home.homeDirectory = "$HOME";
          home.stateVersion = "24.11";

          # Enable Illogical Impulse dotfiles with sensible defaults
          illogical-impulse = {
            enable = true;
            
            # Essential components - enable based on your needs
            audio.enable = true;
            basic.enable = true;
            fonts-themes.enable = true;
            hyprland.enable = true;
            portal.enable = true;
            screencapture.enable = true;
            toolkit.enable = true;
            widgets.enable = true;
            
            # Optional components - uncomment to enable
            # backlight.enable = true;       # For laptops with backlight control
            # kde.enable = true;              # KDE/Plasma integration
            # bibata-cursor.enable = true;    # Bibata cursor theme
            # python.enable = true;           # Python development tools
            # microtex.enable = true;         # LaTeX/math rendering
            
            # Hyprland configuration
            hyprland = {
              monitors = [ ",preferred,auto,1" ];  # Auto-detect monitors
              # Customize monitors:
              # monitors = [
              #   "DP-1,2560x1440@144,0x0,1"
              #   "HDMI-A-1,1920x1080@60,2560x0,1"
              # ];
            };
            
            # Fish shell configuration
            fish = {
              enable = true;
              enableStarship = true;
              autostart.hyprland = true;
              
              # Add custom aliases here
              aliases = {
                ll = "ls -la";
                gs = "git status";
                # Add more aliases as needed
              };
            };
            
            # Terminal configuration
            terminal = {
              default = "kitty";
              kitty.enable = true;
            };
          };

          # Allow unfree packages (needed for some packages)
          nixpkgs.config.allowUnfree = true;
        }
      ];
    };
  };
}
EOF

echo -e "${STY_GREEN}✓ Generated home-manager configuration at $HM_CONFIG_DIR/flake.nix${STY_RESET}"

echo ""
echo -e "${STY_CYAN}[Step 5/5] Applying configuration...${STY_RESET}"

echo -e "${STY_YELLOW}This may take a while as packages are downloaded and built...${STY_RESET}"

cd "$HM_CONFIG_DIR"
home-manager switch --flake ".#$USERNAME"

echo ""
echo -e "${STY_GREEN}╔══════════════════════════════════════════════════════════════╗${STY_RESET}"
echo -e "${STY_GREEN}║  Installation Complete!                                      ║${STY_RESET}"
echo -e "${STY_GREEN}╚══════════════════════════════════════════════════════════════╝${STY_RESET}"
echo ""
echo -e "${STY_CYAN}Next steps:${STY_RESET}"
echo -e "  1. Log out and log back in (or reboot) for all changes to take effect"
echo -e "  2. Launch Hyprland from tty1 (or it will auto-start if configured)"
echo -e "  3. Customize your configuration in: $HM_CONFIG_DIR/flake.nix"
echo -e "  4. Apply changes with: home-manager switch --flake ~/.config/home-manager#$USERNAME"
echo ""
echo -e "${STY_CYAN}Documentation:${STY_RESET}"
echo -e "  • Nix README: $SCRIPT_DIR/README.md"
echo -e "  • Options reference: $REPO_ROOT/OPTIONS.md"
echo -e "  • Wiki: https://end-4.github.io/dots-hyprland-wiki/"
echo -e "  • Discord: https://discord.gg/GtdRBXgMwq"
echo ""
echo -e "${STY_YELLOW}Note: Some configurations may require additional manual setup.${STY_RESET}"
echo -e "${STY_YELLOW}See the README for more information.${STY_RESET}"
