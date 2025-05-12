{ type, activateDebug ? false }:
with builtins;
let total = rec { 
  mapTc = target: map (x: tc type x) target;
  final = target: seq (mapTc target) (isList target);
};
in prelib.wrapDebug { inherit total activateDebug; }
