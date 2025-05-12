{ pkgslib }:
with builtins;
let
  f = target:
    let
      kvPairList = pkgslib.attrsToList target;
      mapFunc = pair:
        if pkgslib.isDerivation pair.value then
          pair
        else if isAttrs pair.value then {
          name = pair.name;
          value = f pair.value;
        } else
          pair;
    in map mapFunc kvPairList;
in f
