{
  description = "NixOS de Breno";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs-com-unfree = import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
        };
      };
    
    in {
      # Configuração do NixOS
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        pkgs = pkgs-com-unfree;

        specialArgs = {
          inherit inputs;
        };

        modules = [
          ./nixos/configuration.nix
        ];
      };

      # Configuração do Home Manager
      homeConfigurations.breno = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs-com-unfree;

        modules = [
          ./home-manager/home.nix
        ];

        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
}
