{ prelib }:
{ list1, list2, activateDebug ? false, ... }:
with builtins;
let
  total = rec {
    map1 = map (x: elem x list2) list1;
    map2 = map (x: elem x list1) list2;
    final = foldl' (acc: next: acc && next) true (map1 ++ map2);
  };
in prelib.wrapDebug { inherit total activateDebug; }
