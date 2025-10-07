# Example Configurations

This directory contains example configurations for common use cases. These can be used as references when setting up your home-manager configuration.

## Available Examples

### minimal.nix
Bare minimum setup to get Hyprland running. Only includes basic utilities, Hyprland, and XDG portals.

**Use case**: Testing, minimal installations, or when you want to add components incrementally.

### standard.nix
Complete desktop setup with all essential components including audio, widgets, themes, and screen capture.

**Use case**: Recommended for most desktop users.

### laptop.nix
Full featured configuration including laptop-specific features like backlight control.

**Use case**: Recommended for laptop users.

### developer.nix
Includes development tools, Python support, and LaTeX/math rendering capabilities.

**Use case**: Developers and power users who need additional development tools.

### multi-monitor.nix
Example configuration for multi-monitor setups with workspace assignments.

**Use case**: Users with multiple displays who want workspace-to-monitor mappings.

## How to Use

These examples are meant to be incorporated into your home-manager configuration. You can:

1. **Copy directly**: Copy the entire configuration block into your `~/.config/home-manager/flake.nix`
2. **Mix and match**: Take specific sections from different examples
3. **Use as reference**: Look at how different features are configured

## Customization

All examples can be customized by:

- Adding/removing modules from the `enable = true` sections
- Modifying monitor configurations
- Adding custom fish aliases
- Adjusting theme settings
- Adding extra Hyprland configuration

See the main [OPTIONS.md](../../OPTIONS.md) for a complete list of available options.
