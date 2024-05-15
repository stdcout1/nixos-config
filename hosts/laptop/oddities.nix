
{ config, pkgs, lib, hardware, ... }:

{
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  services.libinput.touchpad.clickMethod = "clickfinger";
  services.libinput.touchpad.tapping = false;
  services.fprintd.enable = true;

  # make lidclose suspend then hibernate to save battery

  services.logind.lidSwitch = "suspend";
  services.logind.powerKey = "ignore";
  
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "spotify"
  ];

}

