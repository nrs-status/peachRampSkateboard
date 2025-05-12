{ prelib }:
{ target, activateDebug ? false, ... }:
with builtins;
let
  total = rec {
    hasFieldsOfTypeOrFieldsOfPred =
      import ./hasFieldsOfTypeOrFieldsOfPred.nix { inherit prelib; };
    hasTypeFields = (hasFieldsOfTypeOrFieldsOfPred { inherit target; })
      == "type";
    typeNameFieldIsString = isString target.typeName;
    partiallyValidatePred =
      import ./partiallyValidatePred.nix { inherit prelib; };
    areIdUnordLists =
      import ./areIdenticalUnorderedLists.nix { inherit prelib; };
    hasPathPredPairNames = x:
      areIdUnordLists {
        list1 = attrNames x;
        list2 = [ "path" "pred" ];
      };
    isPathPredPair = x:
      if hasPathPredPairNames x then
        partiallyValidatePred { target = x.pred; }
      else
        false;
    allTrue = import ./allElmsOfListAreTrue.nix;
    isPathPredPairList = x: allTrue (map isPathPredPair x);
    final = if hasTypeFields then
      if isList target.spec then isPathPredPairList target.spec else false
    else
      false;
  };
in prelib.wrapDebug { inherit total activateDebug; }
