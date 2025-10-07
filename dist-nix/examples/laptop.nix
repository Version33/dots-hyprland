# Full Desktop Configuration (Laptop)
#
# This configuration includes all features including laptop-specific options
# like backlight control. Recommended for laptop users.

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
    
    # Laptop-specific features
    backlight.enable = true;
    
    # Optional enhancements
    kde.enable = true;
    bibata-cursor.enable = true;
    
    # Hyprland configuration
    hyprland = {
      monitors = [ ",preferred,auto,1" ];
      workspaces = [ ];
      
      # Example laptop-specific settings
      extraConfig = ''
        # Power-saving features
        misc {
          vfr = true
        }
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
        gp = "git push";
        gl = "git pull";
        shutdown-now = "systemctl poweroff";
        reboot-now = "systemctl reboot";
      };
    };
    
    # Terminal configuration
    terminal = {
      default = "kitty";
      kitty.enable = true;
    };
    
    # Theme configuration
    fonts-themes = {
      gtkTheme = "adw-gtk3-dark";
      iconTheme = "breeze-dark";
      cursorTheme = "Bibata-Modern-Classic";
    };
  };
}
