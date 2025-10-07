# Multi-Monitor Configuration
#
# Example configuration for a multi-monitor desktop setup.
# Customize monitor names and resolutions based on your hardware.

{
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
    
    # Optional enhancements
    kde.enable = true;
    bibata-cursor.enable = true;
    
    # Multi-monitor Hyprland configuration
    hyprland = {
      # Example: Two monitors side by side
      # Replace with your actual monitor names and resolutions
      # Use 'hyprctl monitors' to see your monitor names
      monitors = [
        "DP-1,2560x1440@144,0x0,1"       # Primary monitor on the left
        "HDMI-A-1,1920x1080@60,2560x0,1" # Secondary monitor on the right
      ];
      
      # Assign workspaces to specific monitors
      workspaces = [
        "1, monitor:DP-1, default:true"   # Workspace 1 on primary
        "2, monitor:DP-1"                  # Workspace 2 on primary
        "3, monitor:DP-1"                  # Workspace 3 on primary
        "4, monitor:HDMI-A-1, default:true" # Workspace 4 on secondary
        "5, monitor:HDMI-A-1"              # Workspace 5 on secondary
      ];
      
      # Extra configuration for multi-monitor setup
      extraConfig = ''
        # Move workspace with Super + Shift + arrow keys
        bind = SUPER SHIFT, left, movecurrentworkspacetomonitor, l
        bind = SUPER SHIFT, right, movecurrentworkspacetomonitor, r
      '';
    };
    
    # Fish shell configuration
    fish = {
      enable = true;
      enableStarship = true;
      autostart.hyprland = true;
      
      aliases = {
        ll = "ls -la";
        gs = "git status";
      };
    };
    
    # Terminal configuration
    terminal = {
      default = "kitty";
      kitty.enable = true;
    };
  };
}
