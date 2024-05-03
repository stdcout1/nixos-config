
{ config, pkgs, lib, hardware, ... }:

{
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.clickMethod = "clickfinger";
  services.xserver.libinput.touchpad.tapping = false;
  services.fprintd.enable = true;

  # make lidclose suspend then hibernate to save battery

  services.logind.lidSwitch = "suspend";
  services.logind.powerKey = "ignore";
  
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "spotify"
  ];

}

