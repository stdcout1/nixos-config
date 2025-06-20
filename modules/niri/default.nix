{ inputs, pkgs, lib, config, ... }:

with lib;


let
  cfg = config.modules.niri;

  #function stolen from https://github.com/sodiboo/system/blob/main/personal/niri.mod.nix
  binds =
    { suffixes
    , prefixes
    , substitutions ? { }
    ,
    }:
    let
      replacer = replaceStrings (attrNames substitutions) (attrValues substitutions);
      format =
        prefix: suffix:
        let
          actual-suffix =
            if isList suffix.action then
              {
                action = head suffix.action;
                args = tail suffix.action;
              }
            else
              {
                inherit (suffix) action;
                args = [ ];
              };

          action = replacer "${prefix.action}-${actual-suffix.action}";
        in
        {
          name = "${prefix.key}+${suffix.key}";
          value.action.${action} = actual-suffix.args;
        };
      pairs =
        attrs: fn:
        concatMap
          (
            key:
            fn {
              inherit key;
              action = attrs.${key};
            }
          )
          (attrNames attrs);
    in
    listToAttrs (pairs prefixes (prefix: pairs suffixes (suffix: [ (format prefix suffix) ])));
in
{
  imports = [
    inputs.niri.homeModules.niri
  ];
  options.modules.niri = { enable = mkEnableOption "niri"; };
  # options.desktop = { enable = mkEnableOption "desktop"; }; #enable desktop mode for niri
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swww
    ];
    programs.niri = {
      enable = true;
      settings = {
        spawn-at-startup = [
          { command = [ "hypridle" ]; }
          { command = [ "swww-daemon" ]; }
          { command = [ "adthand-dameon" ]; }
          { command = [ "swww-randomize" "$HOME/flake/pics" ]; }
          { command = [ "waybar" ]; }
          { command = [ "dunst" ]; }
        ];
        outputs."eDP-1".scale = 2;
        input = {
          touchpad = {
            tap = true;
            natural-scroll = true;
            dwt = true;
            click-method = "clickfinger";
          };
          # mod-key = "Alt";
        };

        prefer-no-csd = true;

        layout = {
          gaps = 2;
          border.width = 4;
          always-center-single-column = true;
          empty-workspace-above-first = true;

          # fog of war
          focus-ring = {
            # enable = true;
            width = 10000;
            active.color = "#00000055";
          };
          # border.active.gradient = {
          #   from = "red";
          #   to = "blue";
          #   in' = "oklch shorter hue";
          # };

          shadow.enable = true;
          # default-column-display = "tabbed";

          tab-indicator = {
            position = "top";
            gaps-between-tabs = 10;

            # hide-when-single-tab = true;
            # place-within-column = true;

            # active.color = "red";
          };

        };
        hotkey-overlay.skip-at-startup = true;

        screenshot-path = "~/stuff/pictures/screenshots/%Y-%m-%dT%H:%M:%S.png";

        binds =
          with config.lib.niri.actions;
          let
            sh = spawn "sh" "-c";
          in
          lib.attrsets.mergeAttrsList [
            {
              "Mod+T".action = spawn "foot";
              "Mod+D".action = sh ''rofi -show drun -show-icons -terminal foot'';

              "Mod+L".action = spawn "hyprlock";

              "Print".action = screenshot;
              "Mod+Shift+S".action.screenshot-screen = [ ];
              "Mod+Print".action = screenshot-window;

              "Mod+Insert".action = set-dynamic-cast-window;
              "Mod+Shift+Insert".action = set-dynamic-cast-monitor;
              "Mod+Delete".action = clear-dynamic-cast-target;

              "XF86AudioRaiseVolume".action = sh "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
              "XF86AudioLowerVolume".action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
              "XF86AudioMute".action = sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

              "XF86MonBrightnessUp".action = sh "light -A 10";
              "XF86MonBrightnessDown".action = sh "light -U 10";

              "XF86AudioPlay".action = sh ''playerctl --player playerctld play-pause'';

              "Mod+Q".action = close-window;

              "Mod+Space".action = toggle-column-tabbed-display;

              "XF86AudioNext".action = focus-column-right;
              "XF86AudioPrev".action = focus-column-left;

              "Mod+Tab".action = focus-window-down-or-column-right;
              "Mod+Shift+Tab".action = focus-window-up-or-column-left;
            }
            # set up move controls for windows. 
            (binds {
              suffixes."Left" = "column-left";
              suffixes."Down" = "window-down";
              suffixes."Up" = "window-up";
              suffixes."Right" = "column-right";
              prefixes."Mod" = "focus";
              prefixes."Mod+Ctrl" = "move";
              prefixes."Mod+Shift" = "focus-monitor";
              prefixes."Mod+Shift+Ctrl" = "move-window-to-monitor";
              substitutions."monitor-column" = "monitor";
              substitutions."monitor-window" = "monitor";
            })

            #i dont really use these but what the heck
            (binds {
              suffixes."Home" = "first";
              suffixes."End" = "last";
              prefixes."Mod" = "focus-column";
              prefixes."Mod+Ctrl" = "move-column-to";
            })

            (binds {
              suffixes."U" = "workspace-down";
              suffixes."I" = "workspace-up";
              prefixes."Mod" = "focus";
              prefixes."Mod+Ctrl" = "move-window-to";
              prefixes."Mod+Shift" = "move";
            })

            #just like hyprland!
            (binds {
              suffixes = builtins.listToAttrs (
                map
                  (n: {
                    name = toString n;
                    value = [
                      "workspace"
                      (n + 1)
                    ]; # workspace 1 is empty; workspace 2 is the logical first.
                  })
                  (range 1 9)
              );
              prefixes."Mod" = "focus";
              prefixes."Mod+Ctrl" = "move-window-to";
            })

            {
              "Mod+Comma".action = consume-window-into-column;
              "Mod+Period".action = expel-window-from-column;

              "Mod+R".action = switch-preset-column-width;
              "Mod+F".action = maximize-column;
              "Mod+Shift+F".action = fullscreen-window;
              "Mod+C".action = center-column;

              "Mod+Minus".action = set-column-width "-10%";
              "Mod+Plus".action = set-column-width "+10%";
              "Mod+Shift+Minus".action = set-window-height "-10%";
              "Mod+Shift+Plus".action = set-window-height "+10%";

              "Mod+Shift+Escape".action = toggle-keyboard-shortcuts-inhibit;
              "Mod+Shift+M".action = quit;
              "Mod+Shift+P".action = power-off-monitors;
            }
          ];

        gestures.dnd-edge-view-scroll = {
          trigger-width = 64;
          delay-ms = 250;
          max-speed = 12000;
        };

      };

    };
  };
}

