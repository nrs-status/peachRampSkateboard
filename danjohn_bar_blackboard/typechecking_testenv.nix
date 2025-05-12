with builtins; rec {
  pkgs = import <nixpkgs> { system = "x86_64-linux"; };
  pkgslib = pkgs.lib;
  prelib = import ../bill_projects_belt { inherit pkgslib; };
  tc = import ../colossus_rhodes/typecheck.nix { inherit pkgslib prelib; };
  tf = import ../colossus_rhodes/typedFieldPathPredPair.nix {
    inherit prelib pkgslib;
  };
  String = import ../colossus_rhodes/types/String;
  OutputDecl =
    import ../colossus_rhodes/types/OutputDecl { inherit pkgslib prelib; };
  target = {
    nixpkgs = { };
    nixpkgsConfig = [ "hi" ];
    supportedSystems = [ "mysys" ];
    envsToProvide = [ "envs" ];
    packagesToProvide = [ "pkgs" ];
    lclInputs = 7;
    types = x: x;
  };
  result = tc {
    inherit target;
    type = OutputDecl;
    activateDebug = true;
  };
  minitype = {
    typeName = "MiniType";
    spec = [ (tf "field" String) ];
  };
  minival = {
    field = 10;
    badfield = 7;
  };
  result2 = tc {
    target = minival;
    type = minitype;
    activateDebug = true;
  };
  NixFunction = import ../colossus_rhodes/types/NixFunction;
  Attrset = import ../colossus_rhodes/types/Attrset;
  List = import ../colossus_rhodes/types/List { inherit pkgslib prelib; };
  minitypeb = {
    typeName = "MinitypeB";
    spec = [ (tf "field" (List String)) ];
  };
  minivalb = { field = [ "hi" ]; };
  result3 = tc {
    target = minivalb;
    type = minitypeb;
    activateDebug = true;
  };
  typechecksPred =
    import ../colossus_rhodes/typechecksPred.nix { inherit pkgslib prelib; };
  minitype3 = {
    typeName = "Minitype3";
    spec = [{
      path = [ "field" ];
      pred = (typechecksPred { type = String; });
    }];
  };
  minival3 = { field = "ji"; };
  result4 = tc {
    type = minitype3;
    target = minival3;
    activateDebug = true;
  };
}
