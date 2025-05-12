{ lclInputs, activateDebug ? false }:
with lclInputs;
with builtins;
let total = { 
  protoPred = {
    predName = "singleFieldAttrs";
    function = attrs: 1 == length (attrNames attrs)
  };
  final = import ../../addStdHandler.nix protoPred;
}; in prelib.wrapDebug {
  inherit total activateDebug;
}
