{ pkgslib }:
{ filePathForRecursiveFileListing, inputForImportPairs, activateDebug ? false }:
with builtins;
let total = rec {
  filesList = (import ./listDirsSatisfyingPred.nix { inherit pkgslib; }) {
    dir = filePathForRecursiveFileListing;
    pred = pkgslib.hasSuffix "default.nix";
  };
  mkImportPairs = path: import ./mkImportPair.nix { inherit pkgslib; } { importInputs = inputForImportPairs; filePath = path; };
  importPairList = map mkImportPairs filesList;
  testWf = attrs: if length (attrNames attrs) == 1 then attrs else throw ("importPairAttrsOfDir.nix: when skipping attribute 'default', found a value with more than one key:" + (toString (attrNames attrs)));
  skipDefaultAttr = keyvalpair:
    if keyvalpair.name == "default" then { 
      name = elemAt (attrNames (testWf keyvalpair.value)) 0;
      value = elemAt (attrValues keyvalpair.value) 0;
    } else keyvalpair;
  importsWithSkippedDefaultAttr = map skipDefaultAttr importPairList;
  final = listToAttrs importsWithSkippedDefaultAttr;

}; in (import ./wrapDebug.nix) {
  inherit total activateDebug;
}
