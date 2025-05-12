{ prelib }:
{ target, activateDebug ? false, ... }:
with builtins;
let
  total = rec {
    idUnordLists = import ./areIdenticalUnorderedLists.nix { inherit prelib; };
    isType = idUnordLists {
      list1 = (attrNames target);
      list2 = [ "typeName" "spec" ];
    };
    isPred = idUnordLists {
      list1 = (attrNames target);
      list2 = [ "predName" "func" ];
    };
    final = 
      if isAttrs target then
      if isType then
        "type"
      else if isPred then
        "pred"
      else
        abort "typeOrPred.nix: is attrs but has neither type nor pred fields"
  else abort "typeOrPred.nix: is not attrs so cannot be either type nor pred";
  };
in prelib.wrapDebug { inherit total activateDebug; }
