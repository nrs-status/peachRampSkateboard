{ prelib }:
target:
with builtins;
let
  isKvPair = import ./isKvPair.nix { inherit prelib; };
  allTrue = target: foldl' (acc: next: acc && next) true target;
in if isList target then
  if allTrue (map isKvPair target) then true else false
else
  false

