# Minimal Illogical Impulse Configuration
# 
# This is the bare minimum setup to get Hyprland running.
# Suitable for testing or very minimal installations.

{
  illogical-impulse = {
    enable = true;
    
    # Essential components only
    basic.enable = true;
    hyprland.enable = true;
    portal.enable = true;
    
    # Basic Hyprland configuration
    hyprland = {
      monitors = [ ",preferred,auto,1" ];
    };
    
    # Fish shell with minimal config
    fish = {
      enable = true;
      enableStarship = false;  # Disabled for minimal setup
      autostart.hyprland = true;
    };
  };
}
