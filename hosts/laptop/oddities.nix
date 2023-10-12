
{ config, pkgs, lib, hardware, ... }:

{
  hardware.nixosModules.framework-12th-gen-intel;
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.clickMethod = "clickfinger";
  services.xserver.libinput.touchpad.tapping = false;

  # make lidclose suspend then hibernate to save battery

  services.logind.lidSwitch = "hibernate";
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';
  
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
   	"spotify"
  ];

}

