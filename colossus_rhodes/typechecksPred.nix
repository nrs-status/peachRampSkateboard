{ prelib, pkgslib }:
{ type, activateDebug ? false, ... }:
with builtins;
let
  total = rec {
    allTrue = import ./allElmsOfListAreTrue.nix;

    #nonAttrs
    preds = foldl' (acc: next: acc ++ [ next.pred ]) [ ] type.spec;
    satisfiesPreds = target: allTrue (map (pred: pred.func target) preds);

    #attrs
    paths = foldl' (acc: next: acc ++ [ next.path ]) [ ] type.spec;
    isAnAttrsType = !(allTrue (map (x: 0 == length x) paths));
    hasPaths = target: allTrue (map (x: pkgslib.attrsets.hasAttrByPath x target) paths);
    satisfiesPredAtPath = target: pathPredPair: rec {
      val = pkgslib.attrsets.attrByPath pathPredPair.path
        (abort "typechecksPred.nix: tried to access nonexisting path") target;
      satisfiesPred = pathPredPair.pred.func val;
    };
    everyoneSatisfiesPredAtPath = target: allTrue (map (satisfiesPredAtPath target) type.spec);
    final = {
      predName = "typechecks wrt ${type.typeName}";
      func = target: if isAnAttrsType then
        (hasPaths target) && (everyoneSatisfiesPredAtPath target)
      else
        satisfiesPreds target;
    };

  };
in prelib.wrapDebug { inherit total activateDebug; }
