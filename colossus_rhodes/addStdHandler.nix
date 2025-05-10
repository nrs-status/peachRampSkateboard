protoPred: rec {
  predName = protoPred.predName;
  function = protoPred.function;
  handler = { target, typeName }:
    if function target then
      target
    else
      (import ./stdTcError.nix { inherit typeName predName; });
}
