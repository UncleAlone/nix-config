{
  description = "My Personal System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    emacs-overlay.url = "github:nix-community/emacs-overlay";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

  };

  outputs = { self, nixpkgs, home-manager, emacs-overlay, neovim-nightly-overlay, ... }@inputs: 
  let
    # system = "x86_64-linux";
    
    # pkgs = import nixpkgs {
    #   inherit system;
    #   overlays = with inputs;[
    #     neovim-nightly-overlay.overlay
    #     emacs-overlay.overlay
    #   ];
    #   config.allowUnfree = true;
    # };

    nixpkgsConfig = {
      config = { allowUnfree = true; };
      overlays = with inputs; [
        emacs-overlay.overlay
        # nix-direnv.overlay
        neovim-nightly-overlay.overlay
      ];
    };


    lib = nixpkgs.lib;

  in
    {
  #   homeManagerConfigurations = {
  #     dez = home-manager.lib.homeManagerConfiguration {
  #       inherit system pkgs;
  #       username = "dez";
  #       homeDirectory = "/home/dez/";
  #       configuration = {
  #         imports = [
	#     ./users/dez/home.nix
  #           ./modules/nvim.nix
	#     ./emacs.nix
  #         ];
  #       };
  #     };
  #   };
    
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        # inherit system pkgs;
        system = "x86_64-linux";

        modules = [
          ./system/nixos

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            users.users.dez.home = "/home/dez";
            home-manager.users.dez = import ./home;

            nixpkgs = nixpkgsConfig;
          }
        ];

      };
    };
  };
}
