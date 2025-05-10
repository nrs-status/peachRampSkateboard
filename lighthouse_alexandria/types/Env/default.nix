{ lclInputs }:
with lclInputs;
with tclib.types;
tc TypeDecl {
  typeName = "Env";
  preds = [
    (tclib.mkHasExactFieldsPredicate { fields = [
      "name" "packagesFromNixpkgs" "packagesFromLocalRepo" "shellHook"
    ]; })
  ];
}
