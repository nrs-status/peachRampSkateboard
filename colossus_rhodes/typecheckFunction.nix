{ pkgslib, prelib }:
{ inputType, outputType, function, activateDebug ? false }:
with builtins;
  let total = rec {
  typecheck = import ./typecheck.nix { inherit pkgslib prelib; };
  tc = type: target: typecheck { inherit type target; };
  appendFuncInputTypeName = x: mapAttrs (k: v: if k == "typeName" then "FuncInput " + v else v) x;
  appendFuncOutputTypeName = x: mapAttrs (k: v: if k == "typeName" then "FuncOutput " + v else v) x;
  inputType' = appendFuncInputTypeName inputType;
  outputType' = appendFuncOutputTypeName outputType;
  wrapper = inputs: seq (seq (tc inputType' inputs) (tc outputType' (function inputs))) (function inputs);
  final = wrapper;
  }; in prelib.wrapDebug { inherit total activateDebug; }

