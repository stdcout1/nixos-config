{ config, lib, inputs, ... }:

{
  imports = [ ../../modules/default.nix ];
  config.modules = {
    # gui
    firefox.enable = true;
    dunst.enable = true;
    hyprland.enable = true;
    rofi-wayland.enable = true;
    waybar.enable = true;
    foot.enable = true;
    fish.enable = true;
    tmux.enable = true;
    starship.enable = true;
    lf.enable = true;
    scripts.enable = true;
    webcord-vencord.enable = true;
    spotify.enable = true;
    theming.enable = true;
    xdg.enable = true;
    zathura.enable = true;
    nvim.enable = true;
    git.enable = true;
    stremio.enable = true;
    rmapi.enable = true;
  };
}
