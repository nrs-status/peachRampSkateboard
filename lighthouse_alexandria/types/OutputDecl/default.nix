{ tclib, ... }:
with tclib.types;
tclib.mkRecordType {
  typeName = "OutputDecl";
  fieldsAndTypesAttrs = {
    nixpkgs = Attrset;
    nixpkgsConfig = List String;
    supportedSystem = List String;
    envsToProvide = List String;
    packagesToProvide = List String;
    lclInputs = NixFunction;
    types = NixFunction;
  };
}
