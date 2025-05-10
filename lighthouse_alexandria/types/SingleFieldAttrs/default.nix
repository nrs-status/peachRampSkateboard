{ lclInputs }:
with lclInputs;
with tclib.types;
tc TypeDecl {
  typeName = "SingleFieldAttrs";
  preds = [
    lclInputs.tclib.predicates.singleFieldAttrs
  ];
}
