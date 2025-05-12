{ pkgslib, prelib }:
let
  List = import ../List { inherit pkgslib prelib; };
  String = import ../String {};
  NixFunction = import ../NixFunction {};
  Attrset = import ../Attrset {};
  tf = import ../../typedFieldPathPredPair.nix { inherit prelib pkgslib; };
in {
  typeName = "OutputDecl";
  spec = [
    (tf "nixpkgs" Attrset)
    (tf "nixpkgsConfig" (List String))
    (tf "supportedSystems" (List String))
    (tf "envsToProvide" (List String))
    (tf "packagesToProvide" (List String))
    (tf "lclInputs" NixFunction)
    (tf "types" NixFunction)
  ];
}
