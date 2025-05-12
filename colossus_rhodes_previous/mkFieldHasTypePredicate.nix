{ prelib, pkgslib }:
{ field, type, activateDebug ? false }:
with builtins;
let
  total = rec {
    protoPred = (import ./functionToPredicate.nix { inherit prelib; } {
      predName = "field_${field}_hasType_${type.typeName}_";
      function = hasFieldAndFieldTypeChecks;
    });
    final = import ./addStdHandler.nix protoPred;
  };
in prelib.wrapDebug { inherit total activateDebug; }
