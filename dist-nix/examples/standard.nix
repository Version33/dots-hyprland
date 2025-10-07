# Standard Desktop Configuration
#
# This is a complete desktop setup with all essential components.
# Recommended for most users.

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
    
    # Hyprland configuration
    hyprland = {
      monitors = [ ",preferred,auto,1" ];
      workspaces = [ ];
      extraConfig = '''';
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
      };
    };
    
    # Terminal configuration
    terminal = {
      default = "kitty";
      kitty.enable = true;
    };
  };
}
