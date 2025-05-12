{ lclInputs, activateDebug ? false }:
with lclInputs;
with builtins;
let total = rec { 
  protoPred = {
    predName = "nonEmptyAttrs";
    function = attrs:
      0 < length (attrNames attrs);
  };
  final = import ../../addStdHandler.nix protoPred;
}; in prelib.wrapDebug {
  inherit total activateDebug;
}
