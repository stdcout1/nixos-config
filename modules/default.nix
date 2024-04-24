{ inputs, pkgs, config, ... }:


{
  home.stateVersion = "23.05";
  imports = [
    # gui
    ./firefox
    ./dunst
    ./hyprland
    ./rofi-wayland
    ./waybar
    ./foot
    ./fish
    ./starship
    ./tmux
    ./lf
    ./xdg
    ./scripts
    ./webcord-vencord
    ./spotify
    ./theming
    ./zathura
    ./nvim
    ./git
    ./stremio
    ./hyprlock
    # cli
    ./rmapi

    #emulation

    #gaming
    ./steam
    ./minecraft
  ];
}
