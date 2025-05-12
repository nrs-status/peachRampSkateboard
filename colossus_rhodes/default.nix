{ pkgslib, prelib }:
rec {
  areIdenticalUnorderedLists = import ./areIdenticalUnorderedLists.nix { inherit prelib; };
  typecheck = import ./typecheck.nix { inherit prelib pkgslib; };
  tc = type: target: typecheck { inherit type target; };
  typecheckFunction = import ./typecheckFunction.nix { inherit prelib pkgslib; };
  tcf = inputType: outputType: function: typecheckFunction { inherit inputType outputType function; };
  predicates = prelib.importPairAttrsOfDir {
    filePathForRecursiveFileListing = ./predicates;
    inputsForImportPairs = {
        inherit prelib pkgslib; 
    };
  };
  types = prelib.importPairAttrsOfDir {
    filePathForRecursiveFileListing = ./types;
    inputsForImportPairs = {
        inherit prelib pkgslib;
    };
  };
}
