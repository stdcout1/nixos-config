{ config, pkgs, lib, hardware, ... }:

{
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  services.libinput.touchpad.clickMethod = "clickfinger";
  services.libinput.touchpad.tapping = false;
  services.fprintd.enable = true;

  #some sane hibernation
  boot.resumeDevice = "/dev/disk/by-uuid/57438ec0-d02b-4923-8142-d0308bf921af";

  powerManagement.enable = true;
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 32GB in MB
    }
  ];

  services.logind.lidSwitch = "suspend-then-hibernate";
  # Hibernate on power button pressed
  services.logind.powerKey = "hibernate";
  services.logind.powerKeyLongPress = "poweroff";

  # Define time delay for hibernation
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30m
    SuspendState=mem
  '';


  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };


  # for 3sh3 
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "nasir" ];
  boot.kernelParams = [
    "kvm.enable_virt_at_load=0"
    #hibernation
    "resume_offset=131872768"
    "mem_sleep_default=deep"
  ];


  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "spotify"
    "steam"
    "steam-original"
    "steam-unwrapped"
    "idea-ultimate"
    "stremio-shell"
    "stremio-server"
  ];

}

