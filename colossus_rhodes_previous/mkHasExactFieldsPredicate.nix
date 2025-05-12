{ prelib, pkgslib }:
{ fields, activateDebug ? false }:
with builtins;
let
  total = rec {
    isInExpectedFields = key: _val: elem key fields;
    tagMissingFields = target: mapAttrs isInExpectedFields target;
    failures = target:
      pkgslib.filterAttrs (_key: val: val == false) (tagMissingFields target);
    predicate = rec {
      predName = "hasExactFields_${toString fields}_";
      function = target: {
        testResult = length (attrNames (failures target)) > 0;
        failuresResult = failures target;
      };
      handler = { target, type }:
        if (function target).testResult then
          abort
          ("${type.typeName} failed to typecheck due to hasFields predicate; the following fields are unexpected: ${
              toString (attrNames (function target).failuresResult)
            }")
        else
          target;
    };
    final = predicate;
  };
in prelib.wrapDebug { inherit total activateDebug; }
