{ prelib }:
with builtins;
let
  isKvPairList = import ./isKvPairList.nix { inherit prelib; };
  f = target:
    if target == [ ] then
      []
    else if isKvPairList target then
      if isKvPairList (head target).value && !((head target).value == []) then
        (map (pair: {
          path = [ (head target).name ] ++ pair.path;
          value = pair.value;
        }) (f (head target).value)) ++ f (tail target)
      else
        [{
          path = [ (head target).name ];
          value = (head target).value;
        }] ++ f (tail target)
    else
      abort "toPathVals.nix: expected kvPairList";
in f
