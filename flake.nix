{
  description = "libs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = inputs: 
    let total = rec {
      pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
      pkgslib = pkgs.lib;
      prelib = import ./bill_projects_belt { inherit pkgslib; };
      tclib = import ./colossus_rhodes { inherit pkgslib prelib; };
    }; in total;
}
