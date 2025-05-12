{ prelib }:
target:
let areUnordLists = import ./areIdenticalUnorderedLists.nix { inherit prelib; };
in with builtins;
isAttrs target && areUnordLists {
  list1 = attrNames target;
  list2 = [ "name" "value" ];
}
