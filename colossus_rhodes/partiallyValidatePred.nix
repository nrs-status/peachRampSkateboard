{ prelib }:
{ target, activateDebug ? false, ... }:
with builtins;
let
  total = rec {
    hasFieldsOfTypeOrFieldsOfPred = import ./hasFieldsOfTypeOrFieldsOfPred.nix { inherit prelib; };
    hasPredFields = (hasFieldsOfTypeOrFieldsOfPred { inherit target; }) == "pred";
    predNameFieldIsString = isString target.predName;
    funcFieldIsFunc = isFunction target.func;
    final = hasPredFields && predNameFieldIsString && funcFieldIsFunc;
  };
in prelib.wrapDebug { inherit total activateDebug; }
