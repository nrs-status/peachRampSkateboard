{ prelib }:
{ predName, function, activateDebug ? false }:
  let total = rec {
  protoPred = {
    inherit predName function;
  };
  final = import ./addStdHandler.nix protoPred;
}; in prelib.wrapDebug {
    inherit total activateDebug;
  }
