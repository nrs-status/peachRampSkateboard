{ pkgslib, prelib }:
{ target, type, activateDebug ? false, ... }:
with builtins;
let
  total = rec {
    partiallyValidateType =
      import ./partiallyValidateType.nix { inherit prelib; };
    partialTypeValidation = partiallyValidateType { target = type; };
    allTrue = import ./allElmsOfListAreTrue.nix;


    paths = foldl' (acc: next: acc ++ [ next.path ]) [ ] type.spec;
    hasPaths = map (x: pkgslib.attrsets.hasAttrByPath x target) paths;
    handleHasPaths = if allTrue hasPaths then
      target
    else
      let
        missingPaths =
          attrNames (pkgslib.attrsets.filterAttrs (k: v: v == false) hasPaths);
      in abort "typecheck.nix: missing paths ${
        pkgslib.generators.toPretty {} missingPaths
      }";
    satisfiesPredAtPath = pathPredPair: rec {
      inherit target;

      val = pkgslib.attrsets.attrByPath pathPredPair.path (abort "typecheck.nix: tried to access nonexisting path") target;
      pred = pathPredPair.pred;
      path = pathPredPair.path;
      satisfiesPred = pred.func val;
    };
    whoSatisfiesPredAtPath = map satisfiesPredAtPath type.spec;
    onlyFailures = filter (pair: !pair.satisfiesPred) whoSatisfiesPredAtPath;
    handleValidationAtPath = if length onlyFailures == 0 then
      target
    else
      abort
      "typecheck.nix: while typechecking for ${type.typeName}, failure of preds at path: ${
        pkgslib.generators.toPretty {} onlyFailures
      }";

    final = seq (seq handleHasPaths handleValidationAtPath) target;
  };
in prelib.wrapDebug { inherit total activateDebug; }
