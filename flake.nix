{
  description = "libs";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; };

  outputs = inputs:
    let pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    in rec {
      pkgslib = pkgs.lib;
      prelib = import ./bill_projects_belt { inherit pkgslib; };
      tclib = import ./colossus_rhodes { inherit pkgslib prelib; };
      baselib = import ./lighthouse_alexandria { inherit pkgslib prelib tclib; };
      tc = tclib.tc;
    };
}
