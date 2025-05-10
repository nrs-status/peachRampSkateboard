{ prelib, pkgslib }:
{ target, type, activateDebug ? false }:
with builtins;
let total = rec {
  tcPred = pred: pred.handler {
    inherit target type;
  };
  predMap = map tcPred type.preds;
  evalPreds = seq (foldl' (acc: next: seq next {}) {} predMap) target;
  final = evalPreds;
  forDebug = { inherit type; };
}; in prelib.wrapSubstitutingDebug {
  inherit total activateDebug;
  substitutionAttrs = rec {
    tcPred = pred: trace pred pred.handler {
      inherit target type;
    };
  };
}
