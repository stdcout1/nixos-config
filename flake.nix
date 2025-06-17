{
  description = "A very basic flake";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # hardware
    hardware.url = "github:nixos/nixos-hardware";

    # home manager
    home-manager = {
      url = "github:nix-community/home-manager";
    };

    # nur
    nur = {
      url = "github:nix-community/NUR";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };


  };

  # taken from https://github.com/notusknot/dotfiles-nix/blob/main/flake.nix 
  outputs = { self, nixpkgs, nur, hardware, home-manager, ... }@inputs:
    let

      # This lets us reuse the code to "create" a system
      # Credits go to sioodmy on this one!
      # https://github.com/sioodmy/dotfilein/flake.nix
      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
            { networking.hostName = hostname; }
            # General configuration (users, networking, sound, etc)
            ./modules/system/configuration.nix
            # Hardware config (bootloader, kernel modules, filesystems, etc)
            (./. + "/hosts/${hostname}/hardware-configuration.nix")
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit inputs; };
                # Home manager config (configures programs like firefox, zsh, eww, etc)
                users.nasir = (./. + "/hosts/${hostname}/user.nix");
              };
              nixpkgs.overlays = [
                # Add nur overlay for Firefox addons
                nur.overlays.default
                # other overlays
                #(import ./overlays)
              ];
            }
          ] ++ (if hostname == "laptop" then [ hardware.nixosModules.framework-12th-gen-intel ] else [ hardware.nixosModules.common-gpu-intel-disable ]);
          specialArgs = { inherit inputs; };
        };

    in
    {
      nixosConfigurations = {
        # Now, defining a new system is can be done in one line
        #                                Architecture   Hostname
        laptop = mkSystem inputs.nixpkgs "x86_64-linux" "laptop";
        desktop = mkSystem inputs.nixpkgs "x86_64-linux" "desktop";
      };

    };
}
