with builtins; rec {
  pkgs = import <nixpkgs> { };
  pkgslib = pkgs.lib;
  prelib = import ../bill_projects_belt { inherit pkgslib; };
  tclib = import ../colossus_rhodes_two { inherit pkgslib prelib; };
  test = import ../colossus_rhodes_two/areIdenticalUnorderedLists.nix {
    inherit prelib;
    activateDebug = true;
  };
  result1 = test [ 1 2 ] [ 1 2 ];
  result2 = test [ 1 2 ] [ 1 3 ];
  result3 = test [ 1 2 ] [ 2 1 ];
}
