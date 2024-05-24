{
  inputs = {
    nixpkgs = { 
      url = "github:nixos/nixpkgs/nixos-23.11";
    };
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.snowfall-lib.mkFlake {
    inherit inputs;
    src = ./.;
    snowfall.namespace = "dotfiles";
    channels-config.allowUnfree = true;

    systems.modules.nixos = with inputs; [
      agenix.nixosModules.default
      disko.nixosModules.disko
      impermanence.nixosModules.impermanence
      nix-index-database.nixosModules.nix-index
      home-manager.nixosModules.home-manager
      {
        # configure home manager to use this flake's revision of nixpkgs
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        
        # enable comma and nix index
        programs.command-not-found.enable = false;
        programs.nix-index-database.comma.enable = true;
      
        # populate nix channels with this flake's nixpkgs revision
        nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

        # set any nix settings you want here. for reference, see:
        # https://nixos.org/manual/nix/unstable/command-ref/conf-file.html#available-settings
        nix.settings = {
          # enable flakes
          experimental-features = [ "nix-command" "flakes" ];
        };
      }
    ];
  };
}