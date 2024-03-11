{ pkgs, lib, config, ... }:
with lib;
let
    gpuIDs = [
        "10de:2786" # Graphics
        "10de:22bc" # Audio
    ];
    cfg = config.vfio;
in {
  options.vfio.enable = mkEnableOption "turn on virt";

  config = mkIf cfg.enable { 
    boot = {
      initrd.kernelModules = [
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"

        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ];

      kernelParams = [
        # enable IOMMU
        "intel_iommu=on"
      ] ++ optional cfg.enable
        # isolate the GPU
        ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs);
    };

    virtualisation.spiceUSBRedirection.enable = true;

    environment.systemPackages= with pkgs; [
        virt-manager
        qemu
        OVMF
    ];
    virtualisation.libvirtd = {
        enable = true;
            qemu = {
                package = pkgs.qemu_kvm;
                runAsRoot = true;
                swtpm.enable = true;
                ovmf = {
                    enable = true;
                    packages = [(pkgs.OVMF.override {
                        secureBoot = true;
                        tpmSupport = true;
                    }).fd];
                };
            };
        };

    users.groups.libvirtd.members = [ "root" "nasir"];

  };
}
