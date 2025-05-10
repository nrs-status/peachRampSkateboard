{ prelib, pkgslib }:
{
  typecheck = import ./typecheck.nix { inherit prelib pkgslib; };
  predicates = prelib.importPairAttrsOfDir {
    filePathForRecursiveFileListing = ./predicates;
    inputsForImportPairs = {
      lclInputs = {
        inherit prelib pkgslib;
      };
    };
  };
  tc = import ./tc.nix { inherit prelib pkgslib; };
  stdTcError = import ./stdTcError.nix;
  addStdHandler = import ./addStdHandler.nix;
  mkHasExactFieldsPredicate = import ./mkHasExactFieldsPredicate.nix { inherit prelib pkgslib; };
  types = prelib.importPairAttrsOfDir {
    filePathForRecursiveFileListing = ./primTypes;
    inputsForImportPairs = { inherit prelib pkgslib; };
  };
  tfieldp = type: fieldName: import ./mkFieldHasTypePredicate.nix { inherit prelib pkgslib; } { field = fieldName; inherit type; };
  mkFieldHasTypePredicate = import ./mkFieldHasTypePredicate.nix { inherit prelib pkgslib; };
  mkRecordType = import ./mkRecordType.nix { inherit prelib pkgslib; };
}
