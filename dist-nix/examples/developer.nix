# Developer Configuration
#
# This configuration includes development tools and Python support.
# Recommended for developers and power users.

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
    
    # Development tools
    python.enable = true;
    microtex.enable = true;  # For LaTeX/math rendering
    
    # KDE integration for file management
    kde.enable = true;
    
    # Hyprland configuration
    hyprland = {
      monitors = [ ",preferred,auto,1" ];
      
      # Developer-friendly extra configuration
      extraConfig = ''
        # Workspace rules for development
        windowrulev2 = workspace 2, class:^(code|Code)$
        windowrulev2 = workspace 3, class:^(firefox|Firefox)$
      '';
    };
    
    # Fish shell configuration with development aliases
    fish = {
      enable = true;
      enableStarship = true;
      autostart.hyprland = true;
      
      aliases = {
        # Git shortcuts
        gs = "git status";
        ga = "git add";
        gc = "git commit";
        gp = "git push";
        gl = "git pull";
        gd = "git diff";
        gco = "git checkout";
        
        # Development shortcuts
        py = "python3";
        ipy = "ipython";
        ll = "ls -la";
        
        # Docker shortcuts
        dc = "docker compose";
        dps = "docker ps";
      };
    };
    
    # Terminal configuration
    terminal = {
      default = "kitty";
      kitty.enable = true;
    };
  };
}
