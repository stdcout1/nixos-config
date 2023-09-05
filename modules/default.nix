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
    ./zellij
    ./lf
    ./xdg
    ./scripts
    ./webcord-vencord
    ./spotify
    ./theming
    ./zathura
    ./nvim
    ./git
    # cli

  ];
}
