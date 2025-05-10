{ prelib, pkgslib }:
{ field, type, activateDebug ? false }:
with builtins;
let
  total = rec {
    hasFieldPred = import ./functionToPredicate.nix {inherit prelib;} {
      predName = "hasField_${field}_";
      function = target: hasAttr field target;
      };
    hasFieldTempType = {
      typeName = "temphasField_${field}_";
      preds = [ hasFieldPred ];
    };
    tc = import ./tc.nix { inherit prelib pkgslib; };
    fieldTypechecks = target: foldl' (acc: next: acc && next.function target) true type.preds;
    hasFieldAndFieldTypeChecks = target:
      seq (tc hasFieldTempType target) (fieldTypechecks target);
    protoPred = (import ./functionToPredicate.nix { inherit prelib; } {
      predName = "field_${field}_hasType_${type.typeName}_";
      function = hasFieldAndFieldTypeChecks;
    });
    final = import ./addStdHandler.nix protoPred;
  };
in prelib.wrapDebug { inherit total activateDebug; }
