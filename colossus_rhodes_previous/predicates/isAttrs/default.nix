{ lclInputs, activateDebug ? false }:
with lclInputs;
let total = rec { 
  protoPred = {
    predName = "isAttrs";
    function = builtins.isAttrs;
  };
  final = import ../../addStdHandler.nix protoPred;
}; in prelib.wrapDebug {
  inherit total activateDebug;
}
