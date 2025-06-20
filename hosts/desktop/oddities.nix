# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, ... }:

{
  # Oddities for nvidia
  nixpkgs.config.allowUnfree = true;
  

  services.logrotate.checkConfig = false;
  boot.kernelParams = [ "module_blacklist=i915" ]; # blacklist integrated gpu
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    extraPackages = [ pkgs.nvidia-vaapi-driver ];
  };


  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
  #patch to help with wlroots compositors. (hyprland and sway)
  # TODO: remove this when we get first hand explict sync support for wayland!!
  # nixpkgs.overlays = [
  #   (_: final: {
  #     wlroots_0_16 = final.wlroots_0_16.overrideAttrs (_: {
  #       patches = [
  #         ./wlroots-nvidia.patch
  #       ];
  #     });
  #   })
  # ];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Do not disable this unless your GPU is unsupported or if you have a good reason to.
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    # package = config.boot.kernelPackages.nvidiaPackages.production;

    # Special config to load the latest (535 or 550) driver for the support of the 4070 SUPER
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
}

