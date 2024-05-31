{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.theming;
  # gruvboxPlus = import ./gruvbox-plus.nix { inherit pkgs; };
in
{
  options.modules.theming = { enable = mkEnableOption "theming"; };

  config = mkIf cfg.enable {

    qt.enable = true;

    home.packages = with pkgs; [
      # Needed for gtk 
      dconf
    ];


    gtk.enable = true;

    qt.platformTheme.name = "gtk";

    qt.style.name = "adwaita-dark";

    qt.style.package = pkgs.adwaita-qt;

    gtk.cursorTheme.package = pkgs.simp1e-cursors;
    gtk.cursorTheme.name = "Simp1e-Gruvbox-Dark";
    gtk.cursorTheme.size = 24;

    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.simp1e-cursors;
      name = "Simp1e-Gruvbox-Dark";
      size = 12;
    };

    gtk.theme.package = pkgs.gruvbox-gtk-theme;
    gtk.theme.name = "Gruvbox-Dark-BL";

    # gtk.iconTheme.package = gruvboxPlus;
    gtk.iconTheme.package = pkgs.gruvbox-plus-icons;
    gtk.iconTheme.name = "GruvboxPlus";

  };
}
