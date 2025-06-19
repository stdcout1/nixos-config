{ inputs, pkgs, config,... }:


{
  home.stateVersion = "23.05";
  imports = [
    # gui
    ./firefox
    ./dunst
    ./hyprland
    ./niri
    ./rofi-wayland
    ./bemenu
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
    ./git
    ./stremio
    ./hyprlock
    ./hypridle
    # cli
    ./rmapi

    #emulation

    #gaming
    ./steam
    ./minecraft

    #programming
    ./jetbrains
    ./nvim
  ];
}
