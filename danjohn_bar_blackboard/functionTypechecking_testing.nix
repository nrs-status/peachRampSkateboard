with builtins; rec {
  pkgs = import <nixpkgs> { system = "x86_64-linux"; };
  pkgslib = pkgs.lib;
  prelib = import ../bill_projects_belt { inherit pkgslib; };
  typecheck = import ../colossus_rhodes/typecheck.nix { inherit pkgslib prelib; };
  tc = type: target: typecheck { inherit type target; };
  predicates = prelib.importPairAttrsOfDir {
    filePathForRecursiveFileListing = ../colossus_rhodes/predicates;
    inputsForImportPairs = { inherit prelib pkgslib; };
  };
  types = prelib.importPairAttrsOfDir {
    filePathForRecursiveFileListing = ../colossus_rhodes/types;
    inputsForImportPairs = { inherit prelib pkgslib; };
  };
  func = x: x + x;
  funcInputsName = x: mapAttrs (k: v: if k == "typeName" then "FuncInput " + v else v) x;
  funcOutputsName = x: mapAttrs (k: v: if k == "typeName" then "FuncOutput " + v else v) x;
  wrapper = inputs: seq (seq (tc (funcInputsName types.Int) inputs) (tc (funcOutputsName types.String) (func inputs))) (func inputs);
  tcf = import ../colossus_rhodes/typecheckFunction.nix { inherit prelib pkgslib; };
  result = tcf {
    inputType = types.String;
    outputType = types.String;
    function = func;
  };

}
