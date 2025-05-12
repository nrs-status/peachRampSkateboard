{ prelib }:
target:
with builtins;
let
  areIdUnordLists = import ./areIdenticalUnorderedLists.nix { inherit prelib; };
  isPathPair = x:
    areIdUnordLists {
      list1 = attrNames x;
      list2 = [ "path" "value" ];
    };
  allTrue = import ./allElmsOfListAreTrue.nix;
in if isList target then
  if allTrue (map isPathPair target) then true else false
else
  false

